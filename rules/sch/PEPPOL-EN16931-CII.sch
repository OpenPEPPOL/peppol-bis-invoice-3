<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:u="utils"
        schemaVersion="iso" queryBinding="xslt2">

    <title>Rules for PEPPOL BIS 3.0 Billing</title>

    <ns uri="urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100" prefix="rsm"/>
    <ns uri="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:100" prefix="udt"/>
    <ns uri="urn:un:unece:uncefact:data:standard:QualifiedDataType:100" prefix="qdt"/>
    <ns uri="urn:un:unece:uncefact:data:standard:ReusableAggregateBusinessInformationEntity:100" prefix="ram"/>
    <ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
    <ns uri="utils" prefix="u"/>

    <!-- Parameters -->

    <let name="profile" value="if (/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:BusinessProcessSpecifiedDocumentContextParameter and matches(normalize-space(/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:BusinessProcessSpecifiedDocumentContextParameter/ram:ID), 'urn:fdc:peppol.eu:2017:poacc:billing:([0-9]{2}):1.0')) then tokenize(normalize-space(/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:BusinessProcessSpecifiedDocumentContextParameter/ram:ID), ':')[7] else 'Unknown'"/>
    <let name="supplierCountry" value="if (/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction[1]/ram:ApplicableHeaderTradeAgreement[1]/ram:SellerTradeParty[1]/ram:SpecifiedTaxRegistration[ram:ID/@schemeID='VAT']/substring(ram:ID,1,2)) then upper-case(normalize-space(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction[1]/ram:ApplicableHeaderTradeAgreement[1]/ram:SellerTradeParty[1]/ram:SpecifiedTaxRegistration[ram:ID/@schemeID='VAT']/substring(ram:ID,1,2)))  
        else if (/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration[ram:ID/@schemeID='VAT']/substring(ram:ID,1,2)) then upper-case(normalize-space(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration[ram:ID/@schemeID='VAT']/substring(ram:ID,1,2)))
        else if (/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:CountryID) then upper-case(normalize-space(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:CountryID)) 
        else 'XX'"/>  
    
    <!-- -->





    <let name="documentCurrencyCode" value="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode"/>

    <!-- Functions -->

    <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:slack" as="xs:boolean">
        <param name="exp" as="xs:decimal"/>
        <param name="val" as="xs:decimal"/>
        <param name="slack" as="xs:decimal"/>
        <value-of select="xs:decimal($exp + $slack) &gt;= $val and xs:decimal($exp - $slack) &lt;= $val"/>
    </function>

    <pattern>

        <rule context="rsm:ExchangedDocumentContext">
            <assert id="PEPPOL-EN16931-R001"
                    test="ram:BusinessProcessSpecifiedDocumentContextParameter/ram:ID"
                    flag="fatal">Business process MUST be provided.</assert>
            <assert id="PEPPOL-EN16931-R004"
                    test="starts-with(normalize-space(ram:GuidelineSpecifiedDocumentContextParameter/ram:ID/text()), 'urn:cen.eu:en16931:2017#compliant#urn:fdc:peppol.eu:2017:poacc:billing:3.0')"
                    flag="fatal">Specification identifier MUST have the value 'urn:cen.eu:en16931:2017#compliant#urn:fdc:peppol.eu:2017:poacc:billing:3.0'.</assert>
        </rule>

        <rule context="ram:ApplicableHeaderTradeAgreement">
            <assert id="PEPPOL-EN16931-R003"
                    test="ram:BuyerReference or ram:BuyerOrderReferencedDocument/ram:IssuerAssignedID"
                    flag="fatal">A buyer reference or purchase order reference MUST be provided.</assert>
        </rule>

        <rule context="ram:ApplicableHeaderTradeSettlement">
            <assert id="PEPPOL-EN16931-R005"
                    test="not(ram:TaxCurrencyCode) or normalize-space(ram:TaxCurrencyCode/text()) != normalize-space(ram:InvoiceCurrencyCode/text())"
                    flag="fatal">VAT accounting currency code MUST be different from invoice currency code when provided.</assert>
            <assert id="PEPPOL-EN16931-R052"
                    test="not(ram:TaxCurrencyCode) or count(ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxTotalAmount[@currencyID = normalize-space(../../ram:TaxCurrencyCode/text())])"
                    flag="fatal">The currencyID for invoice total VAT in accounting currency, must be the same as VAT accounting currency code (BT-6)</assert>
            <assert id="PEPPOL-EN16931-R053"
                    test="count(ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxTotalAmount[@currencyID = $documentCurrencyCode]) = 1"
                    flag="fatal">Only one tax total with tax subtotals MUST be provided.</assert>
            <assert id="PEPPOL-EN16931-R054"
                    test="count(ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxTotalAmount[@currencyID != $documentCurrencyCode]) = (if (ram:TaxCurrencyCode) then 1 else 0)"
                    flag="fatal">Only one tax total without tax subtotals MUST be provided when tax currency code is provided.</assert>
        </rule>

        <!-- PEPPOL-EN16931-R051 is obsolete in CII. -->

        <rule context="rsm:ExchangedDocument">
            <assert id="PEPPOL-EN16931-R002"
                    test="count(ram:IncludedNote) &lt;= 1 and not(ram:IncludedNote/ram:SubjectCode)"
                    flag="fatal">No more than one note is allowed on document level.</assert>
        </rule>

        <rule context="ram:BuyerTradeParty">
            <assert id="PEPPOL-EN16931-R010"
                    test="ram:URIUniversalCommunication/ram:URIID"
                    flag="fatal">Buyer electronic address MUST be provided</assert>
        </rule>

        <rule context="ram:SellerTradeParty">
            <assert id="PEPPOL-EN16931-R020"
                    test="ram:URIUniversalCommunication/ram:URIID"
                    flag="fatal">Seller electronic address MUST be provided</assert>
        </rule>

        <rule context="ram:SpecifiedTradeAllowanceCharge[ram:CalculationPercent and not(ram:BasisAmount)]">
            <assert id="PEPPOL-EN16931-R041"
                    test="false()"
                    flag="fatal">Allowance/charge base amount MUST be provided when allowance/charge percentage is provided.</assert>
        </rule>

        <rule context="ram:SpecifiedTradeAllowanceCharge[not(ram:CalculationPercent) and ram:BasisAmount]">
            <assert id="PEPPOL-EN16931-R042"
                    test="false()"
                    flag="fatal">Allowance/charge percentage MUST be provided when allowance/charge base amount is provided.</assert>
        </rule>

        <rule context="ram:SpecifiedTradeAllowanceCharge">
            <assert id="PEPPOL-EN16931-R040"
                    test="not(ram:CalculationPercent and ram:BasisAmount) or u:slack(if (ram:ActualAmount) then ram:ActualAmount else 0, (xs:decimal(ram:BasisAmount) * xs:decimal(ram:CalculationPercent)) div 100, 0.02)"
                    flag="fatal">Allowance/charge amount must equal base amount * percentage/100 if base amount and percentage exists</assert>
        </rule>



        <rule context="ram:SpecifiedTradeSettlementPaymentMeans[some $code in tokenize('49 59', '\s') satisfies normalize-space(ram:TypeCode) = $code]">
            <assert id="PEPPOL-EN16931-R061"
                    test="../ram:SpecifiedTradePaymentTerms/ram:DirectDebitMandateID"
                    flag="fatal">Mandate reference MUST be provided for direct debit.</assert>
        </rule>

        <rule context="rsm:SupplyChainTradeTransaction[ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:StartDateTime]/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:StartDateTime">
            <assert id="PEPPOL-EN16931-R110"
                    test="udt:DateTimeString  &gt;= ../../../../ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:StartDateTime/udt:DateTimeString"
                    flag="fatal">Start date of line period MUST be within invoice period.</assert>
        </rule>

        <rule context="rsm:SupplyChainTradeTransaction[ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:EndDateTime]/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:EndDateTime">
            <assert id="PEPPOL-EN16931-R111"
                    test="udt:DateTimeString  &lt;= ../../../../ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:EndDateTime/udt:DateTimeString"
                    flag="fatal">End date of line period MUST be within invoice period.</assert>
        </rule>

        <rule context="ram:IncludedSupplyChainTradeLineItem">
            <let name="lineExtensionAmount" value="if (ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount) then xs:decimal(ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount) else 0"/>
            <let name="quantity" value="if (ram:SpecifiedLineTradeDelivery/ram:BilledQuantity) then xs:decimal(ram:SpecifiedLineTradeDelivery/ram:BilledQuantity) else 1"/>
            <let name="priceAmount" value="if (ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:ChargeAmount) then xs:decimal(ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:ChargeAmount) else 0"/>
            <let name="baseQuantity" value="if (ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:BasisQuantity and xs:decimal(ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:BasisQuantity) != 0) then xs:decimal(ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:BasisQuantity) else 1"/>
            <let name="allowancesTotal" value="if (ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge[normalize-space(ram:ChargeIndicator/udt:Indicator) = 'false']) then xs:decimal(sum(ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge[normalize-space(ram:ChargeIndicator/udt:Indicator) = 'false']/ram:ActualAmount)) else 0"/>
            <let name="chargesTotal" value="if (ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge[normalize-space(ram:ChargeIndicator/udt:Indicator) = 'true']) then xs:decimal(sum(ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge[normalize-space(ram:ChargeIndicator/udt:Indicator) = 'true']/ram:ActualAmount)) else 0"/>

            <assert id="PEPPOL-EN16931-R120"
                    test="u:slack($lineExtensionAmount, ($quantity * ($priceAmount div $baseQuantity)) + $chargesTotal - $allowancesTotal, 0.02)"
                    flag="fatal">Invoice line net amount MUST equal (Invoiced quantity * (Item net price/item price base quantity) + Invoice line charge amount - Invoice line allowance amount</assert>
        </rule>

        <rule context="ram:NetPriceProductTradePrice | ram:GrossPriceProductTradePrice">
            <assert id="PEPPOL-EN16931-R121"
                    test="not(ram:BasisQuantity) or xs:decimal(ram:BasisQuantity) &gt; 0"
                    flag="fatal">Base quantity MUST be a positive number above zero.</assert>
        </rule>

        <!-- PEPPOL-EN16931-R044 and PEPPOL-EN16931-R046 are not needed due to lack of elements for the EN. -->

        <!-- Price -->
        <rule context="ram:NetPriceProductTradePrice/ram:BasisQuantity[@unitCode] | ram:GrossPriceProductTradePrice/ram:BasisQuantity[@unitCode]">
          <assert id="PEPPOL-EN16931-R130"
                  test="@unitCode = ../../../ram:SpecifiedLineTradeDelivery/ram:BilledQuantity/@unitCode"
                  flag="fatal">Unit code of price base quantity MUST be same as invoiced quantity.</assert>
        </rule>

    </pattern>

    <!-- National rules -->
    <pattern>
        <rule context="ram:SellerTradeParty[$supplierCountry = 'NO']">
            <assert id="NO-R-001"
                    test="ram:SpecifiedLegalOrganization"
                    flag="fatal">Norwegian suppliers MUST provide legal entity.</assert>
            <assert id="NO-R-002"
                    test="ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'FC'][normalize-space(text()) = 'Foretaksregisteret']"
                    flag="warning">Most invoice issuers are required to append "Foretaksregisteret" to their invoice. "Dersom selger er aksjeselskap, allmennaksjeselskap eller filial av utenlandsk selskap skal også ordet «Foretaksregisteret» fremgå av salgsdokumentet, jf. foretaksregisterloven § 10-2."</assert>
        </rule>
        
        
        <!-- Italian rules -->
        <rule context="ram:SellerTradeParty[$supplierCountry = 'IT']">
            <assert id="IT-R-001" 
                test=" (exists(ram:SpecifiedTaxRegistration/ram:ID) and ram:SpecifiedTaxRegistration/ram:ID[@schemeID ='FC']) " 
                flag="fatal"> [IT-R-001] BT-32 (Seller tax registration identifier) - Italian suppliers MUST provide Tax Regime Identifier. I fornitori italiani devono indicare il Regime Fiscale </assert>
            <assert id="IT-R-002" 
                test= "exists(ram:PostalTradeAddress/ram:LineOne)" 
                flag="fatal"> [IT-R-002] BT-35 (Seller address line 1) - Italian suppliers MUST provide the postal address line 1 - I fornitori italiani devono indicare l'indirizzo postale. </assert>
            <assert id="IT-R-003" 
                test= "exists(ram:PostalTradeAddress/ram:CityName)" 
                flag="fatal"> [IT-R-003] BT-37 (Seller city) - Italian suppliers MUST provide the postal address city - I fornitori italiani devono indicare la città di residenza. </assert>
            <assert id="IT-R-004" 
                test= "exists(ram:PostalTradeAddress/ram:PostcodeCode)" 
                flag="fatal"> [IT-R-004] BT-38 (Seller post code) - Italian suppliers MUST provide the postal address post code - I fornitori italiani devono indicare il CAP di residenza.</assert>
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

        <rule context="ram:AttachmentBinaryObject[@mimeCode]">
            <assert id="PEPPOL-EN16931-CL001"
                    test="some $code in $MIMECODE satisfies @mimeCode = $code"
                    flag="fatal">Invalid mime code.</assert>
        </rule>

        <rule context="ram:SpecifiedTradeAllowanceCharge[normalize-space(ram:ChargeIndicator/udt:Indicator) = 'false']/ram:ReasonCode">
            <assert id="PEPPOL-EN16931-CL002"
                    test="some $code in $UNCL5189 satisfies normalize-space(text()) = $code"
                    flag="fatal">Reason code MUST be according to subset of UNCL 5189 D.16B.</assert>
        </rule>

        <rule context="ram:SpecifiedTradeAllowanceCharge[normalize-space(ram:ChargeIndicator/udt:Indicator) = 'true']/ram:ReasonCode">
            <assert id="PEPPOL-EN16931-CL003"
                    test="some $code in $UNCL7161 satisfies normalize-space(text()) = $code"
                    flag="fatal">Reason code MUST be according to UNCL 7161 D.16B.</assert>
        </rule>

        <rule context="ram:ApplicableTradeTax/ram:CategoryCode">
            <assert id="PEPPOL-EN16931-CL004"
                    test="some $code in $UNCL5305 satisfies normalize-space(text()) = $code"
                    flag="fatal">Tax category code MUST be according to defined subset of UNCL 5305 D.16B.</assert>
        </rule>

        <rule context="ram:CountryID">
            <assert id="PEPPOL-EN16931-CL005"
                    test="some $code in $ISO3166 satisfies normalize-space(text()) = $code"
                    flag="fatal">Country code MUST be according to ISO 3166 Alpha-2.</assert>
        </rule>


        <!-- PEPPOL-EN16931-CL006 is omitted due to lack of description code for invoice period in CII syntax. -->

        <rule context="ram:TaxTotalAmount[@currencyID]">
            <assert id="PEPPOL-EN16931-CL007"
                    test="some $code in $ISO4217 satisfies @currencyID = $code"
                    flag="fatal">Currency code must be according to ISO 4217:2005</assert>
        </rule>

        <rule context="ram:ExchangedDocument/ram:TypeCode">
            <assert id="PEPPOL-EN16931-P0100"
                    test="$profile != '01' or (some $code in tokenize('380 383 386 393 82 80 84 395 575 623 780 381 396 81 83 532', '\s') satisfies normalize-space(text()) = $code)"
                    flag="fatal">Invoice type code MUST be set according to the profile.</assert>
        </rule>

        <!-- PEPPOL-EN16931-P0101 is part of PEPPOL-EN16931-P0100. -->

        <rule context="udt:DateTimeString">
            <assert id="PEPPOL-EN16931-F001"
                    test="normalize-space(@format) = '102' and string-length(text()) = 8 and matches(normalize-space(text()), '20[0-9]{6}')"
                    flag="fatal">A date MUST be formatted YYYYMMDD.</assert>
        </rule>
    </pattern>

</schema>