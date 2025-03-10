<?xml version="1.0" encoding="UTF-8"?>
<!--
This schematron uses business terms defined the CEN/EN16931-1 and is reproduced with permission
from CEN. CEN bears no liability from the use of the content and implementation of this schematron
and gives no warranties expressed or implied for any purpose.

Last update: 2025 March release 3.0.0.
 -->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:u="utils" schemaVersion="iso"
  queryBinding="xslt2">
  <title>Rules for Peppol BIS 3.0 Billing</title>
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" prefix="cbc" />
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" prefix="cac" />
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2" prefix="ubl-creditnote" />
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" prefix="ubl-invoice" />
  <ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs" />
  <ns uri="utils" prefix="u" />
  <!-- Parameters -->
  <let name="profile"
    value="
      if (/*/cbc:ProfileID and matches(normalize-space(/*/cbc:ProfileID), 'urn:fdc:peppol.eu:2017:poacc:selfbilling:([0-9]{2}):1.0')) then
        tokenize(normalize-space(/*/cbc:ProfileID), ':')[7]
      else
        'Unknown'" />
  <let name="supplierCountry"
    value="
      if (/*/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/substring(cbc:CompanyID, 1, 2)) then
        upper-case(normalize-space(/*/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/substring(cbc:CompanyID, 1, 2)))
      else
        if (/*/cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/substring(cbc:CompanyID, 1, 2)) then
          upper-case(normalize-space(/*/cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/substring(cbc:CompanyID, 1, 2)))
        else
          if (/*/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode) then
            upper-case(normalize-space(/*/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode))
          else
            'XX'" />
  <let name="customerCountry"
    value="
		if (/*/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/substring(cbc:CompanyID, 1, 2)) then
		upper-case(normalize-space(/*/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/substring(cbc:CompanyID, 1, 2)))
		else
		if (/*/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode) then
		upper-case(normalize-space(/*/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode))
		else
		'XX'" />
  <!-- -->
  <let name="supplierCountryIsDE"
    value="(upper-case(normalize-space(/*/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode)) = 'DE')" />
  <let name="customerCountryIsDE"
    value="(upper-case(normalize-space(/*/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode)) = 'DE')" />

  <let name="documentCurrencyCode" value="/*/cbc:DocumentCurrencyCode" />
  <!-- Functions -->
  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:gln" as="xs:boolean">
    <param name="val" />
    <variable name="length" select="string-length($val) - 1" />
    <variable name="digits"
      select="reverse(for $i in string-to-codepoints(substring($val, 0, $length + 1)) return $i - 48)" />
    <variable name="weightedSum"
      select="sum(for $i in (0 to $length - 1) return $digits[$i + 1] * (1 + ((($i + 1) mod 2) * 2)))" />
    <value-of select="(10 - ($weightedSum mod 10)) mod 10 = number(substring($val, $length + 1, 1))" />
  </function>
  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:slack" as="xs:boolean">
    <param name="exp" as="xs:decimal" />
    <param name="val" as="xs:decimal" />
    <param name="slack" as="xs:decimal" />
    <value-of select="xs:decimal($exp + $slack) &gt;= $val and xs:decimal($exp - $slack) &lt;= $val" />
  </function>
  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:mod11" as="xs:boolean">
    <param name="val" />
    <variable name="length" select="string-length($val) - 1" />
    <variable name="digits"
      select="reverse(for $i in string-to-codepoints(substring($val, 0, $length + 1)) return $i - 48)" />
    <variable name="weightedSum"
      select="sum(for $i in (0 to $length - 1) return $digits[$i + 1] * (($i mod 6) + 2))" />
    <value-of
      select="number($val) &gt; 0 and (11 - ($weightedSum mod 11)) mod 11 = number(substring($val, $length + 1, 1))" />
  </function>
  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:mod97-0208" as="xs:boolean">
    <param name="val" />
    <variable name="checkdigits" select="substring($val,9,2)" />
    <variable name="calculated_digits"
      select="xs:string(97 - (xs:integer(substring($val,1,8)) mod 97))" />
    <value-of select="number($checkdigits) = number($calculated_digits)" />
  </function>
  <function name="u:checkCodiceIPA" as="xs:boolean" xmlns="http://www.w3.org/1999/XSL/Transform">
    <param name="arg" as="xs:string?" />
    <variable name="allowed-characters">ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789</variable>
    <sequence
      select="if ( (string-length(translate($arg, $allowed-characters, '')) = 0) and (string-length($arg) = 6) ) then true() else false()" />
  </function>
  <function name="u:checkCF" as="xs:boolean" xmlns="http://www.w3.org/1999/XSL/Transform">
    <param name="arg" as="xs:string?" />
    <sequence
      select="
		if ( (string-length($arg) = 16) or (string-length($arg) = 11) ) 		
		then 
		(
			if ((string-length($arg) = 16)) 
			then
			(
				if (u:checkCF16($arg)) 
				then
				(
					true()
				)
				else
				(
					false()
				)
			)
			else
			(
				if(($arg castable as xs:integer)) then true() else false()
		
			)
		)
		else
		(
			false()
		)
		" />
  </function>
  <function name="u:checkCF16" as="xs:boolean" xmlns="http://www.w3.org/1999/XSL/Transform">
    <param name="arg" as="xs:string?" />
    <variable name="allowed-characters">ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz</variable>
    <sequence
      select="
				if ( 	(string-length(translate(substring($arg,1,6), $allowed-characters, '')) = 0) and  
						(substring($arg,7,2) castable as xs:integer) and 
						(string-length(translate(substring($arg,9,1), $allowed-characters, '')) = 0) and 
						(substring($arg,10,2) castable as xs:integer) and  
						(substring($arg,12,3) castable as xs:string) and 
						(substring($arg,15,1) castable as xs:integer) and  
						(string-length(translate(substring($arg,16,1), $allowed-characters, '')) = 0)
					) 
				then true()
				else false()
				" />
  </function>
  <function name="u:checkPIVAseIT" as="xs:boolean" xmlns="http://www.w3.org/1999/XSL/Transform">
    <param name="arg" as="xs:string" />
    <variable name="paese" select="substring($arg,1,2)" />
    <variable name="codice" select="substring($arg,3)" />
    <sequence
      select="

			if ( $paese = 'IT' or $paese = 'it' )
			then
			(
				if ( ( string-length($codice) = 11 ) and ( if (u:checkPIVA($codice)!=0) then false() else true() ))
				then
				(
					true()
				)
				else
				(
					false()
				)
			)
			else
			(
				true()
			)
		
		" />
  </function>
  <function name="u:checkPIVA" as="xs:integer" xmlns="http://www.w3.org/1999/XSL/Transform">
    <param name="arg" as="xs:string?" />
    <sequence
      select="
				if (not($arg castable as xs:integer)) 
					then 1
					else ( u:addPIVA($arg,xs:integer(0)) mod 10 )" />
  </function>
  <function name="u:addPIVA" as="xs:integer" xmlns="http://www.w3.org/1999/XSL/Transform">
    <param name="arg" as="xs:string" />
    <param name="pari" as="xs:integer" />
    <variable name="tappo" select="if (not($arg castable as xs:integer)) then 0 else 1" />
    <variable name="mapper"
      select="if ($tappo = 0) then 0 else 
																		( if ($pari = 1) 
																			then ( xs:integer(substring('0246813579', ( xs:integer(substring($arg,1,1)) +1 ) ,1)) ) 
																			else ( xs:integer(substring($arg,1,1) ) )
																		)" />
    <sequence
      select="if ($tappo = 0) then $mapper else ( xs:integer($mapper) + u:addPIVA(substring(xs:string($arg),2), (if($pari=0) then 1 else 0) ) )" />
  </function>
  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:abn" as="xs:boolean">
    <param name="val" />
    <value-of
      select="(
((string-to-codepoints(substring($val,1,1)) - 49) * 10) +
((string-to-codepoints(substring($val,2,1)) - 48) * 1) +
((string-to-codepoints(substring($val,3,1)) - 48) * 3) +
((string-to-codepoints(substring($val,4,1)) - 48) * 5) +
((string-to-codepoints(substring($val,5,1)) - 48) * 7) +
((string-to-codepoints(substring($val,6,1)) - 48) * 9) +
((string-to-codepoints(substring($val,7,1)) - 48) * 11) +
((string-to-codepoints(substring($val,8,1)) - 48) * 13) +
((string-to-codepoints(substring($val,9,1)) - 48) * 15) +
((string-to-codepoints(substring($val,10,1)) - 48) * 17) +
((string-to-codepoints(substring($val,11,1)) - 48) * 19)) mod 89 = 0
" />
  </function>

  <!-- Functions and variable for Greek Rules -->
  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:TinVerification" as="xs:boolean">
    <param name="val" as="xs:string" />
    <variable name="digits"
      select="
			for $ch in string-to-codepoints($val)
			return codepoints-to-string($ch)" />
    <variable name="checksum"
      select="
			(number($digits[8])*2) +
			(number($digits[7])*4) +
			(number($digits[6])*8) +
			(number($digits[5])*16) +
			(number($digits[4])*32) +
			(number($digits[3])*64) +
			(number($digits[2])*128) +
			(number($digits[1])*256) " />
    <value-of select="($checksum  mod 11) mod 10 = number($digits[9])" />
  </function>

  <!-- Function for Swedish organisation numbers (0007) -->
  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:checkSEOrgnr" as="xs:boolean">
    <param name="number" as="xs:string" />
    <choose>
      <!-- Check if input is numeric -->
      <when test="not(matches($number, '^\d+$'))">
        <sequence select="false()" />
      </when>
      <otherwise>
        <!-- verify the check number of the provided identifier according to the Luhn algorithm-->
        <variable name="mainPart" select="substring($number, 1, 9)" />
        <variable name="checkDigit" select="substring($number, 10, 1)" />
        <variable name="sum" as="xs:integer">
          <value-of
            select="sum(
						for $pos in 1 to string-length($mainPart) return 
							if ($pos mod 2 = 1) 
							then (number(substring($mainPart, string-length($mainPart) - $pos + 1, 1)) * 2) mod 10 + 
								 (number(substring($mainPart, string-length($mainPart) - $pos + 1, 1)) * 2) idiv 10 
							else number(substring($mainPart, string-length($mainPart) - $pos + 1, 1))
					)" />
        </variable>
        <variable name="calculatedCheckDigit" select="(10 - $sum mod 10) mod 10" />
        <sequence select="$calculatedCheckDigit = number($checkDigit)" />
      </otherwise>
    </choose>
  </function>
  <!-- Empty elements -->
  <pattern>
    <rule context="//*[not(*) and not(normalize-space())]">
      <assert id="PEPPOL-EN16931-R008" test="false()" flag="fatal">Document MUST not contain empty elements.</assert>
    </rule>
  </pattern>
  <!--
    Transaction rules

    R00X - Document level
    R01X - Accounting customer
    R02X - Accounting supplier
    R04X - Allowance/Charge (document and line)
    R05X - Tax
    R06X - Payment
    R08X - Additonal document reference
    R1XX - Line level
    R11X - Invoice period
  -->
  <pattern>
    <rule context="ubl-creditnote:CreditNote">
      <assert id="PEPPOL-EN16931-R080"
        test="(count(cac:AdditionalDocumentReference[cbc:DocumentTypeCode='50']) &lt;= 1)"
        flag="fatal">Only one project reference is allowed on document level</assert>
    </rule>
  </pattern>
  <pattern>
    <!-- Document level -->
    <rule context="ubl-creditnote:CreditNote | ubl-invoice:Invoice">
      <assert id="PEPPOL-EN16931-R001" test="cbc:ProfileID" flag="fatal">Business process MUST be provided.</assert>
      <assert id="PEPPOL-EN16931-R007" test="$profile != 'Unknown'" flag="fatal">Business process MUST be in the format 'urn:fdc:peppol.eu:2017:poacc:selfbilling:NN:1.0' where NN indicates the process number.</assert>
      <assert id="PEPPOL-EN16931-R002"
        test="count(cbc:Note) &lt;= 1 or ($supplierCountryIsDE and $customerCountryIsDE)"
        flag="fatal">No more than one note is allowed on document level, unless both the buyer and seller are German organizations.</assert>
      <assert id="PEPPOL-EN16931-R003" test="cbc:BuyerReference or cac:OrderReference/cbc:ID"
        flag="fatal">A buyer reference or purchase order reference MUST be provided.</assert>
      <assert id="PEPPOL-EN16931-R004"
        test="starts-with(normalize-space(cbc:CustomizationID/text()), 'urn:cen.eu:en16931:2017#compliant#urn:fdc:peppol.eu:2017:poacc:selfbilling:3.0')"
        flag="fatal">Specification identifier MUST have the value 'urn:cen.eu:en16931:2017#compliant#urn:fdc:peppol.eu:2017:poacc:selfbilling:3.0'.</assert>
      <assert id="PEPPOL-EN16931-R053" test="count(cac:TaxTotal[cac:TaxSubtotal]) = 1" flag="fatal">Only one tax total with tax subtotals MUST be provided.</assert>
      <assert id="PEPPOL-EN16931-R054"
        test="count(cac:TaxTotal[not(cac:TaxSubtotal)]) = (if (cbc:TaxCurrencyCode) then 1 else 0)"
        flag="fatal">Only one tax total without tax subtotals MUST be provided when tax currency code is provided.</assert>
      <assert id="PEPPOL-EN16931-R055"
        test="not(cbc:TaxCurrencyCode) or (cac:TaxTotal/cbc:TaxAmount[@currencyID=normalize-space(../../cbc:TaxCurrencyCode)] &lt;= 0 and cac:TaxTotal/cbc:TaxAmount[@currencyID=normalize-space(../../cbc:DocumentCurrencyCode)] &lt;= 0) or (cac:TaxTotal/cbc:TaxAmount[@currencyID=normalize-space(../../cbc:TaxCurrencyCode)] &gt;= 0 and cac:TaxTotal/cbc:TaxAmount[@currencyID=normalize-space(../../cbc:DocumentCurrencyCode)] &gt;= 0) "
        flag="fatal">Invoice total VAT amount and Invoice total VAT amount in accounting currency MUST have the same operational sign</assert>
    </rule>
    <rule context="cbc:TaxCurrencyCode">
      <assert id="PEPPOL-EN16931-R005"
        test="not(normalize-space(text()) = normalize-space(../cbc:DocumentCurrencyCode/text()))"
        flag="fatal">VAT accounting currency code MUST be different from invoice currency code when provided.</assert>
    </rule>
    <!-- Accounting customer -->
    <rule context="cac:AccountingCustomerParty/cac:Party">
      <assert id="PEPPOL-EN16931-R010" test="cbc:EndpointID" flag="fatal">Buyer electronic address MUST be provided</assert>
    </rule>
    <!-- Accounting supplier -->
    <rule context="cac:AccountingSupplierParty/cac:Party">
      <assert id="PEPPOL-EN16931-R020" test="cbc:EndpointID" flag="fatal">Seller electronic address MUST be provided</assert>
    </rule>
    <!-- Allowance/Charge (document level/line level) -->
    <rule
      context="ubl-invoice:Invoice/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)] | ubl-invoice:Invoice/cac:InvoiceLine/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)] | ubl-creditnote:CreditNote/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)] | ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)]">
      <assert id="PEPPOL-EN16931-R041" test="false()" flag="fatal">Allowance/charge base amount MUST be provided when allowance/charge percentage is provided.</assert>
    </rule>
    <rule
      context="ubl-invoice:Invoice/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount] | ubl-invoice:Invoice/cac:InvoiceLine/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount] | ubl-creditnote:CreditNote/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount] | ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount]">
      <assert id="PEPPOL-EN16931-R042" test="false()" flag="fatal">Allowance/charge percentage MUST be provided when allowance/charge base amount is provided.</assert>
    </rule>
    <rule
      context="ubl-invoice:Invoice/cac:AllowanceCharge | ubl-invoice:Invoice/cac:InvoiceLine/cac:AllowanceCharge | ubl-creditnote:CreditNote/cac:AllowanceCharge | ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:AllowanceCharge">
      <assert id="PEPPOL-EN16931-R040"
        test="
          not(cbc:MultiplierFactorNumeric and cbc:BaseAmount) or u:slack(if (cbc:Amount) then
            cbc:Amount
          else
            0, (xs:decimal(cbc:BaseAmount) * xs:decimal(cbc:MultiplierFactorNumeric)) div 100, 0.02)"
        flag="fatal">Allowance/charge amount must equal base amount * percentage/100 if base amount and percentage exists</assert>
      <assert id="PEPPOL-EN16931-R043"
        test="normalize-space(cbc:ChargeIndicator/text()) = 'true' or normalize-space(cbc:ChargeIndicator/text()) = 'false'"
        flag="fatal">Allowance/charge ChargeIndicator value MUST equal 'true' or 'false'</assert>
    </rule>
    <!-- Payment -->
    <rule
      context="
        cac:PaymentMeans[some $code in tokenize('49 59', '\s')
          satisfies normalize-space(cbc:PaymentMeansCode) = $code]">
      <assert id="PEPPOL-EN16931-R061" test="cac:PaymentMandate/cbc:ID" flag="fatal">Mandate reference MUST be provided for direct debit.</assert>
    </rule>
    <!-- Currency -->
    <rule
      context="cbc:Amount | cbc:BaseAmount | cbc:PriceAmount | cac:TaxTotal[cac:TaxSubtotal]/cbc:TaxAmount | cbc:TaxableAmount | cbc:LineExtensionAmount | cbc:TaxExclusiveAmount | cbc:TaxInclusiveAmount | cbc:AllowanceTotalAmount | cbc:ChargeTotalAmount | cbc:PrepaidAmount | cbc:PayableRoundingAmount | cbc:PayableAmount">
      <assert id="PEPPOL-EN16931-R051" test="@currencyID = $documentCurrencyCode" flag="fatal">All currencyID attributes must have the same value as the invoice currency code (BT-5), except for the invoice total VAT amount in accounting currency (BT-111).</assert>
    </rule>
    <!-- Line level - invoice period -->
    <rule
      context="ubl-invoice:Invoice[cac:InvoicePeriod/cbc:StartDate]/cac:InvoiceLine/cac:InvoicePeriod/cbc:StartDate | ubl-creditnote:CreditNote[cac:InvoicePeriod/cbc:StartDate]/cac:CreditNoteLine/cac:InvoicePeriod/cbc:StartDate">
      <assert id="PEPPOL-EN16931-R110"
        test="xs:date(text()) &gt;= xs:date(../../../cac:InvoicePeriod/cbc:StartDate)" flag="fatal">Start date of line period MUST be within invoice period.</assert>
    </rule>
    <rule
      context="ubl-invoice:Invoice[cac:InvoicePeriod/cbc:EndDate]/cac:InvoiceLine/cac:InvoicePeriod/cbc:EndDate | ubl-creditnote:CreditNote[cac:InvoicePeriod/cbc:EndDate]/cac:CreditNoteLine/cac:InvoicePeriod/cbc:EndDate">
      <assert id="PEPPOL-EN16931-R111"
        test="xs:date(text()) &lt;= xs:date(../../../cac:InvoicePeriod/cbc:EndDate)" flag="fatal">End date of line period MUST be within invoice period.</assert>
    </rule>
    <!-- Line level - line extension amount -->
    <rule context="cac:InvoiceLine | cac:CreditNoteLine">
      <let name="lineExtensionAmount"
        value="
          if (cbc:LineExtensionAmount) then
            xs:decimal(cbc:LineExtensionAmount)
          else
            0" />
      <let name="quantity"
        value="
          if (/ubl-invoice:Invoice) then
            (if (cbc:InvoicedQuantity) then
              xs:decimal(cbc:InvoicedQuantity)
            else
              1)
          else
            (if (cbc:CreditedQuantity) then
              xs:decimal(cbc:CreditedQuantity)
            else
              1)" />
      <let name="priceAmount"
        value="
          if (cac:Price/cbc:PriceAmount) then
            xs:decimal(cac:Price/cbc:PriceAmount)
          else
            0" />
      <let name="baseQuantity"
        value="
          if (cac:Price/cbc:BaseQuantity and xs:decimal(cac:Price/cbc:BaseQuantity) != 0) then
            xs:decimal(cac:Price/cbc:BaseQuantity)
          else
            1" />
      <let name="allowancesTotal"
        value="
          if (cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'false']) then
            round(sum(cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'false']/cbc:Amount/xs:decimal(.)) * 10 * 10) div 100
          else
            0" />
      <let name="chargesTotal"
        value="
          if (cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'true']) then
            round(sum(cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'true']/cbc:Amount/xs:decimal(.)) * 10 * 10) div 100
          else
            0" />
      <assert id="PEPPOL-EN16931-R120"
        test="u:slack($lineExtensionAmount, ($quantity * ($priceAmount div $baseQuantity)) + $chargesTotal - $allowancesTotal, 0.02)"
        flag="fatal">Invoice line net amount MUST equal (Invoiced quantity * (Item net price/item price base quantity) + Sum of invoice line charge amount - sum of invoice line allowance amount</assert>
      <assert id="PEPPOL-EN16931-R121"
        test="not(cac:Price/cbc:BaseQuantity) or xs:decimal(cac:Price/cbc:BaseQuantity) &gt; 0"
        flag="fatal">Base quantity MUST be a positive number above zero.</assert>
      <assert id="PEPPOL-EN16931-R100" test="(count(cac:DocumentReference) &lt;= 1)" flag="fatal">Only one invoiced object is allowed pr line</assert>
      <assert id="PEPPOL-EN16931-R101"
        test="(not(cac:DocumentReference) or (cac:DocumentReference/cbc:DocumentTypeCode='130'))"
        flag="fatal">Element Document reference can only be used for Invoice line object</assert>
    </rule>
    <!-- Allowance (price level) -->
    <rule context="cac:Price/cac:AllowanceCharge">
      <assert id="PEPPOL-EN16931-R044" test="normalize-space(cbc:ChargeIndicator) = 'false'"
        flag="fatal">Charge on price level is NOT allowed. Only value 'false' allowed.</assert>
      <assert id="PEPPOL-EN16931-R046"
        test="not(cbc:BaseAmount) or xs:decimal(../cbc:PriceAmount) = xs:decimal(cbc:BaseAmount) - xs:decimal(cbc:Amount)"
        flag="fatal">Item net price MUST equal (Gross price - Allowance amount) when gross price is provided.</assert>
    </rule>
    <!-- Price -->
    <rule context="cac:Price/cbc:BaseQuantity[@unitCode]">
      <let name="hasQuantity" value="../../cbc:InvoicedQuantity or ../../cbc:CreditedQuantity" />
      <let name="quantity"
        value="
          if (/ubl-invoice:Invoice) then
            ../../cbc:InvoicedQuantity
          else
            ../../cbc:CreditedQuantity" />
      <assert id="PEPPOL-EN16931-R130" test="not($hasQuantity) or @unitCode = $quantity/@unitCode"
        flag="fatal">Unit code of price base quantity MUST be same as invoiced quantity.</assert>
    </rule>
    <!-- Validation of ICD -->
    <rule
      context="cbc:EndpointID[@schemeID = '0088'] | cac:PartyIdentification/cbc:ID[@schemeID = '0088'] | cbc:CompanyID[@schemeID = '0088']">
      <assert id="PEPPOL-COMMON-R040"
        test="matches(normalize-space(), '^[0-9]+$') and u:gln(normalize-space())" flag="fatal">GLN must have a valid format according to GS1 rules.</assert>
    </rule>
    <rule
      context="cbc:EndpointID[@schemeID = '0192'] | cac:PartyIdentification/cbc:ID[@schemeID = '0192'] | cbc:CompanyID[@schemeID = '0192']">
      <assert id="PEPPOL-COMMON-R041"
        test="matches(normalize-space(), '^[0-9]{9}$') and u:mod11(normalize-space())" flag="fatal">Norwegian organization number MUST be stated in the correct format.</assert>
    </rule>
    <rule
      context="cbc:EndpointID[@schemeID = '0184'] | cac:PartyIdentification/cbc:ID[@schemeID = '0184'] | cbc:CompanyID[@schemeID = '0184']">
      <assert id="PEPPOL-COMMON-R042"
        test="(string-length(text()) = 10) and (substring(text(), 1, 2) = 'DK') and (string-length(translate(substring(text(), 3, 8), '1234567890', '')) = 0)"
        flag="fatal">Danish organization number (CVR) MUST be stated in the correct format.</assert>
    </rule>
    <rule
      context="cbc:EndpointID[@schemeID = '0208'] | cac:PartyIdentification/cbc:ID[@schemeID = '0208'] | cbc:CompanyID[@schemeID = '0208']">
      <assert id="PEPPOL-COMMON-R043"
        test="matches(normalize-space(), '^[0-9]{10}$') and u:mod97-0208(normalize-space())"
        flag="fatal">Belgian enterprise number MUST be stated in the correct format.</assert>
    </rule>
    <rule
      context="cbc:EndpointID[@schemeID = '0201'] | cac:PartyIdentification/cbc:ID[@schemeID = '0201'] | cbc:CompanyID[@schemeID = '0201']">
      <assert id="PEPPOL-COMMON-R044" test="u:checkCodiceIPA(normalize-space())" flag="warning">IPA Code (Codice Univoco Unità Organizzativa) must be stated in the correct format</assert>
    </rule>
    <rule
      context="cbc:EndpointID[@schemeID = '0210'] | cac:PartyIdentification/cbc:ID[@schemeID = '0210'] | cbc:CompanyID[@schemeID = '0210']">
      <assert id="PEPPOL-COMMON-R045" test="u:checkCF(normalize-space())" flag="warning">Tax Code (Codice Fiscale) must be stated in the correct format</assert>
    </rule>
    <rule context="cbc:EndpointID[@schemeID = '9907']">
      <assert id="PEPPOL-COMMON-R046" test="u:checkCF(normalize-space())" flag="warning">Tax Code (Codice Fiscale) must be stated in the correct format</assert>
    </rule>
    <rule
      context="cbc:EndpointID[@schemeID = '0211'] | cac:PartyIdentification/cbc:ID[@schemeID = '0211'] | cbc:CompanyID[@schemeID = '0211']">
      <assert id="PEPPOL-COMMON-R047" test="u:checkPIVAseIT(normalize-space())" flag="warning">Italian VAT Code (Partita Iva) must be stated in the correct format</assert>
    </rule>
    <!--    <rule context="cbc:EndpointID[@schemeID = '9906']">
      <assert id="PEPPOL-COMMON-R048" test="u:checkPIVAseIT(normalize-space())" flag="warning">Italian
    VAT Code (Partita Iva) must be stated in the correct format</assert>
    </rule> -->
    <rule
      context="cbc:EndpointID[@schemeID = '0007'] | cac:PartyIdentification/cbc:ID[@schemeID = '0007'] | cbc:CompanyID[@schemeID = '0007']">
      <assert id="PEPPOL-COMMON-R049"
        test="string-length(normalize-space()) = 10 and string(number(normalize-space())) != 'NaN' and u:checkSEOrgnr(normalize-space())"
        flag="fatal">Swedish organization number MUST be stated in the correct format.</assert>
    </rule>
    <rule
      context="cbc:EndpointID[@schemeID = '0151'] | cac:PartyIdentification/cbc:ID[@schemeID = '0151'] | cbc:CompanyID[@schemeID = '0151']">
      <assert id="PEPPOL-COMMON-R050"
        test="matches(normalize-space(), '^[0-9]{11}$') and u:abn(normalize-space())" flag="fatal">Australian Business Number (ABN) MUST be stated in the correct format.</assert>
    </rule>
  </pattern>

 <!-- National rules -->

  <!-- National rules that were in general invoice profile are not included in the self billing and need to be reviewed and added by each country. -->

  <!-- Restricted code lists and formatting -->
  <pattern>
    <let name="ISO3166"
      value="tokenize('AD AE AF AG AI AL AM AO AQ AR AS AT AU AW AX AZ BA BB BD BE BF BG BH BI BJ BL BM BN BO BQ BR BS BT BV BW BY BZ CA CC CD CF CG CH CI CK CL CM CN CO CR CU CV CW CX CY CZ DE DJ DK DM DO DZ EC EE EG EH ER ES ET FI FJ FK FM FO FR GA GB GD GE GF GG GH GI GL GM GN GP GQ GR GS GT GU GW GY HK HM HN HR HT HU ID IE IL IM IN IO IQ IR IS IT JE JM JO JP KE KG KH KI KM KN KP KR KW KY KZ LA LB LC LI LK LR LS LT LU LV LY MA MC MD ME MF MG MH MK ML MM MN MO MP MQ MR MS MT MU MV MW MX MY MZ NA NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM PN PR PS PT PW PY QA RE RO RS RU RW SA SB SC SD SE SG SH SI SJ SK SL SM SN SO SR SS ST SV SX SY SZ TC TD TF TG TH TJ TK TL TM TN TO TR TT TV TW TZ UA UG UM US UY UZ VA VC VE VG VI VN VU WF WS YE YT ZA ZM ZW 1A XI', '\s')" />
    <let name="ISO4217" value="tokenize('AFN EUR ALL DZD USD AOA XCD XCD ARS AMD AWG AUD AZN BSD BHD BDT BBD BYN BZD XOF BMD INR BTN BOB BOV USD BAM BWP NOK BRL USD BND BGN XOF BIF CVE KHR XAF CAD KYD XAF XAF CLP CLF CNY AUD AUD COP COU KMF CDF XAF NZD CRC XOF CUP CUC ANG CZK DKK DJF XCD DOP USD EGP SVC USD XAF ERN ETB FKP DKK FJD XPF XAF GMD GEL GHS GIP DKK XCD USD GTQ GBP GNF XOF GYD HTG USD AUD HNL HKD HUF ISK INR IDR XDR IRR IQD GBP ILS JMD JPY GBP JOD KZT KES AUD KPW KRW KWD KGS LAK LBP LSL ZAR LRD LYD CHF MOP MKD MGA MWK MYR MVR XOF USD MRO MUR XUA MXN MXV USD MDL MNT XCD MAD MZN MMK NAD ZAR AUD NPR XPF NZD NIO XOF NGN NZD AUD USD NOK OMR PKR USD PAB USD PGK PYG PEN PHP NZD PLN USD QAR RON RUB RWF SHP XCD XCD XCD WST STD SAR XOF RSD SCR SLE SGD ANG XSU SBD SOS ZAR SSP LKR SDG SRD NOK SZL SEK CHF CHE CHW SYP TWD TJS TZS THB USD XOF NZD TOP TTD TND TRY TMT USD AUD UGX UAH AED GBP USD USD USN UYU UYI UZS VUV VND USD USD XPF MAD YER ZMW ZWL XBA XBB XBC XBD XTS XXX XAU XPD XPT XAG VES VED ZWG ', '\s')"/>
    <let name="MIMECODE"
      value="tokenize('application/pdf image/png image/jpeg text/csv application/vnd.openxmlformats-officedocument.spreadsheetml.sheet application/vnd.oasis.opendocument.spreadsheet', '\s')" />
    <let name="UNCL2005" value="tokenize('3 35 432', '\s')" />
    <let name="UNCL5189"
      value="tokenize('41 42 60 62 63 64 65 66 67 68 70 71 88 95 100 102 103 104 105', '\s')" />
    <let name="UNCL7161"
      value="tokenize('AA AAA AAC AAD AAE AAF AAH AAI AAS AAT AAV AAY AAZ ABA ABB ABC ABD ABF ABK ABL ABN ABR ABS ABT ABU ACF ACG ACH ACI ACJ ACK ACL ACM ACS ADC ADE ADJ ADK ADL ADM ADN ADO ADP ADQ ADR ADT ADW ADY ADZ AEA AEB AEC AED AEF AEH AEI AEJ AEK AEL AEM AEN AEO AEP AES AET AEU AEV AEW AEX AEY AEZ AJ AU CA CAB CAD CAE CAF CAI CAJ CAK CAL CAM CAN CAO CAP CAQ CAR CAS CAT CAU CAV CAW CAX CAY CAZ CD CG CS CT DAB DAC DAD DAF DAG DAH DAI DAJ DAK DAL DAM DAN DAO DAP DAQ DL EG EP ER FAA FAB FAC FC FH FI GAA HAA HD HH IAA IAB ID IF IR IS KO L1 LA LAA LAB LF MAE MI ML NAA OA PA PAA PC PL RAB RAC RAD RAF RE RF RH RV SA SAA SAD SAE SAI SG SH SM SU TAB TAC TT TV V1 V2 WH XAA YY ZZZ', '\s')" />
    <let name="UNCL5305" value="tokenize('AE E S Z G O K L M', '\s')" />
    <let name="eaid" value="tokenize('0002 0007 0009 0037 0060 0088 0096 0097 0106 0130 0135 0142 0147 0151 0170 0177 0183 0184 0188 0190 0191 0192 0193 0195 0196 0198 0199 0200 0201 0202 0204 0208 0209 0210 0211 0212 0213 0215 0216 0218 0221 0230 0235 9901 9906 9907 9910 9913 9914 9915 9918 9919 9920 9922 9923 9924 9925 9926 9927 9928 9929 9930 9931 9932 9933 9934 9935 9936 9937 9938 9939 9940 9941 9942 9943 9944 9945 9946 9947 9948 9949 9950 9951 9952 9953 9957 9959', '\s')"/>
    <rule context="cbc:EmbeddedDocumentBinaryObject[@mimeCode]">
      <assert id="PEPPOL-EN16931-CL001"
        test="
          some $code in $MIMECODE
            satisfies @mimeCode = $code"
        flag="fatal">Mime code must be according to subset of IANA code list.</assert>
    </rule>
    <rule context="cac:AllowanceCharge[cbc:ChargeIndicator = 'false']/cbc:AllowanceChargeReasonCode">
      <assert id="PEPPOL-EN16931-CL002"
        test="
          some $code in $UNCL5189
            satisfies normalize-space(text()) = $code"
        flag="fatal">Reason code MUST be according to subset of UNCL 5189 D.16B.</assert>
    </rule>
    <rule context="cac:AllowanceCharge[cbc:ChargeIndicator = 'true']/cbc:AllowanceChargeReasonCode">
      <assert id="PEPPOL-EN16931-CL003"
        test="
          some $code in $UNCL7161
            satisfies normalize-space(text()) = $code"
        flag="fatal">Reason code MUST be according to UNCL 7161 D.16B.</assert>
    </rule>
    <rule context="cac:InvoicePeriod/cbc:DescriptionCode">
      <assert id="PEPPOL-EN16931-CL006"
        test="
          some $code in $UNCL2005
            satisfies normalize-space(text()) = $code"
        flag="fatal">Invoice period description code must be according to UNCL 2005 D.16B.</assert>
    </rule>
    <rule
      context="cbc:Amount | cbc:BaseAmount | cbc:PriceAmount | cbc:TaxAmount | cbc:TaxableAmount | cbc:LineExtensionAmount | cbc:TaxExclusiveAmount | cbc:TaxInclusiveAmount | cbc:AllowanceTotalAmount | cbc:ChargeTotalAmount | cbc:PrepaidAmount | cbc:PayableRoundingAmount | cbc:PayableAmount">
      <assert id="PEPPOL-EN16931-CL007"
        test="
          some $code in $ISO4217
            satisfies @currencyID = $code"
        flag="fatal">Currency code must be according to ISO 4217:2005</assert>
    </rule>
    <rule context="cbc:InvoiceTypeCode">
      <assert id="PEPPOL-EN16931-P0100"
        test="
          $profile != '01' or (some $code in tokenize('389 527', '\s')
            satisfies normalize-space(text()) = $code)"
        flag="fatal">Invoice type code MUST be set according to the profile.</assert>
      <!--assert id="PEPPOL-EN16931-P0112"
        test="not(normalize-space(.) = '326' or normalize-space(.) = '384') or ($supplierCountryIsDE and $customerCountryIsDE)"
        flag="fatal">Invoice type code 326 or 384 are only allowed when both buyer and seller are German organizations </assert-->		
    </rule>
		
    <rule context="cbc:CreditNoteTypeCode">
      <assert id="PEPPOL-EN16931-P0101"
        test="
          $profile != '01' or (some $code in tokenize('261', '\s')
            satisfies normalize-space(text()) = $code)"
        flag="fatal">Credit note type code MUST be set according to the profile.</assert>
    </rule>
    <rule
      context="cbc:IssueDate | cbc:DueDate | cbc:TaxPointDate | cbc:StartDate | cbc:EndDate | cbc:ActualDeliveryDate">
      <assert id="PEPPOL-EN16931-F001"
        test="string-length(text()) = 10 and (string(.) castable as xs:date)" flag="fatal">A date MUST be formatted YYYY-MM-DD.</assert>
    </rule>
    <rule context="cbc:EndpointID[@schemeID]">
      <assert id="PEPPOL-EN16931-CL008"
        test="
        some $code in $eaid
        satisfies @schemeID = $code" flag="fatal">Electronic address identifier scheme must be from the codelist "Electronic Address Identifier Scheme"</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-G']">
      <assert id="PEPPOL-EN16931-P0104" test="normalize-space(cbc:ID)='G'" flag="fatal">Tax Category G MUST be used when exemption reason code is VATEX-EU-G</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-O']">
      <assert id="PEPPOL-EN16931-P0105" test="normalize-space(cbc:ID)='O'" flag="fatal">Tax Category O MUST be used when exemption reason code is VATEX-EU-O</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-IC']">
      <assert id="PEPPOL-EN16931-P0106" test="normalize-space(cbc:ID)='K'" flag="fatal">Tax Category K MUST be used when exemption reason code is VATEX-EU-IC</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-AE']">
      <assert id="PEPPOL-EN16931-P0107" test="normalize-space(cbc:ID)='AE'" flag="fatal">Tax Category AE MUST be used when exemption reason code is VATEX-EU-AE</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-D']">
      <assert id="PEPPOL-EN16931-P0108" test="normalize-space(cbc:ID)='E'" flag="fatal">Tax Category E MUST be used when exemption reason code is VATEX-EU-D</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-F']">
      <assert id="PEPPOL-EN16931-P0109" test="normalize-space(cbc:ID)='E'" flag="fatal">Tax Category E MUST be used when exemption reason code is VATEX-EU-F</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-I']">
      <assert id="PEPPOL-EN16931-P0110" test="normalize-space(cbc:ID)='E'" flag="fatal">Tax Category E MUST be used when exemption reason code is VATEX-EU-I</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-J']">
      <assert id="PEPPOL-EN16931-P0111" test="normalize-space(cbc:ID)='E'" flag="fatal">Tax Category E MUST be used when exemption reason code is VATEX-EU-J</assert>
    </rule>
  </pattern>
</schema>