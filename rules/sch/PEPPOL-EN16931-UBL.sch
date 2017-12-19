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
  <let name="supplierCountry" value="if (/*/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode) then upper-case(normalize-space(/*/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode)) else 'XX'"/>

  <!-- Functions -->

  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:slack" as="xs:boolean">
    <param name="exp" as="xs:decimal"/>
    <param name="val" as="xs:decimal"/>
    <param name="slack" as="xs:decimal"/>
    <value-of select="xs:decimal($exp + $slack) &gt;= $val and xs:decimal($exp - $slack) &lt;= $val"/>
  </function>

  <!--
    Transaction rules

    R00X - Document level
    R01X - Accounting customer
    R02X - Accounting supplier
    R04X - Allowance/Charge (document and line)
    R1XX - Line level
    R11X - Invoice period
  -->
  <pattern>

    <!-- Document level -->
    <rule context="ubl-creditnote:CreditNote | ubl-invoice:Invoice">
      <assert id="PEPPOL-EN16931-R001"
              test="cbc:ProfileID"
              flag="fatal">Business process must be provided.</assert>
      <assert id="PEPPOL-EN16931-R002"
              test="count(cbc:Note) &lt;= 1"
              flag="fatal">No more than one note is allowed on document level.</assert>
      <assert id="PEPPOL-EN16931-R003"
              test="cbc:BuyerReference or cac:OrderReference/cbc:ID"
              flag="fatal">A buyer reference or purchase order reference MUST be provided.</assert>
      <assert id="PEPPOL-EN16931-R004"
              test="starts-with(normalize-space(cbc:CustomizationID/text()), 'urn:cen.eu:en16931:2017#compliant#urn:fdc:peppol.eu:2017:poacc:billing:3.0')"
              flag="fatal">Specification identifier MUST have the value 'urn:cen.eu:en16931:2017#compliant#urn:fdc:peppol.eu:2017:poacc:billing:3.0'.</assert>
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
      <assert id="NO-R-001"
              test="not($supplierCountry = 'NO') or cac:PartyLegalEntity"
              flag="fatal">Norwegian suppliers MUST provide legal entity.</assert>
      <assert id="NO-R-002"
              test="not($supplierCountry = 'NO') or normalize-space(cac:PartyTaxScheme[normalize-space(cac:TaxScheme/cbc:ID) = 'VAT']/cbc:CompanyID) = 'Foretaksregisteret'"
              flag="warning">"Dersom selger er aksjeselskap, allmennaksjeselskap eller filial av utenlandsk selskap skal også ordet «Foretaksregisteret» fremgå av salgsdokumentet, jf. foretaksregisterloven § 10-2."</assert>
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
      <assert id="PEPPOL-EN16931-R043"
              test="xs:decimal(cbc:Amount) &gt;= 0"
              flag="fatal">Allowance/charge amount cannot be negative</assert>
    </rule>

    <rule context="cbc:TaxExemptionReasonCode">
      <assert id="PEPPOL-EN16931-R050"
              test="false()"
              flag="fatal">Tax exception reason code MUST NOT be used.</assert>
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
      <let name="baseQuantity" value="if (cac:Price/cbc:BaseQuantity) then xs:decimal(cac:Price/cbc:BaseQuantity) else 1"/>
      <let name="allowancesTotal" value="if (cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'false']) then xs:decimal(sum(cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'false']/cbc:Amount)) else 0"/>
      <let name="chargesTotal" value="if (cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'true']) then xs:decimal(sum(cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'true']/cbc:Amount)) else 0"/>

      <assert id="PEPPOL-EN16931-R120"
              test="$baseQuantity &lt;= 0 or u:slack($lineExtensionAmount, ($quantity * ($priceAmount div $baseQuantity)) + $chargesTotal - $allowancesTotal, 0.02)"
              flag="fatal">Invoice line net amount MUST equal (Invoiced quantity * (Item net price/item price base quantity) + Invoice line charge amount - Invoice line allowance amount</assert>
      <assert id="PEPPOL-EN16931-R121"
              test="$baseQuantity &gt; 0"
              flag="fatal">Base quantity MUST be a positive number above zero.</assert>
    </rule>

    <!-- Allowance (price level) -->
    <rule context="cac:Price/cac:AllowanceCharge">
      <assert id="PEPPOL-EN16931-R044"
              test="normalize-space(cbc:ChargeIndicator) = 'false'"
              flag="fatal">Charge on price level is NOT allowed.</assert>
      <assert id="PEPPOL-EN16931-R045"
              test="xs:decimal(cbc:Amount) &gt;= 0"
              flag="fatal">Allowance/charge amount cannot be negative</assert>
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

  <!-- Restricted code lists and formatting -->
  <pattern>
    <!-- TODO -->
    <let name="ISO4217" value="tokenize('AFN EUR ALL DZD USD AOA XCD XCD ARS AMD AWG AUD AZN BSD BHD BDT BBD BYN BZD XOF BMD INR BTN BOB BOV USD BAM BWP NOK BRL USD BND BGN XOF BIF CVE KHR XAF CAD KYD XAF XAF CLP CLF CNY AUD AUD COP COU KMF CDF XAF NZD CRC XOF HRK CUP CUC ANG CZK DKK DJF XCD DOP USD EGP SVC USD XAF ERN ETB FKP DKK FJD XPF XAF GMD GEL GHS GIP DKK XCD USD GTQ GBP GNF XOF GYD HTG USD AUD HNL HKD HUF ISK INR IDR XDR IRR IQD GBP ILS JMD JPY GBP JOD KZT KES AUD KPW KRW KWD KGS LAK LBP LSL ZAR LRD LYD CHF MOP MKD MGA MWK MYR MVR XOF USD MRO MUR XUA MXN MXV USD MDL MNT XCD MAD MZN MMK NAD ZAR AUD NPR XPF NZD NIO XOF NGN NZD AUD USD NOK OMR PKR USD PAB USD PGK PYG PEN PHP NZD PLN USD QAR RON RUB RWF SHP XCD XCD XCD WST STD SAR XOF RSD SCR SLL SGD ANG XSU SBD SOS ZAR SSP LKR SDG SRD NOK SZL SEK CHF CHE CHW SYP TWD TJS TZS THB USD XOF NZD TOP TTD TND TRY TMT USD AUD UGX UAH AED GBP USD USD USN UYU UYI UZS VUV VEF VND USD USD XPF MAD YER ZMW ZWL XBA XBB XBC XBD XTS XXX XAU XPD XPT XAG', '\s')"/>
    <!-- TODO -->
    <let name="ISO6133" value="tokenize('DK NO SE', '\s')"/>
    <let name="MIMECODE" value="tokenize('application/pdf image/png image/jpeg text/csv application/vnd.openxmlformats-officedocument.spreadsheetml.sheet application/vnd.oasis.opendocument.spreadsheet', '\s')"/>
    <let name="UNCL2005" value="tokenize('3 35 432', '\s')"/>
    <let name="UNCL5305" value="tokenize('AE E S Z G O K L M', '\s')"/>

    <rule context="cbc:EmbeddedDocumentBinaryObject[@mimeCode]">
      <assert id="PEPPOL-EN16931-CL001"
              test="some $code in $MIMECODE satisfies @mimeCode = $code"
              flag="fatal">Invalid mime code.</assert>
    </rule>

    <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='false']/cbc:AllowanceChargeReasonCode">
      <!-- TODO -->
      <assert id="PEPPOL-EN16931-CL002"
              test="matches(text(), '[0-9]{1,3}')"
              flag="fatal">Reason code must be according to UNCL 5189 D.16B.</assert>
    </rule>

    <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='true']/cbc:AllowanceChargeReasonCode">
      <!-- TODO -->
      <assert id="PEPPOL-EN16931-CL003"
              test="matches(text(), '[A-Z]{2,3}')"
              flag="fatal">Reason code must be according to UNCL 7161 D.16B.</assert>
    </rule>

    <rule context="cac:ClassifiedTaxCategory/cbc:ID | cac:TaxCategory/cbc:ID">
      <assert id="PEPPOL-EN16931-CL004"
              test="some $code in $UNCL5305 satisfies normalize-space(text()) = $code"
              flag="fatal">Tax category code must be according to defined subset of UNCL 5305 D.16B.</assert>
    </rule>

    <rule context="cac:CountryCode/cbc:IdentificationCode | cac:OriginCountry/cbc:IdentificationCode">
      <assert id="PEPPOL-EN16931-CL005"
              test="some $code in $ISO6133 satisfies text() = $code"
              flag="fatal">Counrty code must be according to ISO 6133 Alpha-2.</assert>
    </rule>

    <rule context="cac:InvoicePeriod/cbc:DescriptionCode">
      <assert id="PEPPOL-EN16931-CL006"
              test="some $code in $UNCL2005 satisfies normalize-space(text()) = $code"
              flag="fatal">Invoice period description code must be according to UNCL 2005 D.16B.</assert>
    </rule>

    <rule context="cbc:*[@currencyID]">
      <assert id="PEPPOL-EN16931-CL007"
              test="some $code in $ISO4217 satisfies @currencyID = $code"
              flag="fatal">Currency code must be according to ISO 4217:2005</assert>
    </rule>

    <rule context="cbc:InvoiceTypeCode">
      <assert id="PEPPOL-EN16931-P0100"
              test="$profile != '01' or (some $code in tokenize('380 393 82 80 84 395 575 623 780', '\s') satisfies normalize-space(text()) = $code)"
              flag="fatal">Invoice type code MUST be set according to the profile.</assert>
    </rule>

    <rule context="cbc:IssueDate | cbc:DueDate | cbc:TaxPointDate | cbc:StartDate | cbc:EndDate | cbc:ActualDeliveryDate">
      <assert id="PEPPOL-EN16931-F001"
              test="string-length(text()) = 10 and (string(.) castable as xs:date)"
              flag="fatal">A date MUST be formatted YYYY-MM-DD.</assert>
    </rule>
  </pattern>

</schema>
