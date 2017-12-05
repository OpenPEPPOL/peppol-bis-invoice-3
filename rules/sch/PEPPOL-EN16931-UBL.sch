<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        schemaVersion="iso" queryBinding="xslt2">

  <title>Rules for PEPPOL BIS 3.0 Billing</title>

  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" prefix="cbc"/>
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" prefix="cac"/>
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2" prefix="ubl-creditnote"/>
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" prefix="ubl-invoice"/>
  <ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>

  <pattern>
    <rule context="ubl-creditnote:CreditNote | ubl-invoice:Invoice">
      <assert id="PEPPOL-EN16931-R001"
              test="cbc:ProfileID"
              flag="fatal">Business process must be provided.</assert>
      <assert id="PEPPOL-EN16931-R002"
              test="count(cbc:Note) &lt;= 1"
              flag="fatal">No more than one note is allowed on document level.</assert>
    </rule>
  </pattern>

  <!-- Restricted code lists -->
  <pattern>
    <let name="ISO4217" value="tokenize('AFN EUR ALL DZD USD AOA XCD XCD ARS AMD AWG AUD AZN BSD BHD BDT BBD BYN BZD XOF BMD INR BTN BOB BOV USD BAM BWP NOK BRL USD BND BGN XOF BIF CVE KHR XAF CAD KYD XAF XAF CLP CLF CNY AUD AUD COP COU KMF CDF XAF NZD CRC XOF HRK CUP CUC ANG CZK DKK DJF XCD DOP USD EGP SVC USD XAF ERN ETB FKP DKK FJD XPF XAF GMD GEL GHS GIP DKK XCD USD GTQ GBP GNF XOF GYD HTG USD AUD HNL HKD HUF ISK INR IDR XDR IRR IQD GBP ILS JMD JPY GBP JOD KZT KES AUD KPW KRW KWD KGS LAK LBP LSL ZAR LRD LYD CHF MOP MKD MGA MWK MYR MVR XOF USD MRO MUR XUA MXN MXV USD MDL MNT XCD MAD MZN MMK NAD ZAR AUD NPR XPF NZD NIO XOF NGN NZD AUD USD NOK OMR PKR USD PAB USD PGK PYG PEN PHP NZD PLN USD QAR RON RUB RWF SHP XCD XCD XCD WST STD SAR XOF RSD SCR SLL SGD ANG XSU SBD SOS ZAR SSP LKR SDG SRD NOK SZL SEK CHF CHE CHW SYP TWD TJS TZS THB USD XOF NZD TOP TTD TND TRY TMT USD AUD UGX UAH AED GBP USD USD USN UYU UYI UZS VUV VEF VND USD USD XPF MAD YER ZMW ZWL XBA XBB XBC XBD XTS XXX XAU XPD XPT XAG', '\s')"/>
    <let name="ISO6133" value="tokenize('DK NO SE', '\s')"/>
    <let name="MIMECODE" value="tokenize('application/pdf image/png image/jpeg text/csv application/vnd.openxmlformats-officedocument.spreadsheetml.sheet application/vnd.oasis.opendocument.spreadsheet', '\s')"/>
    <let name="UNCL2005" value="tokenize('3 35 432', '\s')"/>
    <let name="UNCL5305" value="tokenize('AE E S Z G O K L M', '\s')"/>

    <rule context="cbc:EmbeddedDocumentBinaryObject[@mimeCode]">
      <assert id="PEPPOL-EN16931-CL001"
              test="some $code in $MIMECODE satisfies @mimeCode = $code"
              flag="fatal">Invalid mime code.</assert>
    </rule>

    <rule context="cbc:AllowanceChargeReasonCode[cbc:ChargeIndicator='false']">
      <assert id="PEPPOL-EN16931-CL002"
              test="matches(text(), '[0-9]{1,3}')"
              flag="fatal">Reason code must be according to UNCL 5189 D.16B.</assert>
    </rule>

    <rule context="cbc:AllowanceChargeReasonCode[cbc:ChargeIndicator='true']">
      <assert id="PEPPOL-EN16931-CL003"
              test="matches(text(), '[A-Z]{2,3}')"
              flag="fatal">Reason code must be according to UNCL 7161 D.16B.</assert>
    </rule>

    <rule context="cac:ClassifiedTaxCategory/cbc:ID | cac:TaxCategory/cbc:ID">
      <assert id="PEPPOL-EN16931-CL004"
              test="some $code in $UNCL5305 satisfies text() = $code"
              flag="fatal">Tax category code must be according to defined subset of UNCL 5305 D.16B.</assert>
    </rule>

    <rule context="cac:CountryCode/cbc:IdentificationCode | cac:OriginCountry/cbc:IdentificationCode">
      <assert id="PEPPOL-EN16931-CL005"
              test="some $code in $ISO6133 satisfies text() = $code"
              flag="fatal">County code must be according to ISO 6133 Alpha-2.</assert>
    </rule>

    <rule context="cac:InvoicePeriod/cbc:DescriptionCode">
      <assert id="PEPPOL-EN16931-CL006"
              test="text() = 'ZZZ' or (text() castable as xs:integer and number(text()) &gt;= 1 and number(text()) &lt;= 809)"
              flag="fatal">Invoice period description code must be according to UNCL 2005 D.16B.</assert>
    </rule>

    <rule context="cbc:*[@currencyID]">
      <assert id="PEPPOL-EN16931-CL007"
              test="some $code in $ISO4217 satisfies text() = $code"
              flag="fatal">Currency code must be according to ISO 4217:2005</assert>
    </rule>
  </pattern>

</schema>
