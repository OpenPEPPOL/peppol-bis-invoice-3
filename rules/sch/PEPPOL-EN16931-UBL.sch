<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:u="utils"
        schemaVersion="iso" queryBinding="xslt2">

  <title>Rules for PEPPOL BIS 3.0 Billing</title>

  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" prefix="cbc"/>
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" prefix="cac"/>
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2" prefix="ubl-creditnote"/>
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" prefix="ubl-invoice"/>
  <ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
  <ns uri="utils" prefix="u"/>

  <!-- Parameters -->

  <let name="profile" value="if (/*/cbc:ProfileID and matches(normalize-space(/*/cbc:ProfileID), 'urn:fdc:peppol.eu:2017:poacc:billing:([0-9]{2}):1.0')) then tokenize(normalize-space(/*/cbc:ProfileID), ':')[7] else 'Unknown'"/>
  <let name="supplierCountry" value="if (/*/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/substring(cbc:CompanyID,1,2)) then upper-case(normalize-space(/*/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/substring(cbc:CompanyID,1,2)))
    else if (/*/cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/substring(cbc:CompanyID,1,2)) then upper-case(normalize-space(/*/cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/substring(cbc:CompanyID,1,2)))
    else if (/*/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode) then upper-case(normalize-space(/*/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode))
    else 'XX'"/>
  <!-- -->

  <let name="documentCurrencyCode" value="/*/cbc:DocumentCurrencyCode"/>

  <!-- Functions -->

  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:slack" as="xs:boolean">
    <param name="exp" as="xs:decimal"/>
    <param name="val" as="xs:decimal"/>
    <param name="slack" as="xs:decimal"/>
    <value-of select="xs:decimal($exp + $slack) &gt;= $val and xs:decimal($exp - $slack) &lt;= $val"/>
  </function>

  <!-- Empty elements -->
  <pattern>
    <rule context="cbc:*">
      <assert id="PEPPOL-EN16931-R008"
              test=". != ''"
              flag="fatal">Document MUST not contain empty elements.</assert>
    </rule>
    <rule context="cac:*">
      <assert id="PEPPOL-EN16931-R009"
              test="count(*) != 0"
              flag="fatal">Document MUST not contain empty elements.</assert>
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
    R1XX - Line level
    R11X - Invoice period
  -->
  <pattern>

    <!-- Document level -->
    <rule context="ubl-creditnote:CreditNote | ubl-invoice:Invoice">
      <assert id="PEPPOL-EN16931-R001"
              test="cbc:ProfileID"
              flag="fatal">Business process MUST be provided.</assert>
      <assert id="PEPPOL-EN16931-R002"
              test="count(cbc:Note) &lt;= 1"
              flag="fatal">No more than one note is allowed on document level.</assert>
      <assert id="PEPPOL-EN16931-R003"
              test="cbc:BuyerReference or cac:OrderReference/cbc:ID"
              flag="fatal">A buyer reference or purchase order reference MUST be provided.</assert>
      <assert id="PEPPOL-EN16931-R004"
              test="starts-with(normalize-space(cbc:CustomizationID/text()), 'urn:cen.eu:en16931:2017#compliant#urn:fdc:peppol.eu:2017:poacc:billing:3.0')"
              flag="fatal">Specification identifier MUST have the value 'urn:cen.eu:en16931:2017#compliant#urn:fdc:peppol.eu:2017:poacc:billing:3.0'.</assert>

      <assert id="PEPPOL-EN16931-R053"
              test="count(cac:TaxTotal[cac:TaxSubtotal]) = 1"
              flag="fatal">Only one tax total with tax subtotals MUST be provided.</assert>
      <assert id="PEPPOL-EN16931-R054"
              test="count(cac:TaxTotal[not(cac:TaxSubtotal)]) = (if (cbc:TaxCurrencyCode) then 1 else 0)"
              flag="fatal">Only one tax total without tax subtotals MUST be provided when tax currency code is provided.</assert>
    </rule>

    <rule context="cbc:TaxCurrencyCode">
      <assert id="PEPPOL-EN16931-R005"
              test="not(normalize-space(text()) = normalize-space(../cbc:DocumentCurrencyCode/text()))"
              flag="fatal">VAT accounting currency code MUST be different from invoice currency code when provided.</assert>
    </rule>

    <!-- Accounting customer -->
    <rule context="cac:AccountingCustomerParty/cac:Party">
      <assert id="PEPPOL-EN16931-R010"
              test="cbc:EndpointID"
              flag="fatal">Buyer electronic address MUST be provided</assert>
    </rule>

    <!-- Accounting supplier -->
    <rule context="cac:AccountingSupplierParty/cac:Party">
      <assert id="PEPPOL-EN16931-R020"
              test="cbc:EndpointID"
              flag="fatal">Seller electronic address MUST be provided</assert>
    </rule>

    <!-- Allowance/Charge (document level/line level) -->
    <rule context="ubl-invoice:Invoice/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)] | ubl-invoice:Invoice/cac:InvoiceLine/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)] | ubl-creditnote:CreditNote/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)] | ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)]">
      <assert id="PEPPOL-EN16931-R041"
              test="false()"
              flag="fatal">Allowance/charge base amount MUST be provided when allowance/charge percentage is provided.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount] | ubl-invoice:Invoice/cac:InvoiceLine/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount] | ubl-creditnote:CreditNote/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount] | ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount]">
      <assert id="PEPPOL-EN16931-R042"
              test="false()"
              flag="fatal">Allowance/charge percentage MUST be provided when allowance/charge base amount is provided.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice/cac:AllowanceCharge | ubl-invoice:Invoice/cac:InvoiceLine/cac:AllowanceCharge | ubl-creditnote:CreditNote/cac:AllowanceCharge | ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:AllowanceCharge">
      <assert id="PEPPOL-EN16931-R040"
              test="not(cbc:MultiplierFactorNumeric and cbc:BaseAmount) or u:slack(if (cbc:Amount) then cbc:Amount else 0, (xs:decimal(cbc:BaseAmount) * xs:decimal(cbc:MultiplierFactorNumeric)) div 100, 0.02)"
              flag="fatal">Allowance/charge amount must equal base amount * percentage/100 if base amount and percentage exists</assert>
    </rule>



    <!-- Payment -->
    <rule context="cac:PaymentMeans[some $code in tokenize('49 59', '\s') satisfies normalize-space(cbc:PaymentMeansCode) = $code]">
      <assert id="PEPPOL-EN16931-R061"
              test="cac:PaymentMandate/cbc:ID"
              flag="fatal">Mandate reference MUST be provided for direct debit.</assert>
    </rule>

    <!-- Currency -->
    <rule context="cbc:Amount | cbc:BaseAmount | cbc:PriceAmount | cac:TaxTotal[cac:TaxSubtotal]/cbc:TaxAmount | cbc:TaxableAmount | cbc:LineExtensionAmount | cbc:TaxExclusiveAmount | cbc:TaxInclusiveAmount | cbc:AllowanceTotalAmount | cbc:ChargeTotalAmount | cbc:PrepaidAmount | cbc:PayableRoundingAmount | cbc:PayableAmount">
      <assert id="PEPPOL-EN16931-R051"
              test="@currencyID = $documentCurrencyCode"
              flag="fatal">All currencyID attributes must have the same value as the invoice currency code (BT-5),  except for the invoice total VAT amount in accounting currency (BT-111) </assert>
    </rule>
    <rule context="cac:TaxTotal[not(cac:TaxSubtotal)]/cbc:TaxAmount">
      <assert id="PEPPOL-EN16931-R052"
              test="/*/cbc:TaxCurrencyCode and @currencyID = /*/cbc:TaxCurrencyCode"
              flag="fatal">The currencyID for invoice total VAT in accounting currency, must be the same as VAT accounting currency code (BT-6)</assert>
    </rule>

    <!-- Line level - invoice period -->
    <rule context="ubl-invoice:Invoice[cac:InvoicePeriod/cbc:StartDate]/cac:InvoiceLine/cac:InvoicePeriod/cbc:StartDate | ubl-creditnote:CreditNote[cac:InvoicePeriod/cbc:StartDate]/cac:CreditNoteLine/cac:InvoicePeriod/cbc:StartDate">
      <assert id="PEPPOL-EN16931-R110"
              test="xs:date(text()) &gt;= xs:date(../../../cac:InvoicePeriod/cbc:StartDate)"
              flag="fatal">Start date of line period MUST be within invoice period.</assert>
    </rule>
    <rule context="ubl-invoice:Invoice[cac:InvoicePeriod/cbc:EndDate]/cac:InvoiceLine/cac:InvoicePeriod/cbc:EndDate | ubl-creditnote:CreditNote[cac:InvoicePeriod/cbc:EndDate]/cac:CreditNoteLine/cac:InvoicePeriod/cbc:EndDate">
      <assert id="PEPPOL-EN16931-R111"
              test="xs:date(text()) &lt;= xs:date(../../../cac:InvoicePeriod/cbc:EndDate)"
              flag="fatal">End date of line period MUST be within invoice period.</assert>
    </rule>

    <!-- Line level - line extension amount -->
    <rule context="cac:InvoiceLine | cac:CreditNoteLine">
      <let name="lineExtensionAmount" value="if (cbc:LineExtensionAmount) then xs:decimal(cbc:LineExtensionAmount) else 0"/>
      <let name="quantity" value="if (/ubl-invoice:Invoice) then (if (cbc:InvoicedQuantity) then xs:decimal(cbc:InvoicedQuantity) else 1) else (if (cbc:CreditedQuantity) then xs:decimal(cbc:CreditedQuantity) else 1)"/>
      <let name="priceAmount" value="if (cac:Price/cbc:PriceAmount) then xs:decimal(cac:Price/cbc:PriceAmount) else 0"/>
      <let name="baseQuantity" value="if (cac:Price/cbc:BaseQuantity and xs:decimal(cac:Price/cbc:BaseQuantity) != 0) then xs:decimal(cac:Price/cbc:BaseQuantity) else 1"/>
      <let name="allowancesTotal" value="if (cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'false']) then xs:decimal(sum(cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'false']/cbc:Amount)) else 0"/>
      <let name="chargesTotal" value="if (cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'true']) then xs:decimal(sum(cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'true']/cbc:Amount)) else 0"/>

      <assert id="PEPPOL-EN16931-R120"
              test="u:slack($lineExtensionAmount, ($quantity * ($priceAmount div $baseQuantity)) + $chargesTotal - $allowancesTotal, 0.02)"
              flag="fatal">Invoice line net amount MUST equal (Invoiced quantity * (Item net price/item price base quantity) + Invoice line charge amount - Invoice line allowance amount</assert>
      <assert id="PEPPOL-EN16931-R121"
              test="not(cac:Price/cbc:BaseQuantity) or xs:decimal(cac:Price/cbc:BaseQuantity) &gt; 0"
              flag="fatal">Base quantity MUST be a positive number above zero.</assert>
    </rule>

    <!-- Allowance (price level) -->
    <rule context="cac:Price/cac:AllowanceCharge">
      <assert id="PEPPOL-EN16931-R044"
              test="normalize-space(cbc:ChargeIndicator) = 'false'"
              flag="fatal">Charge on price level is NOT allowed.</assert>
      <assert id="PEPPOL-EN16931-R046"
              test="not(cbc:BaseAmount) or xs:decimal(../cbc:PriceAmount) = xs:decimal(cbc:BaseAmount) - xs:decimal(cbc:Amount)"
              flag="fatal">Item net price MUST equal (Gross price - Allowance amount) when gross price is provided.</assert>
    </rule>

    <!-- Price -->
    <rule context="cac:Price/cbc:BaseQuantity[@unitCode]">
      <let name="hasQuantity" value="../../cbc:InvoicedQuantity or ../../cbc:CreditedQuantity"/>
      <let name="quantity" value="if (/ubl-invoice:Invoice) then ../../cbc:InvoicedQuantity else ../../cbc:CreditedQuantity"/>

      <assert id="PEPPOL-EN16931-R130"
              test="not($hasQuantity) or @unitCode = $quantity/@unitCode"
              flag="fatal">Unit code of price base quantity MUST be same as invoiced quantity.</assert>
    </rule>

  </pattern>

  <!-- National rules -->
  <pattern>



    <!-- NORWAY -->

    <rule context="cac:AccountingSupplierParty/cac:Party[$supplierCountry = 'NO']">
      <assert id="NO-R-001"
              test="cac:PartyLegalEntity"
              flag="fatal">Norwegian suppliers MUST provide legal entity.</assert>
      <assert id="NO-R-002"
              test="normalize-space(cac:PartyTaxScheme[normalize-space(cac:TaxScheme/cbc:ID) = 'TAX']/cbc:CompanyID) = 'Foretaksregisteret'"
              flag="warning">Most invoice issuers are required to append "Foretaksregisteret" to their invoice. "Dersom selger er aksjeselskap, allmennaksjeselskap eller filial av utenlandsk selskap skal også ordet «Foretaksregisteret» fremgå av salgsdokumentet, jf. foretaksregisterloven § 10-2."</assert>
    </rule>

    <!-- DENMARK -->


      <!-- Document level -->
      <rule context="ubl-creditnote:CreditNote | ubl-invoice:Invoice">
        <assert id="DK-R-001"
          test="not(($supplierCountry = 'DK')
          and (normalize-space(cbc:AccountingCost/text()) = '')
          )"
          flag="warning">For Danish suppliers when the Accounting code is known, it should be referred on the Invoice.</assert>
        <assert id="DK-R-002"
          test="not(($supplierCountry = 'DK')
          and not (normalize-space(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/text()) != '')
          )"
          flag="fatal">Danish suppliers MUST provide legal entity (CVR-number).</assert>
      </rule>



      <!-- Line level -->
      <rule context="ubl-creditnote:CreditNote/cac:CreditNoteLine | ubl-invoice:Invoice/cac:InvoiceLine">
        <assert id="DK-R-003"
          test="not(($supplierCountry = 'DK')
          and (cac:Item/cac:CommodityClassification/cbc:ItemClassificationCode/@listID = 'MP')
          and not((cac:Item/cac:CommodityClassification/cbc:ItemClassificationCode/@listVersionID = '19.05.01')
          or (cac:Item/cac:CommodityClassification/cbc:ItemClassificationCode/@listVersionID = '19.0501')
          )
          )"
          flag="warning">If ItemClassification is provided from Danish suppliers, UNSPSC version 19.0501 should be used.</assert>
      </rule>


      <!-- Mix level -->
      <rule context="cac:AllowanceCharge">
        <assert id="DK-R-004"
          test="not(($supplierCountry = 'DK')
          and (cbc:AllowanceChargeReasonCode = 'ZZZ')
          and not((string-length(normalize-space(cbc:AllowanceChargeReason/text())) = 4)
          and (number(cbc:AllowanceChargeReason) &gt;= 0)
          and (number(cbc:AllowanceChargeReason) &lt;= 9999))
          )"
          flag="fatal">When specifying non-VAT Taxes, Danish suppliers MUST use the AllowanceChargeReasonCode="ZZZ" and the 4-digit Tax category MUST be specified in 'AllowanceChargeReason'.</assert>
      </rule>


      <!-- Document level -->
      <rule context="ubl-invoice:Invoice/cac:PaymentMeans" >
        <assert id="DK-R-005"
          test="not(($supplierCountry = 'DK')
          and not(contains(' 1 10 31 42 48 49 50 58 59 93 97 ', concat(' ', cbc:PaymentMeansCode, ' ')))
          )"
          flag="fatal">For Danish suppliers the following Payment means codes are allowed: 1, 10, 31, 42, 48, 49, 50, 58, 59, 93 and 97</assert>
        <assert id="DK-R-006"
          test="not(($supplierCountry = 'DK')
          and ((cbc:PaymentMeansCode = '31') or (cbc:PaymentMeansCode = '42'))
          and not((normalize-space(cac:PayeeFinancialAccount/cbc:ID/text()) != '') and (normalize-space(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID/text()) != ''))
          )"
          flag="fatal">For Danish suppliers bank account and registration account is mandatory if payment means is 31 or 42</assert>
        <assert id="DK-R-007"
          test="not(($supplierCountry = 'DK')
          and (cbc:PaymentMeansCode = '49')
          and not((normalize-space(cac:PaymentMandate/cbc:ID/text()) != '')
          and (normalize-space(cac:PaymentMandate/cac:PayerFinancialAccount/cbc:ID/text()) != ''))
          )"
          flag="fatal">For Danish suppliers PaymentMandate/ID and PayerFinancialAccount/ID are mandatory when payment means is 49</assert>
        <assert id="DK-R-008"
          test="not(($supplierCountry = 'DK')
          and (cbc:PaymentMeansCode = '50')
          and not(((substring(cbc:PaymentID, 0, 4) = '01#')
          or (substring(cbc:PaymentID, 0, 4) = '04#')
          or (substring(cbc:PaymentID, 0, 4) = '15#'))
          and (string-length(cac:PayeeFinancialAccount/cbc:ID/text()) = 7)
          )
          )"
          flag="fatal">For Danish Suppliers PaymentID is mandatory and MUST start with 01#, 04# or 15# (kortartkode), and PayeeFinancialAccount/ID (Giro kontonummer) is mandatory and must be 7 characters long, when payment means equals 50 (Giro)</assert>
        <assert id="DK-R-009"
          test="not(($supplierCountry = 'DK')
          and (cbc:PaymentMeansCode = '50')
          and ((substring(cbc:PaymentID, 0, 4) = '04#')
          or (substring(cbc:PaymentID, 0, 4)  = '15#'))
          and not(string-length(cbc:PaymentID) = 19)
          )"
          flag="fatal">For Danish Suppliers if the PaymentID is prefixed with 04# or 15# the 16 digits instruction Id must be added to the PaymentID eg. "04#1234567890123456" when Payment means equals 50 (Giro)</assert>
        <assert id="DK-R-010"
          test="not(($supplierCountry = 'DK')
          and (cbc:PaymentMeansCode = '93')
          and not(((substring(cbc:PaymentID, 0, 4) = '71#')
          or (substring(cbc:PaymentID, 0, 4) = '73#')
          or (substring(cbc:PaymentID, 0, 4) = '75#'))
          and (string-length(cac:PayeeFinancialAccount/cbc:ID/text()) = 8)
          )
          )"
          flag="fatal">For Danish Suppliers the PaymentID is mandatory and MUST start with 71#, 73# or 75# (kortartkode) and PayeeFinancialAccount/ID (Kreditornummer) is mandatory and must be exactly 8 characters long, when Payment means equals 93 (FIK)</assert>
        <assert id="DK-R-011"
          test="not(($supplierCountry = 'DK')
          and (cbc:PaymentMeansCode = '93')
          and ((substring(cbc:PaymentID, 0, 4) = '71#')
          or (substring(cbc:PaymentID, 0, 4)  = '75#'))
          and not((string-length(cbc:PaymentID) = 18)
          or (string-length(cbc:PaymentID) = 19))
          )"
          flag="fatal">For Danish Suppliers if the PaymentID is prefixed with 71# or 75# the 15-16 digits instruction Id must be added to the PaymentID eg. "71#1234567890123456" when payment Method equals 93 (FIK)</assert>
        <assert id="DK-R-012"
          test="not(($supplierCountry = 'DK')
          and (cbc:PaymentMeansCode = '97')
          )"
          flag="warning">For Danish suppliers when Payment means equals 97 the payment is made to "NemKonto"</assert>
      </rule>

      <rule context="ubl-creditnote:CreditNote | ubl-invoice:Invoice">
        <assert id="DK-R-013"
          test="not(($supplierCountry = 'DK')
          and (((boolean(cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID))
          and (normalize-space(cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID/@schemeID) = ''))
          or
          ((boolean(cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID))
          and (normalize-space(cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID/@schemeID) = ''))
          )
          )"
          flag="fatal">For Danish Suppliers it is mandatory to use schemeID when PartyIdentification/ID is used for AccountingCustomerParty or AccountingSupplierParty</assert>
        <assert id="DK-R-014"
          test="not(($supplierCountry = 'DK')
          and (((boolean(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID))
          and (normalize-space(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID) = ''))
          or
          ((boolean(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID))
          and (normalize-space(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID/@schemeID) = ''))
          )
          )"
          flag="fatal">For Danish Suppliers it is mandatory to use schemeID when PartyLegalEntity/CompanyID is used for AccountingCustomerParty or AccountingSupplierParty</assert>
      </rule>


    <!-- ITALY -->

    <rule context="cac:AccountingSupplierParty/cac:Party[$supplierCountry = 'IT']">
      <assert id="IT-R-001"
        test= "(exists(cac:PartyTaxScheme/cbc:CompanyID) and cac:PartyTaxScheme/cac:TaxScheme/cbc:ID = 'IT:TR')"
        flag="fatal"> [IT-R-001] BT-32 (Seller tax registration identifier) - Italian suppliers MUST provide Tax Regime Identifier. I fornitori italiani devono indicare il Regime Fiscale</assert>
      <assert id="IT-R-002"
        test= "exists(cac:PostalAddress/cbc:StreetName)"
        flag="fatal">[IT-R-002] BT-35 (Seller address line 1) - Italian suppliers MUST provide the postal address line 1 - I fornitori italiani devono indicare l'indirizzo postale.</assert>
      <assert id="IT-R-003"
        test="exists(cac:PostalAddress/cbc:CityName)"
        flag="fatal">[IT-R-003] BT-37 (Seller city) - Italian suppliers MUST provide the postal address city - I fornitori italiani devono indicare la città di residenza.</assert>
      <assert id="IT-R-004"
        test= "exists(cac:PostalAddress/cbc:PostalZone)"
        flag="fatal"> [IT-R-004] BT-38 (Seller post code) - Italian suppliers MUST provide the postal address post code - I fornitori italiani devono indicare il CAP di residenza.</assert>
    </rule>

  </pattern>

    <!-- SWEDEN -->

    <pattern>
  		<rule context="//cac:AccountingSupplierParty/cac:Party[cac:PostalAddress/cac:Country/cbc:IdentificationCode = &apos;SE&apos; and cac:PartyTaxScheme[cac:TaxScheme/cbc:ID=&apos;VAT&apos;]/substring(cbc:CompanyID,1,2)=&apos;SE&apos;]   ">
  			<assert id="SE-R-1" test="string-length(normalize-space(cac:PartyTaxScheme[cac:TaxScheme/cbc:ID=&apos;VAT&apos;]/cbc:CompanyID))=14" flag="fatal">For Swedish suppliers, Swedish VAT-numbers must consist of 14 characters.</assert>
  		</rule>
  	</pattern>

  	<pattern>
  		<rule context="//cac:AccountingSupplierParty/cac:Party[cac:PostalAddress/cac:Country/cbc:IdentificationCode = &apos;SE&apos; and cac:PartyTaxScheme[cac:TaxScheme/cbc:ID=&apos;VAT&apos;]/substring(cbc:CompanyID,1,2)=&apos;SE&apos;]   ">
  			<assert id="SE-R-2" test="string(number(substring(cac:PartyTaxScheme[cac:TaxScheme/cbc:ID=&apos;VAT&apos;]/cbc:CompanyID,3,12))) != &apos;NaN&apos;" flag="fatal">For Swedish suppliers, the Swedish VAT-numbers must have the trailing 12 characters in numeric form</assert>
  		</rule>
  	</pattern>

  	<pattern>
  		<rule context="//cac:AccountingSupplierParty/cac:Party[cac:PostalAddress/cac:Country/cbc:IdentificationCode = &apos;SE&apos; and cac:PartyLegalEntity/cbc:CompanyID]">
  			<assert id="SE-R-3" test="string(number(cac:PartyLegalEntity/cbc:CompanyID)) != &apos;NaN&apos;" flag="fatal">Swedish organisation numbers should be numeric.</assert>
  		</rule>
  	</pattern>

  	<pattern>
  		<rule context="//cac:AccountingSupplierParty/cac:Party[cac:PostalAddress/cac:Country/cbc:IdentificationCode = &apos;SE&apos; and cac:PartyLegalEntity/cbc:CompanyID]">
  			<assert id="SE-R-4" test="string-length(normalize-space(cac:PartyLegalEntity/cbc:CompanyID)) = 10" flag="fatal">Swedish organisation numbers consist of 10 characters.</assert>
  		</rule>
  	</pattern>

  	<pattern>
  		<rule context="//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:ID[../../../cac:PostalAddress/cac:Country/cbc:IdentificationCode = &apos;SE&apos;]">
  			<assert id="SE-R-5" test="normalize-space(.) = &apos;SE:F-SKATT&apos; or normalize-space(upper-case(.)) = &apos;VAT&apos;" flag="fatal">For Swedish suppliers, only TaxScheme/ID with code values VAT or SE:F-SKATT are allowed </assert>
  		</rule>
  	</pattern>

  	<pattern>
  		<rule context="//cac:AccountingSupplierParty/cac:Party[cac:PostalAddress/cac:Country/cbc:IdentificationCode = &apos;SE&apos; and exists(cac:PartyLegalEntity/cbc:CompanyID)]/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID=&apos;SE:F-SKATT&apos;]">
  			<assert id="SE-R-6" test="../cac:PartyLegalEntity/cbc:CompanyID = cbc:CompanyID" flag="fatal">For Swedish suppliers, when using SE:F-SKATT, the CompanyID reference must equal the provided Organisation number</assert>
  		</rule>
  	</pattern>

  	<pattern>
  		<rule context="//cac:TaxCategory[//cac:AccountingSupplierParty/cac:Party[cac:PostalAddress/cac:Country/cbc:IdentificationCode = &apos;SE&apos; and cac:PartyTaxScheme[cac:TaxScheme/cbc:ID=&apos;VAT&apos;]/substring(cbc:CompanyID,1,2)=&apos;SE&apos;] and cbc:ID=&apos;S&apos;]">
  			<assert id="SE-R-7" test="number(cbc:Percent) = 25 or number(cbc:Percent) = 12 or number(cbc:Percent) = 6" flag="fatal">For Swedish suppliers, only standard VAT rate of 6, 12 or 25 are used</assert>
  		</rule>
  	</pattern>

  	<pattern>
  		<rule context="//cac:ClassifiedTaxCategory[//cac:AccountingSupplierParty/cac:Party[cac:PostalAddress/cac:Country/cbc:IdentificationCode = &apos;SE&apos; and cac:PartyTaxScheme[cac:TaxScheme/cbc:ID=&apos;VAT&apos;]/substring(cbc:CompanyID,1,2)=&apos;SE&apos;] and cbc:ID=&apos;S&apos;]">
  			<assert id="SE-R-8" test="number(cbc:Percent) = 25 or number(cbc:Percent) = 12 or number(cbc:Percent) = 6" flag="fatal">For Swedish suppliers, only standard VAT rate of 6, 12 or 25 are used</assert>
  		</rule>
  	</pattern>

  	<pattern>
  		<rule context="//cac:PaymentMeans[//cac:AccountingSupplierParty/cac:Party[cac:PostalAddress/cac:Country/cbc:IdentificationCode = &apos;SE&apos;] and cbc:PaymentMeansCode = normalize-space(&apos;30&apos;) and cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID=normalize-space(&apos;SE:PLUSGIRO&apos;)]/cac:PayeeFinancialAccount/cbc:ID">
  			<assert id="SE-R-9" test="string(number(normalize-space(.))) != &apos;NaN&apos;" flag="warning">For Swedish suppliers using Plusgiro, the Account ID must be numeric </assert>
  		</rule>
  	</pattern>

  	<pattern>
  		<rule context="//cac:PaymentMeans[//cac:AccountingSupplierParty/cac:Party[cac:PostalAddress/cac:Country/cbc:IdentificationCode = &apos;SE&apos;] and cbc:PaymentMeansCode = normalize-space(&apos;30&apos;) and cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID=normalize-space(&apos;SE:BANKGIRO&apos;)]/cac:PayeeFinancialAccount/cbc:ID">
  			<assert id="SE-R-10" test="string(number(normalize-space(.))) != &apos;NaN&apos;" flag="warning">For Swedish suppliers using Bankgiro, the Account ID must be numeric </assert>
  		</rule>
  	</pattern>

  	<pattern>
  		<rule context="//cac:PaymentMeans[//cac:AccountingSupplierParty/cac:Party[cac:PostalAddress/cac:Country/cbc:IdentificationCode = &apos;SE&apos;] and cbc:PaymentMeansCode = normalize-space(&apos;30&apos;) and cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID=normalize-space(&apos;SE:BANKGIRO&apos;)]/cac:PayeeFinancialAccount/cbc:ID">
  			<assert id="SE-R-11" test="string-length(normalize-space(.)) = 7 or string-length(normalize-space(.)) = 8" flag="warning">For Swedish suppliers using Bankgiro, the Account ID must have 7-8 characters</assert>
  		</rule>
  	</pattern>

  	<pattern>
  		<rule context="//cac:PaymentMeans[//cac:AccountingSupplierParty/cac:Party[cac:PostalAddress/cac:Country/cbc:IdentificationCode = &apos;SE&apos;] and cbc:PaymentMeansCode = normalize-space(&apos;30&apos;) and cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID=normalize-space(&apos;SE:PLUSGIRO&apos;)]/cac:PayeeFinancialAccount/cbc:ID">
  			<assert id="SE-R-12" test="string-length(normalize-space(.)) &gt;= 2 and string-length(normalize-space(.)) &lt;= 8  " flag="warning">For Swedish suppliers using Plusgiro, the Account ID must have 2-8 characteres</assert>
  		</rule>
  	</pattern>

  	<pattern>
  		<rule context="//cac:PaymentMeans[//cac:AccountingSupplierParty/cac:Party[cac:PostalAddress/cac:Country/cbc:IdentificationCode = &apos;SE&apos;] and (cbc:PaymentMeansCode = normalize-space(&apos;50&apos;) or cbc:PaymentMeansCode = normalize-space(&apos;56&apos;))]">
  			<assert id="SE-R-13" test="false()" flag="warning">For Swedish suppliers using Swedish Bankgiro or Plusgiro, the proper way to indicate this is to use PaymentMeansCode 30 and FinancialInstitutionBranch ID with code SE:BANKGIRO or SE:PLUSGIRO</assert>
  		</rule>
  	</pattern>

  <!-- Restricted code lists and formatting -->
  <pattern>
    <let name="ISO3166" value="tokenize('AD AE AF AG AI AL AM AO AQ AR AS AT AU AW AX AZ BA BB BD BE BF BG BH BI BJ BL BM BN BO BQ BR BS BT BV BW BY BZ CA CC CD CF CG CH CI CK CL CM CN CO CR CU CV CW CX CY CZ DE DJ DK DM DO DZ EC EE EG EH ER ES ET FI FJ FK FM FO FR GA GB GD GE GF GG GH GI GL GM GN GP GQ GR GS GT GU GW GY HK HM HN HR HT HU ID IE IL IM IN IO IQ IR IS IT JE JM JO JP KE KG KH KI KM KN KP KR KW KY KZ LA LB LC LI LK LR LS LT LU LV LY MA MC MD ME MF MG MH MK ML MM MN MO MP MQ MR MS MT MU MV MW MX MY MZ NA NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM PN PR PS PT PW PY QA RE RO RS RU RW SA SB SC SD SE SG SH SI SJ SK SL SM SN SO SR SS ST SV SX SY SZ TC TD TF TG TH TJ TK TL TM TN TO TR TT TV TW TZ UA UG UM US UY UZ VA VC VE VG VI VN VU WF WS YE YT ZA ZM ZW', '\s')"/>
    <let name="ISO4217" value="tokenize('AFN EUR ALL DZD USD AOA XCD XCD ARS AMD AWG AUD AZN BSD BHD BDT BBD BYN BZD XOF BMD INR BTN BOB BOV USD BAM BWP NOK BRL USD BND BGN XOF BIF CVE KHR XAF CAD KYD XAF XAF CLP CLF CNY AUD AUD COP COU KMF CDF XAF NZD CRC XOF HRK CUP CUC ANG CZK DKK DJF XCD DOP USD EGP SVC USD XAF ERN ETB FKP DKK FJD XPF XAF GMD GEL GHS GIP DKK XCD USD GTQ GBP GNF XOF GYD HTG USD AUD HNL HKD HUF ISK INR IDR XDR IRR IQD GBP ILS JMD JPY GBP JOD KZT KES AUD KPW KRW KWD KGS LAK LBP LSL ZAR LRD LYD CHF MOP MKD MGA MWK MYR MVR XOF USD MRO MUR XUA MXN MXV USD MDL MNT XCD MAD MZN MMK NAD ZAR AUD NPR XPF NZD NIO XOF NGN NZD AUD USD NOK OMR PKR USD PAB USD PGK PYG PEN PHP NZD PLN USD QAR RON RUB RWF SHP XCD XCD XCD WST STD SAR XOF RSD SCR SLL SGD ANG XSU SBD SOS ZAR SSP LKR SDG SRD NOK SZL SEK CHF CHE CHW SYP TWD TJS TZS THB USD XOF NZD TOP TTD TND TRY TMT USD AUD UGX UAH AED GBP USD USD USN UYU UYI UZS VUV VEF VND USD USD XPF MAD YER ZMW ZWL XBA XBB XBC XBD XTS XXX XAU XPD XPT XAG', '\s')"/>
    <let name="MIMECODE" value="tokenize('application/pdf image/png image/jpeg text/csv application/vnd.openxmlformats-officedocument.spreadsheetml.sheet application/vnd.oasis.opendocument.spreadsheet', '\s')"/>
    <let name="UNCL2005" value="tokenize('3 35 432', '\s')"/>
    <let name="UNCL5189" value="tokenize('41 42 60 62 63 64 65 66 67 68 70 71 88 95 100 102 103 104 105', '\s')"/>
    <let name="UNCL7161" value="tokenize('AA AAA AAC AAD AAE AAF AAH AAI AAS AAT AAV AAY AAZ ABA ABB ABC ABD ABF ABK ABL ABN ABR ABS ABT ABU ACF ACG ACH ACI ACJ ACK ACL ACM ACS ADC ADE ADJ ADK ADL ADM ADN ADO ADP ADQ ADR ADT ADW ADY ADZ AEA AEB AEC AED AEF AEH AEI AEJ AEK AEL AEM AEN AEO AEP AES AET AEU AEV AEW AEX AEY AEZ AJ AU CA CAB CAD CAE CAF CAI CAJ CAK CAL CAM CAN CAO CAP CAQ CAR CAS CAT CAU CAV CAW CD CG CS CT DAB DAD DL EG EP ER FAA FAB FAC FC FH FI GAA HAA HD HH IAA IAB ID IF IR IS KO L1 LA LAA LAB LF MAE MI ML NAA OA PA PAA PC PL RAB RAC RAD RAF RE RF RH RV SA SAA SAD SAE SAI SG SH SM SU TAB TAC TT TV V1 V2 WH XAA YY ZZZ', '\s')"/>
    <let name="UNCL5305" value="tokenize('AE E S Z G O K L M', '\s')"/>

    <rule context="cbc:EmbeddedDocumentBinaryObject[@mimeCode]">
      <assert id="PEPPOL-EN16931-CL001"
              test="some $code in $MIMECODE satisfies @mimeCode = $code"
              flag="fatal">Invalid mime code.</assert>
    </rule>

    <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='false']/cbc:AllowanceChargeReasonCode">
      <assert id="PEPPOL-EN16931-CL002"
              test="some $code in $UNCL5189 satisfies normalize-space(text()) = $code"
              flag="fatal">Reason code MUST be according to subset of UNCL 5189 D.16B.</assert>
    </rule>

    <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='true']/cbc:AllowanceChargeReasonCode">
      <assert id="PEPPOL-EN16931-CL003"
              test="some $code in $UNCL7161 satisfies normalize-space(text()) = $code"
              flag="fatal">Reason code MUST be according to UNCL 7161 D.16B.</assert>
    </rule>

    <rule context="cac:ClassifiedTaxCategory/cbc:ID | cac:TaxCategory/cbc:ID">
      <assert id="PEPPOL-EN16931-CL004"
              test="some $code in $UNCL5305 satisfies normalize-space(text()) = $code"
              flag="fatal">Tax category code MUST be according to defined subset of UNCL 5305 D.16B.</assert>
    </rule>

    <rule context="cac:Country/cbc:IdentificationCode | cac:OriginCountry/cbc:IdentificationCode">
      <assert id="PEPPOL-EN16931-CL005"
              test="some $code in $ISO3166 satisfies text() = $code"
              flag="fatal">Country code MUST be according to ISO 3166 Alpha-2.</assert>
    </rule>

    <rule context="cac:InvoicePeriod/cbc:DescriptionCode">
      <assert id="PEPPOL-EN16931-CL006"
              test="some $code in $UNCL2005 satisfies normalize-space(text()) = $code"
              flag="fatal">Invoice period description code must be according to UNCL 2005 D.16B.</assert>
    </rule>

    <rule context="cbc:Amount | cbc:BaseAmount | cbc:PriceAmount | cbc:TaxAmount | cbc:TaxableAmount | cbc:LineExtensionAmount | cbc:TaxExclusiveAmount | cbc:TaxInclusiveAmount | cbc:AllowanceTotalAmount | cbc:ChargeTotalAmount | cbc:PrepaidAmount | cbc:PayableRoundingAmount | cbc:PayableAmount">
      <assert id="PEPPOL-EN16931-CL007"
              test="some $code in $ISO4217 satisfies @currencyID = $code"
              flag="fatal">Currency code must be according to ISO 4217:2005</assert>
    </rule>

    <rule context="cbc:InvoiceTypeCode">
      <assert id="PEPPOL-EN16931-P0100"
              test="$profile != '01' or (some $code in tokenize('380 383 386 393 82 80 84 395 575 623 780', '\s') satisfies normalize-space(text()) = $code)"
              flag="fatal">Invoice type code MUST be set according to the profile.</assert>
    </rule>
    <rule context="cbc:CreditNoteTypeCode">
      <assert id="PEPPOL-EN16931-P0101"
              test="$profile != '01' or (some $code in tokenize('381 396 81 83 532', '\s') satisfies normalize-space(text()) = $code)"
              flag="fatal">Credit note type code MUST be set according to the profile.</assert>
    </rule>

    <rule context="cbc:IssueDate | cbc:DueDate | cbc:TaxPointDate | cbc:StartDate | cbc:EndDate | cbc:ActualDeliveryDate">
      <assert id="PEPPOL-EN16931-F001"
              test="string-length(text()) = 10 and (string(.) castable as xs:date)"
              flag="fatal">A date MUST be formatted YYYY-MM-DD.</assert>
    </rule>
  </pattern>

</schema>
