<?xml version="1.0" encoding="UTF-8"?>
<!--
This schematron uses business terms defined the CEN/EN16931-1 and is reproduced with permission
from CEN. CEN bears no liability from the use of the content and implementation of this schematron
and gives no warranties expressed or implied for any purpose.

Last update: 2026 November release 3.0.3.
 -->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:u="utils" schemaVersion="iso"
  queryBinding="xslt2">
  <title>Rules for Peppol BIS 3.0 Self-Billing</title>
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" prefix="cbc" />
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" prefix="cac" />
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2" prefix="ubl-creditnote" />
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" prefix="ubl-invoice" />
  <ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs" />
  <ns uri="utils" prefix="u" />
  <!-- Parameters -->
<let name="profile"
     value="
       if (normalize-space(/*/cbc:ProfileID) = (
        'urn:fdc:peppol.eu:2017:poacc:selfbilling:01:1.0',
        'urn:peppol:france:billing:regulated',
        'urn:peppol:france:billing:non-regulated'
       ))
       then '01'
       else if (normalize-space(/*/cbc:ProfileID) = 'urn:peppol:bis:billing_with_response')
       then '02'
       else 'Unknown'
     " />
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
    <sequence select="(10 - ($weightedSum mod 10)) mod 10 = number(substring($val, $length + 1, 1))" />
  </function>
  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:slack" as="xs:boolean">
    <param name="exp" as="xs:decimal" />
    <param name="val" as="xs:decimal" />
    <param name="slack" as="xs:decimal" />
    <sequence select="xs:decimal($exp + $slack) &gt;= $val and xs:decimal($exp - $slack) &lt;= $val" />
  </function>
  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:mod11" as="xs:boolean">
    <param name="val" />
    <variable name="length" select="string-length($val) - 1" />
    <variable name="digits"
      select="reverse(for $i in string-to-codepoints(substring($val, 0, $length + 1)) return $i - 48)" />
    <variable name="weightedSum"
      select="sum(for $i in (0 to $length - 1) return $digits[$i + 1] * (($i mod 6) + 2))" />
    <sequence
      select="number($val) &gt; 0 and (11 - ($weightedSum mod 11)) mod 11 = number(substring($val, $length + 1, 1))" />
  </function>
  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:mod97-0208" as="xs:boolean">
    <param name="val" />
    <variable name="checkdigits" select="substring($val,9,2)" />
    <variable name="calculated_digits"
      select="xs:string(97 - (xs:integer(substring($val,1,8)) mod 97))" />
    <sequence select="number($checkdigits) = number($calculated_digits)" />
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
    <sequence
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
    <sequence select="($checksum  mod 11) mod 10 = number($digits[9])" />
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
          <sequence
            select="xs:integer(sum(
						for $pos in 1 to string-length($mainPart) return 
							if ($pos mod 2 = 1) 
							then (number(substring($mainPart, string-length($mainPart) - $pos + 1, 1)) * 2) mod 10 + 
								 (number(substring($mainPart, string-length($mainPart) - $pos + 1, 1)) * 2) idiv 10 
							else number(substring($mainPart, string-length($mainPart) - $pos + 1, 1))
					))" />
        </variable>
        <variable name="calculatedCheckDigit" select="(10 - $sum mod 10) mod 10" />
        <sequence select="$calculatedCheckDigit = number($checkDigit)" />
      </otherwise>
    </choose>
  </function>
  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:mod89-LU_VAT" as="xs:boolean">
    <param name="val" as="xs:string"/>
    <variable name="normalized" select="upper-case(normalize-space($val))"/>
    <variable name="base" select="substring($normalized, 3, 6)"/>
    <variable name="checkdigits" select="substring($normalized, 9, 2)"/>
    <variable name="calculated" select="format-integer(xs:integer($base) mod 89, '00')"/>
    <sequence select="$checkdigits = $calculated"/>
  </function>
  <!-- Function for Luxembourg Register of Legal Persons number (Matricule) (0240) -->
  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:check-lux-0240" as="xs:boolean">
    <param name="val" as="xs:string"/>
    <choose>
      <when test="not(matches($val, '^[0-9]{11}$'))">
        <sequence select="false()"/>
      </when>
      <otherwise>
        <variable name="typecode"   select="xs:integer(substring($val, 5, 2))"/>
        <choose>
          <when test="not($typecode ge 20 and $typecode le 99)">
            <sequence select="false()"/>
          </when>
          <otherwise>
            <variable name="digits"     select="for $c in string-to-codepoints($val) return $c - 48"/>
            <variable name="weights"    select="(5, 4, 3, 2, 7, 6, 5, 4, 3, 2)"/>
            <variable name="wsum"       select="sum(for $i in 1 to 10 return $digits[$i] * $weights[$i])"/>
            <variable name="remainder"  select="$wsum mod 11"/>
            <variable name="exp11"      select="if ($remainder = 0) then 0 else 11 - $remainder"/>
            <variable name="exp12"      select="if ($remainder = 0) then 1 else if ($remainder = 1) then 0 else 12 - $remainder"/>
            <variable name="checkdigit" select="$digits[11]"/>
            <variable name="valid"      select="if ($typecode = 24) then ($checkdigit = $exp11 or $checkdigit = $exp12) else $checkdigit = $exp11"/>
            <sequence select="$valid"/>
          </otherwise>
        </choose>
      </otherwise>
    </choose>
  </function>
  <!-- Empty elements -->
  <pattern>
    <rule context="//*[not(*) and not(normalize-space())]">
      <assert id="PEPPOL-EN16931-R008" test="false()" flag="fatal">[PEPPOL-EN16931-R008]-Document MUST not contain empty elements.</assert>
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
        flag="fatal">[PEPPOL-EN16931-R080]-Only one project reference is allowed on document level</assert>
    </rule>
  </pattern>
  <pattern>
    <!-- Document level -->
    <rule context="ubl-creditnote:CreditNote | ubl-invoice:Invoice">
      <assert id="PEPPOL-EN16931-R001" test="cbc:ProfileID" flag="fatal">[PEPPOL-EN16931-R001]-Business process MUST be provided.</assert>
      <assert id="PEPPOL-EN16931-R007" test="$profile != 'Unknown'" flag="fatal">[PEPPOL-EN16931-R007]-Business process MUST have an approved identifier.</assert>
      <assert id="PEPPOL-EN16931-R002"
        test="count(cbc:Note) &lt;= 1 or ($supplierCountryIsDE and $customerCountryIsDE)"
        flag="fatal">[PEPPOL-EN16931-R002]-No more than one note is allowed on document level, unless both the buyer and seller are German organizations.</assert>
      <assert id="PEPPOL-EN16931-R003" test="cbc:BuyerReference or cac:OrderReference/cbc:ID"
        flag="fatal">[PEPPOL-EN16931-R003]-A buyer reference or purchase order reference MUST be provided.</assert>
      <assert id="PEPPOL-EN16931-R004"
        test="starts-with(normalize-space(cbc:CustomizationID/text()), 'urn:cen.eu:en16931:2017#compliant#urn:fdc:peppol.eu:2017:poacc:selfbilling:3.0') and not(contains(normalize-space(cbc:CustomizationID/text()), '::'))"
        flag="fatal">[PEPPOL-EN16931-R004]-Specification identifier MUST have the value 'urn:cen.eu:en16931:2017#compliant#urn:fdc:peppol.eu:2017:poacc:selfbilling:3.0' and follow the format rules for the identifier.</assert>
      <assert id="PEPPOL-EN16931-R053" test="count(cac:TaxTotal[cac:TaxSubtotal]) = 1" flag="fatal">[PEPPOL-EN16931-R053]-Only one tax total with tax subtotals MUST be provided.</assert>
      <assert id="PEPPOL-EN16931-R054"
        test="count(cac:TaxTotal[not(cac:TaxSubtotal)]) = (if (cbc:TaxCurrencyCode) then 1 else 0)"
        flag="fatal">[PEPPOL-EN16931-R054]-Only one tax total without tax subtotals MUST be provided when tax currency code is provided.</assert>
      <assert id="PEPPOL-EN16931-R055"
        test="not(cbc:TaxCurrencyCode) or (cac:TaxTotal/cbc:TaxAmount[@currencyID=normalize-space(../../cbc:TaxCurrencyCode)] &lt;= 0 and cac:TaxTotal/cbc:TaxAmount[@currencyID=normalize-space(../../cbc:DocumentCurrencyCode)] &lt;= 0) or (cac:TaxTotal/cbc:TaxAmount[@currencyID=normalize-space(../../cbc:TaxCurrencyCode)] &gt;= 0 and cac:TaxTotal/cbc:TaxAmount[@currencyID=normalize-space(../../cbc:DocumentCurrencyCode)] &gt;= 0) "
        flag="fatal">[PEPPOL-EN16931-R055]-Invoice total VAT amount and Invoice total VAT amount in accounting currency MUST have the same operational sign</assert>
    </rule>
    <rule context="cbc:TaxCurrencyCode">
      <assert id="PEPPOL-EN16931-R005"
        test="not(normalize-space(text()) = normalize-space(../cbc:DocumentCurrencyCode/text()))"
        flag="fatal">[PEPPOL-EN16931-R005]-VAT accounting currency code MUST be different from invoice currency code when provided.</assert>
    </rule>
    <!-- Accounting customer -->
    <rule context="cac:AccountingCustomerParty/cac:Party">
      <assert id="PEPPOL-EN16931-R010" test="cbc:EndpointID" flag="fatal">[PEPPOL-EN16931-R010]-Buyer electronic address MUST be provided</assert>
    </rule>
    <!-- Accounting supplier -->
    <rule context="cac:AccountingSupplierParty/cac:Party">
      <assert id="PEPPOL-EN16931-R020" test="cbc:EndpointID" flag="fatal">[PEPPOL-EN16931-R020]-Seller electronic address MUST be provided</assert>
    </rule>
    <!-- Allowance/Charge (document level/line level) -->
    <rule
      context="ubl-invoice:Invoice/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)] | ubl-invoice:Invoice/cac:InvoiceLine/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)] | ubl-creditnote:CreditNote/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)] | ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)]">
      <assert id="PEPPOL-EN16931-R041" test="false()" flag="fatal">[PEPPOL-EN16931-R041]-Allowance/charge base amount MUST be provided when allowance/charge percentage is provided.</assert>
    </rule>
    <rule
      context="ubl-invoice:Invoice/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount] | ubl-invoice:Invoice/cac:InvoiceLine/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount] | ubl-creditnote:CreditNote/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount] | ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount]">
      <assert id="PEPPOL-EN16931-R042" test="false()" flag="fatal">[PEPPOL-EN16931-R042]-Allowance/charge percentage MUST be provided when allowance/charge base amount is provided.</assert>
    </rule>
    <rule
      context="ubl-invoice:Invoice/cac:AllowanceCharge | ubl-invoice:Invoice/cac:InvoiceLine/cac:AllowanceCharge | ubl-creditnote:CreditNote/cac:AllowanceCharge | ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:AllowanceCharge">
      <assert id="PEPPOL-EN16931-R040"
        test="
          not(cbc:MultiplierFactorNumeric and cbc:BaseAmount) or u:slack(if (cbc:Amount) then
            cbc:Amount
          else
            0, (xs:decimal(cbc:BaseAmount) * xs:decimal(cbc:MultiplierFactorNumeric)) div 100, 0.02)"
        flag="fatal">[PEPPOL-EN16931-R040]-Allowance/charge amount must equal base amount * percentage/100 if base amount and percentage exists</assert>
      <assert id="PEPPOL-EN16931-R043"
        test="normalize-space(cbc:ChargeIndicator/text()) = 'true' or normalize-space(cbc:ChargeIndicator/text()) = 'false'"
        flag="fatal">[PEPPOL-EN16931-R043]-Allowance/charge ChargeIndicator value MUST equal 'true' or 'false'</assert>
    </rule>
    <!-- Payment -->
    <rule
      context="
        cac:PaymentMeans[some $code in tokenize('49 59', '\s')
          satisfies normalize-space(cbc:PaymentMeansCode) = $code]">
      <assert id="PEPPOL-EN16931-R061" test="cac:PaymentMandate/cbc:ID" flag="fatal">[PEPPOL-EN16931-R061]-Mandate reference MUST be provided for direct debit.</assert>
    </rule>
    <!-- Currency -->
    <rule
      context="cbc:Amount | cbc:BaseAmount | cbc:PriceAmount | cac:TaxTotal[cac:TaxSubtotal]/cbc:TaxAmount | cbc:TaxableAmount | cac:TaxSubtotal/cbc:TaxAmount | cbc:LineExtensionAmount | cbc:TaxExclusiveAmount | cbc:TaxInclusiveAmount | cbc:AllowanceTotalAmount | cbc:ChargeTotalAmount | cbc:PrepaidAmount | cbc:PayableRoundingAmount | cbc:PayableAmount">
      <assert id="PEPPOL-EN16931-R051" test="@currencyID = $documentCurrencyCode" flag="fatal">[PEPPOL-EN16931-R051]-All currencyID attributes must have the same value as the invoice currency code (BT-5), except for the invoice total VAT amount in accounting currency (BT-111).</assert>
    </rule>
    <!-- Line level - invoice period -->
    <rule
      context="ubl-invoice:Invoice[cac:InvoicePeriod/cbc:StartDate]/cac:InvoiceLine/cac:InvoicePeriod/cbc:StartDate | ubl-creditnote:CreditNote[cac:InvoicePeriod/cbc:StartDate]/cac:CreditNoteLine/cac:InvoicePeriod/cbc:StartDate">
      <assert id="PEPPOL-EN16931-R110"
        test="xs:date(text()) &gt;= xs:date(../../../cac:InvoicePeriod/cbc:StartDate)" flag="fatal">[PEPPOL-EN16931-R110]-Start date of line period MUST be within invoice period.</assert>
    </rule>
    <rule
      context="ubl-invoice:Invoice[cac:InvoicePeriod/cbc:EndDate]/cac:InvoiceLine/cac:InvoicePeriod/cbc:EndDate | ubl-creditnote:CreditNote[cac:InvoicePeriod/cbc:EndDate]/cac:CreditNoteLine/cac:InvoicePeriod/cbc:EndDate">
      <assert id="PEPPOL-EN16931-R111"
        test="xs:date(text()) &lt;= xs:date(../../../cac:InvoicePeriod/cbc:EndDate)" flag="fatal">[PEPPOL-EN16931-R111]-End date of line period MUST be within invoice period.</assert>
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
        flag="fatal">[PEPPOL-EN16931-R120]-Invoice line net amount MUST equal (Invoiced quantity * (Item net price/item price base quantity) + Sum of invoice line charge amount - sum of invoice line allowance amount</assert>
      <assert id="PEPPOL-EN16931-R121"
        test="not(cac:Price/cbc:BaseQuantity) or xs:decimal(cac:Price/cbc:BaseQuantity) &gt; 0"
        flag="fatal">[PEPPOL-EN16931-R121]-Base quantity MUST be a positive number above zero.</assert>
      <assert id="PEPPOL-EN16931-R100" test="(count(cac:DocumentReference) &lt;= 1)" flag="fatal">[PEPPOL-EN16931-R100]-Only one invoiced object is allowed pr line</assert>
      <assert id="PEPPOL-EN16931-R101"
        test="(not(cac:DocumentReference) or (cac:DocumentReference/cbc:DocumentTypeCode='130'))"
        flag="fatal">[PEPPOL-EN16931-R101]-Element Document reference can only be used for Invoice line object</assert>
    </rule>
    <!-- Allowance (price level) -->
    <rule context="cac:Price/cac:AllowanceCharge">
      <assert id="PEPPOL-EN16931-R044" test="normalize-space(cbc:ChargeIndicator) = 'false'"
        flag="fatal">[PEPPOL-EN16931-R044]-Charge on price level is NOT allowed. Only value 'false' allowed.</assert>
      <assert id="PEPPOL-EN16931-R046"
        test="not(cbc:BaseAmount) or xs:decimal(../cbc:PriceAmount) = xs:decimal(cbc:BaseAmount) - xs:decimal(cbc:Amount)"
        flag="fatal">[PEPPOL-EN16931-R046]-Item net price MUST equal (Gross price - Allowance amount) when gross price is provided.</assert>
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
        flag="fatal">[PEPPOL-EN16931-R130]-Unit code of price base quantity MUST be same as invoiced quantity.</assert>
    </rule>
    <!-- Validation of ICD -->
    <rule
      context="cbc:EndpointID[@schemeID = '0088'] | cac:PartyIdentification/cbc:ID[@schemeID = '0088'] | cbc:CompanyID[@schemeID = '0088']">
      <assert id="PEPPOL-COMMON-R040"
        test="matches(normalize-space(), '^[0-9]{13}$') and u:gln(normalize-space())" flag="fatal">[PEPPOL-COMMON-R040]-GLN13 MUST have a valid format according to GS1 rules.</assert>
    </rule>
    <rule
      context="cbc:EndpointID[@schemeID = '0192'] | cac:PartyIdentification/cbc:ID[@schemeID = '0192'] | cbc:CompanyID[@schemeID = '0192']">
      <assert id="PEPPOL-COMMON-R041"
        test="matches(normalize-space(), '^[0-9]{9}$') and u:mod11(normalize-space())" flag="fatal">[PEPPOL-COMMON-R041]-Norwegian organization number MUST be stated in the correct format.</assert>
    </rule>
    <rule
      context="cbc:EndpointID[@schemeID = '0184'] | cac:PartyIdentification/cbc:ID[@schemeID = '0184'] | cbc:CompanyID[@schemeID = '0184']">
      <assert id="PEPPOL-COMMON-R042"
          test="(string-length(string()) = 10 and substring(string(), 1, 2) = 'DK' and string-length(translate(substring(string(), 3, 8), '1234567890', '')) = 0)
                 or
                (string-length(string()) = 8) and (string-length(translate(substring(string(), 1, 8),'1234567890', '')) = 0)"
        flag="fatal">[PEPPOL-COMMON-R042]-Danish organization number (CVR) MUST be stated in the correct format.</assert>
    </rule>
    <rule
      context="cbc:EndpointID[@schemeID = '0208'] | cac:PartyIdentification/cbc:ID[@schemeID = '0208'] | cbc:CompanyID[@schemeID = '0208']">
      <assert id="PEPPOL-COMMON-R043"
        test="matches(normalize-space(), '^[01][0-9]{9}$') and u:mod97-0208(normalize-space())"
        flag="fatal">[PEPPOL-COMMON-R043]-Belgian enterprise number MUST be stated in the correct format.</assert>
    </rule>
    <rule
      context="cac:PartyTaxScheme
                   [normalize-space(cac:TaxScheme/cbc:ID) = 'VAT']
                   /cbc:CompanyID
                   [starts-with(normalize-space(.), 'BE')]">
      <assert id="PEPPOL-COMMON-R062"
        flag="warning"
        test="matches(upper-case(normalize-space(.)), '^BE[01][0-9]{9}$') and u:mod97-0208(substring(upper-case(normalize-space(.)), 3))">[PEPPOL-COMMON-R062]-Belgian VAT number MUST be stated in the correct format.</assert>
    </rule>
    <rule
      context="cbc:EndpointID[@schemeID = '0201'] | cac:PartyIdentification/cbc:ID[@schemeID = '0201'] | cbc:CompanyID[@schemeID = '0201']">
      <assert id="PEPPOL-COMMON-R044" test="u:checkCodiceIPA(normalize-space())" flag="warning">[PEPPOL-COMMON-R044]-IPA Code (Codice Univoco Unità Organizzativa) SHOULD be stated in the correct format</assert>
    </rule>
    <rule 
      context="cbc:EndpointID[@schemeID = '0210'] | cac:PartyIdentification/cbc:ID[@schemeID = '0210'] | cbc:CompanyID[@schemeID = '0210']">
      <assert id="PEPPOL-COMMON-R045" test="u:checkCF(normalize-space())" flag="warning">[PEPPOL-COMMON-R045]-Tax Code (Codice Fiscale) SHOULD be stated in the correct format</assert>
    </rule>
    <rule context="cbc:EndpointID[@schemeID = '9907']">
      <assert id="PEPPOL-COMMON-R046" test="u:checkCF(normalize-space())" flag="warning">[PEPPOL-COMMON-R046]-Tax Code (Codice Fiscale) SHOULD be stated in the correct format</assert>
    </rule>
    <rule
      context="cbc:EndpointID[@schemeID = '0211'] | cac:PartyIdentification/cbc:ID[@schemeID = '0211'] | cbc:CompanyID[@schemeID = '0211']">
      <assert id="PEPPOL-COMMON-R047" test="u:checkPIVAseIT(normalize-space())" flag="warning">[PEPPOL-COMMON-R047]-Italian VAT Code (Partita Iva) SHOULD be stated in the correct format</assert>
    </rule>
    <!--    <rule context="cbc:EndpointID[@schemeID = '9906']">
      <assert id="PEPPOL-COMMON-R048" test="u:checkPIVAseIT(normalize-space())" flag="warning">Italian
    VAT Code (Partita Iva) must be stated in the correct format</assert>
    </rule> -->
    <rule
      context="cbc:EndpointID[@schemeID = '0007'] | cac:PartyIdentification/cbc:ID[@schemeID = '0007'] | cbc:CompanyID[@schemeID = '0007']">
      <assert id="PEPPOL-COMMON-R049"
        test="string-length(normalize-space()) = 10 and string(number(normalize-space())) != 'NaN' and u:checkSEOrgnr(normalize-space())"
        flag="fatal">[PEPPOL-COMMON-R049]-Swedish organization number MUST be stated in the correct format.</assert>
    </rule>
    <rule 
      context="cbc:EndpointID[@schemeID = '0151'] | cac:PartyIdentification/cbc:ID[@schemeID = '0151'] | cbc:CompanyID[@schemeID = '0151']">
      <assert id="PEPPOL-COMMON-R050"
        test="matches(normalize-space(), '^[0-9]{11}$') and u:abn(normalize-space())" flag="fatal">[PEPPOL-COMMON-R050]-Australian Business Number (ABN) MUST be stated in the correct format.</assert>
    </rule>
    <rule context="cbc:EndpointID[@schemeID = '0096'] | cac:PartyIdentification/cbc:ID[@schemeID = '0096'] | cbc:CompanyID[@schemeID = '0096']">
      <assert id="PEPPOL-COMMON-R052" test="(string-length(string()) = 10) and (string-length(translate(substring(string(), 1, 10),'1234567890', '')) = 0)" flag="fatal">[PEPPOL-COMMON-R052]-Danish chamber of commerce number (P) MUST be stated in the correct format.</assert>
    </rule>
    <rule context="cbc:EndpointID[@schemeID = '0198'] | cac:PartyIdentification/cbc:ID[@schemeID = '0198'] | cbc:CompanyID[@schemeID = '0198']">
      <assert id="PEPPOL-COMMON-R053" test="(string-length(string()) = 10 and substring(string(), 1, 2) = 'DK' and string-length(translate(substring(string(), 3, 8), '1234567890', '')) = 0)" flag="fatal">[PEPPOL-COMMON-R053]-Danish ERSTORG number (SE) MUST be stated in the correct format.</assert>
    </rule>
    <rule context="cbc:EndpointID[@schemeID = '0106'] | cac:PartyIdentification/cbc:ID[@schemeID = '0106'] | cbc:CompanyID[@schemeID = '0106']">
      <assert id="PEPPOL-COMMON-R054" test="matches(normalize-space(), '^[0-9]{8}$')" flag="fatal">[PEPPOL-COMMON-R054]-Dutch Chamber of Commerce (KVK) numbers (0106) MUST be stated in the correct format (12345678).</assert>
    </rule>
    <rule context="cbc:EndpointID[@schemeID = '0190'] | cac:PartyIdentification/cbc:ID[@schemeID = '0190'] | cbc:CompanyID[@schemeID = '0190']">
      <assert id="PEPPOL-COMMON-R055" test="matches(normalize-space(), '^[0-9]{20}$')" flag="fatal">[PEPPOL-COMMON-R055]-Dutch organization identification numbers (0190) MUST be stated in the correct format (12345678901234567890).</assert>
    </rule>
    <rule context="cbc:EndpointID[@schemeID = '9944'] | cac:PartyIdentification/cbc:ID[@schemeID = '9944'] | cbc:CompanyID[@schemeID = '9944']">
      <assert id="PEPPOL-COMMON-R056-1" test="matches(normalize-space(), '^NL[0-9]{9}B[0-9]{2}$')" flag="fatal">[PEPPOL-COMMON-R056-1]-Dutch VAT numbers (9944) MUST be stated in the correct format (NL123456789B12).</assert>
    </rule>
    <!-- If main VAT number starts with NL, validate that too -->
    <rule context="cac:PartyTaxScheme
                   [normalize-space(cac:TaxScheme/cbc:ID) = 'VAT']
                   /cbc:CompanyID
                   [starts-with(normalize-space(.), 'NL')]">
    <assert id="PEPPOL-COMMON-R056-2" test="matches(normalize-space(.), '^NL[0-9]{9}B[0-9]{2}$')" flag="fatal">[PEPPOL-COMMON-R056-2]-Dutch VAT numbers MUST have the format (NL123456789B12).</assert>
    </rule>
    <rule context="cbc:EndpointID[@schemeID = '0217'] | cac:PartyIdentification/cbc:ID[@schemeID = '0217'] | cbc:CompanyID[@schemeID = '0217']">
      <assert id="PEPPOL-COMMON-R057" test="matches(normalize-space(), '^[0-9]{12}$')" flag="fatal">[PEPPOL-COMMON-R057]-Dutch Chamber of Commerce Establishment numbers (0217) MUST be stated in the correct format (123456789012).</assert>
    </rule>
    <!-- Luxembourg VAT number validation -->
    <rule
      context="cac:PartyTaxScheme
                   [normalize-space(cac:TaxScheme/cbc:ID) = 'VAT']
                   /cbc:CompanyID
                   [starts-with(upper-case(normalize-space(.)), 'LU')]">
      <assert id="PEPPOL-COMMON-R058"
              flag="warning"
              test="matches(upper-case(normalize-space(.)), '^LU[0-9]{8}$') and u:mod89-LU_VAT(.)">
        [PEPPOL-COMMON-R058]-Luxembourg VAT number MUST be stated in the correct format.
      </assert>
    </rule>
    <!-- Luxembourg Register of Legal Persons number (Matricule) validation -->
    <rule context="cbc:EndpointID[@schemeID = '0240'] | cac:PartyIdentification/cbc:ID[@schemeID = '0240'] | cbc:CompanyID[@schemeID = '0240']">
      <assert id="PEPPOL-COMMON-R059"
              flag="warning"
              test="u:check-lux-0240(normalize-space(.))">[PEPPOL-COMMON-R059]-Luxembourg Register of Legal Persons number (Matricule) MUST be stated in the correct format.</assert>
    </rule>
  </pattern>

 <!-- National rules -->

  <!-- National rules that were in general invoice profile are not included in the self billing and need to be reviewed and added by each country. -->

  <!-- Restricted code lists and formatting -->
  <pattern>
    <let name="ISO3166"
      value="tokenize('AD AE AF AG AI AL AM AO AQ AR AS AT AU AW AX AZ BA BB BD BE BF BG BH BI BJ BL BM BN BO BQ BR BS BT BV BW BY BZ CA CC CD CF CG CH CI CK CL CM CN CO CR CU CV CW CX CY CZ DE DJ DK DM DO DZ EC EE EG EH ER ES ET FI FJ FK FM FO FR GA GB GD GE GF GG GH GI GL GM GN GP GQ GR GS GT GU GW GY HK HM HN HR HT HU ID IE IL IM IN IO IQ IR IS IT JE JM JO JP KE KG KH KI KM KN KP KR KW KY KZ LA LB LC LI LK LR LS LT LU LV LY MA MC MD ME MF MG MH MK ML MM MN MO MP MQ MR MS MT MU MV MW MX MY MZ NA NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM PN PR PS PT PW PY QA RE RO RS RU RW SA SB SC SD SE SG SH SI SJ SK SL SM SN SO SR SS ST SV SX SY SZ TC TD TF TG TH TJ TK TL TM TN TO TR TT TV TW TZ UA UG UM US UY UZ VA VC VE VG VI VN VU WF WS YE YT ZA ZM ZW 1A XI', '\s')" />
    <let name="ISO4217" value="tokenize('AED AFN ALL AMD AOA ARS AUD AWG AZN BAM BBD BDT BHD BIF BMD BND BOB BOV BRL BSD BTN BWP BYN BZD CAD CDF CHE CHF CHW CLF CLP CNY COP COU CRC CUP CVE CZK DJF DKK DOP DZD EGP ERN ETB EUR FJD FKP GBP GEL GHS GIP GMD GNF GTQ GYD HKD HNL HTG HUF IDR ILS INR IQD IRR ISK JMD JOD JPY KES KGS KHR KMF KPW KRW KWD KYD KZT LAK LBP LKR LRD LSL LYD MAD MDL MGA MKD MMK MNT MOP MRU MUR MVR MWK MXN MXV MYR MZN NAD NGN NIO NOK NPR NZD OMR PAB PEN PGK PHP PKR PLN PYG QAR RON RSD RUB RWF SAR SBD SCR SDG SEK SGD SHP SLE SOS SRD SSP STN SVC SYP SZL THB TJS TMT TND TOP TRY TTD TWD TZS UAH UGX USD USN UYI UYU UYW UZS VED VES VND VUV WST XAF XAG XAU XBA XBB XBC XBD XCD XDR XOF XPD XPF XPT XSU XTS XUA YER ZAR ZMW ZWG CNH XCG XXX', '\s')"/>
    <let name="MIMECODE"
      value="tokenize('application/pdf image/png image/jpeg text/csv application/vnd.openxmlformats-officedocument.spreadsheetml.sheet application/vnd.oasis.opendocument.spreadsheet', '\s')" />
    <let name="UNCL2005" value="tokenize('3 35 432', '\s')" />
    <let name="UNCL5189"
      value="tokenize('41 42 60 62 63 64 65 66 67 68 70 71 88 95 100 102 103 104 105', '\s')" />
    <let name="UNCL7161" value="tokenize('AA AAA AAC AAD AAE AAF AAH AAI AAS AAT AAV AAY AAZ ABA ABB ABC ABD ABF ABK ABL ABN ABR ABS ABT ABU ACF ACG ACH ACI ACJ ACK ACL ACM ACS ADC ADE ADJ ADK ADL ADM ADN ADO ADP ADQ ADR ADT ADW ADY ADZ AEA AEB AEC AED AEF AEH AEI AEJ AEK AEL AEM AEN AEO AEP AES AET AEU AEV AEW AEX AEY AEZ AJ AU CA CAB CAD CAE CAF CAI CAJ CAK CAL CAM CAN CAO CAP CAQ CAR CAS CAT CAU CAV CAW CAX CAY CAZ CD CG CS CT DAB DAC DAD DAF DAG DAH DAI DAJ DAK DAL DAM DAN DAO DAP DAQ DL EG EP ER FAA FAB FAC FC FH FI GAA HAA HD HH IAA IAB ID IF IR IS KO L1 LA LAA LAB LF MAE MI ML NAA OA PA PAA PC PL PRV RAB RAC RAD RAF RE RF RH RV SA SAA SAD SAE SAI SG SH SM SU TAB TAC TT TV V1 V2 WH XAA YY ZZZ', '\s')" />
    <let name="UNCL5305" value="tokenize('AE E S Z G O K L M B', '\s')" />
    <let name="eaid" value="tokenize('0002 0007 0009 0060 0088 0096 0097 0106 0130 0135 0142 0151 0158 0183 0184 0188 0190 0191 0192 0195 0196 0198 0199 0200 0201 0204 0208 0209 0210 0211 0216 0218 0221 0230 0235 9910 9913 9914 9915 9918 9919 9920 9922 9923 9924 9925 9926 9927 9928 9929 9930 9931 9932 9933 9934 9935 9936 9937 9938 9939 9940 9941 9942 9943 9944 9945 9946 9947 9948 9949 9950 9951 9952 9953 9957 9959 0225 0240 0244 0245 0242 0246 0248', '\s')"/>
    <rule context="cbc:EmbeddedDocumentBinaryObject[@mimeCode]">
      <assert id="PEPPOL-EN16931-CL001"
        test="
          some $code in $MIMECODE
            satisfies @mimeCode = $code"
        flag="fatal">[PEPPOL-EN16931-CL001]-Mime code must be according to subset of IANA code list.</assert>
    </rule>
    <rule context="cac:AllowanceCharge[cbc:ChargeIndicator = 'false']/cbc:AllowanceChargeReasonCode">
      <assert id="PEPPOL-EN16931-CL002"
        test="
          some $code in $UNCL5189
            satisfies normalize-space(text()) = $code"
        flag="fatal">[PEPPOL-EN16931-CL002]-Reason code MUST be according to subset of UNCL 5189 D.16B.</assert>
    </rule>
    <rule context="cac:AllowanceCharge[cbc:ChargeIndicator = 'true']/cbc:AllowanceChargeReasonCode">
      <assert id="PEPPOL-EN16931-CL003"
        test="
          some $code in $UNCL7161
            satisfies normalize-space(text()) = $code"
        flag="fatal">[PEPPOL-EN16931-CL003]-Reason code MUST be according to UNCL 7161 D.16B.</assert>
    </rule>
    <rule context="cac:InvoicePeriod/cbc:DescriptionCode">
      <assert id="PEPPOL-EN16931-CL006"
        test="
          some $code in $UNCL2005
            satisfies normalize-space(text()) = $code"
        flag="fatal">[PEPPOL-EN16931-CL006]-Invoice period description code must be according to UNCL 2005 D.16B.</assert>
    </rule>
    <rule
      context="cbc:Amount | cbc:BaseAmount | cbc:PriceAmount | cbc:TaxAmount | cbc:TaxableAmount | cbc:LineExtensionAmount | cbc:TaxExclusiveAmount | cbc:TaxInclusiveAmount | cbc:AllowanceTotalAmount | cbc:ChargeTotalAmount | cbc:PrepaidAmount | cbc:PayableRoundingAmount | cbc:PayableAmount">
      <assert id="PEPPOL-EN16931-CL007"
        test="
          some $code in $ISO4217
            satisfies @currencyID = $code"
        flag="fatal">[PEPPOL-EN16931-CL007]-Currency code must be according to ISO 4217:2005</assert>
    </rule>
    <rule context="cbc:InvoiceTypeCode">
      <assert id="PEPPOL-EN16931-P0100"
        test="
          $profile != '01' or (some $code in tokenize('389 527', '\s')
            satisfies normalize-space(text()) = $code)"
        flag="fatal">[PEPPOL-EN16931-P0100]-Invoice type code MUST be set according to the profile.</assert>
      <!--assert id="PEPPOL-EN16931-P0112"
        test="not(normalize-space(.) = '326' or normalize-space(.) = '384') or ($supplierCountryIsDE and $customerCountryIsDE)"
        flag="fatal">Invoice type code 326 or 384 are only allowed when both buyer and seller are German organizations </assert-->		
    </rule>
		
    <rule context="cbc:CreditNoteTypeCode">
      <assert id="PEPPOL-EN16931-P0101"
        test="
          $profile != '01' or (some $code in tokenize('261', '\s')
            satisfies normalize-space(text()) = $code)"
        flag="fatal">[PEPPOL-EN16931-P0101]-Credit note type code MUST be set according to the profile.</assert>
    </rule>
    <rule
      context="cbc:IssueDate | cbc:DueDate | cbc:TaxPointDate | cbc:StartDate | cbc:EndDate | cbc:ActualDeliveryDate">
      <assert id="PEPPOL-EN16931-F001"
        test="string-length(text()) = 10 and (string(.) castable as xs:date)" flag="fatal">[PEPPOL-EN16931-F001]-A date MUST be formatted YYYY-MM-DD.</assert>
    </rule>
    <rule context="cbc:EndpointID[@schemeID]">
      <assert id="PEPPOL-EN16931-CL008"
        test="
        some $code in $eaid
        satisfies @schemeID = $code" flag="fatal">[PEPPOL-EN16931-CL008]-Electronic address identifier scheme must be from the codelist "Electronic Address Identifier Scheme"</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-G']">
      <assert id="PEPPOL-EN16931-P0104" test="normalize-space(cbc:ID)='G'" flag="fatal">[PEPPOL-EN16931-P0104]-Tax Category G MUST be used when exemption reason code is VATEX-EU-G</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-O']">
      <assert id="PEPPOL-EN16931-P0105" test="normalize-space(cbc:ID)='O'" flag="fatal">[PEPPOL-EN16931-P0105]-Tax Category O MUST be used when exemption reason code is VATEX-EU-O</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-IC']">
      <assert id="PEPPOL-EN16931-P0106" test="normalize-space(cbc:ID)='K'" flag="fatal">[PEPPOL-EN16931-P0106]-Tax Category K MUST be used when exemption reason code is VATEX-EU-IC</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-AE']">
      <assert id="PEPPOL-EN16931-P0107" test="normalize-space(cbc:ID)='AE'" flag="fatal">[PEPPOL-EN16931-P0107]-Tax Category AE MUST be used when exemption reason code is VATEX-EU-AE</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-D']">
      <assert id="PEPPOL-EN16931-P0108" test="normalize-space(cbc:ID)='E'" flag="fatal">[PEPPOL-EN16931-P0108]-Tax Category E MUST be used when exemption reason code is VATEX-EU-D</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-F']">
      <assert id="PEPPOL-EN16931-P0109" test="normalize-space(cbc:ID)='E'" flag="fatal">[PEPPOL-EN16931-P0109]-Tax Category E MUST be used when exemption reason code is VATEX-EU-F</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-I']">
      <assert id="PEPPOL-EN16931-P0110" test="normalize-space(cbc:ID)='E'" flag="fatal">[PEPPOL-EN16931-P0110]-Tax Category E MUST be used when exemption reason code is VATEX-EU-I</assert>
    </rule>
    <rule context="cac:TaxCategory[upper-case(cbc:TaxExemptionReasonCode)='VATEX-EU-J']">
      <assert id="PEPPOL-EN16931-P0111" test="normalize-space(cbc:ID)='E'" flag="fatal">[PEPPOL-EN16931-P0111]-Tax Category E MUST be used when exemption reason code is VATEX-EU-J</assert>
    </rule>
  </pattern>
  <pattern id="inferred-mandatory-cardinality">
    <rule context="ubl-creditnote:CreditNote">
      <assert id="PEPPOL-EN16931-R140" test="count(cac:AccountingCustomerParty) = 1" flag="fatal">[PEPPOL-EN16931-R140]-ubl-creditnote:CreditNote MUST contain exactly one cac:AccountingCustomerParty.</assert>
      <assert id="PEPPOL-EN16931-R205" test="count(cbc:CreditNoteTypeCode) = 1" flag="fatal">[PEPPOL-EN16931-R205]-ubl-creditnote:CreditNote MUST contain exactly one cbc:CreditNoteTypeCode.</assert>
      <assert id="PEPPOL-EN16931-R206" test="count(cbc:CustomizationID) = 1" flag="fatal">[PEPPOL-EN16931-R206]-ubl-creditnote:CreditNote MUST contain exactly one cbc:CustomizationID.</assert>
      <assert id="PEPPOL-EN16931-R207" test="count(cbc:DocumentCurrencyCode) = 1" flag="fatal">[PEPPOL-EN16931-R207]-ubl-creditnote:CreditNote MUST contain exactly one cbc:DocumentCurrencyCode.</assert>
      <assert id="PEPPOL-EN16931-R208" test="count(cbc:ProfileID) = 1" flag="fatal">[PEPPOL-EN16931-R208]-ubl-creditnote:CreditNote MUST contain exactly one cbc:ProfileID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingCustomerParty">
      <assert id="PEPPOL-EN16931-R141" test="count(cac:Party) = 1" flag="fatal">[PEPPOL-EN16931-R141]-ubl-creditnote:CreditNote/cac:AccountingCustomerParty MUST contain exactly one cac:Party.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party">
      <assert id="PEPPOL-EN16931-R142" test="count(cac:PartyLegalEntity) = 1" flag="fatal">[PEPPOL-EN16931-R142]-ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party MUST contain exactly one cac:PartyLegalEntity.</assert>
      <assert id="PEPPOL-EN16931-R146" test="count(cac:PostalAddress) = 1" flag="fatal">[PEPPOL-EN16931-R146]-ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party MUST contain exactly one cac:PostalAddress.</assert>
      <assert id="PEPPOL-EN16931-R150" test="count(cbc:EndpointID) = 1" flag="fatal">[PEPPOL-EN16931-R150]-ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party MUST contain exactly one cbc:EndpointID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity">
      <assert id="PEPPOL-EN16931-R143" test="count(cbc:RegistrationName) = 1" flag="fatal">[PEPPOL-EN16931-R143]-ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity MUST contain exactly one cbc:RegistrationName.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme">
      <assert id="PEPPOL-EN16931-R145" test="count(cbc:CompanyID) = 1" flag="fatal">[PEPPOL-EN16931-R145]-ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme MUST contain exactly one cbc:CompanyID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme">
      <assert id="PEPPOL-EN16931-R144" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R144]-ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress">
      <assert id="PEPPOL-EN16931-R148" test="count(cac:Country) = 1" flag="fatal">[PEPPOL-EN16931-R148]-ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress MUST contain exactly one cac:Country.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:AddressLine">
      <assert id="PEPPOL-EN16931-R147" test="count(cbc:Line) = 1" flag="fatal">[PEPPOL-EN16931-R147]-ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:AddressLine MUST contain exactly one cbc:Line.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country">
      <assert id="PEPPOL-EN16931-R149" test="count(cbc:IdentificationCode) = 1" flag="fatal">[PEPPOL-EN16931-R149]-ubl-creditnote:CreditNote/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country MUST contain exactly one cbc:IdentificationCode.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingSupplierParty">
      <assert id="PEPPOL-EN16931-R151" test="count(cac:Party) = 1" flag="fatal">[PEPPOL-EN16931-R151]-ubl-creditnote:CreditNote/cac:AccountingSupplierParty MUST contain exactly one cac:Party.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party">
      <assert id="PEPPOL-EN16931-R152" test="count(cac:PartyLegalEntity) = 1" flag="fatal">[PEPPOL-EN16931-R152]-ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party MUST contain exactly one cac:PartyLegalEntity.</assert>
      <assert id="PEPPOL-EN16931-R156" test="count(cac:PostalAddress) = 1" flag="fatal">[PEPPOL-EN16931-R156]-ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party MUST contain exactly one cac:PostalAddress.</assert>
      <assert id="PEPPOL-EN16931-R160" test="count(cbc:EndpointID) = 1" flag="fatal">[PEPPOL-EN16931-R160]-ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party MUST contain exactly one cbc:EndpointID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity">
      <assert id="PEPPOL-EN16931-R153" test="count(cbc:RegistrationName) = 1" flag="fatal">[PEPPOL-EN16931-R153]-ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity MUST contain exactly one cbc:RegistrationName.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme">
      <assert id="PEPPOL-EN16931-R155" test="count(cbc:CompanyID) = 1" flag="fatal">[PEPPOL-EN16931-R155]-ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme MUST contain exactly one cbc:CompanyID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme">
      <assert id="PEPPOL-EN16931-R154" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R154]-ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress">
      <assert id="PEPPOL-EN16931-R158" test="count(cac:Country) = 1" flag="fatal">[PEPPOL-EN16931-R158]-ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress MUST contain exactly one cac:Country.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:AddressLine">
      <assert id="PEPPOL-EN16931-R157" test="count(cbc:Line) = 1" flag="fatal">[PEPPOL-EN16931-R157]-ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:AddressLine MUST contain exactly one cbc:Line.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
      <assert id="PEPPOL-EN16931-R159" test="count(cbc:IdentificationCode) = 1" flag="fatal">[PEPPOL-EN16931-R159]-ubl-creditnote:CreditNote/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country MUST contain exactly one cbc:IdentificationCode.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference">
      <assert id="PEPPOL-EN16931-R161" test="count(cbc:URI) = 1" flag="fatal">[PEPPOL-EN16931-R161]-ubl-creditnote:CreditNote/cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference MUST contain exactly one cbc:URI.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AllowanceCharge">
      <assert id="PEPPOL-EN16931-R162" test="count(cac:TaxCategory) = 1" flag="fatal">[PEPPOL-EN16931-R162]-ubl-creditnote:CreditNote/cac:AllowanceCharge MUST contain exactly one cac:TaxCategory.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AllowanceCharge/cac:TaxCategory">
      <assert id="PEPPOL-EN16931-R163" test="count(cac:TaxScheme) = 1" flag="fatal">[PEPPOL-EN16931-R163]-ubl-creditnote:CreditNote/cac:AllowanceCharge/cac:TaxCategory MUST contain exactly one cac:TaxScheme.</assert>
      <assert id="PEPPOL-EN16931-R165" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R165]-ubl-creditnote:CreditNote/cac:AllowanceCharge/cac:TaxCategory MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:AllowanceCharge/cac:TaxCategory/cac:TaxScheme">
      <assert id="PEPPOL-EN16931-R164" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R164]-ubl-creditnote:CreditNote/cac:AllowanceCharge/cac:TaxCategory/cac:TaxScheme MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:BillingReference">
      <assert id="PEPPOL-EN16931-R166" test="count(cac:InvoiceDocumentReference) = 1" flag="fatal">[PEPPOL-EN16931-R166]-ubl-creditnote:CreditNote/cac:BillingReference MUST contain exactly one cac:InvoiceDocumentReference.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:CreditNoteLine">
      <assert id="PEPPOL-EN16931-R168" test="count(cac:Item) = 1" flag="fatal">[PEPPOL-EN16931-R168]-ubl-creditnote:CreditNote/cac:CreditNoteLine MUST contain exactly one cac:Item.</assert>
      <assert id="PEPPOL-EN16931-R177" test="count(cac:Price) = 1" flag="fatal">[PEPPOL-EN16931-R177]-ubl-creditnote:CreditNote/cac:CreditNoteLine MUST contain exactly one cac:Price.</assert>
      <assert id="PEPPOL-EN16931-R178" test="count(cbc:CreditedQuantity) = 1" flag="fatal">[PEPPOL-EN16931-R178]-ubl-creditnote:CreditNote/cac:CreditNoteLine MUST contain exactly one cbc:CreditedQuantity.</assert>
      <assert id="PEPPOL-EN16931-R179" test="count(cbc:LineExtensionAmount) = 1" flag="fatal">[PEPPOL-EN16931-R179]-ubl-creditnote:CreditNote/cac:CreditNoteLine MUST contain exactly one cbc:LineExtensionAmount.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:DocumentReference">
      <assert id="PEPPOL-EN16931-R167" test="count(cbc:DocumentTypeCode) = 1" flag="fatal">[PEPPOL-EN16931-R167]-ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:DocumentReference MUST contain exactly one cbc:DocumentTypeCode.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:Item">
      <assert id="PEPPOL-EN16931-R170" test="count(cac:ClassifiedTaxCategory) = 1" flag="fatal">[PEPPOL-EN16931-R170]-ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:Item MUST contain exactly one cac:ClassifiedTaxCategory.</assert>
      <assert id="PEPPOL-EN16931-R176" test="count(cbc:Name) = 1" flag="fatal">[PEPPOL-EN16931-R176]-ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:Item MUST contain exactly one cbc:Name.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:Item/cac:AdditionalItemProperty">
      <assert id="PEPPOL-EN16931-R169" test="count(cbc:Value) = 1" flag="fatal">[PEPPOL-EN16931-R169]-ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:Item/cac:AdditionalItemProperty MUST contain exactly one cbc:Value.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:Item/cac:ClassifiedTaxCategory">
      <assert id="PEPPOL-EN16931-R171" test="count(cac:TaxScheme) = 1" flag="fatal">[PEPPOL-EN16931-R171]-ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:Item/cac:ClassifiedTaxCategory MUST contain exactly one cac:TaxScheme.</assert>
      <assert id="PEPPOL-EN16931-R173" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R173]-ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:Item/cac:ClassifiedTaxCategory MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
      <assert id="PEPPOL-EN16931-R172" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R172]-ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:Item/cac:CommodityClassification">
      <assert id="PEPPOL-EN16931-R174" test="count(cbc:ItemClassificationCode) = 1" flag="fatal">[PEPPOL-EN16931-R174]-ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:Item/cac:CommodityClassification MUST contain exactly one cbc:ItemClassificationCode.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:Item/cac:OriginCountry">
      <assert id="PEPPOL-EN16931-R175" test="count(cbc:IdentificationCode) = 1" flag="fatal">[PEPPOL-EN16931-R175]-ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:Item/cac:OriginCountry MUST contain exactly one cbc:IdentificationCode.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:Delivery/cac:DeliveryLocation/cac:Address">
      <assert id="PEPPOL-EN16931-R181" test="count(cac:Country) = 1" flag="fatal">[PEPPOL-EN16931-R181]-ubl-creditnote:CreditNote/cac:Delivery/cac:DeliveryLocation/cac:Address MUST contain exactly one cac:Country.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:Delivery/cac:DeliveryLocation/cac:Address/cac:AddressLine">
      <assert id="PEPPOL-EN16931-R180" test="count(cbc:Line) = 1" flag="fatal">[PEPPOL-EN16931-R180]-ubl-creditnote:CreditNote/cac:Delivery/cac:DeliveryLocation/cac:Address/cac:AddressLine MUST contain exactly one cbc:Line.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:Delivery/cac:DeliveryLocation/cac:Address/cac:Country">
      <assert id="PEPPOL-EN16931-R182" test="count(cbc:IdentificationCode) = 1" flag="fatal">[PEPPOL-EN16931-R182]-ubl-creditnote:CreditNote/cac:Delivery/cac:DeliveryLocation/cac:Address/cac:Country MUST contain exactly one cbc:IdentificationCode.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:Delivery/cac:DeliveryParty">
      <assert id="PEPPOL-EN16931-R183" test="count(cac:PartyName) = 1" flag="fatal">[PEPPOL-EN16931-R183]-ubl-creditnote:CreditNote/cac:Delivery/cac:DeliveryParty MUST contain exactly one cac:PartyName.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:LegalMonetaryTotal">
      <assert id="PEPPOL-EN16931-R184" test="count(cbc:LineExtensionAmount) = 1" flag="fatal">[PEPPOL-EN16931-R184]-ubl-creditnote:CreditNote/cac:LegalMonetaryTotal MUST contain exactly one cbc:LineExtensionAmount.</assert>
      <assert id="PEPPOL-EN16931-R185" test="count(cbc:TaxExclusiveAmount) = 1" flag="fatal">[PEPPOL-EN16931-R185]-ubl-creditnote:CreditNote/cac:LegalMonetaryTotal MUST contain exactly one cbc:TaxExclusiveAmount.</assert>
      <assert id="PEPPOL-EN16931-R186" test="count(cbc:TaxInclusiveAmount) = 1" flag="fatal">[PEPPOL-EN16931-R186]-ubl-creditnote:CreditNote/cac:LegalMonetaryTotal MUST contain exactly one cbc:TaxInclusiveAmount.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:PayeeParty">
      <assert id="PEPPOL-EN16931-R188" test="count(cac:PartyName) = 1" flag="fatal">[PEPPOL-EN16931-R188]-ubl-creditnote:CreditNote/cac:PayeeParty MUST contain exactly one cac:PartyName.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:PayeeParty/cac:PartyLegalEntity">
      <assert id="PEPPOL-EN16931-R187" test="count(cbc:CompanyID) = 1" flag="fatal">[PEPPOL-EN16931-R187]-ubl-creditnote:CreditNote/cac:PayeeParty/cac:PartyLegalEntity MUST contain exactly one cbc:CompanyID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:PaymentMeans/cac:PayeeFinancialAccount">
      <assert id="PEPPOL-EN16931-R190" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R190]-ubl-creditnote:CreditNote/cac:PaymentMeans/cac:PayeeFinancialAccount MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch">
      <assert id="PEPPOL-EN16931-R189" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R189]-ubl-creditnote:CreditNote/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:PaymentMeans/cac:PaymentMandate/cac:PayerFinancialAccount">
      <assert id="PEPPOL-EN16931-R191" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R191]-ubl-creditnote:CreditNote/cac:PaymentMeans/cac:PaymentMandate/cac:PayerFinancialAccount MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:PaymentTerms">
      <assert id="PEPPOL-EN16931-R192" test="count(cbc:Note) = 1" flag="fatal">[PEPPOL-EN16931-R192]-ubl-creditnote:CreditNote/cac:PaymentTerms MUST contain exactly one cbc:Note.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:TaxRepresentativeParty">
      <assert id="PEPPOL-EN16931-R193" test="count(cac:PartyName) = 1" flag="fatal">[PEPPOL-EN16931-R193]-ubl-creditnote:CreditNote/cac:TaxRepresentativeParty MUST contain exactly one cac:PartyName.</assert>
      <assert id="PEPPOL-EN16931-R194" test="count(cac:PartyTaxScheme) = 1" flag="fatal">[PEPPOL-EN16931-R194]-ubl-creditnote:CreditNote/cac:TaxRepresentativeParty MUST contain exactly one cac:PartyTaxScheme.</assert>
      <assert id="PEPPOL-EN16931-R197" test="count(cac:PostalAddress) = 1" flag="fatal">[PEPPOL-EN16931-R197]-ubl-creditnote:CreditNote/cac:TaxRepresentativeParty MUST contain exactly one cac:PostalAddress.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:TaxRepresentativeParty/cac:PartyTaxScheme">
      <assert id="PEPPOL-EN16931-R196" test="count(cbc:CompanyID) = 1" flag="fatal">[PEPPOL-EN16931-R196]-ubl-creditnote:CreditNote/cac:TaxRepresentativeParty/cac:PartyTaxScheme MUST contain exactly one cbc:CompanyID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:TaxRepresentativeParty/cac:PartyTaxScheme/cac:TaxScheme">
      <assert id="PEPPOL-EN16931-R195" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R195]-ubl-creditnote:CreditNote/cac:TaxRepresentativeParty/cac:PartyTaxScheme/cac:TaxScheme MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:TaxRepresentativeParty/cac:PostalAddress">
      <assert id="PEPPOL-EN16931-R199" test="count(cac:Country) = 1" flag="fatal">[PEPPOL-EN16931-R199]-ubl-creditnote:CreditNote/cac:TaxRepresentativeParty/cac:PostalAddress MUST contain exactly one cac:Country.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:TaxRepresentativeParty/cac:PostalAddress/cac:AddressLine">
      <assert id="PEPPOL-EN16931-R198" test="count(cbc:Line) = 1" flag="fatal">[PEPPOL-EN16931-R198]-ubl-creditnote:CreditNote/cac:TaxRepresentativeParty/cac:PostalAddress/cac:AddressLine MUST contain exactly one cbc:Line.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:TaxRepresentativeParty/cac:PostalAddress/cac:Country">
      <assert id="PEPPOL-EN16931-R200" test="count(cbc:IdentificationCode) = 1" flag="fatal">[PEPPOL-EN16931-R200]-ubl-creditnote:CreditNote/cac:TaxRepresentativeParty/cac:PostalAddress/cac:Country MUST contain exactly one cbc:IdentificationCode.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:TaxTotal/cac:TaxSubtotal">
      <assert id="PEPPOL-EN16931-R204" test="count(cbc:TaxableAmount) = 1" flag="fatal">[PEPPOL-EN16931-R204]-ubl-creditnote:CreditNote/cac:TaxTotal/cac:TaxSubtotal MUST contain exactly one cbc:TaxableAmount.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory">
      <assert id="PEPPOL-EN16931-R201" test="count(cac:TaxScheme) = 1" flag="fatal">[PEPPOL-EN16931-R201]-ubl-creditnote:CreditNote/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory MUST contain exactly one cac:TaxScheme.</assert>
      <assert id="PEPPOL-EN16931-R203" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R203]-ubl-creditnote:CreditNote/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-creditnote:CreditNote/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
      <assert id="PEPPOL-EN16931-R202" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R202]-ubl-creditnote:CreditNote/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice">
      <assert id="PEPPOL-EN16931-R209" test="count(cac:AccountingCustomerParty) = 1" flag="fatal">[PEPPOL-EN16931-R209]-ubl-invoice:Invoice MUST contain exactly one cac:AccountingCustomerParty.</assert>
      <assert id="PEPPOL-EN16931-R273" test="count(cbc:CustomizationID) = 1" flag="fatal">[PEPPOL-EN16931-R273]-ubl-invoice:Invoice MUST contain exactly one cbc:CustomizationID.</assert>
      <assert id="PEPPOL-EN16931-R274" test="count(cbc:DocumentCurrencyCode) = 1" flag="fatal">[PEPPOL-EN16931-R274]-ubl-invoice:Invoice MUST contain exactly one cbc:DocumentCurrencyCode.</assert>
      <assert id="PEPPOL-EN16931-R275" test="count(cbc:InvoiceTypeCode) = 1" flag="fatal">[PEPPOL-EN16931-R275]-ubl-invoice:Invoice MUST contain exactly one cbc:InvoiceTypeCode.</assert>
      <assert id="PEPPOL-EN16931-R276" test="count(cbc:ProfileID) = 1" flag="fatal">[PEPPOL-EN16931-R276]-ubl-invoice:Invoice MUST contain exactly one cbc:ProfileID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingCustomerParty">
      <assert id="PEPPOL-EN16931-R210" test="count(cac:Party) = 1" flag="fatal">[PEPPOL-EN16931-R210]-ubl-invoice:Invoice/cac:AccountingCustomerParty MUST contain exactly one cac:Party.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party">
      <assert id="PEPPOL-EN16931-R211" test="count(cac:PartyLegalEntity) = 1" flag="fatal">[PEPPOL-EN16931-R211]-ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party MUST contain exactly one cac:PartyLegalEntity.</assert>
      <assert id="PEPPOL-EN16931-R215" test="count(cac:PostalAddress) = 1" flag="fatal">[PEPPOL-EN16931-R215]-ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party MUST contain exactly one cac:PostalAddress.</assert>
      <assert id="PEPPOL-EN16931-R219" test="count(cbc:EndpointID) = 1" flag="fatal">[PEPPOL-EN16931-R219]-ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party MUST contain exactly one cbc:EndpointID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity">
      <assert id="PEPPOL-EN16931-R212" test="count(cbc:RegistrationName) = 1" flag="fatal">[PEPPOL-EN16931-R212]-ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity MUST contain exactly one cbc:RegistrationName.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme">
      <assert id="PEPPOL-EN16931-R214" test="count(cbc:CompanyID) = 1" flag="fatal">[PEPPOL-EN16931-R214]-ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme MUST contain exactly one cbc:CompanyID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme">
      <assert id="PEPPOL-EN16931-R213" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R213]-ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress">
      <assert id="PEPPOL-EN16931-R217" test="count(cac:Country) = 1" flag="fatal">[PEPPOL-EN16931-R217]-ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress MUST contain exactly one cac:Country.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:AddressLine">
      <assert id="PEPPOL-EN16931-R216" test="count(cbc:Line) = 1" flag="fatal">[PEPPOL-EN16931-R216]-ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:AddressLine MUST contain exactly one cbc:Line.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country">
      <assert id="PEPPOL-EN16931-R218" test="count(cbc:IdentificationCode) = 1" flag="fatal">[PEPPOL-EN16931-R218]-ubl-invoice:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country MUST contain exactly one cbc:IdentificationCode.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingSupplierParty">
      <assert id="PEPPOL-EN16931-R220" test="count(cac:Party) = 1" flag="fatal">[PEPPOL-EN16931-R220]-ubl-invoice:Invoice/cac:AccountingSupplierParty MUST contain exactly one cac:Party.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party">
      <assert id="PEPPOL-EN16931-R221" test="count(cac:PartyLegalEntity) = 1" flag="fatal">[PEPPOL-EN16931-R221]-ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party MUST contain exactly one cac:PartyLegalEntity.</assert>
      <assert id="PEPPOL-EN16931-R225" test="count(cac:PostalAddress) = 1" flag="fatal">[PEPPOL-EN16931-R225]-ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party MUST contain exactly one cac:PostalAddress.</assert>
      <assert id="PEPPOL-EN16931-R229" test="count(cbc:EndpointID) = 1" flag="fatal">[PEPPOL-EN16931-R229]-ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party MUST contain exactly one cbc:EndpointID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity">
      <assert id="PEPPOL-EN16931-R222" test="count(cbc:RegistrationName) = 1" flag="fatal">[PEPPOL-EN16931-R222]-ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity MUST contain exactly one cbc:RegistrationName.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme">
      <assert id="PEPPOL-EN16931-R224" test="count(cbc:CompanyID) = 1" flag="fatal">[PEPPOL-EN16931-R224]-ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme MUST contain exactly one cbc:CompanyID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme">
      <assert id="PEPPOL-EN16931-R223" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R223]-ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress">
      <assert id="PEPPOL-EN16931-R227" test="count(cac:Country) = 1" flag="fatal">[PEPPOL-EN16931-R227]-ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress MUST contain exactly one cac:Country.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:AddressLine">
      <assert id="PEPPOL-EN16931-R226" test="count(cbc:Line) = 1" flag="fatal">[PEPPOL-EN16931-R226]-ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:AddressLine MUST contain exactly one cbc:Line.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
      <assert id="PEPPOL-EN16931-R228" test="count(cbc:IdentificationCode) = 1" flag="fatal">[PEPPOL-EN16931-R228]-ubl-invoice:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country MUST contain exactly one cbc:IdentificationCode.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference">
      <assert id="PEPPOL-EN16931-R230" test="count(cbc:URI) = 1" flag="fatal">[PEPPOL-EN16931-R230]-ubl-invoice:Invoice/cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference MUST contain exactly one cbc:URI.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AllowanceCharge">
      <assert id="PEPPOL-EN16931-R231" test="count(cac:TaxCategory) = 1" flag="fatal">[PEPPOL-EN16931-R231]-ubl-invoice:Invoice/cac:AllowanceCharge MUST contain exactly one cac:TaxCategory.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AllowanceCharge/cac:TaxCategory">
      <assert id="PEPPOL-EN16931-R232" test="count(cac:TaxScheme) = 1" flag="fatal">[PEPPOL-EN16931-R232]-ubl-invoice:Invoice/cac:AllowanceCharge/cac:TaxCategory MUST contain exactly one cac:TaxScheme.</assert>
      <assert id="PEPPOL-EN16931-R234" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R234]-ubl-invoice:Invoice/cac:AllowanceCharge/cac:TaxCategory MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AllowanceCharge/cac:TaxCategory/cac:TaxScheme">
      <assert id="PEPPOL-EN16931-R233" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R233]-ubl-invoice:Invoice/cac:AllowanceCharge/cac:TaxCategory/cac:TaxScheme MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:BillingReference">
      <assert id="PEPPOL-EN16931-R235" test="count(cac:InvoiceDocumentReference) = 1" flag="fatal">[PEPPOL-EN16931-R235]-ubl-invoice:Invoice/cac:BillingReference MUST contain exactly one cac:InvoiceDocumentReference.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:Delivery/cac:DeliveryLocation/cac:Address">
      <assert id="PEPPOL-EN16931-R237" test="count(cac:Country) = 1" flag="fatal">[PEPPOL-EN16931-R237]-ubl-invoice:Invoice/cac:Delivery/cac:DeliveryLocation/cac:Address MUST contain exactly one cac:Country.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:Delivery/cac:DeliveryLocation/cac:Address/cac:AddressLine">
      <assert id="PEPPOL-EN16931-R236" test="count(cbc:Line) = 1" flag="fatal">[PEPPOL-EN16931-R236]-ubl-invoice:Invoice/cac:Delivery/cac:DeliveryLocation/cac:Address/cac:AddressLine MUST contain exactly one cbc:Line.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:Delivery/cac:DeliveryLocation/cac:Address/cac:Country">
      <assert id="PEPPOL-EN16931-R238" test="count(cbc:IdentificationCode) = 1" flag="fatal">[PEPPOL-EN16931-R238]-ubl-invoice:Invoice/cac:Delivery/cac:DeliveryLocation/cac:Address/cac:Country MUST contain exactly one cbc:IdentificationCode.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:Delivery/cac:DeliveryParty">
      <assert id="PEPPOL-EN16931-R239" test="count(cac:PartyName) = 1" flag="fatal">[PEPPOL-EN16931-R239]-ubl-invoice:Invoice/cac:Delivery/cac:DeliveryParty MUST contain exactly one cac:PartyName.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:InvoiceLine">
      <assert id="PEPPOL-EN16931-R249" test="count(cac:Price) = 1" flag="fatal">[PEPPOL-EN16931-R249]-ubl-invoice:Invoice/cac:InvoiceLine MUST contain exactly one cac:Price.</assert>
      <assert id="PEPPOL-EN16931-R250" test="count(cbc:InvoicedQuantity) = 1" flag="fatal">[PEPPOL-EN16931-R250]-ubl-invoice:Invoice/cac:InvoiceLine MUST contain exactly one cbc:InvoicedQuantity.</assert>
      <assert id="PEPPOL-EN16931-R251" test="count(cbc:LineExtensionAmount) = 1" flag="fatal">[PEPPOL-EN16931-R251]-ubl-invoice:Invoice/cac:InvoiceLine MUST contain exactly one cbc:LineExtensionAmount.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:InvoiceLine/cac:DocumentReference">
      <assert id="PEPPOL-EN16931-R240" test="count(cbc:DocumentTypeCode) = 1" flag="fatal">[PEPPOL-EN16931-R240]-ubl-invoice:Invoice/cac:InvoiceLine/cac:DocumentReference MUST contain exactly one cbc:DocumentTypeCode.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:InvoiceLine/cac:Item">
      <assert id="PEPPOL-EN16931-R242" test="count(cac:ClassifiedTaxCategory) = 1" flag="fatal">[PEPPOL-EN16931-R242]-ubl-invoice:Invoice/cac:InvoiceLine/cac:Item MUST contain exactly one cac:ClassifiedTaxCategory.</assert>
      <assert id="PEPPOL-EN16931-R248" test="count(cbc:Name) = 1" flag="fatal">[PEPPOL-EN16931-R248]-ubl-invoice:Invoice/cac:InvoiceLine/cac:Item MUST contain exactly one cbc:Name.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty">
      <assert id="PEPPOL-EN16931-R241" test="count(cbc:Value) = 1" flag="fatal">[PEPPOL-EN16931-R241]-ubl-invoice:Invoice/cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty MUST contain exactly one cbc:Value.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory">
      <assert id="PEPPOL-EN16931-R243" test="count(cac:TaxScheme) = 1" flag="fatal">[PEPPOL-EN16931-R243]-ubl-invoice:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory MUST contain exactly one cac:TaxScheme.</assert>
      <assert id="PEPPOL-EN16931-R245" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R245]-ubl-invoice:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
      <assert id="PEPPOL-EN16931-R244" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R244]-ubl-invoice:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:InvoiceLine/cac:Item/cac:CommodityClassification">
      <assert id="PEPPOL-EN16931-R246" test="count(cbc:ItemClassificationCode) = 1" flag="fatal">[PEPPOL-EN16931-R246]-ubl-invoice:Invoice/cac:InvoiceLine/cac:Item/cac:CommodityClassification MUST contain exactly one cbc:ItemClassificationCode.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:InvoiceLine/cac:Item/cac:OriginCountry">
      <assert id="PEPPOL-EN16931-R247" test="count(cbc:IdentificationCode) = 1" flag="fatal">[PEPPOL-EN16931-R247]-ubl-invoice:Invoice/cac:InvoiceLine/cac:Item/cac:OriginCountry MUST contain exactly one cbc:IdentificationCode.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:LegalMonetaryTotal">
      <assert id="PEPPOL-EN16931-R252" test="count(cbc:LineExtensionAmount) = 1" flag="fatal">[PEPPOL-EN16931-R252]-ubl-invoice:Invoice/cac:LegalMonetaryTotal MUST contain exactly one cbc:LineExtensionAmount.</assert>
      <assert id="PEPPOL-EN16931-R253" test="count(cbc:TaxExclusiveAmount) = 1" flag="fatal">[PEPPOL-EN16931-R253]-ubl-invoice:Invoice/cac:LegalMonetaryTotal MUST contain exactly one cbc:TaxExclusiveAmount.</assert>
      <assert id="PEPPOL-EN16931-R254" test="count(cbc:TaxInclusiveAmount) = 1" flag="fatal">[PEPPOL-EN16931-R254]-ubl-invoice:Invoice/cac:LegalMonetaryTotal MUST contain exactly one cbc:TaxInclusiveAmount.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:PayeeParty">
      <assert id="PEPPOL-EN16931-R256" test="count(cac:PartyName) = 1" flag="fatal">[PEPPOL-EN16931-R256]-ubl-invoice:Invoice/cac:PayeeParty MUST contain exactly one cac:PartyName.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:PayeeParty/cac:PartyLegalEntity">
      <assert id="PEPPOL-EN16931-R255" test="count(cbc:CompanyID) = 1" flag="fatal">[PEPPOL-EN16931-R255]-ubl-invoice:Invoice/cac:PayeeParty/cac:PartyLegalEntity MUST contain exactly one cbc:CompanyID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount">
      <assert id="PEPPOL-EN16931-R258" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R258]-ubl-invoice:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch">
      <assert id="PEPPOL-EN16931-R257" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R257]-ubl-invoice:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:PaymentMeans/cac:PaymentMandate/cac:PayerFinancialAccount">
      <assert id="PEPPOL-EN16931-R259" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R259]-ubl-invoice:Invoice/cac:PaymentMeans/cac:PaymentMandate/cac:PayerFinancialAccount MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:PaymentTerms">
      <assert id="PEPPOL-EN16931-R260" test="count(cbc:Note) = 1" flag="fatal">[PEPPOL-EN16931-R260]-ubl-invoice:Invoice/cac:PaymentTerms MUST contain exactly one cbc:Note.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:TaxRepresentativeParty">
      <assert id="PEPPOL-EN16931-R261" test="count(cac:PartyName) = 1" flag="fatal">[PEPPOL-EN16931-R261]-ubl-invoice:Invoice/cac:TaxRepresentativeParty MUST contain exactly one cac:PartyName.</assert>
      <assert id="PEPPOL-EN16931-R262" test="count(cac:PartyTaxScheme) = 1" flag="fatal">[PEPPOL-EN16931-R262]-ubl-invoice:Invoice/cac:TaxRepresentativeParty MUST contain exactly one cac:PartyTaxScheme.</assert>
      <assert id="PEPPOL-EN16931-R265" test="count(cac:PostalAddress) = 1" flag="fatal">[PEPPOL-EN16931-R265]-ubl-invoice:Invoice/cac:TaxRepresentativeParty MUST contain exactly one cac:PostalAddress.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:TaxRepresentativeParty/cac:PartyTaxScheme">
      <assert id="PEPPOL-EN16931-R264" test="count(cbc:CompanyID) = 1" flag="fatal">[PEPPOL-EN16931-R264]-ubl-invoice:Invoice/cac:TaxRepresentativeParty/cac:PartyTaxScheme MUST contain exactly one cbc:CompanyID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:TaxRepresentativeParty/cac:PartyTaxScheme/cac:TaxScheme">
      <assert id="PEPPOL-EN16931-R263" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R263]-ubl-invoice:Invoice/cac:TaxRepresentativeParty/cac:PartyTaxScheme/cac:TaxScheme MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:TaxRepresentativeParty/cac:PostalAddress">
      <assert id="PEPPOL-EN16931-R267" test="count(cac:Country) = 1" flag="fatal">[PEPPOL-EN16931-R267]-ubl-invoice:Invoice/cac:TaxRepresentativeParty/cac:PostalAddress MUST contain exactly one cac:Country.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:TaxRepresentativeParty/cac:PostalAddress/cac:AddressLine">
      <assert id="PEPPOL-EN16931-R266" test="count(cbc:Line) = 1" flag="fatal">[PEPPOL-EN16931-R266]-ubl-invoice:Invoice/cac:TaxRepresentativeParty/cac:PostalAddress/cac:AddressLine MUST contain exactly one cbc:Line.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:TaxRepresentativeParty/cac:PostalAddress/cac:Country">
      <assert id="PEPPOL-EN16931-R268" test="count(cbc:IdentificationCode) = 1" flag="fatal">[PEPPOL-EN16931-R268]-ubl-invoice:Invoice/cac:TaxRepresentativeParty/cac:PostalAddress/cac:Country MUST contain exactly one cbc:IdentificationCode.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:TaxTotal/cac:TaxSubtotal">
      <assert id="PEPPOL-EN16931-R272" test="count(cbc:TaxableAmount) = 1" flag="fatal">[PEPPOL-EN16931-R272]-ubl-invoice:Invoice/cac:TaxTotal/cac:TaxSubtotal MUST contain exactly one cbc:TaxableAmount.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory">
      <assert id="PEPPOL-EN16931-R269" test="count(cac:TaxScheme) = 1" flag="fatal">[PEPPOL-EN16931-R269]-ubl-invoice:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory MUST contain exactly one cac:TaxScheme.</assert>
      <assert id="PEPPOL-EN16931-R271" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R271]-ubl-invoice:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory MUST contain exactly one cbc:ID.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
      <assert id="PEPPOL-EN16931-R270" test="count(cbc:ID) = 1" flag="fatal">[PEPPOL-EN16931-R270]-ubl-invoice:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme MUST contain exactly one cbc:ID.</assert>
    </rule>
  </pattern>
</schema>
