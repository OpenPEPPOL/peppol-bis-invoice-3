<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        xmlns:rsm="urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100"
        xmlns:ccts="urn:un:unece:uncefact:documentation:standard:CoreComponentsTechnicalSpecification:2"
        xmlns:udt="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:100"
        xmlns:qdt="urn:un:unece:uncefact:data:standard:QualifiedDataType:100"
        xmlns:ram="urn:un:unece:uncefact:data:standard:ReusableAggregateBusinessInformationEntity:100"
        queryBinding="xslt2">
  <title>EN16931 model bound to CII</title>
  <ns prefix="rsm"
       uri="urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100"/>
  <ns prefix="ccts"
       uri="urn:un:unece:uncefact:documentation:standard:CoreComponentsTechnicalSpecification:2"/>
  <ns prefix="udt"
       uri="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:100"/>
  <ns prefix="qdt"
       uri="urn:un:unece:uncefact:data:standard:QualifiedDataType:100"/>
  <ns prefix="ram"
       uri="urn:un:unece:uncefact:data:standard:ReusableAggregateBusinessInformationEntity:100"/>
  <phase id="EN16931-model-phase">
      <active pattern="EN16931-CII-Model"/>
  </phase>
  <phase id="codelist_phase">
      <active pattern="EN16931-Codes"/>
  </phase>
  <phase id="syntax_phase">
      <active pattern="EN16931-CII-Syntax"/>
  </phase>
  
  
  <!--Suppressed abstract pattern EN16931 was here-->
  <!--Suppressed abstract pattern EN16931-CII was here-->
  
  
  <!--Start pattern based on abstract EN16931--><pattern id="EN16931-CII-Model">  
      <rule context="//ram:AdditionalReferencedDocument">
         <assert test="(ram:IssuerAssignedID!='')" flag="fatal" id="BR-52">[BR-52]-Each Additional supporting document (BG-24) shall contain a Supporting document reference (BT-122).</assert>    
      </rule>
      <rule context="//ram:ApplicableTradeSettlementFinancialCard">
         <assert test="string-length(ram:ID)&lt;=6 and string-length(ram:ID)&gt;=4"
                 flag="fatal"
                 id="BR-51">[BR-51]-The last 4 to 6 digits of the Payment card primary account number (BT-87) shall be present if Payment card information (BG-18) is provided in the Invoice.</assert>
      </rule>
      <rule context="//ram:SpecifiedTradeSettlementPaymentMeans[ram:TypeCode='30' or ram:TypeCode='58']/ram:PayerPartyDebtorFinancialAccount">
         <assert test="(ram:IBANID) or (ram:ProprietaryID)" flag="fatal" id="BR-50">[BR-50]-A Payment account identifier (BT-84) shall be present if Credit transfer (BG-16) information is provided in the Invoice.</assert>
         <assert test="(ram:IBANID) or (ram:ProprietaryID)" flag="fatal" id="BR-61">[BR-61]-If the Payment means type code (BT-81) means SEPA credit transfer, Local credit transfer or Non-SEPA international credit transfer, the Payment account identifier (BT-84) shall be present.</assert>
      </rule>
      <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery">
         <assert test="(ram:ShipToTradeParty/ram:PostalTradeAddress and ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CountryID!='') or not (ram:ShipToTradeParty/ram:PostalTradeAddress)"
                 flag="fatal"
                 id="BR-57">[BR-57]-Each Deliver to address (BG-15) shall contain a Deliver to country code (BT-80).</assert>
      </rule>
      <rule context="//ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false']">
         <assert test="(ram:ActualAmount)" flag="fatal" id="BR-31">[BR-31]-Each Document level allowance (BG-20) shall have a Document level allowance amount (BT-92).</assert>
         <assert test="(ram:CategoryTradeTax/ram:CategoryCode)"
                 flag="fatal"
                 id="BR-32">[BR-32]-Each Document level allowance (BG-20) shall have a Document level allowance VAT category code (BT-95).</assert>
         <assert test="(ram:Reason) or (ram:ReasonCode)" flag="fatal" id="BR-33">[BR-33]-Each Document level allowance (BG-20) shall have a Document level allowance reason (BT-97) or a Document level allowance reason code (BT-98).</assert>
         <assert test="true()" flag="fatal" id="BR-CO-05">[BR-CO-05]-Document level allowance reason code (BT-98) and Document level allowance reason (BT-97) shall indicate the same type of allowance.</assert>
         <assert test="(ram:Reason) or (ram:ReasonCode)" flag="fatal" id="BR-CO-21">[BR-CO-21]-Each Document level allowance (BG-20) shall contain a Document level allowance reason (BT-97) or a Document level allowance reason code (BT-98), or both.</assert>
         <assert test="string-length(substring-after(ram:ActualAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-01">[BR-DEC-01]-The allowed maximum number of decimals for the Document level allowance amount (BT-92) is 2.</assert>
         <assert test="string-length(substring-after(ram:BasisAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-02">[BR-DEC-02]-The allowed maximum number of decimals for the Document level allowance base amount (BT-93) is 2.</assert>    
      </rule>
      <rule context="//ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true']">
         <assert test="(ram:ActualAmount)" flag="fatal" id="BR-36">[BR-36]-Each Document level charge (BG-21) shall have a Document level charge amount (BT-99). </assert>
         <assert test="(ram:CategoryTradeTax/ram:CategoryCode)"
                 flag="fatal"
                 id="BR-37">[BR-37]-Each Document level charge (BG-21) shall have a Document level charge VAT category code (BT-102).</assert>
         <assert test="(ram:Reason) or (ram:ReasonCode)" flag="fatal" id="BR-38">[BR-38]-Each Document level charge (BG-21) shall have a Document level charge reason (BT-104) or a Document level charge reason code (BT-105).</assert>    
         <assert test="true()" flag="fatal" id="BR-CO-06">[BR-CO-06]-Document level charge reason code (BT-105) and Document level charge reason (BT-104) shall indicate the same type of charge. </assert>
         <assert test="(ram:Reason) or (ram:ReasonCode)" flag="fatal" id="BR-CO-22">[BR-CO-22]-Each Document level charge (BG-21) shall contain a Document level charge reason (BT-104) or a Document level charge reason code (BT-105), or both.</assert>
         <assert test="string-length(substring-after(ram:ActualAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-05">[BR-DEC-05]-The allowed maximum number of decimals for the Document level charge amount (BT-92) is 2.</assert>
         <assert test="string-length(substring-after(ram:BasisAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-06">[BR-DEC-06]-The allowed maximum number of decimals for the Document level charge base amount (BT-93) is 2.</assert>    
      </rule>
      <rule context="//ram:SpecifiedTradeSettlementHeaderMonetarySummation">
         <assert test="(ram:LineTotalAmount)" flag="fatal" id="BR-12">[BR-12]-An Invoice shall have the Sum of Invoice line net amount (BT-106). </assert>
         <assert test="(ram:TaxBasisTotalAmount)" flag="fatal" id="BR-13">[BR-13]-An Invoice shall have the Invoice total amount without VAT (BT-109).</assert>
         <assert test="(ram:GrandTotalAmount)" flag="fatal" id="BR-14">[BR-14]-An Invoice shall have the Invoice total amount with VAT (BT-112).</assert>
         <assert test="(ram:DuePayableAmount)" flag="fatal" id="BR-15">[BR-15]-An Invoice shall have the Amount due for payment (BT-115).</assert>
         <assert test="ram:LineTotalAmount = (round(sum(../../ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount) * 10 * 10)div 100)"
                 flag="fatal"
                 id="BR-CO-10">[BR-CO-10]-Sum of Invoice line net amount (BT-106) = Σ Invoice line net amount (BT-131).</assert>
         <assert test="(not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false'])and not (ram:AllowanceTotalAmount)) or ram:AllowanceTotalAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false']/ram:ActualAmount)* 10 * 10 ) div 100)"
                 flag="fatal"
                 id="BR-CO-11">[BR-CO-11]-Sum of allowances on document level (BT-107) = Σ Document level allowance amount (BT-92).</assert>
         <assert test="(not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true'])and not (ram:ChargeTotalAmount)) or ram:ChargeTotalAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true']/ram:ActualAmount)* 10 * 10 ) div 100) "
                 flag="fatal"
                 id="BR-CO-12">[BR-CO-12]-Sum of charges on document level (BT-108) = Σ Document level charge amount (BT-99).</assert>
         <assert test="(ram:TaxBasisTotalAmount = ram:LineTotalAmount - ram:AllowanceTotalAmount + ram:ChargeTotalAmount) or      ((ram:TaxBasisTotalAmount = ram:LineTotalAmount - ram:AllowanceTotalAmount) and not (ram:ChargeTotalAmount)) or      ((ram:TaxBasisTotalAmount = ram:LineTotalAmount + ram:ChargeTotalAmount) and not (ram:AllowanceTotalAmount)) or      ((ram:TaxBasisTotalAmount = ram:LineTotalAmount) and not (ram:ChargeTotalAmount) and not (ram:AllowanceTotalAmount))"
                 flag="fatal"
                 id="BR-CO-13">[BR-CO-13]-Invoice total amount without VAT (BT-109) = Σ Invoice line net amount (BT-131) - Sum of allowances on document level (BT-107) + Sum of charges on document level (BT-108).</assert>
         <assert test="(ram:GrandTotalAmount = round(     ram:TaxBasisTotalAmount*100 + ram:TaxTotalAmount[@currencyID=/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode]*100 +0)      div 100) or     ((ram:GrandTotalAmount = ram:TaxBasisTotalAmount) and not (ram:TaxTotalAmount[@currencyID=/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode]))"
                 flag="fatal"
                 id="BR-CO-15">[BR-CO-15]-Invoice total amount with VAT (BT-112) = Invoice total amount without VAT (BT-109) + Invoice total VAT amount (BT-110).</assert>
         <assert test="(ram:DuePayableAmount = ram:GrandTotalAmount - ram:TotalPrepaidAmount + ram:RoundingAmount) or      ((ram:DuePayableAmount = ram:GrandTotalAmount + ram:RoundingAmount) and not (ram:TotalPrepaidAmount)) or      ((ram:DuePayableAmount = ram:GrandTotalAmount - ram:TotalPrepaidAmount) and not (ram:RoundingAmount)) or      ((ram:DuePayableAmount = ram:GrandTotalAmount) and not (ram:TotalPrepaidAmount) and not (ram:RoundingAmount))"
                 flag="fatal"
                 id="BR-CO-16">[BR-CO-16]-Amount due for payment (BT-115) = Invoice total amount with VAT (BT-112) -Paid amount (BT-113) +Rounding amount (BT-114).</assert>
         <assert test="string-length(substring-after(ram:LineTotalAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-09">[BR-DEC-09]-The allowed maximum number of decimals for the Sum of Invoice line net amount (BT-106) is 2.</assert>
         <assert test="string-length(substring-after(ram:AllowanceTotalAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-10">[BR-DEC-10]-The allowed maximum number of decimals for the Sum of allowanced on document level (BT-107) is 2.</assert>
         <assert test="string-length(substring-after(ram:ChargeTotalAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-11">[BR-DEC-11]-The allowed maximum number of decimals for the Sum of charges on document level (BT-108) is 2.</assert>
         <assert test="string-length(substring-after(ram:TaxBasisTotalAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-12">[BR-DEC-12]-The allowed maximum number of decimals for the Invoice total amount without VAT (BT-109) is 2.</assert>    
         <assert test="string-length(substring-after(ram:GrandTotalAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-14">[BR-DEC-14]-The allowed maximum number of decimals for the Invoice total amount with VAT (BT-112) is 2.</assert>
         <assert test="not(ram:TaxTotalAmount) or ram:TaxTotalAmount[(@currencyID =/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode and . = round(. * 100) div 100) or not (@currencyID =/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode)]"
                 flag="fatal"
                 id="BR-DEC-13">[BR-DEC-13]-The allowed maximum number of decimals for the Invoice total VAT amount (BT-110) is 2.</assert>
         <assert test="not(ram:TaxTotalAmount) or ram:TaxTotalAmount[(@currencyID =/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode and . = round(. * 100) div 100) or not (/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode)]"
                 flag="fatal"
                 id="BR-DEC-15">[BR-DEC-15]-The allowed maximum number of decimals for the Invoice total VAT amount in accounting currency (BT-111) is 2.</assert>
         <assert test="string-length(substring-after(ram:TotalPrepaidAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-16">[BR-DEC-16]-The allowed maximum number of decimals for the Paid amount (BT-113) is 2.</assert>
         <assert test="string-length(substring-after(ram:RoundingAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-17">[BR-DEC-17]-The allowed maximum number of decimals for the Rounding amount (BT-114) is 2.</assert>
         <assert test="string-length(substring-after(ram:DuePayableAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-18">[BR-DEC-18]-The allowed maximum number of decimals for the Amount due for payment (BT-115) is 2.</assert>
      </rule>  
      <rule context="/rsm:CrossIndustryInvoice">
         <assert test="(rsm:ExchangedDocumentContext/ram:GuidelineSpecifiedDocumentContextParameter/ram:ID != '')"
                 flag="fatal"
                 id="BR-01">[BR-01]-An Invoice shall have a Specification identifier (BT-24).</assert>    
         <assert test="(rsm:ExchangedDocument/ram:ID !='')" flag="fatal" id="BR-02">[BR-02]-An Invoice shall have an Invoice number (BT-1).</assert>
         <assert test="(rsm:ExchangedDocument/ram:IssueDateTime/udt:DateTimeString[@format='102']!='')"
                 flag="fatal"
                 id="BR-03">[BR-03]-An Invoice shall have an Invoice issue date (BT-2).</assert>
         <assert test="(rsm:ExchangedDocument/ram:TypeCode!='')"
                 flag="fatal"
                 id="BR-04">[BR-04]-An Invoice shall have an Invoice type code (BT-3).</assert>
         <assert test="(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode!='')"
                 flag="fatal"
                 id="BR-05">[BR-05]-An Invoice shall have an Invoice currency code (BT-5).</assert>
         <assert test="(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:Name!='')"
                 flag="fatal"
                 id="BR-06">[BR-06]-An Invoice shall contain the Seller name (BT-27).</assert>
         <assert test="(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:Name!='')"
                 flag="fatal"
                 id="BR-07">[BR-07]-An Invoice shall contain the Buyer name (BT-44).</assert>
         <assert test="//ram:SellerTradeParty/ram:PostalTradeAddress"
                 flag="fatal"
                 id="BR-08">[BR-08]-An Invoice shall contain the Seller postal address (BG-5).</assert>
         <assert test="//ram:SellerTradeParty/ram:PostalTradeAddress/ram:CountryID!=''"
                 flag="fatal"
                 id="BR-09">[BR-09]-The Seller postal address (BG-5) shall contain a Seller country code (BT-40).</assert>
         <assert test="//ram:BuyerTradeParty/ram:PostalTradeAddress"
                 flag="fatal"
                 id="BR-10">[BR-10]-An Invoice shall contain the Buyer postal address (BG-8).</assert>
         <assert test="//ram:BuyerTradeParty/ram:PostalTradeAddress/ram:CountryID!=''"
                 flag="fatal"
                 id="BR-11">[BR-11]-The Buyer postal address shall contain a Buyer country code (BT-55).</assert>
         <assert test="//ram:IncludedSupplyChainTradeLineItem"
                 flag="fatal"
                 id="BR-16">[BR-16]-An Invoice shall have at least one Invoice line (BG-25).</assert>
         <assert test="rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication/ram:URIID/@schemeID!='' or not (rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication)"
                 flag="fatal"
                 id="BR-62">[BR-62]-The Seller electronic address (BT-34) shall have a Scheme identifier.</assert>
         <assert test="rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication/ram:URIID/@schemeID!='' or not (rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication)"
                 flag="fatal"
                 id="BR-63">[BR-63]-The Buyer electronic address (BT-49) shall have a Scheme identifier.</assert>    
         <assert test="(number(//ram:DuePayableAmount) &gt; 0 and ((//ram:SpecifiedTradePaymentTerms/ram:DueDateDateTime) or (//ram:SpecifiedTradePaymentTerms/ram:Description))) or not(number(//ram:DuePayableAmount)&gt;0)"
                 flag="fatal"
                 id="BR-CO-25">[BR-CO-25]-In case the Amount due for payment (BT-115) is positive, either the Payment due date (BT-9) or the Payment terms (BT-20) shall be present.</assert>
         <assert test="((count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='S']) + count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='S'])) &gt;=2 or not (//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='S'])) and      ((count(//ram:CategoryTradeTax[ram:CategoryCode='S']) + count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='S'])) &gt;=2 or not (//ram:CategoryTradeTax[ram:CategoryCode='S']))"
                 flag="fatal"
                 id="BR-S-01">[BR-S-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “Standard rated” shall contain in the VAT breakdown (BG-23) at least one VAT category code (BT-118) equal with "Standard rated".</assert>
         <assert test="(count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='Z'])=0 and count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='Z'])=0 and count(//ram:CategoryTradeTax[ram:CategoryCode='Z'])=0) or ( count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='Z'])=1 and (exists(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='Z']) or exists(//ram:CategoryTradeTax[ram:CategoryCode='Z'])))"
                 flag="fatal"
                 id="BR-Z-01">[BR-Z-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “Zero rated” shall contain in the VAT breakdown (BG-23) exactly one VAT category code (BT-118) equal with "Zero rated".</assert>    
         <assert test="(count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='E'])=0 and count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='E'])=0 and count(//ram:CategoryTradeTax[ram:CategoryCode='E'])=0) or ( count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='E'])=1 and (exists(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='E']) or exists(//ram:CategoryTradeTax[ram:CategoryCode='E'])))"
                 flag="fatal"
                 id="BR-E-01">[BR-E-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “Exempt from VAT” shall contain exactly one VAT breakdown (BG-23) with the VAT category code (BT-118) equal to "Exempt from VAT".</assert>
         <assert test="(count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='AE'])=0 and count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='AE'])=0 and count(//ram:CategoryTradeTax[ram:CategoryCode='AE'])=0) or ( count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='AE'])=1 and (exists(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='AE']) or exists(//ram:CategoryTradeTax[ram:CategoryCode='AE'])))"
                 flag="fatal"
                 id="BR-AE-01">[BR-AE-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “Reverse charge” shall contain in the VAT breakdown (BG-23) exactly one VAT category code (BT-118) equal with "VAT reverse charge".</assert>
         <assert test="(count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='K'])=0 and count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='K'])=0 and count(//ram:CategoryTradeTax[ram:CategoryCode='K'])=0) or ( count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='K'])=1 and (exists(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='K']) or exists(//ram:CategoryTradeTax[ram:CategoryCode='K'])))"
                 flag="fatal"
                 id="BR-IC-01">[BR-IC-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “Intra-community supply” shall contain in the VAT breakdown (BG-23) exactly one VAT category code (BT-118) equal with "Intra-community supply".</assert>
         <assert test="(count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='G'])=0 and count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='G'])=0 and count(//ram:CategoryTradeTax[ram:CategoryCode='G'])=0) or ( count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='G'])=1 and (exists(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='G']) or exists(//ram:CategoryTradeTax[ram:CategoryCode='G'])))"
                 flag="fatal"
                 id="BR-G-01">[BR-G-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “Export outside the EU” shall contain in the VAT breakdown (BG-23) exactly one VAT category code (BT-118) equal with "Export outside the EU".</assert>
         <assert test="not(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='O']) or (      count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='O'])=1 and      (exists(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='O']) or     exists(//ram:CategoryTradeTax[ram:CategoryCode='O'])))"
                 flag="fatal"
                 id="BR-O-01">[BR-O-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “Not subject to VAT” shall contain exactly one VAT breakdown group (BG-23) with the VAT category code (BT-118) equal to "Not subject to VAT".</assert>
         <assert test="((count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='L']) + count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='L'])) &gt;=2 or not (//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='L'])) and      ((count(//ram:CategoryTradeTax[ram:CategoryCode='L']) + count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='L'])) &gt;=2 or not (//ram:CategoryTradeTax[ram:CategoryCode='L']))"
                 flag="fatal"
                 id="BR-AF-01">[BR-IG-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “IGIC” shall contain in the VAT breakdown (BG-23) at least one VAT category code (BT-118) equal with "IGIC".</assert>
         <assert test="((count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='M']) + count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='M'])) &gt;=2 or not (//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='M'])) and      ((count(//ram:CategoryTradeTax[ram:CategoryCode='M']) + count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode='M'])) &gt;=2 or not (//ram:CategoryTradeTax[ram:CategoryCode='M']))"
                 flag="fatal"
                 id="BR-AG-01">[BR-IP-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “IPSI” shall contain in the VAT breakdown (BG-23) at least one VAT category code (BT-118) equal with "IPSI".</assert>
      </rule>
      <rule context="//ram:IncludedSupplyChainTradeLineItem">
         <assert test="(ram:AssociatedDocumentLineDocument/ram:LineID!='')"
                 flag="fatal"
                 id="BR-21">[BR-21]-Each Invoice line (BG-25) shall have an Invoice line identifier (BT-126).</assert>
         <assert test="(ram:SpecifiedLineTradeDelivery/ram:BilledQuantity)"
                 flag="fatal"
                 id="BR-22">[BR-22]-Each Invoice line (BG-25) shall have an Invoiced quantity (BT-129).</assert>
         <assert test="(ram:SpecifiedLineTradeDelivery/ram:BilledQuantity/@unitCode)"
                 flag="fatal"
                 id="BR-23">[BR-23]-An Invoice line (BG-25) shall have an Invoiced quantity unit of measure code (BT-130).</assert>
         <assert test="(ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)"
                 flag="fatal"
                 id="BR-24">[BR-24]-Each Invoice line (BG-25) shall have an Invoice line net amount (BT-131).</assert>
         <assert test="(ram:SpecifiedTradeProduct/ram:Name!='')"
                 flag="fatal"
                 id="BR-25">[BR-25]-Each Invoice line (BG-25) shall contain the Item name (BT-153).</assert>
         <assert test="(ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:ChargeAmount)"
                 flag="fatal"
                 id="BR-26">[BR-26]-Each Invoice line (BG-25) shall contain the Item net price (BT-146).</assert>
         <assert test="(ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:ChargeAmount) &gt;= 0"
                 flag="fatal"
                 id="BR-27">[BR-27]-The Item net price (BT-146) shall NOT be negative.</assert>
         <assert test="(ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:ChargeAmount &gt;= 0) or not(ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:ChargeAmount)"
                 flag="fatal"
                 id="BR-28">[BR-28]-The Item gross price (BT-148) shall NOT be negative.</assert>
         <assert test="ram:SpecifiedTradeProduct/ram:GlobalID/@schemeID!='' or not (ram:SpecifiedTradeProduct/ram:GlobalID)"
                 flag="fatal"
                 id="BR-64">[BR-64]-The Item standard identifier (BT-157) shall have a Scheme identifier.</assert>
         <assert test="(ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:ClassCode/@listID!='') or not (ram:SpecifiedTradeProduct/ram:DesignatedProductClassification)"
                 flag="fatal"
                 id="BR-65">[BR-65]-The Item classification identifier (BT-158) shall have a Scheme identifier.</assert>
         <assert test="(ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode)"
                 flag="fatal"
                 id="BR-CO-04">[BR-CO-04]-Each Invoice line (BG-25) shall be categorized with an Invoiced item VAT category code (BT-151).</assert>
         <assert test="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax"
                 flag="fatal"
                 id="BR-CO-18">[BR-CO-18]-An Invoice shall at least have one VAT breakdown group (BG-23).</assert>
         <assert test="string-length(substring-after(ram:SpecifiedTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-23">[BR-DEC-23]-The allowed maximum number of decimals for the Invoice line net amount (BT-131) is 2.</assert>    
      </rule>
      <rule context="//ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator = 'false']">
         <assert test="(ram:ActualAmount)" flag="fatal" id="BR-41">[BR-41]-Each Invoice line allowance (BG-27) shall have an Invoice line allowance amount (BT-136).</assert>
         <assert test="(ram:Reason) or (ram:ReasonCode)" flag="fatal" id="BR-42">[BR-42]-Each Invoice line allowance (BG-27) shall have an Invoice line allowance reason (BT-139) or an Invoice line allowance reason code (BT-140).</assert>
         <assert test="true()" flag="fatal" id="BR-CO-07">[BR-CO-07]-Invoice line allowance reason code (BT-140) and Invoice line allowance reason (BT-139) shall indicate the same type of allowance reason.</assert>
         <assert test="(ram:Reason) or (ram:ReasonCode)" flag="fatal" id="BR-CO-23">[BR-CO-23]-Each Invoice line allowance (BG-27) shall contain an Invoice line allowance reason (BT-139) or an Invoice line allowance reason code (BT-140), or both.</assert>
         <assert test="string-length(substring-after(ram:ActualAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-24">[BR-DEC-24]-The allowed maximum number of decimals for the Invoice line allowance amount (BT-136) is 2.</assert>
         <assert test="string-length(substring-after(ram:BasisAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-25">[BR-DEC-25]-The allowed maximum number of decimals for the Invoice line allowance base amount (BT-137) is 2.</assert>    
      </rule>
      <rule context="//ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator = 'true']">
         <assert test="(ram:ActualAmount)" flag="fatal" id="BR-43">[BR-43]-Each Invoice line charge (BG-28) shall have an Invoice line charge amount (BT-141).</assert>
         <assert test="(ram:Reason) or (ram:ReasonCode)" flag="fatal" id="BR-44">[BR-44]-Each Invoice line charge (BG-28) shall have an Invoice line charge reason (BT-144) or an Invoice line charge reason code (BT-145).</assert>
         <assert test="true()" flag="fatal" id="BR-CO-08">[BR-CO-08]-Invoice line charge reason code (BT-145) and Invoice line charge reason (BT144) shall indicate the same type of charge reason.</assert>
         <assert test="(ram:Reason) or (ram:ReasonCode)" flag="fatal" id="BR-CO-24">[BR-CO-24]-Each Invoice line charge (BG-28) shall contain an Invoice line charge reason (BT-144) or an Invoice line charge reason code (BT-145), or both.</assert>
         <assert test="string-length(substring-after(ram:ActualAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-27">[BR-DEC-27]-The allowed maximum number of decimals for the Invoice line charge amount (BT-141) is 2.</assert>
         <assert test="string-length(substring-after(ram:BasisAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-28">[BR-DEC-28]-The allowed maximum number of decimals for the Invoice line charge base amount (BT-142) is 2.</assert>    
      </rule>
      <rule context="//ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod">
         <assert test="(ram:EndDateTime/udt:DateTimeString[@format = '102']) &gt;= (ram:StartDateTime/udt:DateTimeString[@format = '102']) or not (ram:EndDateTime) or not (ram:StartDateTime)"
                 flag="fatal"
                 id="BR-30">[BR-30]-If both Invoice line period start date (BT-134) and Invoice line period end date (BT-135) are given then the Invoice line period end date (BT-135) shall be later or equal to the Invoice line period start date (BT-134).</assert>
         <assert test="(ram:StartDateTime) or (ram:EndDateTime)"
                 flag="fatal"
                 id="BR-CO-20">[BR-CO-20]-If Invoice line period (BG-26) is used, the Invoice line period start date (BT-134) or the Invoice line period end date (BT-135) shall be filled, or both.</assert>
      </rule>
      <rule context="//ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod">
         <assert test="(ram:EndDateTime/udt:DateTimeString[@format = '102']) &gt;= (ram:StartDateTime/udt:DateTimeString[@format = '102']) or not (ram:EndDateTime) or not (ram:StartDateTime)"
                 flag="fatal"
                 id="BR-29">[BR-29]-If both Invoicing period start date (BT-73) and Invoicing period end date (BT-74) are given then the Invoicing period end date (BT-74) shall be later or equal to the Invoicing period start date (BT-73).</assert>
         <assert test="(ram:StartDateTime) or (ram:EndDateTime)"
                 flag="fatal"
                 id="BR-CO-19">[BR-CO-19]-If Invoicing period (BG-14) is used, the Invoicing period start date (BT-73) or the Invoicing period end date (BT-74) shall be filled, or both.</assert>
      </rule>
      <rule context="//ram:ApplicableProductCharacteristic">
         <assert test="(ram:Description) and (ram:Value)" flag="fatal" id="BR-54">[BR-54]-Each Item attribute (BG-32) shall contain an Item attribute name (BT-160) and an Item attribute value (BT-161).</assert>
      </rule>
      <rule context="//ram:PayeeTradeParty">
         <assert test="(ram:Name) and (not(ram:Name = ../ram:SellerTradeParty/ram:Name) and not(ram:ID = ../ram:SellerTradeParty/ram:ID) and not(ram:SpecifiedLegalOrganization/ram:ID = ../ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:ID))"
                 flag="fatal"
                 id="BR-17">[BR-17]-The Payee name (BT-59) shall be provided in the Invoice, if the Payee (BG-10) is different from the Seller (BG-4).</assert>
      </rule>
      <rule context="//ram:SpecifiedTradeSettlementPaymentMeans">
         <assert test="(ram:TypeCode)" flag="fatal" id="BR-49">[BR-49]-A Payment instruction (BG-16) shall specify the Payment means type code (BT-81).</assert>
      </rule>
      <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument">
         <assert test="(ram:IssuerAssignedID!='')" flag="fatal" id="BR-55">[BR-55]-Each Preceding Invoice reference (BG-3) shall contain a Preceding Invoice reference (BT-25).</assert>
      </rule>
      <rule context="//ram:SellerTradeParty">
         <assert test="(ram:ID) or (ram:GlobalID) or (ram:SpecifiedLegalOrganization/ram:ID) or (ram:SpecifiedTaxRegistration/ram:ID[@schemeID='VAT'])"
                 flag="fatal"
                 id="BR-CO-26">[BR-CO-26]-In order for the buyer to automatically identify a supplier, the Seller identifier (BT-29), the Seller legal registration identifier (BT-30) and/or the Seller VAT identifier (BT-31) shall be present.</assert>
      </rule>  
      <rule context="//ram:SellerTaxRepresentativeTradeParty">
         <assert test="(ram:Name)" flag="fatal" id="BR-18">[BR-18]-The Seller tax representative name (BT-62) shall be provided in the Invoice, if the Seller (BG-4) has a Seller tax representative party (BG-11).</assert>
         <assert test="(ram:PostalTradeAddress)" flag="fatal" id="BR-19">[BR-19]-The Seller tax representative postal address (BG-12) shall be provided in the Invoice, if the Seller (BG-4) has a Seller tax representative party (BG-11).</assert>
         <assert test="(ram:PostalTradeAddress/ram:CountryID)"
                 flag="fatal"
                 id="BR-20">[BR-20]-The Seller tax representative postal address (BG-12) shall contain a Tax representative country code (BT-69), if the Seller (BG-4) has a Seller tax representative party (BG-11).</assert>
         <assert test="(ram:SpecifiedTaxRegistration/ram:ID[@schemeID='VAT']!='')"
                 flag="fatal"
                 id="BR-56">[BR-56]-Each Seller tax representative party (BG-11) shall have a Seller tax representative VAT identifier (BT-63).</assert>    
      </rule>
      <rule context="//ram:SpecifiedTradeSettlementHeaderMonetarySummation">
         <assert test="not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode) or (/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode and (ram:TaxTotalAmount/@currencyID = /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode) and not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode = /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode))"
                 flag="fatal"
                 id="BR-53">[BR-53]-If the VAT accounting currency code (BT-6) is present, then the Invoice total VAT amount in accounting currency (BT-111) shall be provided.</assert>
    
      </rule>
      <rule context="//ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxTotalAmount[@currencyID=/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode]">
         <assert test=". = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CalculatedAmount)*10*10)div 100) "
                 flag="fatal"
                 id="BR-CO-14">[BR-CO-14]-Invoice total VAT amount (BT-110) = Σ VAT category tax amount (BT-117).</assert>
      </rule>

      <rule context="//ram:SpecifiedTaxRegistration/ram:ID[@schemeID='VAT']">
         <assert test="contains(' EL AD AE AF AG AI AL AM AN AO AQ AR AS AT AU AW AX AZ BA BB BD BE BF BG BH BI BL BJ BM BN BO BR BS BT BV BW BY BZ CA CC CD CF CG CH CI CK CL CM CN CO CR CU CV CX CY CZ DE DJ DK DM DO DZ EC EE EG EH ER ES ET FI FJ FK FM FO FR GA GB GD GE GF GG GH GI GL GM GN GP GQ GR GS GT GU GW GY HK HM HN HR HT HU ID IE IL IM IN IO IQ IR IS IT JE JM JO JP KE KG KH KI KM KN KP KR KW KY KZ LA LB LC LI LK LR LS LT LU LV LY MA MC MD ME MF MG MH MK ML MM MN MO MP MQ MR MS MT MU MV MW MX MY MZ NA NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM PN PR PS PT PW PY QA RO RS RU RW SA SB SC SD SE SG SH SI SJ SK SL SM SN SO SR ST SV SY SZ TC TD TF TG TH TJ TK TL TM TN TO TR TT TV TW TZ UA UG UM US UY UZ VA VC VE VG VI VN VU WF WS YE YT ZA ZM ZW ', concat(' ', substring(.,1,2), ' '))"
                 flag="fatal"
                 id="BR-CO-09">[BR-CO-09]-The Seller VAT identifier (BT-31), the Seller tax representative VAT identifier (BT-63) and the Buyer VAT identifier (BT-48) shall have a prefix in accordance with ISO code ISO 3166-1 alpha-2 by which the country of issue may be identified. Nevertheless, Greece may use the prefix ‘EL’.</assert>
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[. = 'AE']">
         <assert test="../ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = 'AE']/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true' and ram:CategoryTradeTax/ram:CategoryCode='AE']/ram:ActualAmount)*10*10)div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false' and ram:CategoryTradeTax/ram:CategoryCode='AE']/ram:ActualAmount)*10*10)div 100)"
                 flag="fatal"
                 id="BR-AE-08">[BR-AE-08]-In a VAT breakdown (BG-23) where the VAT category code (BT-118) is "Reverse charge" the VAT category taxable amount (BT-116) shall equal the sum of Invoice line net amounts (BT-131) minus the sum of Document level allowance amounts (BT-92) plus the sum of Document level charge amounts (BT-99) where the VAT category codes (BT-151, BT-95, BT-102) are “Reverse charge".</assert>
         <assert test="../ram:CalculatedAmount = 0" flag="fatal" id="BR-AE-09">[BR-AE-09]-The VAT category tax amount (BT-117) in a VAT breakdown (BG-23) where the VAT category code (BT-118) is “Reverse charge” shall be 0 (zero).</assert>
         <assert test="(../ram:ExemptionReason) or (../ram:ExemptionReasonCode)"
                 flag="fatal"
                 id="BR-AE-10">[BR-AE-10]-A VAT Breakdown (BG-23) with VAT Category code (BT-118) "Reverse charge" shall have a VAT exemption reason code (BT-121), meaning "Reverse charge" or the VAT exemption reason text (BT-120) "Reverse charge" (or the equivalent standard text in another language).</assert>
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false']/ram:CategoryTradeTax[ram:CategoryCode = 'AE']">
         <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']) and (//ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'] or //ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:ID)"
                 flag="fatal"
                 id="BR-AE-03">[BR-AE-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “Reverse charge” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63) and the Buyer VAT identifier (BT-48) and/or the Buyer legal registration identifier (BT-47).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-AE-06">[BR-AE-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "Reverse charge" the Document level allowance VAT rate (BT-96) shall be 0 (zero).</assert>
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true']/ram:CategoryTradeTax[ram:CategoryCode = 'AE']">
         <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']) and (//ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'] or //ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:ID)"
                 flag="fatal"
                 id="BR-AE-04">[BR-AE-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “Reverse charge” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63) and the Buyer VAT identifier (BT-48) and/or the Buyer legal registration identifier (BT-47).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-AE-07">[BR-AE-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "Reverse charge" the Document level charge VAT rate (BT-103) shall be 0 (zero).</assert>
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = 'AE']">
         <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']) and (//ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'] or //ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:ID)"
                 flag="fatal"
                 id="BR-AE-02">[BR-AE-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “Reverse charge” shall contain the Seller VAT Identifier (BT-31), the Seller Tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63) and the Buyer VAT identifier (BT-48) and/or the Buyer legal registration identifier (BT-47).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-AE-05">[BR-AE-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "Reverse charge" the Invoiced item VAT rate (BT-152) shall be 0 (zero).</assert>
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = 'L']">
         <assert test="ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = 'L' and ram:RateApplicablePercent=ram:ApplicableTradeTax/ram:RateApplicablePercent]/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true' and ram:CategoryTradeTax/ram:CategoryCode='L' and ram:RateApplicablePercent=ram:CategoryTradeTax/ram:RateApplicablePercent]/ram:ActualAmount)*10*10) div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false' and ram:CategoryTradeTax/ram:CategoryCode='L' and ram:RateApplicablePercent=ram:CategoryTradeTax/ram:RateApplicablePercent]/ram:ActualAmount)*10*10) div 100)"
                 flag="fatal"
                 id="BR-AF-08">[BR-IG-08]-For each different value of VAT category rate (BT-119) where the VAT category code (BT-118) is "IGIC", the VAT category taxable amount (BT-116) in a VAT breakdown (BG-23) shall equal the sum of Invoice line net amounts (BT-131) plus the sum of document level charge amounts (BT-99) minus the sum of document level allowance amounts (BT-92) where the VAT category code (BT-151, BT-102, BT-95) is “IGIC” and the VAT rate (BT-152, BT-103, BT-96) equals the VAT category rate (BT-119).</assert>
         <assert test="true()" flag="fatal" id="BR-AF-09">[BR-IG-09]-The VAT category tax amount (BT-117) in a VAT breakdown (BG-23) where VAT category code (BT-118) is "IGIC" shall equal the VAT category taxable amount (BT-116) multiplied by the VAT category rate (BT-119).</assert>
         <assert test="not(ram:ExemptionReason) and not (ram:ExemptionReasonCode)"
                 flag="fatal"
                 id="BR-AF-10">[BR-IG-10]-A VAT Breakdown (BG-23) with VAT Category code (BT-118) "IGIC" shall not have a VAT exemption reason code (BT-121) or VAT exemption reason text (BT-120).</assert>    
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = 'L']">    
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-AF-02">[BR-IG-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “IGIC” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent &gt; 0" flag="fatal" id="BR-AF-05">[BR-IG-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "IGIC" the invoiced item VAT rate (BT-152) shall be greater than 0 (zero).</assert>    
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false']/ram:CategoryTradeTax[ram:CategoryCode = 'L']">
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-AF-03">[BR-IG-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “IGIC” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent &gt; 0" flag="fatal" id="BR-AF-06">[BR-IG-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "IGIC" the Document level allowance VAT rate (BT-96) shall be 0 (zero) or greater than zero.</assert>      
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true']/ram:CategoryTradeTax[ram:CategoryCode = 'L']">        
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-AF-04">[BR-IG-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “IGIC” shall contain the Seller VAT Identifier (BT-31), the Seller Tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent &gt; 0" flag="fatal" id="BR-AF-07">[BR-IG-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "IGIC" the Document level charge VAT rate (BT-103) shall be 0 (zero) or greater than zero.</assert>
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = 'M']">
         <assert test="ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = 'M' and ram:RateApplicablePercent=ram:ApplicableTradeTax/ram:RateApplicablePercent]/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true' and ram:CategoryTradeTax/ram:CategoryCode='M' and ram:RateApplicablePercent=ram:CategoryTradeTax/ram:RateApplicablePercent]/ram:ActualAmount)*10*10) div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false' and ram:CategoryTradeTax/ram:CategoryCode='M' and ram:RateApplicablePercent=ram:CategoryTradeTax/ram:RateApplicablePercent]/ram:ActualAmount)*10*10) div 100)"
                 flag="fatal"
                 id="BR-AG-08">[BR-IP-08]-For each different value of VAT category rate (BT-119) where the VAT category code (BT-118) is "IPSI", the VAT category taxable amount (BT-116) in a VAT breakdown (BG-23) shall equal the sum of Invoice line net amounts (BT-131) plus the sum of document level charge amounts (BT-99) minus the sum of document level allowance amounts (BT-92) where the VAT category code (BT-151, BT-102, BT-95) is “IPSI” and the VAT rate (BT-152, BT-103, BT-96) equals the VAT category rate (BT-119).</assert>
         <assert test="true()" flag="fatal" id="BR-AG-09">[BR-IP-09]-The VAT category tax amount (BT-117) in a VAT breakdown (BG-23) where VAT category code (BT-118) is "IPSI" shall equal the VAT category taxable amount (BT-116) multiplied by the VAT category rate (BT-119).</assert>
         <assert test="not(ram:ExemptionReason) and not (ram:ExemptionReasonCode)"
                 flag="fatal"
                 id="BR-AG-10">[BR-IP-10]-A VAT Breakdown (BG-23) with VAT Category code (BT-118) "IPSI" shall not have a VAT exemption reason code (BT-121) or VAT exemption reason text (BT-120). </assert>    
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = 'M']">    
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-AG-02">[BR-IP-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “IPSI” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent &gt; 0" flag="fatal" id="BR-AG-05">[BR-IP-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "IPSI" the Invoiced item VAT rate (BT-152) shall be 0 (zero) or greater than zero.</assert>    
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false']/ram:CategoryTradeTax[ram:CategoryCode = 'M']">
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-AG-03">[BR-IP-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “IPSI” shall contain the Seller VAT Identifier (BT-31), the Seller Tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent &gt; 0" flag="fatal" id="BR-AG-06">[BR-IP-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "IPSI" the Document level allowance VAT rate (BT-96) shall be 0 (zero) or greater than zero.</assert>      
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true']/ram:CategoryTradeTax[ram:CategoryCode = 'M']">        
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-AG-04">[BR-IP-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “IPSI” shall contain the Seller VAT Identifier (BT-31), the Seller Tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent &gt; 0" flag="fatal" id="BR-AG-07">[BR-IP-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "IPSI" the Document level charge VAT rate (BT-103) shall be 0 (zero) or greater than zero.</assert>
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[. = 'E']">    
         <assert test="../ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = 'E']/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true' and ram:CategoryTradeTax/ram:CategoryCode='E']/ram:ActualAmount)*10*10)div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false' and ram:CategoryTradeTax/ram:CategoryCode='E']/ram:ActualAmount)*10*10)div 100)"
                 flag="fatal"
                 id="BR-E-08">[BR-E-08]-In a VAT breakdown (BG-23) where the VAT category code (BT-118) is "Exempt from VAT" the VAT category taxable amount (BT-116) shall equal the sum of Invoice line net amounts (BT-131) minus the sum of Document level allowance amounts (BT-92) plus the sum of Document level charge amounts (BT-99) where the VAT category codes (BT-151, BT-95, BT-102) are “Exempt from VAT".</assert>
         <assert test="../ram:CalculatedAmount = 0" flag="fatal" id="BR-E-09">[BR-E-09]-The VAT category tax amount (BT-117) In a VAT breakdown (BG-23) where the VAT category code (BT-118) equals "Exempt from VAT" shall equal 0 (zero).</assert>
         <assert test="(../ram:ExemptionReason) or (../ram:ExemptionReasonCode)"
                 flag="fatal"
                 id="BR-E-10">[BR-E-10]-A VAT Breakdown (BG-23) with VAT Category code (BT-118) "Exempt from VAT" shall have a VAT exemption reason code (BT-121) or a VAT exemption reason text (BT-120).</assert>    
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false']/ram:CategoryTradeTax[ram:CategoryCode = 'E']">
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-E-03">[BR-E-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “Exempt from VAT” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-E-06">[BR-E-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "Exempt from VAT", the Document level allowance VAT rate (BT-96) shall be 0 (zero).</assert>    
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true']/ram:CategoryTradeTax[ram:CategoryCode = 'E']">
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-E-04">[BR-E-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “Exempt from VAT” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-E-07">[BR-E-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "Exempt from VAT", the Document level charge VAT rate (BT-103) shall be 0 (zero).</assert>    
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = 'E']">
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-E-02">[BR-E-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “Exempt from VAT” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-E-05">[BR-E-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "Exempt from VAT", the Invoiced item VAT rate (BT-152) shall be 0 (zero).</assert>    
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[. = 'G']">
         <assert test="../ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = 'G']/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true' and ram:CategoryTradeTax/ram:CategoryCode='G']/ram:ActualAmount)*10*10)div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false' and ram:CategoryTradeTax/ram:CategoryCode='G']/ram:ActualAmount)*10*10)div 100)"
                 flag="fatal"
                 id="BR-G-08">[BR-G-08]-In a VAT breakdown (BG-23) where the VAT category code (BT-118) is "Export outside the EU" the VAT category taxable amount (BT-116) shall equal the sum of Invoice line net amounts (BT-131) minus the sum of Document level allowance amounts (BT-92) plus the sum of Document level charge amounts (BT-99) where the VAT category codes (BT-151, BT-95, BT-102) are “Export outside the EU".</assert>
         <assert test="../ram:CalculatedAmount = 0" flag="fatal" id="BR-G-09">[BR-G-09]-The VAT category tax amount (BT-117) in a VAT breakdown (BG-23) where the VAT category code (BT-118) is “Export outside the EU” shall be 0 (zero).</assert>
         <assert test="(../ram:ExemptionReason) or (../ram:ExemptionReasonCode)"
                 flag="fatal"
                 id="BR-G-10">[BR-G-10]-A VAT Breakdown (BG-23) with the VAT Category code (BT-118) "Export outside the EU" shall have a VAT exemption reason code (BT-121), meaning "Export outside the EU" or the VAT exemption reason text (BT-120) "Export outside the EU" (or the equivalent standard text in another language).</assert>
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false']/ram:CategoryTradeTax[ram:CategoryCode = 'G']">
         <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'])"
                 flag="fatal"
                 id="BR-G-03">[BR-G-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “Export outside the EU” shall contain the Seller VAT Identifier (BT-31) or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-G-06">[BR-G-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "Export outside the EU" the Document level allowance VAT rate (BT-96) shall be 0 (zero).</assert>
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true']/ram:CategoryTradeTax[ram:CategoryCode = 'G']">
         <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'])"
                 flag="fatal"
                 id="BR-G-04">[BR-G-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “Export outside the EU” shall contain the Seller VAT Identifier (BT-31) or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-G-07">[BR-G-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "Export outside the EU" the Document level charge VAT rate (BT-103) shall be 0 (zero).</assert>
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = 'G']">
         <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'])"
                 flag="fatal"
                 id="BR-G-02">[BR-G-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “Export outside the EU” shall contain the Seller VAT Identifier (BT-31) or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-G-05">[BR-G-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "Export outside the EU" the Invoiced item VAT rate (BT-152) shall be 0 (zero).</assert>
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[.= 'K']">
         <assert test="../ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = 'K']/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true' and ram:CategoryTradeTax/ram:CategoryCode='K']/ram:ActualAmount)*10*10)div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false' and ram:CategoryTradeTax/ram:CategoryCode='K']/ram:ActualAmount)*10*10)div 100)"
                 flag="fatal"
                 id="BR-IC-08">[BR-IC-08]-In a VAT breakdown (BG-23) where the VAT category code (BT-118) is "Intra-community supply" the VAT category taxable amount (BT-116) shall equal the sum of Invoice line net amounts (BT-131) minus the sum of Document level allowance amounts (BT-92) plus the sum of Document level charge amounts (BT-99) where the VAT category codes (BT-151, BT-95, BT-102) are “Intra-community supply".</assert>
         <assert test="../ram:CalculatedAmount = 0" flag="fatal" id="BR-IC-09">[BR-IC-09]-The VAT category tax amount (BT-117) in a VAT breakdown (BG-23) where the VAT category code (BT-118) is “Intra-community supply” shall be 0 (zero).</assert>
         <assert test="(../ram:ExemptionReason) or (../ram:ExemptionReasonCode)"
                 flag="fatal"
                 id="BR-IC-10">[BR-IC-10]-A VAT Breakdown (BG-23) with the VAT Category code (BT-118) "Intra-community supply" shall have a VAT exemption reason code (BT-121), meaning "Intra-community supply" or the VAT exemption reason text (BT-120) "Intra-community supply" (or the equivalent standard text in another language).</assert>
         <assert test="(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDeliverySupplyChainEvent/ram:OccurrenceDateTime/udt:DateTimeString) or (../../ram:BillingSpecifiedPeriod/ram:StartDateTime) or (../../ram:BillingSpecifiedPeriod/ram:EndDateTime)"
                 flag="fatal"
                 id="BR-IC-11">[BR-IC-11]-In an Invoice with a VAT breakdown (BG-23) where the VAT category code (BT-118) is "Intra-community supply" the Actual delivery date (BT-72) or the Invoicing period (BG-14) shall not be blank.</assert>
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CountryID"
                 flag="fatal"
                 id="BR-IC-12">[BR-IC-12]-In an Invoice with a VAT breakdown (BG-23) where the VAT category code (BT-118) is "Intra-community supply" the Deliver to country code (BT-80) shall not be blank.</assert>
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false']/ram:CategoryTradeTax[ram:CategoryCode = 'K']">
         <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']) and //ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-IC-03">[BR-IC-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “Intra-community supply” shall contain the Seller VAT Identifier (BT-31) or the Seller tax representative VAT identifier (BT-63) and the Buyer VAT identifier (BT-48).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-IC-06">[BR-IC-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "Intra-community supply" the Document level allowance VAT rate (BT-96) shall be 0 (zero).</assert>
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true']/ram:CategoryTradeTax[ram:CategoryCode = 'K']">
         <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']) and //ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-IC-04">[BR-IC-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “Intra-community supply” shall contain the Seller VAT Identifier (BT-31) or the Seller tax representative VAT identifier (BT-63) and the Buyer VAT identifier (BT-48).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-IC-07">[BR-IC-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "Intra-community supply" the Document level charge VAT rate (BT-103) shall be 0 (zero).</assert>
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = 'K']">
         <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']) and //ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-IC-02">[BR-IC-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “Intra-community supply” shall contain the Seller VAT Identifier (BT-31) or the Seller tax representative VAT identifier (BT-63) and the Buyer VAT identifier (BT-48).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-IC-05">[BR-IC-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "Intracommunity supply" the Invoiced item VAT rate (BT-152) shall be 0 (zero).</assert>
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = 'O']">
         <assert test="ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = 'O']/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true' and ram:CategoryTradeTax/ram:CategoryCode='O']/ram:ActualAmount)*10*10)div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false' and ram:CategoryTradeTax/ram:CategoryCode='O']/ram:ActualAmount)*10*10)div 100)"
                 flag="fatal"
                 id="BR-O-08">[BR-O-08]-In a VAT breakdown (BG-23) where the VAT category code (BT-118) is " Not subject to VAT" the VAT category taxable amount (BT-116) shall equal the sum of Invoice line net amounts (BT-131) minus the sum of Document level allowance amounts (BT-92) plus the sum of Document level charge amounts (BT-99) where the VAT category codes (BT-151, BT-95, BT-102) are “Not subject to VAT".</assert>
         <assert test="ram:CalculatedAmount = 0" flag="fatal" id="BR-O-09">[BR-O-09]-The VAT category tax amount (BT-117) in a VAT breakdown (BG-23) where the VAT category code (BT-118) is “Not subject to VAT” shall be 0 (zero).</assert>
         <assert test="(ram:ExemptionReason) or (ram:ExemptionReasonCode)"
                 flag="fatal"
                 id="BR-O-10">[BR-O-10]-A VAT Breakdown (BG-23) with VAT Category code (BT-118) " Not subject to VAT" shall have a VAT exemption reason code (BT-121), meaning " Not subject to VAT" or a VAT exemption reason text (BT-120) " Not subject to VAT" (or the equivalent standard text in another language).</assert>
         <assert test="not(//ram:ApplicableTradeTax[ram:CategoryCode != 'O'])"
                 flag="fatal"
                 id="BR-O-11">[BR-O-11]-An Invoice that contains a VAT breakdown group (BG-23) with a VAT category code (BT-118) "Not subject to VAT" shall not contain other VAT breakdown groups (BG-23).</assert>    
         <assert test="not(//ram:ApplicableTradeTax[ram:CategoryCode != 'O'])"
                 flag="fatal"
                 id="BR-O-12">[BR-O-12]-An Invoice that contains a VAT breakdown group (BG-23) with a VAT category code (BT-118) "Not subject to VAT" shall not contain an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is not "Not subject to VAT".</assert>
         <assert test="not(//ram:CategoryTradeTax[ram:CategoryCode != 'O'])"
                 flag="fatal"
                 id="BR-O-13">[BR-O-13]-An Invoice that contains a VAT breakdown group (BG-23) with a VAT category code (BT-118) "Not subject to VAT" shall not contain Document level allowances (BG-20) where Document level allowance VAT category code (BT-95) is not "Not subject to VAT".</assert>
         <assert test="not(//ram:CategoryTradeTax[ram:CategoryCode != 'O'])"
                 flag="fatal"
                 id="BR-O-14">[BR-O-14]-An Invoice that contains a VAT breakdown group (BG-23) with a VAT category code (BT-118) "Not subject to VAT" shall not contain Document level charges (BG-21) where Document level charge VAT category code (BT-102) is not "Not subject to VAT".</assert>
    
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false']/ram:CategoryTradeTax[ram:CategoryCode = 'O']">
         <assert test="not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']) and not (/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']) and not (/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'])"
                 flag="fatal"
                 id="BR-O-03">[BR-O-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “Not subject to VAT” shall not contain the Seller VAT identifier (BT-31), the Seller tax representative VAT identifier (BT-63) or the Buyer VAT identifier (BT-48).</assert>
         <assert test="not(ram:RateApplicablePercent)" flag="fatal" id="BR-O-06">[BR-O-06]-A Document level allowance (BG-20) where VAT category code (BT-95) is "Not subject to VAT" shall not contain a Document level allowance VAT rate (BT-96).</assert>
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true']/ram:CategoryTradeTax[ram:CategoryCode = 'O']">
         <assert test="not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']) and not (/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']) and not (/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'])"
                 flag="fatal"
                 id="BR-O-04">[BR-O-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “Not subject to VAT” shall not contain the Seller VAT identifier (BT-31), the Seller tax representative VAT identifier (BT-63) or the Buyer VAT identifier (BT-48).</assert>
         <assert test="not(ram:RateApplicablePercent)" flag="fatal" id="BR-O-07">[BR-O-07]-A Document level charge (BG-21) where the VAT category code (BT-102) is "Not subject to VAT" shall not contain a Document level charge VAT rate (BT-103).</assert>
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = 'O']">
         <assert test="not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']) and not (/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']) and not (/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT'])"
                 flag="fatal"
                 id="BR-O-02">[BR-O-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “Not subject to VAT” shall not contain the Seller VAT identifier (BT-31), the Seller tax representative VAT identifier (BT-63) or the Buyer VAT identifier (BT-46).</assert>
         <assert test="not(ram:RateApplicablePercent)" flag="fatal" id="BR-O-05">[BR-O-05]-An Invoice line (BG-25) where the VAT category code (BT-151) is "Not subject to VAT" shall not contain an Invoiced item VAT rate (BT-152).</assert>
      </rule>
      <rule context="//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[.='S']">
         <assert test="every $rate in ../ram:RateApplicablePercent satisfies (../ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = 'S' and ram:ApplicableTradeTax/ram:RateApplicablePercent =$rate]/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount) * 10 * 10) div 100 + round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true' and ram:CategoryTradeTax/ram:CategoryCode='S' and ram:CategoryTradeTax/ram:RateApplicablePercent=$rate]/ram:ActualAmount) * 10 * 10) div 100 - round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false' and ram:CategoryTradeTax/ram:CategoryCode='S' and ram:CategoryTradeTax/ram:RateApplicablePercent=$rate]/ram:ActualAmount) * 10 * 10) div 100))"
                 flag="fatal"
                 id="BR-S-08">[BR-S-08]-For each different value of VAT category rate (BT-119) where the VAT category code (BT-118) is "Standard rated", the VAT category taxable amount (BT-116) in a VAT breakdown (BG-23) shall equal the sum of Invoice line net amounts (BT-131) plus the sum of document level charge amounts (BT-99) minus the sum of document level allowance amounts (BT-92) where the VAT category code (BT-151, BT-102, BT-95) is “Standard rated” and the VAT rate (BT-152, BT-103, BT-96) equals the VAT category rate (BT-119).</assert>
         <assert test="../ram:CalculatedAmount = round(../ram:BasisAmount * ../ram:RateApplicablePercent) div 100 +0"
                 flag="fatal"
                 id="BR-S-09">[BR-S-09]-The VAT category tax amount (BT-117) in a VAT breakdown (BG-23) where VAT category code (BT-118) is "Standard rated" shall equal the VAT category taxable amount (BT-116) multiplied by the VAT category rate (BT-119).</assert>
         <assert test="not(../ram:ExemptionReason) and not (../ram:ExemptionReasonCode)"
                 flag="fatal"
                 id="BR-S-10">[BR-S-10]-A VAT Breakdown (BG-23) with VAT Category code (BT-118) "Standard rate" shall not have a VAT exemption reason code (BT-121) or VAT exemption reason text (BT-120).</assert>    
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = 'S']">    
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-S-02">[BR-S-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “Standard rated” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent &gt; 0" flag="fatal" id="BR-S-05">[BR-S-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "Standard rated" the Invoiced item VAT rate (BT-152) shall be greater than zero.</assert>    
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false']/ram:CategoryTradeTax[ram:CategoryCode = 'S']">
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-S-03">[BR-S-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “Standard rated” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent &gt; 0" flag="fatal" id="BR-S-06">[BR-S-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "Standard rated" the Document level allowance VAT rate (BT-96) shall be greater than zero.</assert>
    
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true']/ram:CategoryTradeTax[ram:CategoryCode = 'S']">        
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-S-04">[BR-S-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “Standard rated” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent &gt; 0" flag="fatal" id="BR-S-07">[BR-S-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "Standard rated" the Document level charge VAT rate (BT-103) shall be greater than zero.</assert>
      </rule>  
      <rule context="//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[. = 'Z']">    
         <assert test="../ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = 'Z']/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true' and ram:CategoryTradeTax/ram:CategoryCode='Z']/ram:ActualAmount)*10*10)div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false' and ram:CategoryTradeTax/ram:CategoryCode='Z']/ram:ActualAmount)*10*10)div 100)"
                 flag="fatal"
                 id="BR-Z-08">[BR-Z-08]-In a VAT breakdown (BG-23) where VAT category code (BT-118) is "Zero rated" the VAT category taxable amount (BT-116) shall equal the sum of Invoice line net amount (BT-131) minus the sum of Document level allowance amounts (BT-92) plus the sum of Document level charge amounts (BT-99) where the VAT category codes (BT-151, BT-95, BT-102) are “Zero rated".</assert>
         <assert test="../ram:CalculatedAmount = 0" flag="fatal" id="BR-Z-09">[BR-Z-09]-The VAT category tax amount (BT-117) in a VAT breakdown (BG-23) where VAT category code (BT-118) is "Zero rated" shall equal 0 (zero).</assert>
         <assert test="not(../ram:ExemptionReason) and not (../ram:ExemptionReasonCode)"
                 flag="fatal"
                 id="BR-Z-10">[BR-Z-10]-A VAT Breakdown (BG-23) with VAT Category code (BT-118) "Zero rated" shall not have a VAT exemption reason code (BT-121) or VAT exemption reason text (BT-120).</assert>
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='false']/ram:CategoryTradeTax[ram:CategoryCode = 'Z']">
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-Z-03">[BR-Z-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “Zero rated” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-Z-06">[BR-Z-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "Zero rated" the Document level allowance VAT rate (BT-96) shall be 0 (zero).</assert>
      </rule>
      <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator='true']/ram:CategoryTradeTax[ram:CategoryCode = 'Z']">
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-Z-04">[BR-Z-04]-An Invoice that contains a Document level charge where the Document level charge VAT category code (BT-102) is “Zero rated” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-Z-07">[BR-Z-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "Zero rated" the Document level charge VAT rate (BT-103) shall be 0 (zero).</assert>
      </rule>
      <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = 'Z']">
         <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = ('VAT', 'FC')] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = 'VAT']"
                 flag="fatal"
                 id="BR-Z-02">[BR-Z-02]-An Invoice that contains an Invoice line where the Invoiced item VAT category code (BT-151) is “Zero rated” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="ram:RateApplicablePercent = 0" flag="fatal" id="BR-Z-05">[BR-Z-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "Zero rated" the Invoiced item VAT rate (BT-152) shall be 0 (zero).</assert>    
      </rule>
  
      <rule context="//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax">
         <assert test="(ram:BasisAmount)" flag="fatal" id="BR-45">[BR-45]-Each VAT breakdown (BG-23) shall have a VAT category taxable amount (BT-116).</assert>
         <assert test="(ram:CalculatedAmount)" flag="fatal" id="BR-46">[BR-46]-Each VAT breakdown (BG-23) shall have a VAT category tax amount (BT-117).</assert>
         <assert test="(ram:CategoryCode)" flag="fatal" id="BR-47">[BR-47]-Each VAT breakdown (BG-23) shall be defined through a VAT category code (BT-118).</assert>
         <assert test="(ram:RateApplicablePercent) or (ram:CategoryCode = 'O')"
                 flag="fatal"
                 id="BR-48">[BR-48]-Each VAT breakdown (BG-23) shall have a VAT category rate (BT-119), except if the Invoice is not subject to VAT.</assert>
         <assert test="((ram:TaxPointDate) and not (ram:DueDateTypeCode)) or (not (ram:TaxPointDate) and (ram:DueDateTypeCode)) or (not (ram:TaxPointDate) and not (ram:DueDateTypeCode))"
                 flag="fatal"
                 id="BR-CO-03">[BR-CO-03]-Value added tax point date (BT-7) and Value added tax point date code (BT-8) are mutually exclusive.</assert>
         <assert test="ram:CalculatedAmount = round(ram:BasisAmount * ram:RateApplicablePercent) div 100 +0 or not (ram:RateApplicablePercent)"
                 flag="fatal"
                 id="BR-CO-17">[BR-CO-17]-VAT category tax amount (BT-117) = VAT category taxable amount (BT-116) x (VAT category rate (BT-119) / 100), rounded to two decimals.</assert>
         <assert test="string-length(substring-after(ram:BasisAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-19">[BR-DEC-19]-The allowed maximum number of decimals for the VAT category taxable amount (BT-116) is 2.</assert>
         <assert test="string-length(substring-after(ram:CalculatedAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-20">[BR-DEC-20]-The allowed maximum number of decimals for the VAT category tax amount (BT-117) is 2.</assert>    
      </rule>
   </pattern>
  <!--Start pattern based on abstract EN16931-CII--><pattern id="EN16931-CII-Syntax">
      <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext">
        <assert test="not(ram:SpecifiedTransactionID)"
                 flag="warning"
                 id="CII-SR-001">[CII-SR-001] - SpecifiedTransactionID should not be present</assert>
        <assert test="not(ram:TestIndicator)" flag="warning" id="CII-SR-002">[CII-SR-002] - TestIndicator should not be present</assert>
        <assert test="(count(ram:BusinessProcessSpecifiedDocumentContextParameter) &lt;= 1)"
                 flag="warning"
                 id="CII-SR-003">[CII-SR-003] - BusinessProcessSpecifiedDocumentContextParameter should exist maximum once</assert>
        <assert test="not(ram:BIMSpecifiedDocumentContextParameter)"
                 flag="warning"
                 id="CII-SR-006">[CII-SR-006] - BIMSpecifiedDocumentContextParameter should not be present</assert>
        <assert test="not(ram:ScenarioSpecifiedDocumentContextParameter)"
                 flag="warning"
                 id="CII-SR-007">[CII-SR-007] - ScenarioSpecifiedDocumentContextParameter should not be present</assert>
        <assert test="not(ram:ApplicationSpecifiedDocumentContextParameter)"
                 flag="warning"
                 id="CII-SR-008">[CII-SR-008] - ApplicationSpecifiedDocumentContextParameter should not be present</assert>
        <assert test="count(ram:GuidelineSpecifiedDocumentContextParameter) = 1"
                 flag="fatal"
                 id="CII-SR-009">[CII-SR-009] - GuidelineSpecifiedDocumentContextParameter must exist exactly once</assert>
        <assert test="count(ram:GuidelineSpecifiedDocumentContextParameter/ram:ID) = 1"
                 flag="fatal"
                 id="CII-SR-010">[CII-SR-010] - ID must exist exactly once</assert>
        <assert test="not(ram:SubsetSpecifiedDocumentContextParameter)"
                 flag="warning"
                 id="CII-SR-011">[CII-SR-011] - SubsetSpecifiedDocumentContextParameter should not be present</assert>
        <assert test="not(ram:MessageStandardSpecifiedDocumentContextParameter)"
                 flag="warning"
                 id="CII-SR-012">[CII-SR-012] - MessageStandardSpecifiedDocumentContextParameter should not be present</assert>
      </rule>
      <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument">
        <assert test="not(ram:Name)" flag="warning" id="CII-SR-013">[CII-SR-013] - Name should not be present</assert>
        <assert test="count(ram:TypeCode) = 1" flag="fatal" id="CII-SR-014">[CII-SR-014] - TypeCode must exist exactly once</assert>
        <assert test="not(ram:IssueDateTime/udt:DateTime)"
                 flag="warning"
                 id="CII-SR-015">[CII-SR-015] - DateTime should not be present</assert>
        <assert test="not(ram:CopyIndicator)" flag="warning" id="CII-SR-016">[CII-SR-016] - CopyIndicator should not be present</assert>
        <assert test="not(ram:Purpose)" flag="warning" id="CII-SR-017">[CII-SR-017] - Purpose should not be present</assert>
        <assert test="not(ram:ControlRequirementIndicator)"
                 flag="warning"
                 id="CII-SR-018">[CII-SR-018] - ControlRequirementIndicator should not be present</assert>
        <assert test="not(ram:LanguageID)" flag="warning" id="CII-SR-019">[CII-SR-019] - LanguageID should not be present</assert>
        <assert test="not(ram:PurposeCode)" flag="warning" id="CII-SR-020">[CII-SR-020] - PurposeCode should not be present</assert>
        <assert test="not(ram:RevisionDateTime)" flag="warning" id="CII-SR-021">[CII-SR-021] - RevisionDateTime should not be present</assert>
        <assert test="not(ram:VersionID)" flag="warning" id="CII-SR-022">[CII-SR-022] - VersionID should not be present</assert>
        <assert test="not(ram:GlobalID)" flag="warning" id="CII-SR-023">[CII-SR-023] - GlobalID should not be present</assert>
        <assert test="not(ram:RevisionID)" flag="warning" id="CII-SR-024">[CII-SR-024] - RevisionID should not be present</assert>
        <assert test="not(ram:PreviousRevisionID)" flag="warning" id="CII-SR-025">[CII-SR-025] - PreviousRevisionID should not be present</assert>
        <assert test="not(ram:CategoryCode)" flag="warning" id="CII-SR-026">[CII-SR-026] - CategoryCode should not be present</assert>
        <assert test="not(ram:IncludedNote/ram:Subject)"
                 flag="warning"
                 id="CII-SR-027">[CII-SR-027] - Subject should not be present</assert>
        <assert test="not(ram:IncludedNote/ram:ContentCode)"
                 flag="warning"
                 id="CII-SR-028">[CII-SR-028] - ContentCode should not be present</assert>
        
        <assert test="not(ram:IncludedNote/ram:ID)" flag="warning" id="CII-SR-032">[CII-SR-032] - ID should not be present</assert>
        <assert test="not(ram:EffectiveSpecifiedPeriod)"
                 flag="warning"
                 id="CII-SR-033">[CII-SR-033] - EffectiveSpecifiedPeriod should not be present</assert>
        <assert test="not(ram:IssuerTradeParty)" flag="warning" id="CII-SR-034">[CII-SR-034] - IssuerTradeParty should not be present</assert>
      </rule>
      <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote">
        <assert test="count(ram:Content) &lt;= 1" flag="warning" id="CII-SR-030">[CII-SR-030] - Content should exist maximum once</assert>
      </rule>
      <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem">
        <assert test="not(ram:DescriptionCode)" flag="warning" id="CII-SR-035">[CII-SR-035] - DescriptionCode should not be present</assert>
        <assert test="not(ram:ParentLineID)" flag="warning" id="CII-SR-036">[CII-SR-036] - ParentLineID should not be present</assert>
        <assert test="not(ram:LineStatusCode)" flag="warning" id="CII-SR-037">[CII-SR-037] - LineStatusCode should not be present</assert>
        <assert test="not(ram:LineStatusReasonCode)" flag="warning" id="CII-SR-038">[CII-SR-038] - LineStatusReasonCode should not be present</assert>
        <assert test="count(ram:IncludedNote) &lt;= 1" flag="warning" id="CII-SR-039">[CII-SR-039] - IncludedNote should exist maximum once</assert>
        <assert test="count(ram:IncludedNote/ram:Content) &lt;= 1"
                 flag="warning"
                 id="CII-SR-040">[CII-SR-040] - Content should exist maximum once</assert>
        <assert test="not(ram:IncludedNote/ram:SubjectCode)"
                 flag="warning"
                 id="CII-SR-041">[CII-SR-041] - SubjectCode should not be present</assert>
        <assert test="not(ram:IncludedNote/ram:ID)" flag="warning" id="CII-SR-042">[CII-SR-042] - ID should not be present</assert>
        <assert test="not(ram:IncludedNote/ram:Subject)"
                 flag="warning"
                 id="CII-SR-043">[CII-SR-043] - CategoryCode should not be present</assert>
        <assert test="not(ram:IncludedNote/ram:ContentCode)"
                 flag="warning"
                 id="CII-SR-044">[CII-SR-044] - Subject should not be present</assert>
        <assert test="not(ram:IncludedSubordinateTradeLineItem)"
                 flag="warning"
                 id="CII-SR-221">[CII-SR-221] - IncludedSubordinateTradeLineItem should not be present</assert>
      </rule>
      <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct">
        <assert test="not(ram:ID)" flag="warning" id="CII-SR-045">[CII-SR-045] - ID should not be present</assert>
        <assert test="not(ram:GlobalID) or (ram:GlobalID/@schemeID)"
                 flag="fatal"
                 id="CII-SR-046">[CII-SR-046] - schemeID must be present if GlobalID is present</assert>
        
        <assert test="not(ram:ManufacturerAssignedID)"
                 flag="warning"
                 id="CII-SR-048">[CII-SR-048] - ManufacturerAssignedID should not be present</assert>
        <assert test="not(ram:TradeName)" flag="warning" id="CII-SR-049">[CII-SR-049] - TradeName should not be present</assert>
        <assert test="not(ram:TypeCode)" flag="warning" id="CII-SR-050">[CII-SR-050] - TypeCode should not be present</assert>
        <assert test="not(ram:NetWeightMeasure)" flag="warning" id="CII-SR-051">[CII-SR-051] - NetWeightMeasure should not be present</assert>
        <assert test="not(ram:GrossWeightMeasure)" flag="warning" id="CII-SR-052">[CII-SR-052] - GrossWeightMeasure should not be present</assert>
        <assert test="not(ram:ProductGroupID)" flag="warning" id="CII-SR-053">[CII-SR-053] - ProductGroupID should not be present</assert>
        <assert test="not(ram:EndItemTypeCode)" flag="warning" id="CII-SR-054">[CII-SR-054] - EndItemTypeCode should not be present</assert>
        <assert test="not(ram:EndItemName)" flag="warning" id="CII-SR-055">[CII-SR-055] - EndItemName should not be present</assert>
        <assert test="not(ram:AreaDensityMeasure)" flag="warning" id="CII-SR-056">[CII-SR-056] - AreaDensityMeasure should not be present</assert>
        <assert test="not(ram:UseDescription)" flag="warning" id="CII-SR-057">[CII-SR-057] - UseDescription should not be present</assert>
        <assert test="not(ram:BrandName)" flag="warning" id="CII-SR-058">[CII-SR-058] - BrandName should not be present</assert>
        <assert test="not(ram:SubBrandName)" flag="warning" id="CII-SR-059">[CII-SR-059] - SubBrandName should not be present</assert>
        <assert test="not(ram:DrainedNetWeightMeasure)"
                 flag="warning"
                 id="CII-SR-060">[CII-SR-060] - DrainedNetWeightMeasure should not be present</assert>
        <assert test="not(ram:VariableMeasureIndicator)"
                 flag="warning"
                 id="CII-SR-061">[CII-SR-061] - VariableMeasureIndicator should not be present</assert>
        <assert test="not(ram:ColourCode)" flag="warning" id="CII-SR-062">[CII-SR-062] - ColourCode should not be present</assert>
        <assert test="not(ram:ColourDescription)" flag="warning" id="CII-SR-063">[CII-SR-063] - ColourDescription should not be present</assert>
        <assert test="not(ram:Designation)" flag="warning" id="CII-SR-064">[CII-SR-064] - Designation should not be present</assert>
        <assert test="not(ram:FormattedCancellationAnnouncedLaunchDateTime)"
                 flag="warning"
                 id="CII-SR-065">[CII-SR-065] - FormattedCancellationAnnouncedLaunchDateTime should not be present</assert>
        <assert test="not(ram:FormattedLatestProductDataChangeDateTime)"
                 flag="warning"
                 id="CII-SR-066">[CII-SR-066] - FormattedLatestProductDataChangeDateTime should not be present</assert>
        <assert test="not(ram:ApplicableProductCharacteristic/ram:ID)"
                 flag="warning"
                 id="CII-SR-067">[CII-SR-067] - ID should not be present</assert>
        <assert test="not(ram:ApplicableProductCharacteristic/ram:TypeCode)"
                 flag="warning"
                 id="CII-SR-068">[CII-SR-068] - TypeCode should not be present</assert>
        
        <assert test="not(ram:ApplicableProductCharacteristic/ram:ValueMeasure)"
                 flag="warning"
                 id="CII-SR-070">[CII-SR-070] - ValueMeasure should not be present</assert>
        <assert test="not(ram:ApplicableProductCharacteristic/ram:MeasurementMethodCode)"
                 flag="warning"
                 id="CII-SR-071">[CII-SR-071] - MeasurementMethodCode should not be present</assert>
    	
        <assert test="not(ram:ApplicableProductCharacteristic/ram:ValueCode)"
                 flag="warning"
                 id="CII-SR-073">[CII-SR-073] - ValueCode should not be present</assert>
        <assert test="not(ram:ApplicableProductCharacteristic/ram:ValueDateTime)"
                 flag="warning"
                 id="CII-SR-074">[CII-SR-074] - ValueDateTime should not be present</assert>
        <assert test="not(ram:ApplicableProductCharacteristic/ram:ValueIndicator)"
                 flag="warning"
                 id="CII-SR-075">[CII-SR-075] - ValueIndicator should not be present</assert>
        <assert test="not(ram:ApplicableProductCharacteristic/ram:ContentTypeCode)"
                 flag="warning"
                 id="CII-SR-076">[CII-SR-076] - ContentTypeCode should not be present</assert>
        <assert test="not(ram:ApplicableProductCharacteristic/ram:ValueSpecifiedBinaryFile)"
                 flag="warning"
                 id="CII-SR-077">[CII-SR-077] - ValueSpecifiedBinaryFile should not be present</assert>
        <assert test="not(ram:ApplicableProductCharacteristic/ram:ApplicableProductCharacteristicCondition)"
                 flag="warning"
                 id="CII-SR-078">[CII-SR-078] - ApplicableProductCharacteristicCondition should not be present</assert>
        <assert test="not(ram:ApplicableProductCharacteristic/ram:ApplicableReferencedStandard)"
                 flag="warning"
                 id="CII-SR-079">[CII-SR-079] - ApplicableReferencedStandard should not be present</assert>
        <assert test="not(ram:ApplicableMaterialGoodsCharacteristic)"
                 flag="warning"
                 id="CII-SR-080">[CII-SR-080] - ApplicableMaterialGoodsCharacteristic should not be present</assert>
        
        <assert test="not(ram:DesignatedProductClassification/ram:SystemID)"
                 flag="warning"
                 id="CII-SR-081">[CII-SR-081] - SystemID should not be present</assert>
        <assert test="not(ram:DesignatedProductClassification/ram:SystemName)"
                 flag="warning"
                 id="CII-SR-082">[CII-SR-082] - SystemName should not be present</assert>
        <assert test="not(ram:DesignatedProductClassification/ram:ClassName)"
                 flag="warning"
                 id="CII-SR-083">[CII-SR-083] - ClassName should not be present</assert>
        <assert test="not(ram:DesignatedProductClassification/ram:SubClassCode)"
                 flag="warning"
                 id="CII-SR-084">[CII-SR-084] - SubClassCode should not be present</assert>
        <assert test="not(ram:DesignatedProductClassification/ram:ClassProductCharacteristic)"
                 flag="warning"
                 id="CII-SR-085">[CII-SR-085] - ClassProductCharacteristic should not be present</assert>
        <assert test="not(ram:DesignatedProductClassification/ram:ApplicableReferencedStandard)"
                 flag="warning"
                 id="CII-SR-086">[CII-SR-086] - ApplicableReferencedStandard should not be present</assert>
        
        <assert test="not(ram:IndividualTradeProductInstance)"
                 flag="warning"
                 id="CII-SR-087">[CII-SR-087] - IndividualTradeProductInstance should not be present</assert>
        <assert test="not(ram:CertificationEvidenceReferenceReferencedDocument)"
                 flag="warning"
                 id="CII-SR-088">[CII-SR-088] - CertificationEvidenceReferenceReferencedDocument should not be present</assert>
        <assert test="not(ram:InspectionReferenceReferencedDocument)"
                 flag="warning"
                 id="CII-SR-089">[CII-SR-089] - InspectionReferenceReferencedDocument should not be present</assert>
        
        <assert test="not (ram:OriginTradeCountry) or (count(ram:OriginTradeCountry/ram:ID) =1)"
                 flag="fatal"
                 id="CII-SR-090">[CII-SR-090] - ID should exist maximum once.</assert>
        <assert test="not(ram:OriginTradeCountry/ram:Name)"
                 flag="warning"
                 id="CII-SR-091">[CII-SR-091] - Name should not be present</assert>
        <assert test="not(ram:OriginTradeCountry/ram:SubordinateTradeCountrySubDivision)"
                 flag="warning"
                 id="CII-SR-092">[CII-SR-092] - SubordinateTradeCountrySubDivision should not be present</assert>
        
        <assert test="not(ram:LinearSpatialDimension)"
                 flag="warning"
                 id="CII-SR-093">[CII-SR-093] - LinearSpatialDimension should not be present</assert>
        <assert test="not(ram:MinimumLinearSpatialDimension)"
                 flag="warning"
                 id="CII-SR-094">[CII-SR-094] - MinimumLinearSpatialDimension should not be present</assert>
        <assert test="not(ram:MaximumLinearSpatialDimension)"
                 flag="warning"
                 id="CII-SR-095">[CII-SR-095] - MaximumLinearSpatialDimension should not be present</assert>
        <assert test="not(ram:ManufacturerTradeParty)"
                 flag="warning"
                 id="CII-SR-096">[CII-SR-096] - ManufacturerTradeParty should not be present</assert>
        <assert test="not(ram:PresentationSpecifiedBinaryFile)"
                 flag="warning"
                 id="CII-SR-097">[CII-SR-097] - PresentationSpecifiedBinaryFile should not be present</assert>
        <assert test="not(ram:MSDSReferenceReferencedDocument)"
                 flag="warning"
                 id="CII-SR-098">[CII-SR-098] - MSDSReferenceReferencedDocument should not be present</assert>
        <assert test="not(ram:AdditionalReferenceReferencedDocument)"
                 flag="warning"
                 id="CII-SR-099">[CII-SR-099] - AdditionalReferenceReferencedDocument should not be present</assert>
        <assert test="not(ram:LegalRightsOwnerTradeParty)"
                 flag="warning"
                 id="CII-SR-100">[CII-SR-100] - LegalRightsOwnerTradeParty should not be present</assert>
        <assert test="not(ram:BrandOwnerTradeParty)" flag="warning" id="CII-SR-101">[CII-SR-101] - BrandOwnerTradeParty should not be present</assert>
        <assert test="not(ram:IncludedReferencedProduct)"
                 flag="warning"
                 id="CII-SR-102">[CII-SR-102] - IncludedReferencedProduct should not be present</assert>
        <assert test="not(ram:InformationNote)" flag="warning" id="CII-SR-103">[CII-SR-103] - InformationNote should not be present</assert>
      </rule>
	     <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic">
		       <assert test="(count(ram:Description) =1)" flag="fatal" id="CII-SR-069">[CII-SR-069] - Description should exist maximum once.</assert>
		       <assert test="(count(ram:Value) =1)" flag="fatal" id="CII-SR-072">[CII-SR-072] - Value should exist maximum once.</assert>
	     </rule>
      <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement">
		       <assert test="not(ram:BuyerReference)" flag="warning" id="CII-SR-104">[CII-SR-104] - BuyerReference should not be present</assert>
		       <assert test="not(ram:BuyerRequisitionerTradeParty)"
                 flag="warning"
                 id="CII-SR-105">[CII-SR-105] - BuyerRequisitionerTradeParty should not be present</assert>
		       <assert test="not(ram:ApplicableTradeDeliveryTerms)"
                 flag="warning"
                 id="CII-SR-106">[CII-SR-106] - ApplicableTradeDeliveryTerms should not be present</assert>
		       <assert test="not(ram:SellerOrderReferencedDocument)"
                 flag="warning"
                 id="CII-SR-107">[CII-SR-107] - SellerOrderReferencedDocument should not be present</assert>
		       <assert test="not(ram:BuyerOrderReferencedDocument/ram:IssuerAssignedID)"
                 flag="warning"
                 id="CII-SR-108">[CII-SR-108] - IssuerAssignedID should not be present</assert>
		       <assert test="not(ram:QuotationReferencedDocument)"
                 flag="warning"
                 id="CII-SR-109">[CII-SR-109] - QuotationReferencedDocument should not be present</assert>
		       <assert test="not(ram:ContractReferencedDocument)"
                 flag="warning"
                 id="CII-SR-110">[CII-SR-110] - ContractReferencedDocument should not be present</assert>
		       <assert test="not(ram:DemandForecastReferencedDocument)"
                 flag="warning"
                 id="CII-SR-111">[CII-SR-111] - DemandForecastReferencedDocument should not be present</assert>
		       <assert test="not(ram:PromotionalDealReferencedDocument)"
                 flag="warning"
                 id="CII-SR-112">[CII-SR-112] - PromotionalDealReferencedDocument should not be present</assert>
		       <assert test="not(ram:AdditionalReferencedDocument)"
                 flag="warning"
                 id="CII-SR-113">[CII-SR-113] - AdditionalReferencedDocument should not be present</assert>

		       <assert test="not(ram:GrossPriceProductTradePrice/ram:TypeCode)"
                 flag="warning"
                 id="CII-SR-114">[CII-SR-114] - TypeCode should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:MinimumQuantity)"
                 flag="warning"
                 id="CII-SR-115">[CII-SR-115] - MinimumQuantity should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:MaximumQuantity)"
                 flag="warning"
                 id="CII-SR-116">[CII-SR-116] - MaximumQuantity should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:ChangeReason)"
                 flag="warning"
                 id="CII-SR-117">[CII-SR-117] - ChangeReason should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:OrderUnitConversionFactorNumeric)"
                 flag="warning"
                 id="CII-SR-118">[CII-SR-118] - OrderUnitConversionFactorNumeric should not be present</assert>
		       <assert test="count(ram:NetPriceProductTradePrice/ram:ChargeAmount) = 1"
                 flag="fatal"
                 id="CII-SR-439">[CII-SR-439] - ChargeAmount should exist maximum once</assert>
		
		       <assert test="(ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:ChargeIndicator[udt:Indicator='false'] and ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:ActualAmount) or (not (ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:ChargeIndicator) and not (ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:ActualAmount))"
                 flag="warning"
                 id="CII-SR-119">[CII-SR-119] - Only allowances on price a price should be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:ID)"
                 flag="warning"
                 id="CII-SR-120">[CII-SR-120] - ID should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:SequenceNumeric)"
                 flag="warning"
                 id="CII-SR-121">[CII-SR-121] - SequenceNumeric should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:CalculationPercent)"
                 flag="warning"
                 id="CII-SR-122">[CII-SR-122] - CalculationPercent should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:BasisAmount)"
                 flag="warning"
                 id="CII-SR-123">[CII-SR-123] - BasisAmount should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:BasisQuantity)"
                 flag="warning"
                 id="CII-SR-124">[CII-SR-124] - BasisQuantityshould not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:PrepaidIndicator)"
                 flag="warning"
                 id="CII-SR-125">[CII-SR-125] - PrepaidIndicator should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:UnitBasisAmount)"
                 flag="warning"
                 id="CII-SR-126">[CII-SR-126] - UnitBasisAmount should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:ReasonCode)"
                 flag="warning"
                 id="CII-SR-127">[CII-SR-127] - ReasonCode should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:Reason)"
                 flag="warning"
                 id="CII-SR-128">[CII-SR-128] - Reason should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:TypeCode)"
                 flag="warning"
                 id="CII-SR-129">[CII-SR-129] - TypeCode should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:CategoryTradeTax)"
                 flag="warning"
                 id="CII-SR-130">[CII-SR-130] - CategoryTradeTax should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:ActualTradeCurrencyExchange)"
                 flag="warning"
                 id="CII-SR-131">[CII-SR-131] - ActualTradeCurrencyExchange should not be present</assert>
		       <assert test="count(ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:ActualAmount) &lt;= 1"
                 flag="fatal"
                 id="CII-SR-440">[CII-SR-440] - ActualAmount should exist maximum once</assert>
		
    	    <assert test="not(ram:GrossPriceProductTradePrice/ram:IncludedTradeTax)"
                 flag="warning"
                 id="CII-SR-445">[CII-SR-445] - IncludedTradeTax should not be present</assert>
    	    <assert test="not(ram:GrossPriceProductTradePrice/ram:ValiditySpecifiedPeriod)"
                 flag="warning"
                 id="CII-SR-132">[CII-SR-132] - ValiditySpecifiedPeriod should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:DeliveryTradeLocation)"
                 flag="warning"
                 id="CII-SR-133">[CII-SR-133] - DeliveryTradeLocation should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:TradeComparisonReferencePrice)"
                 flag="warning"
                 id="CII-SR-134">[CII-SR-134] - TradeComparisonReferencePrice should not be present</assert>
		       <assert test="not(ram:GrossPriceProductTradePrice/ram:AssociatedReferencedDocument)"
                 flag="warning"
                 id="CII-SR-135">[CII-SR-135] - AssociatedReferencedDocument should not be present</assert>
		
		       <assert test="not(ram:NetPriceProductTradePrice/ram:TypeCode)"
                 flag="warning"
                 id="CII-SR-136">[CII-SR-136] - TypeCode should not be present</assert>
		
		       <assert test="not(ram:NetPriceProductTradePrice/ram:MinimumQuantity)"
                 flag="warning"
                 id="CII-SR-138">[CII-SR-138] - MinimumQuantity should not be present</assert>
		       <assert test="not(ram:NetPriceProductTradePrice/ram:MaximumQuantity)"
                 flag="warning"
                 id="CII-SR-139">[CII-SR-139] - MaximumQuantity should not be present</assert>
		       <assert test="not(ram:NetPriceProductTradePrice/ram:ChangeReason)"
                 flag="warning"
                 id="CII-SR-140">[CII-SR-140] - ChangeReason should not be present</assert>
		       <assert test="not(ram:NetPriceProductTradePrice/ram:OrderUnitConversionFactorNumeric)"
                 flag="warning"
                 id="CII-SR-141">[CII-SR-141] - OrderUnitConversionFactorNumeric should not be present</assert>
		       <assert test="not(ram:NetPriceProductTradePrice/ram:AppliedTradeAllowanceCharge)"
                 flag="warning"
                 id="CII-SR-142">[CII-SR-142] - AppliedTradeAllowanceCharge should not be present</assert>
    	    <assert test="not(ram:NetPriceProductTradePrice/ram:IncludedTradeTax)"
                 flag="warning"
                 id="CII-SR-446">[CII-SR-446] - IncludedTradeTax should not be present</assert>
		       <assert test="not(ram:NetPriceProductTradePrice/ram:ValiditySpecifiedPeriod)"
                 flag="warning"
                 id="CII-SR-143">[CII-SR-143] - ValiditySpecifiedPeriod should not be present</assert>
		       <assert test="not(ram:NetPriceProductTradePrice/ram:DeliveryTradeLocation)"
                 flag="warning"
                 id="CII-SR-144">[CII-SR-144] - DeliveryTradeLocation should not be present</assert>
		       <assert test="not(ram:NetPriceProductTradePrice/ram:TradeComparisonReferencePrice)"
                 flag="warning"
                 id="CII-SR-145">[CII-SR-145] - TradeComparisonReferencePrice should not be present</assert>
		       <assert test="not(ram:NetPriceProductTradePrice/ram:AssociatedReferencedDocument)"
                 flag="warning"
                 id="CII-SR-146">[CII-SR-146] - AssociatedReferencedDocument should not be present</assert>
		       <assert test="count(ram:NetPriceProductTradePrice/ram:ChargeAmount) &lt;= 1"
                 flag="fatal"
                 id="CII-SR-441">[CII-SR-441] - ChargeAmount should exist maximum once</assert>

		       <assert test="not(ram:RequisitionerReferencedDocument)"
                 flag="warning"
                 id="CII-SR-147">[CII-SR-147] - RequisitionerReferencedDocument should not be present</assert>
		       <assert test="not(ram:ItemSellerTradeParty)" flag="warning" id="CII-SR-148">[CII-SR-148] - ItemSellerTradeParty should not be present</assert>
		       <assert test="not(ram:ItemBuyerTradeParty)" flag="warning" id="CII-SR-149">[CII-SR-149] - ItemBuyerTradeParty should not be present</assert>
		       <assert test="not(ram:IncludedSpecifiedMarketplace)"
                 flag="warning"
                 id="CII-SR-150">[CII-SR-150] - IncludedSpecifiedMarketplace should not be present</assert>
    	    <assert test="not(ram:UltimateCustomerOrderReferencedDocument)"
                 flag="warning"
                 id="CII-SR-447">[CII-SR-447] - UltimateCustomerOrderReferencedDocument should not be present</assert>
				
      </rule>
      <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery">
		       <assert test="not(ram:RequestedQuantity)" flag="warning" id="CII-SR-151">[CII-SR-151] - RequestedQuantity should not be present</assert>
		       <assert test="not(ram:ReceivedQuantity)" flag="warning" id="CII-SR-152">[CII-SR-152] - ReceivedQuantity should not be present</assert>
		       <assert test="not(ram:ChargeFreeQuantity)" flag="warning" id="CII-SR-153">[CII-SR-153] - ChargeFreeQuantity should not be present</assert>
		       <assert test="not(ram:PackageQuantity)" flag="warning" id="CII-SR-154">[CII-SR-154] - PackageQuantity should not be present</assert>
		       <assert test="not(ram:ProductUnitQuantity)" flag="warning" id="CII-SR-155">[CII-SR-155] - ProductUnitQuantity should not be present</assert>
		       <assert test="not(ram:PerPackageUnitQuantity)"
                 flag="warning"
                 id="CII-SR-156">[CII-SR-156] - PerPackageUnitQuantity should not be present</assert>
		       <assert test="not(ram:NetWeightMeasure)" flag="warning" id="CII-SR-157">[CII-SR-157] - NetWeightMeasure should not be present</assert>
		       <assert test="not(ram:GrossWeightMeasure)" flag="warning" id="CII-SR-158">[CII-SR-158] - GrossWeightMeasure should not be present</assert>
		       <assert test="not(ram:TheoreticalWeightMeasure)"
                 flag="warning"
                 id="CII-SR-159">[CII-SR-159] - TheoreticalWeightMeasure should not be present</assert>
		       <assert test="not(ram:DespatchedQuantity)" flag="warning" id="CII-SR-160">[CII-SR-160] - DespatchedQuantity should not be present</assert>
		       <assert test="not(ram:SpecifiedDeliveryAdjustment)"
                 flag="warning"
                 id="CII-SR-161">[CII-SR-161] - SpecifiedDeliveryAdjustment should not be present</assert>
		       <assert test="not(ram:IncludedSupplyChainPackaging)"
                 flag="warning"
                 id="CII-SR-162">[CII-SR-162] - IncludedSupplyChainPackaging should not be present</assert>
		       <assert test="not(ram:RelatedSupplyChainConsignment)"
                 flag="warning"
                 id="CII-SR-163">[CII-SR-163] - RelatedSupplyChainConsignment should not be present</assert>
		       <assert test="not(ram:ShipToTradeParty)" flag="warning" id="CII-SR-164">[CII-SR-164] - ShipToTradeParty should not be present</assert>
		       <assert test="not(ram:UltimateShipToTradeParty)"
                 flag="warning"
                 id="CII-SR-165">[CII-SR-165] - UltimateShipToTradeParty should not be present</assert>
		       <assert test="not(ram:ShipFromTradeParty)" flag="warning" id="CII-SR-166">[CII-SR-166] - ShipFromTradeParty should not be present</assert>
		       <assert test="not(ram:ActualDespatchSupplyChainEvent)"
                 flag="warning"
                 id="CII-SR-167">[CII-SR-167] - ActualDespatchSupplyChainEvent should not be present</assert>
		       <assert test="not(ram:ActualPickUpSupplyChainEvent)"
                 flag="warning"
                 id="CII-SR-168">[CII-SR-168] - ActualPickUpSupplyChainEvent should not be present</assert>
		       <assert test="not(ram:ActualReceiptSupplyChainEvent)"
                 flag="warning"
                 id="CII-SR-169">[CII-SR-169] - RequestedDeliverySupplyChainEvent should not be present</assert>
		       <assert test="not(ram:ActualDeliverySupplyChainEvent)"
                 flag="warning"
                 id="CII-SR-170">[CII-SR-170] - ActualDeliverySupplyChainEvent should not be present</assert>
		       <assert test="not(ram:RequestedQuantity)" flag="warning" id="CII-SR-171">[CII-SR-171] - ActualReceiptSupplyChainEvent should not be present</assert>
		       <assert test="not(ram:AdditionalReferencedDocument)"
                 flag="warning"
                 id="CII-SR-172">[CII-SR-172] - AdditionalReferencedDocument should not be present</assert>
		       <assert test="not(ram:DespatchAdviceReferencedDocument)"
                 flag="warning"
                 id="CII-SR-173">[CII-SR-173] - DespatchAdviceReferencedDocument should not be present</assert>
		       <assert test="not(ram:ReceivingAdviceReferencedDocument)"
                 flag="warning"
                 id="CII-SR-174">[CII-SR-174] - ReceivingAdviceReferencedDocument should not be present</assert>
		       <assert test="not(ram:DeliveryNoteReferencedDocument)"
                 flag="warning"
                 id="CII-SR-175">[CII-SR-175] - DeliveryNoteReferencedDocument should not be present</assert>
		       <assert test="not(ram:ConsumptionReportReferencedDocument)"
                 flag="warning"
                 id="CII-SR-176">[CII-SR-176] - ConsumptionReportReferencedDocument should not be present</assert>
		       <assert test="not(ram:PackingListReferencedDocument)"
                 flag="warning"
                 id="CII-SR-177">[CII-SR-177] - RequestedQuantity should not be present</assert>
	     </rule>
	     <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement">
		       <assert test="not(ram:PaymentReference)" flag="warning" id="CII-SR-178">[CII-SR-178] - PaymentReference should not be present</assert>
		       <assert test="not(ram:InvoiceIssuerReference)"
                 flag="warning"
                 id="CII-SR-179">[CII-SR-179] - InvoiceIssuerReference should not be present</assert>
		       <assert test="not(ram:TotalAdjustmentAmount)"
                 flag="warning"
                 id="CII-SR-180">[CII-SR-180] - TotalAdjustmentAmount should not be present</assert>
		       <assert test="not(ram:DiscountIndicator)" flag="warning" id="CII-SR-181">[CII-SR-181] - DiscountIndicator should not be present</assert>
		       <assert test="not(ram:ApplicableTradeTax/ram:CalculatedAmount)"
                 flag="warning"
                 id="CII-SR-182">[CII-SR-182] - CalculatedAmount should not be present</assert>
		
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:ChargeIndicator/udt:IndicatorString)"
                 flag="warning"
                 id="CII-SR-183">[CII-SR-183] - IndicatorString should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:ID)"
                 flag="warning"
                 id="CII-SR-184">[CII-SR-184] - ID should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:SequenceNumeric)"
                 flag="warning"
                 id="CII-SR-185">[CII-SR-185] - SequenceNumeric should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:CalculationPercent/@format)"
                 flag="warning"
                 id="CII-SR-186">[CII-SR-186] - @format should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:BasisQuantity)"
                 flag="warning"
                 id="CII-SR-187">[CII-SR-187] - BasisQuantity should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:PrepaidIndicator)"
                 flag="warning"
                 id="CII-SR-188">[CII-SR-188] - PrepaidIndicator should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:UnitBasisAmount)"
                 flag="warning"
                 id="CII-SR-189">[CII-SR-189] - UnitBasisAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:TypeCode)"
                 flag="warning"
                 id="CII-SR-190">[CII-SR-190] - TypeCode should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax)"
                 flag="warning"
                 id="CII-SR-191">[CII-SR-191] - CategoryTradeTax should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:ActualTradeCurrencyExchange)"
                 flag="warning"
                 id="CII-SR-192">[CII-SR-192] - ActualTradeCurrencyExchange should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:ID)"
                 flag="warning"
                 id="CII-SR-193">[CII-SR-193] - ID should not be present</assert>
		
		       <assert test="not(ram:SubtotalCalculatedTradeTax)"
                 flag="warning"
                 id="CII-SR-194">[CII-SR-194] - SubtotalCalculatedTradeTax should not be present</assert>
		       <assert test="not(ram:SpecifiedLogisticsServiceCharge)"
                 flag="warning"
                 id="CII-SR-195">[CII-SR-195] - SpecifiedLogisticsServiceCharge should not be present</assert>
		       <assert test="not(ram:SpecifiedTradePaymentTerms)"
                 flag="warning"
                 id="CII-SR-196">[CII-SR-196] - SpecifiedTradePaymentTerms should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementLineMonetarySummation/ram:ChargeTotalAmount)"
                 flag="warning"
                 id="CII-SR-197">[CII-SR-197] - ChargeTotalAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementLineMonetarySummation/ram:AllowanceTotalAmount)"
                 flag="warning"
                 id="CII-SR-198">[CII-SR-198] - AllowanceTotalAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementLineMonetarySummation/ram:TaxBasisTotalAmount)"
                 flag="warning"
                 id="CII-SR-199">[CII-SR-199] - TaxBasisTotalAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementLineMonetarySummation/ram:TaxTotalAmount)"
                 flag="warning"
                 id="CII-SR-200">[CII-SR-200] - TaxTotalAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementLineMonetarySummation/ram:GrandTotalAmount)"
                 flag="warning"
                 id="CII-SR-201">[CII-SR-201] - GrandTotalAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementLineMonetarySummation/ram:InformationAmount)"
                 flag="warning"
                 id="CII-SR-202">[CII-SR-202] - InformationAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementLineMonetarySummation/ram:TotalAllowanceChargeAmount)"
                 flag="warning"
                 id="CII-SR-203">[CII-SR-203] - TotalAllowanceChargeAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementLineMonetarySummation/ram:TotalRetailValueInformationAmount)"
                 flag="warning"
                 id="CII-SR-204">[CII-SR-204] - TotalRetailValueInformationAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementLineMonetarySummation/ram:GrossLineTotalAmount)"
                 flag="warning"
                 id="CII-SR-205">[CII-SR-205] - GrossLineTotalAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementLineMonetarySummation/ram:NetLineTotalAmount)"
                 flag="warning"
                 id="CII-SR-206">[CII-SR-206] - NetLineTotalAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementLineMonetarySummation/ram:NetIncludingTaxesLineTotalAmount)"
                 flag="warning"
                 id="CII-SR-207">[CII-SR-207] - NetIncludingTaxesLineTotalAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementLineMonetarySummation/ram:ProductWeightLossInformationAmount)"
                 flag="warning"
                 id="CII-SR-208">[CII-SR-208] - ProductWeightLossInformationAmount should not be present</assert>
				
		       <assert test="not(ram:SpecifiedFinancialAdjustment)"
                 flag="warning"
                 id="CII-SR-209">[CII-SR-209] - SpecifiedFinancialAdjustment should not be present</assert>
		       <assert test="not(ram:InvoiceReferencedDocument)"
                 flag="warning"
                 id="CII-SR-210">[CII-SR-210] - InvoiceReferencedDocument should not be present</assert>
		
		       <assert test="not(ram:PayableSpecifiedTradeAccountingAccount)"
                 flag="warning"
                 id="CII-SR-212">[CII-SR-212] - PayableSpecifiedTradeAccountingAccount should not be present</assert>
		       <assert test="not(ram:ReceivableSpecifiedTradeAccountingAccount/ram:SetTriggerCode)"
                 flag="warning"
                 id="CII-SR-213">[CII-SR-213] - SetTriggerCode should not be present</assert>
		       <assert test="not(ram:ReceivableSpecifiedTradeAccountingAccount/ram:TypeCode)"
                 flag="warning"
                 id="CII-SR-214">[CII-SR-214] - TypeCode should not be present</assert>
		       <assert test="not(ram:ReceivableSpecifiedTradeAccountingAccount/ram:AmountTypeCode)"
                 flag="warning"
                 id="CII-SR-215">[CII-SR-215] - AmountTypeCode should not be present</assert>
		       <assert test="not(ram:ReceivableSpecifiedTradeAccountingAccount/ram:Name)"
                 flag="warning"
                 id="CII-SR-216">[CII-SR-216] - Name should not be present</assert>
		       <assert test="not(ram:ReceivableSpecifiedTradeAccountingAccount/ram:CostReferenceDimensionPattern)"
                 flag="warning"
                 id="CII-SR-217">[CII-SR-217] - CostReferenceDimensionPattern should not be present</assert>
		       <assert test="not(ram:PurchaseSpecifiedTradeAccountingAccount)"
                 flag="warning"
                 id="CII-SR-218">[CII-SR-218] - PurchaseSpecifiedTradeAccountingAccount should not be present</assert>
		       <assert test="not(ram:SalesSpecifiedTradeAccountingAccount)"
                 flag="warning"
                 id="CII-SR-219">[CII-SR-219] - SalesSpecifiedTradeAccountingAccount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementFinancialCard)"
                 flag="warning"
                 id="CII-SR-220">[CII-SR-220] - SpecifiedTradeSettlementFinancialCard should not be present</assert>
		
      </rule>		
	     <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement">
		       <assert test="not(ram:Reference)" flag="warning" id="CII-SR-442">[CII-SR-442] - Reference should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:RoleCode)"
                 flag="warning"
                 id="CII-SR-222">[CII-SR-222] - RoleCode should not be present</assert>
		
		       <assert test="not(ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:LegalClassificationCode)"
                 flag="warning"
                 id="CII-SR-223">[CII-SR-223] - LegalClassificationCode should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:Name)"
                 flag="warning"
                 id="CII-SR-224">[CII-SR-224] - Name should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:PostalTradeAddress)"
                 flag="warning"
                 id="CII-SR-225">[CII-SR-225] - PostalTradeAddress should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:AuthorizedLegalRegistration)"
                 flag="warning"
                 id="CII-SR-226">[CII-SR-226] - RoleCode should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:ID)"
                 flag="warning"
                 id="CII-SR-227">[CII-SR-227] - ID should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:TypeCode)"
                 flag="warning"
                 id="CII-SR-228">[CII-SR-228] - TypeCode should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:JobTitle)"
                 flag="warning"
                 id="CII-SR-229">[CII-SR-229] - JobTitle should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:Responsibility)"
                 flag="warning"
                 id="CII-SR-230">[CII-SR-230] - Responsibility should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:PersonID)"
                 flag="warning"
                 id="CII-SR-231">[CII-SR-231] - PersonID should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:TelephoneUniversalCommunication/ram:URIID)"
                 flag="warning"
                 id="CII-SR-232">[CII-SR-232] - URIID should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:TelephoneUniversalCommunication/ram:ChannelCode)"
                 flag="warning"
                 id="CII-SR-233">[CII-SR-233] - ChannelCode should not be present</assert>
		
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:DirectTelephoneUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-234">[CII-SR-234] - DirectTelephoneUniversalCommunication should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:MobileTelephoneUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-235">[CII-SR-235] - MobileTelephoneUniversalCommunication should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:FaxUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-236">[CII-SR-236] - FaxUniversalCommunication should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:ChannelCode)"
                 flag="warning"
                 id="CII-SR-237">[CII-SR-237] - ChannelCode should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:CompleteNumber)"
                 flag="warning"
                 id="CII-SR-238">[CII-SR-238] - CompleteNumber should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:TelexUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-239">[CII-SR-239] - TelexUniversalCommunication should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:VOIPUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-240">[CII-SR-240] - VOIPUniversalCommunication should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:InstantMessagingUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-241">[CII-SR-241] - InstantMessagingUniversalCommunication should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:SpecifiedNote)"
                 flag="warning"
                 id="CII-SR-242">[CII-SR-242] - SpecifiedNote should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:DefinedTradeContact/ram:SpecifiedContactPerson)"
                 flag="warning"
                 id="CII-SR-243">[CII-SR-243] - SpecifiedContactPerson should not be present</assert>
		
		       <assert test="not(ram:SellerTradeParty/ram:URIUniversalCommunication/ram:ChannelCode)"
                 flag="warning"
                 id="CII-SR-244">[CII-SR-244] - ChannelCode should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:URIUniversalCommunication/ram:CompleteNumber)"
                 flag="warning"
                 id="CII-SR-245">[CII-SR-245] - CompleteNumber should not be present</assert>
		
		       <assert test="not(ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:AssociatedRegisteredTax)"
                 flag="warning"
                 id="CII-SR-246">[CII-SR-246] - AssociatedRegisteredTax should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:EndPointURIUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-247">[CII-SR-247] - EndPointURIUniversalCommunication should not be present</assert>
		       <assert test="not(ram:SellerTradeParty/ram:LogoAssociatedSpecifiedBinaryFile)"
                 flag="warning"
                 id="CII-SR-248">[CII-SR-248] - LogoAssociatedSpecifiedBinaryFile should not be present</assert>
		
		       <assert test="not(ram:BuyerTradeParty/ram:RoleCode)"
                 flag="warning"
                 id="CII-SR-249">[CII-SR-249] - RoleCode should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:Description)"
                 flag="warning"
                 id="CII-SR-250">[CII-SR-250] - Description should not be present</assert>		
		       <assert test="not(ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:LegalClassificationCode)"
                 flag="warning"
                 id="CII-SR-251">[CII-SR-251] - LegalClassificationCode should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:Name)"
                 flag="warning"
                 id="CII-SR-252">[CII-SR-252] - Name should not be present</assert>
		
		       <assert test="not(ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:PostalTradeAddress)"
                 flag="warning"
                 id="CII-SR-254">[CII-SR-254] - PostalTradeAddress should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:AuthorizedLegalRegistration)"
                 flag="warning"
                 id="CII-SR-255">[CII-SR-255] - AuthorizedLegalRegistration should not be present</assert>

		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:ID)"
                 flag="warning"
                 id="CII-SR-256">[CII-SR-256] - ID should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:TypeCode)"
                 flag="warning"
                 id="CII-SR-257">[CII-SR-257] - TypeCode should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:JobTitle)"
                 flag="warning"
                 id="CII-SR-258">[CII-SR-258] - JobTitle should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:Responsibility)"
                 flag="warning"
                 id="CII-SR-259">[CII-SR-259] - Responsibility should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:PersonID)"
                 flag="warning"
                 id="CII-SR-260">[CII-SR-260] - PersonID should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:TelephoneUniversalCommunication/ram:URIID)"
                 flag="warning"
                 id="CII-SR-261">[CII-SR-261] - URIID should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:TelephoneUniversalCommunication/ram:ChannelCode)"
                 flag="warning"
                 id="CII-SR-262">[CII-SR-262] - ChannelCode should not be present</assert>
		
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:DirectTelephoneUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-263">[CII-SR-263] - DirectTelephoneUniversalCommunication should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:MobileTelephoneUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-264">[CII-SR-264] - MobileTelephoneUniversalCommunication should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:FaxUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-265">[CII-SR-265] - FaxUniversalCommunication should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:ChannelCode)"
                 flag="warning"
                 id="CII-SR-266">[CII-SR-266] - ChannelCode should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:CompleteNumber)"
                 flag="warning"
                 id="CII-SR-267">[CII-SR-267] - CompleteNumber should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:TelexUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-268">[CII-SR-268] - TelexUniversalCommunication should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:VOIPUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-269">[CII-SR-269] - VOIPUniversalCommunication should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:InstantMessagingUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-270">[CII-SR-270] - InstantMessagingUniversalCommunication should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:SpecifiedNote)"
                 flag="warning"
                 id="CII-SR-271">[CII-SR-271] - SpecifiedNote should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:DefinedTradeContact/ram:SpecifiedContactPerson)"
                 flag="warning"
                 id="CII-SR-272">[CII-SR-272] - SpecifiedContactPerson should not be present</assert>		
		
		       <assert test="not(ram:BuyerTradeParty/ram:URIUniversalCommunication/ram:ChannelCode)"
                 flag="warning"
                 id="CII-SR-273">[CII-SR-273] - ChannelCode should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:URIUniversalCommunication/ram:CompleteNumber)"
                 flag="warning"
                 id="CII-SR-274">[CII-SR-274] - CompleteNumber should not be present</assert>
		
		       <assert test="not(ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:AssociatedRegisteredTax)"
                 flag="warning"
                 id="CII-SR-275">[CII-SR-275] - AssociatedRegisteredTax should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:EndPointURIUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-276">[CII-SR-276] - EndPointURIUniversalCommunication should not be present</assert>
		       <assert test="not(ram:BuyerTradeParty/ram:LogoAssociatedSpecifiedBinaryFile)"
                 flag="warning"
                 id="CII-SR-277">[CII-SR-277] - LogoAssociatedSpecifiedBinaryFile should not be present</assert>
		
		       <assert test="not(ram:SalesAgentTradeParty)" flag="warning" id="CII-SR-278">[CII-SR-278] - SalesAgentTradeParty should not be present</assert>
		       <assert test="not(ram:BuyerRequisitionerTradeParty)"
                 flag="warning"
                 id="CII-SR-279">[CII-SR-279] - BuyerRequisitionerTradeParty should not be present</assert>
		       <assert test="not(ram:BuyerAssignedAccountantTradeParty)"
                 flag="warning"
                 id="CII-SR-280">[CII-SR-280] - BuyerAssignedAccountantTradeParty should not be present</assert>
		       <assert test="not(ram:SellerAssignedAccountantTradeParty)"
                 flag="warning"
                 id="CII-SR-281">[CII-SR-281] - SellerAssignedAccountantTradeParty should not be present</assert>
		       <assert test="not(ram:BuyerTaxRepresentativeTradeParty)"
                 flag="warning"
                 id="CII-SR-282">[CII-SR-282] - BuyerTaxRepresentativeTradeParty should not be present</assert>
		
		       <assert test="not(ram:SellerTaxRepresentativeTradeParty/ram:GlobalID)"
                 flag="warning"
                 id="CII-SR-283">[CII-SR-283] - GlobalID should not be present</assert>
		       <assert test="not(ram:SellerTaxRepresentativeTradeParty/ram:RoleCode)"
                 flag="warning"
                 id="CII-SR-284">[CII-SR-284] - RoleCode should not be present</assert>
		       <assert test="not(ram:SellerTaxRepresentativeTradeParty/ram:Description)"
                 flag="warning"
                 id="CII-SR-285">[CII-SR-285] - Description should not be present</assert>
		       <assert test="not(ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedLegalOrganization)"
                 flag="warning"
                 id="CII-SR-286">[CII-SR-286] - SpecifiedLegalOrganization should not be present</assert>
		       <assert test="not(ram:SellerTaxRepresentativeTradeParty/ram:DefinedTradeContact)"
                 flag="warning"
                 id="CII-SR-287">[CII-SR-287] - DefinedTradeContact should not be present</assert>
		       <assert test="not(ram:SellerTaxRepresentativeTradeParty/ram:URIUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-288">[CII-SR-288] - URIUniversalCommunication should not be present</assert>
		       <assert test="not(ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:AssociatedRegisteredTax)"
                 flag="warning"
                 id="CII-SR-289">[CII-SR-289] - AssociatedRegisteredTax should not be present</assert>
		       <assert test="not(ram:SellerTaxRepresentativeTradeParty/ram:EndPointURIUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-290">[CII-SR-290] - EndPointURIUniversalCommunication should not be present</assert>
		       <assert test="not(ram:SellerTaxRepresentativeTradeParty/ram:LogoAssociatedSpecifiedBinaryFile)"
                 flag="warning"
                 id="CII-SR-291">[CII-SR-291] - LogoAssociatedSpecifiedBinaryFile should not be present</assert>
		
		       <assert test="not(ram:ProductEndUserTradeParty)"
                 flag="warning"
                 id="CII-SR-292">[CII-SR-292] - ProductEndUserTradeParty should not be present</assert>
		       <assert test="not(ram:ApplicableTradeDeliveryTerms)"
                 flag="warning"
                 id="CII-SR-293">[CII-SR-293] - ApplicableTradeDeliveryTerms should not be present</assert>
		       <assert test="not(ram:SellerOrderReferencedDocument/ram:LineID)"
                 flag="warning"
                 id="CII-SR-294">[CII-SR-294] - LineID should not be present</assert>
		       <assert test="not(ram:BuyerOrderReferencedDocument/ram:LineID)"
                 flag="warning"
                 id="CII-SR-295">[CII-SR-295] - LineID should not be present</assert>
		       <assert test="not(ram:QuotationReferencedDocument)"
                 flag="warning"
                 id="CII-SR-296">[CII-SR-296] - QuotationReferencedDocument should not be present</assert>
		       <assert test="not(ram:OrderResponseReferencedDocument)"
                 flag="warning"
                 id="CII-SR-297">[CII-SR-297] - OrderResponseReferencedDocument should not be present</assert>
		       <assert test="not(ram:ContractReferencedDocument/ram:LineID)"
                 flag="warning"
                 id="CII-SR-298">[CII-SR-298] - LineID should not be present</assert>
		       <assert test="not(ram:DemandForecastReferencedDocument)"
                 flag="warning"
                 id="CII-SR-299">[CII-SR-299] - DemandForecastReferencedDocument should not be present</assert>
		       <assert test="not(ram:SupplyInstructionReferencedDocument)"
                 flag="warning"
                 id="CII-SR-300">[CII-SR-300] - SupplyInstructionReferencedDocument should not be present</assert>
		       <assert test="not(ram:PromotionalDealReferencedDocument)"
                 flag="warning"
                 id="CII-SR-301">[CII-SR-301] - PromotionalDealReferencedDocument should not be present</assert>
		       <assert test="not(ram:PriceListReferencedDocument)"
                 flag="warning"
                 id="CII-SR-302">[CII-SR-302] - PriceListReferencedDocument should not be present</assert>
		       <assert test="not(ram:AdditionalReferencedDocument/ram:LineID)"
                 flag="warning"
                 id="CII-SR-303">[CII-SR-303] - LineID should not be present</assert>
		       <assert test="not(ram:RequisitionerReferencedDocument)"
                 flag="warning"
                 id="CII-SR-304">[CII-SR-304] - RequisitionerReferencedDocument should not be present</assert>
		       <assert test="not(ram:BuyerAgentTradeParty)" flag="warning" id="CII-SR-305">[CII-SR-305] - BuyerAgentTradeParty should not be present</assert>
		       <assert test="not(ram:PurchaseConditionsReferencedDocument)"
                 flag="warning"
                 id="CII-SR-306">[CII-SR-306] - PurchaseConditionsReferencedDocument should not be present</assert>
		       <assert test="not(ram:SpecifiedProcuringProject/ram:Description)"
                 flag="warning"
                 id="CII-SR-307">[CII-SR-307] - Description should not be present</assert>
		       <assert test="not(ram:UltimateCustomerOrderReferencedDocument)"
                 flag="warning"
                 id="CII-SR-448">[CII-SR-448] - UltimateCustomerOrderReferencedDocument should not be present</assert>
		
		
	     </rule>
	     <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery">
		       <assert test="not(ram:RelatedSupplyChainConsignment)"
                 flag="warning"
                 id="CII-SR-308">[CII-SR-308] - RelatedSupplyChainConsignment should not be present</assert>
		
		       <assert test="not(ram:ShipToTradeParty/ram:RoleCode)"
                 flag="warning"
                 id="CII-SR-309">[CII-SR-309] - RoleCode should not be present</assert>
		       <assert test="not(ram:ShipToTradeParty/ram:Description)"
                 flag="warning"
                 id="CII-SR-310">[CII-SR-310] - Description should not be present</assert>
		       <assert test="not(ram:ShipToTradeParty/ram:SpecifiedLegalOrganization)"
                 flag="warning"
                 id="CII-SR-311">[CII-SR-311] - SpecifiedLegalOrganization should not be present</assert>
		       <assert test="not(ram:ShipToTradeParty/ram:DefinedTradeContact)"
                 flag="warning"
                 id="CII-SR-312">[CII-SR-312] - DefinedTradeContact should not be present</assert>
		       <assert test="not(ram:ShipToTradeParty/ram:URIUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-313">[CII-SR-313] - URIUniversalCommunication should not be present</assert>
		       <assert test="not(ram:ShipToTradeParty/ram:SpecifiedTaxRegistration)"
                 flag="warning"
                 id="CII-SR-314">[CII-SR-314] - SpecifiedTaxRegistration should not be present</assert>
		       <assert test="not(ram:ShipToTradeParty/ram:EndPointURIUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-315">[CII-SR-315] - EndPointURIUniversalCommunication should not be present</assert>
		       <assert test="not(ram:ShipToTradeParty/ram:LogoAssociatedSpecifiedBinaryFile)"
                 flag="warning"
                 id="CII-SR-316">[CII-SR-316] - LogoAssociatedSpecifiedBinaryFile should not be present</assert>
		
		       <assert test="not(ram:UltimateShipToTradeParty)"
                 flag="warning"
                 id="CII-SR-317">[CII-SR-317] - UltimateShipToTradeParty should not be present</assert>
		       <assert test="not(ram:ShipFromTradeParty)" flag="warning" id="CII-SR-318">[CII-SR-318] - ShipFromTradeParty should not be present</assert>
		       <assert test="not(ram:ActualDespatchSupplyChainEvent)"
                 flag="warning"
                 id="CII-SR-319">[CII-SR-319] - ActualDespatchSupplyChainEvent should not be present</assert>
		       <assert test="not(ram:ActualPickUpSupplyChainEvent)"
                 flag="warning"
                 id="CII-SR-320">[CII-SR-320] - ActualPickUpSupplyChainEvent should not be present</assert>
		
		       <assert test="not(ram:ActualDeliverySupplyChainEvent/ram:ID)"
                 flag="warning"
                 id="CII-SR-321">[CII-SR-321] - ID should not be present</assert>
		       <assert test="not(ram:ActualDeliverySupplyChainEvent/ram:OccurrenceDateTime/udt:DateTime)"
                 flag="warning"
                 id="CII-SR-322">[CII-SR-322] - DateTime should not be present</assert>
		       <assert test="not(ram:ActualDeliverySupplyChainEvent/ram:TypeCode)"
                 flag="warning"
                 id="CII-SR-323">[CII-SR-323] - TypeCode should not be present</assert>
		       <assert test="not(ram:ActualDeliverySupplyChainEvent/ram:Description)"
                 flag="warning"
                 id="CII-SR-324">[CII-SR-324] - Description should not be present</assert>
		       <assert test="not(ram:ActualDeliverySupplyChainEvent/ram:DescriptionBinaryObject)"
                 flag="warning"
                 id="CII-SR-325">[CII-SR-325] - DescriptionBinaryObject should not be present</assert>
		       <assert test="not(ram:ActualDeliverySupplyChainEvent/ram:UnitQuantity)"
                 flag="warning"
                 id="CII-SR-326">[CII-SR-326] - UnitQuantity should not be present</assert>
		       <assert test="not(ram:ActualDeliverySupplyChainEvent/ram:LatestOccurrenceDateTime)"
                 flag="warning"
                 id="CII-SR-327">[CII-SR-327] - LatestOccurrenceDateTime should not be present</assert>
		       <assert test="not(ram:ActualDeliverySupplyChainEvent/ram:EarliestOccurrenceDateTime)"
                 flag="warning"
                 id="CII-SR-328">[CII-SR-328] - EarliestOccurrenceDateTime should not be present</assert>
		       <assert test="not(ram:ActualDeliverySupplyChainEvent/ram:OccurrenceSpecifiedPeriod)"
                 flag="warning"
                 id="CII-SR-329">[CII-SR-329] - OccurrenceSpecifiedPeriod should not be present</assert>
		       <assert test="not(ram:ActualDeliverySupplyChainEvent/ram:OccurrenceLogisticsLocation)"
                 flag="warning"
                 id="CII-SR-330">[CII-SR-330] - OccurrenceLogisticsLocation should not be present</assert>
		
		       <assert test="not(ram:ActualReceiptSupplyChainEvent)"
                 flag="warning"
                 id="CII-SR-331">[CII-SR-331] - ActualReceiptSupplyChainEvent should not be present</assert>
		       <assert test="not(ram:AdditionalReferencedDocument)"
                 flag="warning"
                 id="CII-SR-332">[CII-SR-332] - AdditionalReferencedDocument should not be present</assert>
		       <assert test="not(ram:DespatchAdviceReferencedDocument/ram:LineID)"
                 flag="warning"
                 id="CII-SR-333">[CII-SR-333] - LineID should not be present</assert>
		       <assert test="not(ram:DespatchAdviceReferencedDocument/ram:LineID)"
                 flag="warning"
                 id="CII-SR-334">[CII-SR-334] - LineID should not be present</assert>
		       <assert test="not(ram:DeliveryNoteReferencedDocument)"
                 flag="warning"
                 id="CII-SR-335">[CII-SR-335] - DeliveryNoteReferencedDocument should not be present</assert>
		       <assert test="not(ram:ConsumptionReportReferencedDocument)"
                 flag="warning"
                 id="CII-SR-336">[CII-SR-336] - ConsumptionReportReferencedDocument should not be present</assert>
		       <assert test="not(ram:PreviousDeliverySupplyChainEvent)"
                 flag="warning"
                 id="CII-SR-337">[CII-SR-337] - PreviousDeliverySupplyChainEvent should not be present</assert>
		       <assert test="not(ram:PackingListReferencedDocument)"
                 flag="warning"
                 id="CII-SR-338">[CII-SR-338] - PackingListReferencedDocument should not be present</assert>
		
	     </rule>
	     <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement">
		       <assert test="not(ram:DuePayableAmount)" flag="warning" id="CII-SR-339">[CII-SR-339] - DuePayableAmount should not be present</assert>
		       <assert test="not(ram:CreditorReferenceTypeCode)"
                 flag="warning"
                 id="CII-SR-340">[CII-SR-340] - CreditorReferenceTypeCode should not be present</assert>
		       <assert test="not(ram:CreditorReferenceType)"
                 flag="warning"
                 id="CII-SR-341">[CII-SR-341] - CreditorReferenceType should not be present</assert>
		       <assert test="not(ram:CreditorReferenceIssuerID)"
                 flag="warning"
                 id="CII-SR-342">[CII-SR-342] - CreditorReferenceIssuerID should not be present</assert>
		
		       <assert test="not(ram:PaymentCurrencyCode)" flag="warning" id="CII-SR-344">[CII-SR-344] - PaymentCurrencyCode should not be present</assert>
		       <assert test="not(ram:InvoiceIssuerReference)"
                 flag="warning"
                 id="CII-SR-345">[CII-SR-345] - InvoiceIssuerReference should not be present</assert>
		       <assert test="not(ram:InvoiceDateTime)" flag="warning" id="CII-SR-346">[CII-SR-346] - InvoiceDateTime should not be present</assert>
		       <assert test="not(ram:NextInvoiceDateTime)" flag="warning" id="CII-SR-347">[CII-SR-347] - NextInvoiceDateTime should not be present</assert>
		       <assert test="not(ram:CreditReasonCode)" flag="warning" id="CII-SR-348">[CII-SR-348] - CreditReasonCode should not be present</assert>
		       <assert test="not(ram:CreditReason)" flag="warning" id="CII-SR-349">[CII-SR-349] - CreditReason should not be present</assert>
		       <assert test="not(ram:InvoicerTradeParty)" flag="warning" id="CII-SR-350">[CII-SR-350] - InvoicerTradeParty should not be present</assert>
		       <assert test="not(ram:InvoiceeTradeParty)" flag="warning" id="CII-SR-351">[CII-SR-351] - InvoiceeTradeParty should not be present</assert>
		
		       <assert test="not(ram:PayeeTradeParty/ram:RoleCode)"
                 flag="warning"
                 id="CII-SR-352">[CII-SR-352] - RoleCode should not be present</assert>
		       <assert test="not(ram:PayeeTradeParty/ram:Description)"
                 flag="warning"
                 id="CII-SR-353">[CII-SR-353] - Description should not be present</assert>
		       <assert test="not(ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:LegalClassificationCode)"
                 flag="warning"
                 id="CII-SR-354">[CII-SR-354] - LegalClassificationCode should not be present</assert>
		       <assert test="not(ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:Name)"
                 flag="warning"
                 id="CII-SR-355">[CII-SR-355] - Name should not be present</assert>
		       <assert test="not(ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:TradingBusinessName)"
                 flag="warning"
                 id="CII-SR-356">[CII-SR-356] - TradingBusinessName should not be present</assert>
		       <assert test="not(ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:PostalTradeAddress)"
                 flag="warning"
                 id="CII-SR-357">[CII-SR-357] - PostalTradeAddress should not be present</assert>
		       <assert test="not(ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:AuthorizedLegalRegistration)"
                 flag="warning"
                 id="CII-SR-358">[CII-SR-358] - AuthorizedLegalRegistration should not be present</assert>
		       <assert test="not(ram:PayeeTradeParty/ram:DefinedTradeContact)"
                 flag="warning"
                 id="CII-SR-359">[CII-SR-359] - DefinedTradeContact should not be present</assert>
		       <assert test="not(ram:PayeeTradeParty/ram:PostalTradeAddress)"
                 flag="warning"
                 id="CII-SR-360">[CII-SR-360] - PostalTradeAddress should not be present</assert>
		       <assert test="not(ram:PayeeTradeParty/ram:URIUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-361">[CII-SR-361] - URIUniversalCommunication should not be present</assert>
		       <assert test="not(ram:PayeeTradeParty/ram:SpecifiedTaxRegistration)"
                 flag="warning"
                 id="CII-SR-362">[CII-SR-362] - SpecifiedTaxRegistration should not be present</assert>
		       <assert test="not(ram:PayeeTradeParty/ram:EndPointURIUniversalCommunication)"
                 flag="warning"
                 id="CII-SR-363">[CII-SR-363] - EndPointURIUniversalCommunication should not be present</assert>
		       <assert test="not(ram:PayeeTradeParty/ram:LogoAssociatedSpecifiedBinaryFile)"
                 flag="warning"
                 id="CII-SR-364">[CII-SR-364] - LogoAssociatedSpecifiedBinaryFile should not be present</assert>
		
		       <assert test="not(ram:PayerTradeParty)" flag="warning" id="CII-SR-365">[CII-SR-365] - PayerTradeParty should not be present</assert>
		       <assert test="not(ram:TaxApplicableTradeCurrencyExchange)"
                 flag="warning"
                 id="CII-SR-366">[CII-SR-366] - TaxApplicableTradeCurrencyExchange should not be present</assert>
		       <assert test="not(ram:InvoiceApplicableTradeCurrencyExchange)"
                 flag="warning"
                 id="CII-SR-367">[CII-SR-367] - InvoiceApplicableTradeCurrencyExchange should not be present</assert>
		       <assert test="not(ram:PaymentApplicableTradeCurrencyExchange)"
                 flag="warning"
                 id="CII-SR-368">[CII-SR-368] - PaymentApplicableTradeCurrencyExchange should not be present</assert>
		
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:PaymentChannelCode)"
                 flag="warning"
                 id="CII-SR-369">[CII-SR-369] - PaymentChannelCode should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:GuaranteeMethodCode)"
                 flag="warning"
                 id="CII-SR-370">[CII-SR-370] - GuaranteeMethodCode should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:PaymentMethodCode)"
                 flag="warning"
                 id="CII-SR-371">[CII-SR-371] - PaymentMethodCode should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:ID)"
                 flag="warning"
                 id="CII-SR-443">[CII-SR-443] - ID should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:MicrochipIndicator)"
                 flag="warning"
                 id="CII-SR-372">[CII-SR-372] - MicrochipIndicator should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:TypeCode)"
                 flag="warning"
                 id="CII-SR-373">[CII-SR-373] - TypeCode should not be present</assert>
		
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:ExpiryDate)"
                 flag="warning"
                 id="CII-SR-375">[CII-SR-375] - ExpiryDate should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:VerificationNumeric)"
                 flag="warning"
                 id="CII-SR-376">[CII-SR-376] - VerificationNumeric should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:ValidFromDateTime)"
                 flag="warning"
                 id="CII-SR-377">[CII-SR-377] - ValidFromDateTime should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:CreditLimitAmount)"
                 flag="warning"
                 id="CII-SR-378">[CII-SR-378] - CreditLimitAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:CreditAvailableAmount)"
                 flag="warning"
                 id="CII-SR-379">[CII-SR-379] - CreditAvailableAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:InterestRatePercent)"
                 flag="warning"
                 id="CII-SR-380">[CII-SR-380] - InterestRatePercent should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:Description)"
                 flag="warning"
                 id="CII-SR-381">[CII-SR-381] - Description should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerPartyDebtorFinancialAccount/ram:AccountName)"
                 flag="warning"
                 id="CII-SR-382">[CII-SR-382] - AccountName should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerPartyDebtorFinancialAccount/ram:ProprietaryID)"
                 flag="warning"
                 id="CII-SR-444">[CII-SR-444] - ProprietaryID should not be present</assert>
		
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerSpecifiedDebtorFinancialInstitution/ram:ClearingSystemName)"
                 flag="warning"
                 id="CII-SR-384">[CII-SR-384] - ClearingSystemName should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerSpecifiedDebtorFinancialInstitution/ram:Name)"
                 flag="warning"
                 id="CII-SR-385">[CII-SR-385] - Name should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerSpecifiedDebtorFinancialInstitution/ram:LocationFinancialInstitutionAddress)"
                 flag="warning"
                 id="CII-SR-386">[CII-SR-386] - LocationFinancialInstitutionAddress should not be present</assert>
		
		
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:ID)"
                 flag="warning"
                 id="CII-SR-388">[CII-SR-388] - ID should not be present</assert>		
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:SequenceNumeric)"
                 flag="warning"
                 id="CII-SR-389">[CII-SR-389] - SequenceNumeric should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:BasisQuantity)"
                 flag="warning"
                 id="CII-SR-390">[CII-SR-390] - BasisQuantity should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:PrepaidIndicator)"
                 flag="warning"
                 id="CII-SR-391">[CII-SR-391] - PrepaidIndicator should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:UnitBasisAmount)"
                 flag="warning"
                 id="CII-SR-392">[CII-SR-392] - UnitBasisAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:TypeCode)"
                 flag="warning"
                 id="CII-SR-393">[CII-SR-393] - TypeCode should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeAllowanceCharge/ram:ActualTradeCurrencyExchange)"
                 flag="warning"
                 id="CII-SR-394">[CII-SR-394] - ActualTradeCurrencyExchange should not be present</assert>
		       <assert test="not(ram:SubtotalCalculatedTradeTax)"
                 flag="warning"
                 id="CII-SR-395">[CII-SR-395] - SubtotalCalculatedTradeTax should not be present</assert>
		       <assert test="not(ram:SpecifiedLogisticsServiceCharge)"
                 flag="warning"
                 id="CII-SR-396">[CII-SR-396] - SpecifiedLogisticsServiceCharge should not be present</assert>
		
		       <assert test="not(ram:SpecifiedTradePaymentTerms/ram:ID)"
                 flag="warning"
                 id="CII-SR-397">[CII-SR-397] - ID should not be present</assert>
		       <assert test="not(ram:SpecifiedTradePaymentTerms/ram:FromEventCode)"
                 flag="warning"
                 id="CII-SR-398">[CII-SR-398] - FromEventCode should not be present</assert>
		       <assert test="not(ram:SpecifiedTradePaymentTerms/ram:SettlementPeriodMeasure)"
                 flag="warning"
                 id="CII-SR-399">[CII-SR-399] - SettlementPeriodMeasure should not be present</assert>
		       <assert test="not(ram:SpecifiedTradePaymentTerms/ram:DueDateDateTime/udt:DateTime)"
                 flag="warning"
                 id="CII-SR-400">[CII-SR-400] - DateTime should not be present</assert>
		       <assert test="not(ram:SpecifiedTradePaymentTerms/ram:TypeCode)"
                 flag="warning"
                 id="CII-SR-401">[CII-SR-401] - TypeCode should not be present</assert>
		       <assert test="not(ram:SpecifiedTradePaymentTerms/ram:InstructionTypeCode)"
                 flag="warning"
                 id="CII-SR-402">[CII-SR-402] - InstructionTypeCode should not be present</assert>
		
		       <assert test="not(ram:SpecifiedTradePaymentTerms/ram:PartialPaymentPercent)"
                 flag="warning"
                 id="CII-SR-404">[CII-SR-404] - PartialPaymentPercent should not be present</assert>
		       <assert test="not(ram:SpecifiedTradePaymentTerms/ram:PaymentMeansID)"
                 flag="warning"
                 id="CII-SR-405">[CII-SR-405] - PaymentMeansID should not be present</assert>
		       <assert test="not(ram:SpecifiedTradePaymentTerms/ram:PartialPaymentAmount)"
                 flag="warning"
                 id="CII-SR-406">[CII-SR-406] - PartialPaymentAmount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradePaymentTerms/ram:ApplicableTradePaymentPenaltyTerms)"
                 flag="warning"
                 id="CII-SR-407">[CII-SR-407] - ApplicableTradePaymentPenaltyTerms should not be present</assert>
		       <assert test="not(ram:SpecifiedTradePaymentTerms/ram:ApplicableTradePaymentDiscountTerms)"
                 flag="warning"
                 id="CII-SR-408">[CII-SR-408] - ApplicableTradePaymentDiscountTerms should not be present</assert>
		       <assert test="not(ram:SpecifiedTradePaymentTerms/ram:PayeeTradeParty)"
                 flag="warning"
                 id="CII-SR-409">[CII-SR-409] - PayeeTradeParty should not be present</assert>

		       <assert test="not(ram:SpecifiedFinancialAdjustment)"
                 flag="warning"
                 id="CII-SR-421">[CII-SR-421] - SpecifiedFinancialAdjustment should not be present</assert>
		       <assert test="not(ram:InvoiceReferencedDocument/ram:LineID)"
                 flag="warning"
                 id="CII-SR-422">[CII-SR-422] - LineID should not be present</assert>
		       <assert test="not(ram:ProFormaInvoiceReferencedDocument)"
                 flag="warning"
                 id="CII-SR-423">[CII-SR-423] - ProFormaInvoiceReferencedDocument should not be present</assert>
		       <assert test="not(ram:LetterOfCreditReferencedDocument)"
                 flag="warning"
                 id="CII-SR-424">[CII-SR-424] - LetterOfCreditReferencedDocument should not be present</assert>
		       <assert test="not(ram:FactoringAgreementReferencedDocument)"
                 flag="warning"
                 id="CII-SR-425">[CII-SR-425] - FactoringAgreementReferencedDocument should not be present</assert>
		       <assert test="not(ram:FactoringListReferencedDocument)"
                 flag="warning"
                 id="CII-SR-426">[CII-SR-426] - FactoringListReferencedDocument should not be present</assert>
		       <assert test="not(ram:PayableSpecifiedTradeAccountingAccount)"
                 flag="warning"
                 id="CII-SR-427">[CII-SR-427] - PayableSpecifiedTradeAccountingAccount should not be present</assert>
		       <assert test="not(ram:ReceivableSpecifiedTradeAccountingAccount/ram:SetTriggerCode)"
                 flag="warning"
                 id="CII-SR-428">[CII-SR-428] - SetTriggerCode should not be present</assert>
		       <assert test="not(ram:ReceivableSpecifiedTradeAccountingAccount/ram:TypeCode)"
                 flag="warning"
                 id="CII-SR-429">[CII-SR-429] - TypeCode should not be present</assert>
		       <assert test="not(ram:ReceivableSpecifiedTradeAccountingAccount/ram:AmountTypeCode)"
                 flag="warning"
                 id="CII-SR-430">[CII-SR-430] - AmountTypeCode should not be present</assert>
		       <assert test="not(ram:ReceivableSpecifiedTradeAccountingAccount/ram:Name)"
                 flag="warning"
                 id="CII-SR-431">[CII-SR-431] - Name should not be present</assert>
		       <assert test="not(ram:ReceivableSpecifiedTradeAccountingAccount/ram:CostReferenceDimensionPattern)"
                 flag="warning"
                 id="CII-SR-432">[CII-SR-432] - CostReferenceDimensionPattern should not be present</assert>
		       <assert test="not(ram:PurchaseSpecifiedTradeAccountingAccount)"
                 flag="warning"
                 id="CII-SR-433">[CII-SR-433] - PurchaseSpecifiedTradeAccountingAccount should not be present</assert>
		       <assert test="not(ram:SalesSpecifiedTradeAccountingAccount)"
                 flag="warning"
                 id="CII-SR-434">[CII-SR-434] - SalesSpecifiedTradeAccountingAccount should not be present</assert>
		       <assert test="not(ram:SpecifiedTradeSettlementFinancialCard)"
                 flag="warning"
                 id="CII-SR-435">[CII-SR-435] - SpecifiedTradeSettlementFinancialCard should not be present</assert>
		       <assert test="not(ram:SpecifiedAdvancePayment)"
                 flag="warning"
                 id="CII-SR-436">[CII-SR-436] - SpecifiedAdvancePayment should not be present</assert>
		       <assert test="not(ram:UltimatePayeeTradeParty)"
                 flag="warning"
                 id="CII-SR-437">[CII-SR-437] - UltimatePayeeTradeParty should not be present</assert>
		
	     </rule>
	     <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation">
		
		       <assert test="not(ram:InformationAmount)" flag="warning" id="CII-SR-411">[CII-SR-411] - InformationAmount should not be present</assert>
		       <assert test="not(ram:TotalDiscountAmount)" flag="warning" id="CII-SR-412">[CII-SR-412] - TotalDiscountAmount should not be present</assert>
		       <assert test="not(ram:TotalAllowanceChargeAmount)"
                 flag="warning"
                 id="CII-SR-413">[CII-SR-413] - TotalAllowanceChargeAmount should not be present</assert>
		       <assert test="not(ram:RetailValueExcludingTaxInformationAmount)"
                 flag="warning"
                 id="CII-SR-414">[CII-SR-414] - RetailValueExcludingTaxInformationAmount should not be present</assert>
		       <assert test="not(ram:TotalDepositFeeInformationAmount)"
                 flag="warning"
                 id="CII-SR-415">[CII-SR-415] - TotalDepositFeeInformationAmount should not be present</assert>
		       <assert test="not(ram:ProductValueExcludingTobaccoTaxInformationAmount)"
                 flag="warning"
                 id="CII-SR-416">[CII-SR-416] - ProductValueExcludingTobaccoTaxInformationAmount should not be present</assert>
		       <assert test="not(ram:TotalRetailValueInformationAmount)"
                 flag="warning"
                 id="CII-SR-417">[CII-SR-417] - TotalRetailValueInformationAmount should not be present</assert>
		       <assert test="not(ram:GrossLineTotalAmount)" flag="warning" id="CII-SR-418">[CII-SR-418] - GrossLineTotalAmount should not be present</assert>
		       <assert test="not(ram:NetLineTotalAmount)" flag="warning" id="CII-SR-419">[CII-SR-419] - NetLineTotalAmount should not be present</assert>
		       <assert test="not(ram:NetIncludingTaxesLineTotalAmount)"
                 flag="warning"
                 id="CII-SR-420">[CII-SR-420] - NetIncludingTaxesLineTotalAmount should not be present</assert>
	     </rule>
      <rule context="/rsm:CrossIndustryInvoice">
        <assert test="not(@languageID)" flag="fatal" id="CII-DT-013">[CII-DT-013] - languageID should not be present</assert>
        <assert test="not(@languageLocaleID)" flag="fatal" id="CII-DT-014">[CII-DT-014] - languageLocaleID should not be present</assert>

        <assert test="not(ram:ValuationBreakdownStatement)"
                 flag="warning"
                 id="CII-SR-438">[CII-SR-438] - ValuationBreakdownStatement should not be present</assert>	
      </rule>
      <rule context="//*[ends-with(name(), 'DocumentContextParameter')]">
        <assert test="not(ram:Value)" flag="warning" id="CII-SR-04">[CII-SR-004] - Value should not be present</assert>
        <assert test="not(ram:SpecifiedDocumentVersion)"
                 flag="warning"
                 id="CII-SR-05">[CII-SR-005] - SpecifiedDocumentVersion should not be present</assert>
      </rule>
      <rule context="//ram:*[ends-with(name(), 'ID')]">
        <assert test="not(@schemeName)" flag="fatal" id="CII-DT-001">[CII-DT-001] - schemeName should not be present</assert>
        <assert test="not(@schemeAgencyName)" flag="fatal" id="CII-DT-002">[CII-DT-002] - schemeAgencyName should not be present</assert>
        <assert test="not(@schemeDataURI)" flag="fatal" id="CII-DT-003">[CII-DT-003] - schemeDataURI should not be present</assert>
        <assert test="not(@schemeURI)" flag="fatal" id="CII-DT-004">[CII-DT-004] - schemeURI should not be present</assert>
    	    <assert test="not(@schemeVersionID)" flag="fatal" id="CII-DT-097">[CII-DT-097] - schemeVersionID should not be present</assert>
      </rule>
	     <rule context="/rsm:CrossIndustryInvoice/*[self::rsm:ExchangedDocumentContext/ram:GuidelineSpecifiedDocumentContextParameter/ram:ID or         self::rsm:ExchangedDocument/ram:ID or self::rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:LineID or         self::rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:SellerAssignedID]">
        <assert test="not(@schemeID)" flag="fatal" id="CII-DT-005">[CII-DT-005] - schemeID should not be present</assert>
        <assert test="not(@schemeAgencyID)" flag="fatal" id="CII-DT-006">[CII-DT-006] - schemeAgencyID should not be present</assert>
        <assert test="not(@schemeVersionID)" flag="fatal" id="CII-DT-007">[CII-DT-007] - schemeVersionID should not be present</assert>
      </rule>
      <rule context="//ram:TypeCode">
        <assert test="not(@name)" flag="fatal" id="CII-DT-008">[CII-DT-008] - name should not be present</assert>
        <assert test="not(@listURI)" flag="fatal" id="CII-DT-009">[CII-DT-009] - listURI should not be present</assert>
      </rule>
	     <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:TypeCode">
        <assert test="not(@listID)" flag="fatal" id="CII-DT-010">[CII-DT-010] - listID should not be present</assert>
        <assert test="not(@listAgencyID)" flag="fatal" id="CII-DT-011">[CII-DT-011] - listAgencyID should not be present</assert>
        <assert test="not(@listVersionID)" flag="fatal" id="CII-DT-012">[CII-DT-012] - listVersionID should not be present</assert>
      </rule>
      <rule context="//ram:*[ends-with(name(), 'ReferencedDocument')]">
        <assert test="not(ram:URIID) or (name()='ram:AdditionalReferencedDocument' and ram:TypeCode='916') "
                 flag="fatal"
                 id="CII-DT-015">[CII-DT-015] - URIID should not be present</assert>
        <assert test="not(ram:StatusCode)" flag="fatal" id="CII-DT-016">[CII-DT-016] - StatusCode should not be present</assert>
        <assert test="not(ram:CopyIndicator)" flag="fatal" id="CII-DT-017">[CII-DT-017] - CopyIndicator should not be present</assert>
        <assert test="not(ram:TypeCode) or (name()='ram:AdditionalReferencedDocument') and (ram:TypeCode='50' or ram:TypeCode='130' or ram:TypeCode='916')"
                 flag="fatal"
                 id="CII-DT-018">[CII-DT-018] - TypeCode should not be present</assert>
        <assert test="not(ram:GlobalID)" flag="fatal" id="CII-DT-019">[CII-DT-019] - GlobalID should not be present</assert>
        <assert test="not(ram:RevisionID)" flag="fatal" id="CII-DT-020">[CII-DT-020] - RevisionID should not be present</assert>
        <assert test="not(ram:Name) or (name()='ram:AdditionalReferencedDocument' and ram:TypeCode='916')"
                 flag="fatal"
                 id="CII-DT-021">[CII-DT-021] - Name should not be present</assert>
        <assert test="not(ram:AttachmentBinaryObject) or (name()='ram:AdditionalReferencedDocument' and ram:TypeCode='916')"
                 flag="fatal"
                 id="CII-DT-022">[CII-DT-022] - AttachmentBinaryObject should not be present</assert>
        <assert test="not(ram:Information)" flag="fatal" id="CII-DT-023">[CII-DT-023] - Information should not be present</assert>
        <assert test="not(ram:ReferenceTypeCode) or (name()='ram:AdditionalReferencedDocument' and ram:TypeCode='130')"
                 flag="fatal"
                 id="CII-DT-024">[CII-DT-024] - ReferenceTypeCode should not be present</assert>
        <assert test="not(ram:SectionName)" flag="fatal" id="CII-DT-025">[CII-DT-025] - SectionName should not be present</assert>
        <assert test="not(ram:PreviousRevisionID)" flag="fatal" id="CII-DT-026">[CII-DT-026] - PreviousRevisionID should not be present</assert>
        <assert test="not(ram:FormattedIssueDateTime) or name()='ram:InvoiceReferencedDocument'"
                 flag="fatal"
                 id="CII-DT-027">[CII-DT-027] - FormattedIssueDateTime should not be present</assert>
        <assert test="not(ram:EffectiveSpecifiedPeriod)"
                 flag="fatal"
                 id="CII-DT-028">[CII-DT-028] - EffectiveSpecifiedPeriod should not be present</assert>
        <assert test="not(ram:IssuerTradeParty)" flag="fatal" id="CII-DT-029">[CII-DT-029] - IssuerTradeParty should not be present</assert>
        <assert test="not(ram:AttachedSpecifiedBinaryFile)"
                 flag="fatal"
                 id="CII-DT-030">[CII-DT-030] - AttachedSpecifiedBinaryFile should not be present</assert>
      </rule>
      <rule context="//ram:*[ends-with(name(), 'Amount') and not (self::ram:TaxTotalAmount)]">
        <assert test="not(@currencyID)" flag="fatal" id="CII-DT-031">[CII-DT-031] - currencyID should not be present</assert>
        <assert test="not(@currencyCodeListVersionID)" flag="fatal" id="CII-DT-032">[CII-DT-032] - currencyCodeListVersionID should not be present</assert>
	     </rule>
	     <rule context="//ram:*[ends-with(name(), 'Quantity')]">
        <assert test="not(@unitCode) or (/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:BilledQuantity/@unitCode)"
                 flag="fatal"
                 id="CII-DT-033">[CII-DT-033] - unitCode should not be present</assert>
        <assert test="not(@unitCodeListID)" flag="fatal" id="CII-DT-034">[CII-DT-034] - unitCodeListID should not be present</assert>
        <assert test="not(@unitCodeListAgencyID)" flag="fatal" id="CII-DT-035">[CII-DT-035] - unitCodeListAgencyID should not be present</assert>
        <assert test="not(@unitCodeListAgencyName)" flag="fatal" id="CII-DT-036">[CII-DT-036] - unitCodeListAgencyName should not be present</assert>
	     </rule>
	     <rule context="//ram:*[ends-with(name(), 'TradeTax')]">
        <assert test="not(ram:TypeCode) or (ram:TypeCode = 'VAT')"
                 flag="fatal"
                 id="CII-DT-037">[CII-DT-037] - TypeCode shall be 'VAT'</assert>
        <assert test="not(ram:CalculatedRate)" flag="warning" id="CII-DT-038">[CII-DT-038] - CalculatedRate should not be present</assert>
        <assert test="not(ram:CalculationSequenceNumeric)"
                 flag="warning"
                 id="CII-DT-039">[CII-DT-039] - CalculationSequenceNumeric should not be present</assert>
        <assert test="not(ram:BasisQuantity)" flag="warning" id="CII-DT-040">[CII-DT-040] - BasisQuantity should not be present</assert>
        <assert test="not(ram:BasisAmount) or (ancestor::ram:ApplicableHeaderTradeSettlement)"
                 flag="warning"
                 id="CII-DT-041">[CII-DT-041] - BasisAmount should not be present</assert>
        <assert test="not(ram:UnitBasisAmount)" flag="warning" id="CII-DT-042">[CII-DT-042] - UnitBasisAmount should not be present</assert>
        <assert test="not(ram:LineTotalBasisAmount)" flag="warning" id="CII-DT-043">[CII-DT-043] - LineTotalBasisAmount should not be present</assert>
        <assert test="not(ram:AllowanceChargeBasisAmount)"
                 flag="warning"
                 id="CII-DT-044">[CII-DT-044] - AllowanceChargeBasisAmount should not be present</assert>
        <assert test="not(ram:CategoryCode/@listID)" flag="warning" id="CII-DT-045">[CII-DT-045] - @listID should not be present</assert>
        <assert test="not(ram:CategoryCode/@listAgencyID)"
                 flag="warning"
                 id="CII-DT-046">[CII-DT-046] - @listAgencyID should not be present</assert>
        <assert test="not(ram:CategoryCode/@listVersionID)"
                 flag="warning"
                 id="CII-DT-047">[CII-DT-047] - @listVersionID should not be present</assert>
        <assert test="not(ram:CategoryCode/@listURI)"
                 flag="warning"
                 id="CII-DT-048">[CII-DT-048] - @listURI should not be present</assert>
        <assert test="not(ram:CurrencyCode)" flag="warning" id="CII-DT-049">[CII-DT-049] - CurrencyCode should not be present</assert>
        <assert test="not(ram:Jurisdiction)" flag="warning" id="CII-DT-050">[CII-DT-050] - Jurisdiction should not be present</assert>
        <assert test="not(ram:CustomsDutyIndicator)" flag="warning" id="CII-DT-051">[CII-DT-051] - CustomsDutyIndicator should not be present</assert>
        <assert test="not(ram:ExemptionReasonCode) or name()='ram:ApplicableTradeTax'"
                 flag="warning"
                 id="CII-DT-052">[CII-DT-052] - ExemptionReasonCode should not be present</assert>
		       <assert test="not(ram:ExemptionReason) or name()='ram:ApplicableTradeTax'"
                 flag="warning"
                 id="CII-DT-098">[CII-DT-098] - ExemptionReason should not be present</assert>
        <assert test="not(ram:TaxBasisAllowanceRate)"
                 flag="warning"
                 id="CII-DT-053">[CII-DT-053] - TaxBasisAllowanceRate should not be present</assert>
        <assert test="not(ram:TaxPointDate)  or (ancestor::ram:ApplicableHeaderTradeSettlement)"
                 flag="warning"
                 id="CII-DT-054">[CII-DT-054] - TaxPointDate should not be present</assert>
        <assert test="not(ram:Type)" flag="warning" id="CII-DT-055">[CII-DT-055] - Type should not be present</assert>
        <assert test="not(ram:InformationAmount)" flag="warning" id="CII-DT-056">[CII-DT-056] - InformationAmount should not be present</assert>
        <assert test="not(ram:CategoryName)" flag="warning" id="CII-DT-057">[CII-DT-057] - CategoryName should not be present</assert>
        <assert test="not(ram:DueDateTypeCode) or (ancestor::ram:ApplicableHeaderTradeSettlement)"
                 flag="warning"
                 id="CII-DT-058">[CII-DT-058] - DueDateTypeCode should not be present</assert>
        <assert test="not(ram:RateApplicablePercent/@format)"
                 flag="warning"
                 id="CII-DT-059">[CII-DT-059] - @format should not be present</assert>
        <assert test="not(ram:SpecifiedTradeAccountingAccount)"
                 flag="warning"
                 id="CII-DT-060">[CII-DT-060] - SpecifiedTradeAccountingAccount should not be present</assert>
        <assert test="not(ram:ServiceSupplyTradeCountry)"
                 flag="warning"
                 id="CII-DT-061">[CII-DT-061] - ServiceSupplyTradeCountry should not be present</assert>
        <assert test="not(ram:BuyerRepayableTaxSpecifiedTradeAccountingAccount)"
                 flag="warning"
                 id="CII-DT-062">[CII-DT-062] - BuyerRepayableTaxSpecifiedTradeAccountingAccount should not be present</assert>
        <assert test="not(ram:SellerPayableTaxSpecifiedTradeAccountingAccount)"
                 flag="warning"
                 id="CII-DT-063">[CII-DT-063] - SellerPayableTaxSpecifiedTradeAccountingAccount should not be present</assert>
        <assert test="not(ram:SellerRefundableTaxSpecifiedTradeAccountingAccount)"
                 flag="warning"
                 id="CII-DT-064">[CII-DT-064] - SellerRefundableTaxSpecifiedTradeAccountingAccount should not be present</assert>
        <assert test="not(ram:BuyerDeductibleTaxSpecifiedTradeAccountingAccount)"
                 flag="warning"
                 id="CII-DT-065">[CII-DT-065] - BuyerDeductibleTaxSpecifiedTradeAccountingAccount should not be present</assert>
        <assert test="not(ram:BuyerNonDeductibleTaxSpecifiedTradeAccountingAccount)"
                 flag="warning"
                 id="CII-DT-066">[CII-DT-066] - BuyerNonDeductibleTaxSpecifiedTradeAccountingAccount should not be present</assert>   
        <assert test="not(ram:PlaceApplicableTradeLocation)"
                 flag="warning"
                 id="CII-DT-067">[CII-DT-067] - PlaceApplicableTradeLocation should not be present</assert>        
	     </rule>
	     <rule context="//ram:BillingSpecifiedPeriod">
        <assert test="not(ram:StartDateTime/udt:DateTime)"
                 flag="fatal"
                 id="CII-DT-068">[CII-DT-068] - DateTime shall not be used.</assert>
        <assert test="not(ram:DurationMeasure)" flag="fatal" id="CII-DT-069">[CII-DT-069] - DurationMeasure shall not be used.</assert>
        <assert test="not(ram:InclusiveIndicator)" flag="fatal" id="CII-DT-070">[CII-DT-070] - InclusiveIndicator shall not be used.</assert>
        <assert test="not(ram:Description)" flag="fatal" id="CII-DT-071">[CII-DT-071] - Description shall not be used.</assert>
        <assert test="not(ram:EndDateTime/udt:DateTime)"
                 flag="fatal"
                 id="CII-DT-072">[CII-DT-072] - DateTime shall not be used.</assert>
        <assert test="not(ram:CompleteDateTime)" flag="fatal" id="CII-DT-073">[CII-DT-073] - CompleteDateTime shall not be used.</assert>
        <assert test="not(ram:OpenIndicator)" flag="fatal" id="CII-DT-074">[CII-DT-074] - OpenIndicator shall not be used.</assert>
        <assert test="not(ram:SeasonCode)" flag="fatal" id="CII-DT-075">[CII-DT-075] - SeasonCode shall not be used.</assert>
        <assert test="not(ram:ID)" flag="fatal" id="CII-DT-076">[CII-DT-076] - ID shall not be used.</assert>
        <assert test="not(ram:Name)" flag="fatal" id="CII-DT-077">[CII-DT-077] - Name shall not be used.</assert>
        <assert test="not(ram:SequenceNumeric)" flag="fatal" id="CII-DT-078">[CII-DT-078] - SequenceNumeric shall not be used.</assert>
        <assert test="not(ram:StartDateFlexibilityCode)"
                 flag="fatal"
                 id="CII-DT-079">[CII-DT-079] - StartDateFlexibilityCode shall not be used.</assert>
        <assert test="not(ram:ContinuousIndicator)" flag="fatal" id="CII-DT-080">[CII-DT-080] - ContinuousIndicator shall not be used.</assert>
        <assert test="not(ram:PurposeCode)" flag="fatal" id="CII-DT-081">[CII-DT-081] - PurposeCode shall not be used.</assert>
      </rule>
      <rule context="//ram:PostalTradeAddress">
        <assert test="not(ram:ID)" flag="fatal" id="CII-DT-082">[CII-DT-082] - ID shall not be used.</assert>
        <assert test="not(ram:PostOfficeBox)" flag="fatal" id="CII-DT-083">[CII-DT-083] - PostOfficeBox shall not be used.</assert>
        <assert test="not(ram:BuildingName)" flag="fatal" id="CII-DT-084">[CII-DT-084] - BuildingName shall not be used.</assert>
        <assert test="not(ram:LineFour)" flag="fatal" id="CII-DT-086">[CII-DT-086] - LineFour shall not be used.</assert>
        <assert test="not(ram:LineFive)" flag="fatal" id="CII-DT-087">[CII-DT-087] - LineFive shall not be used.</assert>
        <assert test="not(ram:StreetName)" flag="fatal" id="CII-DT-088">[CII-DT-088] - StreetName shall not be used.</assert>
        <assert test="not(ram:CitySubDivisionName)" flag="fatal" id="CII-DT-089">[CII-DT-089] - CitySubDivisionName shall not be used.</assert>
        <assert test="not(ram:CountryName)" flag="fatal" id="CII-DT-090">[CII-DT-090] - CountryName shall not be used.</assert>
        <assert test="not(ram:CountrySubDivisionID)" flag="fatal" id="CII-DT-091">[CII-DT-091] - CountrySubDivisionID shall not be used.</assert>
        <assert test="not(ram:AttentionOf)" flag="fatal" id="CII-DT-092">[CII-DT-092] - AttentionOf shall not be used.</assert>
        <assert test="not(ram:CareOf)" flag="fatal" id="CII-DT-093">[CII-DT-093] - CareOf shall not be used.</assert>
        <assert test="not(ram:BuildingNumber)" flag="fatal" id="CII-DT-094">[CII-DT-094] - BuildingNumber shall not be used.</assert>
        <assert test="not(ram:DepartmentName)" flag="fatal" id="CII-DT-095">[CII-DT-095] - DepartmentName shall not be used.</assert>
        <assert test="not(ram:AdditionalStreetName)" flag="fatal" id="CII-DT-096">[CII-DT-096] - AdditionalStreetName shall not be used.</assert>
      </rule>
   </pattern>
  
  
  <pattern id="EN16931-Codes">
      <rule context="rsm:ExchangedDocument/ram:TypeCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' 80 81 82 83 84 130 202 203 204 211 261 262 295 296 308 325 326 380 381 383 384 385 386 387 388 389 390 393 394 395 396 420 456 457 458 527 532 575 623 633 751 780 935 ', concat(' ', normalize-space(.), ' '))))"
                 flag="warning"
                 id="BR-CL-01">[BR-CL-01]-The document type code MUST be coded by the invoice and credit note related code lists of UNTDID 1001.</assert>
      </rule>

      <rule context="@currencyID" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AED AFN ALL AMD ANG AOA ARS AUD AWG AZN BAM BBD BDT BGN BHD BIF BMD BND BOB BOV BRL BSD BTN BWP BYR BZD CAD CDF CHE CHF CHW CLF CLP CNY COP COU CRC CUC CUP CVE CZK DJF DKK DOP DZD EGP ERN ETB EUR FJD FKP GBP GEL GHS GIP GMD GNF GTQ GYD HKD HNL HRK HTG HUF IDR ILS INR IQD IRR ISK JMD JOD JPY KES KGS KHR KMF KPW KRW KWD KYD KZT LAK LBP LKR LRD LSL LYD MAD MDL MGA MKD MMK MNT MOP MRO MUR MVR MWK MXN MXV MYR MZN NAD NGN NIO NOK NPR NZD OMR PAB PEN PGK PHP PKR PLN PYG QAR RON RSD RUB RWF SAR SBD SCR SDG SEK SGD SHP SLL SOS SRD SSP STD SVC SYP SZL THB TJS TMT TND TOP TRY TTD TWD TZS UAH UGX USD USN UYI UYU UZS VEF VND VUV WST XAF XAG XAU XBA XBB XBC XBD XCD XDR XOF XPD XPF XPT XSU XTS XUA XXX YER ZAR ZMW ZWL ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-03">[BR-CL-03]-currencyID MUST be coded using ISO code list 4217 alpha-3</assert>
      </rule>

      <rule context="ram:InvoiceCurrencyCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AED AFN ALL AMD ANG AOA ARS AUD AWG AZN BAM BBD BDT BGN BHD BIF BMD BND BOB BOV BRL BSD BTN BWP BYR BZD CAD CDF CHE CHF CHW CLF CLP CNY COP COU CRC CUC CUP CVE CZK DJF DKK DOP DZD EGP ERN ETB EUR FJD FKP GBP GEL GHS GIP GMD GNF GTQ GYD HKD HNL HRK HTG HUF IDR ILS INR IQD IRR ISK JMD JOD JPY KES KGS KHR KMF KPW KRW KWD KYD KZT LAK LBP LKR LRD LSL LYD MAD MDL MGA MKD MMK MNT MOP MRO MUR MVR MWK MXN MXV MYR MZN NAD NGN NIO NOK NPR NZD OMR PAB PEN PGK PHP PKR PLN PYG QAR RON RSD RUB RWF SAR SBD SCR SDG SEK SGD SHP SLL SOS SRD SSP STD SVC SYP SZL THB TJS TMT TND TOP TRY TTD TWD TZS UAH UGX USD USN UYI UYU UZS VEF VND VUV WST XAF XAG XAU XBA XBB XBC XBD XCD XDR XOF XPD XPF XPT XSU XTS XUA XXX YER ZAR ZMW ZWL ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-04">[BR-CL-04]-Invoice currency code MUST be coded using ISO code list 4217 alpha-3</assert>
      </rule>

      <rule context="ram:TaxCurrencyCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AED AFN ALL AMD ANG AOA ARS AUD AWG AZN BAM BBD BDT BGN BHD BIF BMD BND BOB BOV BRL BSD BTN BWP BYR BZD CAD CDF CHE CHF CHW CLF CLP CNY COP COU CRC CUC CUP CVE CZK DJF DKK DOP DZD EGP ERN ETB EUR FJD FKP GBP GEL GHS GIP GMD GNF GTQ GYD HKD HNL HRK HTG HUF IDR ILS INR IQD IRR ISK JMD JOD JPY KES KGS KHR KMF KPW KRW KWD KYD KZT LAK LBP LKR LRD LSL LYD MAD MDL MGA MKD MMK MNT MOP MRO MUR MVR MWK MXN MXV MYR MZN NAD NGN NIO NOK NPR NZD OMR PAB PEN PGK PHP PKR PLN PYG QAR RON RSD RUB RWF SAR SBD SCR SDG SEK SGD SHP SLL SOS SRD SSP STD SVC SYP SZL THB TJS TMT TND TOP TRY TTD TWD TZS UAH UGX USD USN UYI UYU UZS VEF VND VUV WST XAF XAG XAU XBA XBB XBC XBD XCD XDR XOF XPD XPF XPT XSU XTS XUA XXX YER ZAR ZMW ZWL ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-05">[BR-CL-05]-Tax currency code MUST be coded using ISO code list 4217 alpha-3</assert>
      </rule>

      <rule context="ram:DueDateTypeCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' 5 29 72 ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-06">[BR-CL-06]-Value added tax point date code MUST be coded using a restriction of UNTDID 2475.</assert>
      </rule>

      <rule context="ram:ReferenceTypeCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AAA AAB AAC AAD AAE AAF AAG AAH AAI AAJ AAK AAL AAM AAN AAO AAP AAQ AAR AAS AAT AAU AAV AAW AAX AAY AAZ ABA ABB ABC ABD ABE ABF ABG ABH ABI ABJ ABK ABL ABM ABN ABO ABP ABQ ABR ABS ABT ABU ABV ABW ABX ABY ABZ AC ACA ACB ACC ACD ACE ACF ACG ACH ACI ACJ ACK ACL ACN ACO ACP ACQ ACR ACT ACU ACV ACW ACX ACY ACZ ADA ADB ADC ADD ADE ADF ADG ADI ADJ ADK ADL ADM ADN ADO ADP ADQ ADT ADU ADV ADW ADX ADY ADZ AE AEA AEB AEC AED AEE AEF AEG AEH AEI AEJ AEK AEL AEM AEN AEO AEP AEQ AER AES AET AEU AEV AEW AEX AEY AEZ AF AFA AFB AFC AFD AFE AFF AFG AFH AFI AFJ AFK AFL AFM AFN AFO AFP AFQ AFR AFS AFT AFU AFV AFW AFX AFY AFZ AGA AGB AGC AGD AGE AGF AGG AGH AGI AGJ AGK AGL AGM AGN AGO AGP AGQ AGR AGS AGT AGU AGV AGW AGX AGY AGZ AHA AHB AHC AHD AHE AHF AHG AHH AHI AHJ AHK AHL AHM AHN AHO AHP AHQ AHR AHS AHT AHU AHV AHX AHY AHZ AIA AIB AIC AID AIE AIF AIG AIH AII AIJ AIK AIL AIM AIN AIO AIP AIQ AIR AIS AIT AIU AIV AIW AIX AIY AIZ AJA AJB AJC AJD AJE AJF AJG AJH AJI AJJ AJK AJL AJM AJN AJO AJP AJQ AJR AJS AJT AJU AJV AJW AJX AJY AJZ AKA AKB AKC AKD AKE AKF AKG AKH AKI AKJ AKK AKL AKM AKN AKO AKP AKQ AKR AKS AKT AKU AKV AKW AKX AKY AKZ ALA ALB ALC ALD ALE ALF ALG ALH ALI ALJ ALK ALL ALM ALN ALO ALP ALQ ALR ALS ALT ALU ALV ALW ALX ALY ALZ AMA AMB AMC AMD AME AMF AMG AMH AMI AMJ AMK AML AMM AMN AMO AMP AMQ AMR AMS AMT AMU AMV AMW AMX AMY AMZ ANA ANB ANC AND ANE ANF ANG ANH ANI ANJ ANK ANL ANM ANN ANO ANP ANQ ANR ANS ANT ANU ANV ANW ANX ANY AOA AOD AOE AOF AOG AOH AOI AOJ AOK AOL AOM AON AOO AOP AOQ AOR AOS AOT AOU AOV AOW AOX AOY AOZ AP APA APB APC APD APE APF APG APH API APJ APK APL APM APN APO APP APQ APR APS APT APU APV APW APX APY APZ AQA AQB AQC AQD AQE AQF AQG AQH AQI AQJ AQK AQL AQM AQN AQO AQP AQQ AQR AQS AQT AQU AQV AQW AQX AQY AQZ ARA ARB ARC ARD ARE ARF ARG ARH ARI ARJ ARK ARL ARM ARN ARO ARP ARQ ARR ARS ART ARU ARV ARW ARX ARY ARZ ASA ASB ASC ASD ASE ASF ASG ASH ASI ASJ ASK ASL ASM ASN ASO ASP ASQ ASR ASS AST ASU ASV ASW ASX ASY ASZ ATA ATB ATC ATD ATE ATF ATG ATH ATI ATJ ATK ATL ATM ATN ATO ATP ATQ ATR ATS ATT ATU ATV ATW ATX ATY ATZ AU AUA AUB AUC AUD AUE AUF AUG AUH AUI AUJ AUK AUL AUM AUN AUO AUP AUQ AUR AUS AUT AUU AUV AUW AUX AUY AUZ AV AVA AVB AVC AVD AVE AVF AVG AVH AVI AVJ AVK AVL AVM AVN AVO AVP AVQ AVR AVS AVT AVU AVV AVW AVX AVY AVZ AWA AWB AWC AWD AWE AWF AWG AWH AWI AWJ AWK AWL AWM AWN AWO AWP AWQ AWR AWS AWT AWU AWV AWW AWX AWY AWZ AXA AXB AXC AXD AXE AXF AXG AXH AXI AXJ AXK AXL AXM AXN AXO AXP AXQ AXR BA BC BD BE BH BM BN BO BR BT BW CAS CAT CAU CAV CAW CAX CAY CAZ CBA CBB CD CEC CED CFE CFF CFO CG CH CK CKN CM CMR CN CNO COF CP CR CRN CS CST CT CU CV CW CZ DA DAN DB DI DL DM DQ DR EA EB ED EE EI EN EQ ER ERN ET EX FC FF FI FLW FN FO FS FT FV FX GA GC GD GDN GN HS HWB IA IB ICA ICE ICO II IL INB INN INO IP IS IT IV JB JE LA LAN LAR LB LC LI LO LRC LS MA MB MF MG MH MR MRN MS MSS MWB NA NF OH OI ON OP OR PB PC PD PE PF PI PK PL POR PP PQ PR PS PW PY RA RC RCN RE REN RF RR RT SA SB SD SE SEA SF SH SI SM SN SP SQ SRN SS STA SW SZ TB TCR TE TF TI TIN TL TN TP UAR UC UCN UN UO URI VA VC VGR VM VN VON VOR VP VR VS VT VV WE WM WN WR WS WY XA XC XP ZZZ ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-07">[BR-CL-07]-Object identifier identification scheme identifier MUST be coded using a restriction of UNTDID 1153.</assert>
      </rule>

      <rule context="ram:SubjectCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AAA AAB AAC AAD AAE AAF AAG AAI AAJ AAK AAL AAM AAN AAO AAP AAQ AAR AAS AAT AAU AAV AAW AAX AAY AAZ ABA ABB ABC ABD ABE ABF ABG ABH ABI ABJ ABK ABL ABM ABN ABO ABP ABQ ABR ABS ABT ABU ABV ABW ABX ABZ ACA ACB ACC ACD ACE ACF ACG ACH ACI ACJ ACK ACL ACM ACN ACO ACP ACQ ACR ACS ACT ACU ACV ACW ACX ACY ACZ ADA ADB ADC ADD ADE ADF ADG ADH ADI ADJ ADK ADL ADM ADN ADO ADP ADQ ADR ADS ADT ADU ADV ADW ADX ADY ADZ AEA AEB AEC AED AEE AEF AEG AEH AEI AEJ AEK AEL AEM AEN AEO AEP AEQ AER AES AET AEU AEV AEW AEX AEY AEZ AFA AFB AFC AFD AFE AFF AFG AFH AFI AFJ AFK AFL AFM AFN AFO AFP AFQ AFR AFS AFT AFU AFV AFW AFX AFY AFZ AGA AGB AGC AGD AGE AGF AGG AGH AGI AGJ AGK AGL AGM AGN AGO AGP AGQ AGR AGS AGT AGU AGV AGW AGX AGY AGZ AHA AHB AHC AHD AHE AHF AHG AHH AHI AHJ AHK AHL AHM AHN AHO AHP AHQ AHR AHS AHT AHU AHV AHW AHX AHY AHZ AIA AIB AIC AID AIE AIF AIG AIH AII AIJ AIK AIL AIM AIN AIO AIP AIQ AIR AIS AIT AIU AIV AIW AIX AIY AIZ AJA AJB ALC ALD ALE ALF ALG ALH ALI ALJ ALK ALL ALM ALN ALO ALP ALQ ARR ARS AUT AUU AUV AUW AUX AUY AUZ AVA AVB AVC AVD AVE AVF BAG BAH BAI BAJ BAK BAL BAM BAN BAO BAP BAQ BLC BLD BLE BLF BLG BLH BLI BLJ BLK BLL BLM BLN BLO BLP BLQ BLR BLS BLT BLU BLV BLW BLX BLY BLZ BMA BMB BMC BMD BME CCI CEX CHG CIP CLP CLR COI CUR CUS DAR DCL DEL DIN DOC DUT EUR FBC GBL GEN GS7 HAN HAZ ICN IIN IMI IND INS INV IRP ITR ITS LAN LIN LOI MCO MDH MKS ORI OSI PAC PAI PAY PKG PKT PMD PMT PRD PRF PRI PUR QIN QQD QUT RAH REG RET REV RQR SAF SIC SIN SLR SPA SPG SPH SPP SPT SRN SSR SUR TCA TDT TRA TRR TXD WHI ZZZ ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-08">[BR-CL-08]-Subject Code MUST be coded using a restriction of UNTDID 4451.</assert>
      </rule>

          <!-- 2018-11-13 - Added newest ICD values manually -->
      <rule context="//ram:GlobalID/@schemeID[not(ancestor::ram:SpecifiedTradeProduct)]"
            flag="fatal">
              <assert test="((not(contains(normalize-space(.), ' ')) and contains(' 0001 0002 0003 0004 0005 0006 0007 0008 0009 0010 0011 0012 0013 0014 0015 0016 0017 0018 0019 0020 0021 0022 0023 0024 0025 0026 0027 0028 0029 0030 0031 0032 0033 0034 0035 0036 0037 0038 0039 0040 0041 0042 0043 0044 0045 0046 0047 0048 0049 0050 0051 0052 0053 0054 0055 0056 0057 0058 0059 0060 0061 0062 0063 0064 0065 0066 0067 0068 0069 0070 0071 0072 0073 0074 0075 0076 0077 0078 0079 0080 0081 0082 0083 0084 0085 0086 0087 0088 0089 0090 0091 0092 0093 0094 0095 0096 0097 0098 0099 0100 0101 0102 0103 0104 0105 0106 0107 0108 0109 0110 0111 0112 0113 0114 0115 0116 0117 0118 0119 0120 0121 0122 0123 0124 0125 0126 0127 0128 0129 0130 0131 0132 0133 0134 0135 0136 0137 0138 0139 0140 0141 0142 0143 0144 0145 0146 0147 0148 0149 0150 0151 0152 0153 0154 0155 0156 0157 0158 0159 0160 0161 0162 0163 0164 0165 0166 0167 0168 0169 0170 0171 0172 0173 0174 0175 0176 0177 0178 0179 0180 0183 0184 0185 0186 0187 0188 0189 0190 0191 0192 0193 0194 0195 0196', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-10">[BR-CL-10]-Any identifier identification scheme identifier MUST be coded using one of the ISO 6523 ICD list.</assert>
      </rule>

          <!-- 2018-11-13 - Added newest ICD values manually -->
      <rule context="ram:ID/@schemeID[not(ancestor::ram:SpecifiedTaxRegistration)]"
            flag="fatal">
              <assert test="((not(contains(normalize-space(.), ' ')) and contains(' 0001 0002 0003 0004 0005 0006 0007 0008 0009 0010 0011 0012 0013 0014 0015 0016 0017 0018 0019 0020 0021 0022 0023 0024 0025 0026 0027 0028 0029 0030 0031 0032 0033 0034 0035 0036 0037 0038 0039 0040 0041 0042 0043 0044 0045 0046 0047 0048 0049 0050 0051 0052 0053 0054 0055 0056 0057 0058 0059 0060 0061 0062 0063 0064 0065 0066 0067 0068 0069 0070 0071 0072 0073 0074 0075 0076 0077 0078 0079 0080 0081 0082 0083 0084 0085 0086 0087 0088 0089 0090 0091 0092 0093 0094 0095 0096 0097 0098 0099 0100 0101 0102 0103 0104 0105 0106 0107 0108 0109 0110 0111 0112 0113 0114 0115 0116 0117 0118 0119 0120 0121 0122 0123 0124 0125 0126 0127 0128 0129 0130 0131 0132 0133 0134 0135 0136 0137 0138 0139 0140 0141 0142 0143 0144 0145 0146 0147 0148 0149 0150 0151 0152 0153 0154 0155 0156 0157 0158 0159 0160 0161 0162 0163 0164 0165 0166 0167 0168 0169 0170 0171 0172 0173 0174 0175 0176 0177 0178 0179 0180 0183 0184 0185 0186 0187 0188 0189 0190 0191 0192 0193 0194 0195 0196', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-11">[BR-CL-11]-Any registration identifier identification scheme identifier MUST be coded using one of the ISO 6523 ICD list.</assert>
      </rule>


      <rule context="ram:ClassCode/@listID" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AA AB AC AD AE AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW AX AY AZ BA BB BC BD BE BF BG BH BI BJ BK BL BM BN BO BP BQ BR BS BT BU BV BW BX BY BZ CC CG CL CR CV DR DW EC EF EN FS GB GN GS HS IB IN IS IT IZ MA MF MN MP NB ON PD PL PO PV QS RC RN RU RY SA SG SK SN SRS SRT SRU SRV SRW SRX SRY SRZ SS SSA SSB SSC SSD SSE SSF SSG SSH SSI SSJ SSK SSL SSM SSN SSO SSP SSQ SSR SSS SST SSU SSV SSW SSX SSY SSZ ST STA STB STC STD STE STF STG STH STI STJ STK STL STM STN STO STP STQ STR STS STT STU STV STW STX STY STZ SUA SUB SUC SUD SUE SUF SUG SUH SUI SUJ SUK SUL SUM TG TSN TSO TSP UA UP VN VP VS VX ZZZ ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-13">[BR-CL-13]-Item classification identifier identification scheme identifier MUST be coded using one of the UNTDID 7143 list.</assert>
      </rule>

      <rule context="ram:CountryID" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AD AE AF AG AI AL AM AN AO AQ AR AS AT AU AW AX AZ BA BB BD BE BF BG BH BI BL BJ BM BN BO BR BS BT BV BW BY BZ CA CC CD CF CG CH CI CK CL CM CN CO CR CU CV CX CY CZ DE DJ DK DM DO DZ EC EE EG EH ER ES ET FI FJ FK FM FO FR GA GB GD GE GF GG GH GI GL GM GN GP GQ GR GS GT GU GW GY HK HM HN HR HT HU ID IE IL IM IN IO IQ IR IS IT JE JM JO JP KE KG KH KI KM KN KP KR KW KY KZ LA LB LC LI LK LR LS LT LU LV LY MA MC MD ME MF MG MH MK ML MM MN MO MP MQ MR MS MT MU MV MW MX MY MZ NA NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM PN PR PS PT PW PY QA RO RS RU RW SA SB SC SD SE SG SH SI SJ SK SL SM SN SO SR ST SV SY SZ TC TD TF TG TH TJ TK TL TM TN TO TR TT TV TW TZ UA UG UM US UY UZ VA VC VE VG VI VN VU WF WS YE YT ZA ZM ZW ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-14">[BR-CL-14]-Country codes in an invoice MUST be coded using ISO code list 3166-1</assert>
      </rule>

      <rule context="ram:OriginTradeCountry/ram:ID" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AD AE AF AG AI AL AM AN AO AQ AR AS AT AU AW AX AZ BA BB BD BE BF BG BH BI BL BJ BM BN BO BR BS BT BV BW BY BZ CA CC CD CF CG CH CI CK CL CM CN CO CR CU CV CX CY CZ DE DJ DK DM DO DZ EC EE EG EH ER ES ET FI FJ FK FM FO FR GA GB GD GE GF GG GH GI GL GM GN GP GQ GR GS GT GU GW GY HK HM HN HR HT HU ID IE IL IM IN IO IQ IR IS IT JE JM JO JP KE KG KH KI KM KN KP KR KW KY KZ LA LB LC LI LK LR LS LT LU LV LY MA MC MD ME MF MG MH MK ML MM MN MO MP MQ MR MS MT MU MV MW MX MY MZ NA NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM PN PR PS PT PW PY QA RO RS RU RW SA SB SC SD SE SG SH SI SJ SK SL SM SN SO SR ST SV SY SZ TC TD TF TG TH TJ TK TL TM TN TO TR TT TV TW TZ UA UG UM US UY UZ VA VC VE VG VI VN VU WF WS YE YT ZA ZM ZW ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-15">[BR-CL-15]-Country codes in an invoice MUST be coded using ISO code list 3166-1</assert>
      </rule>

      <rule context="ram:SpecifiedTradeSettlementPaymentMeans/ram:TypeCode"
            flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 70 74 75 76 77 78 91 92 93 94 95 96 97 ZZZ ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-16">[BR-CL-16]-Payment means in an invoice MUST be coded using UNTDID 4461 code list</assert>
      </rule>

      <rule context="ram:CategoryTradeTax/ram:CategoryCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AE L M E S Z G O K ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-17">[BR-CL-17]-Invoice tax categories MUST be coded using UNCL 5305 code list</assert>
      </rule>

      <rule context="ram:ApplicableTradeTax/ram:CategoryCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AE L M E S Z G O K ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-18">[BR-CL-18]-Invoice tax categories MUST be coded using UNCL 5305 code list</assert>
      </rule>

      <rule context="ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator = 'false']/ram:ReasonCode"
            flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 ZZZ ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-19">[BR-CL-19]-Coded allowance reasons MUST belong to the UNCL 4465 code list</assert>
      </rule>
  
      <rule context="ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator = 'true']/ram:ReasonCode"
            flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AA AAA AAC AAD AAE AAF AAH AAI AAS AAT AAV AAY AAZ ABA ABB ABC ABD ABF ABK ABL ABN ABR ABS ABT ABU ACF ACG ACH ACI ACJ ACK ACL ACM ACS ADC ADE ADJ ADK ADL ADM ADN ADO ADP ADQ ADR ADT ADW ADY ADZ AEA AEB AEC AED AEF AEH AEI AEJ AEK AEL AEM AEN AEO AEP AES AET AEU AEV AEW AEX AEY AEZ AJ AU CA CAB CAD CAE CAF CAI CAJ CAK CAL CAM CAN CAO CAP CAQ CAR CAS CAT CAU CAV CAW CD CG CS CT DAB DAD DL EG EP ER FAA FAB FAC FC FH FI GAA HAA HD HH IAA IAB ID IF IR IS KO L1 LA LAA LAB LF MAE MI ML NAA OA PA PAA PC PL RAB RAC RAD RAF RE RF RH RV SA SAA SAD SAE SAI SG SH SM SU TAB TAC TT TV V1 V2 WH XAA YY ZZZ ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-20">[BR-CL-20]-Coded charge reasons MUST belong to the UNCL 7161 code list</assert>
      </rule>

          <!-- 2018-11-13 - Added newest ICD values manually -->
      <rule context="ram:SpecifiedTradeProduct/ram:GlobalID/@schemeID" flag="fatal">
              <assert test="((not(contains(normalize-space(.), ' ')) and contains(' 0001 0002 0003 0004 0005 0006 0007 0008 0009 0010 0011 0012 0013 0014 0015 0016 0017 0018 0019 0020 0021 0022 0023 0024 0025 0026 0027 0028 0029 0030 0031 0032 0033 0034 0035 0036 0037 0038 0039 0040 0041 0042 0043 0044 0045 0046 0047 0048 0049 0050 0051 0052 0053 0054 0055 0056 0057 0058 0059 0060 0061 0062 0063 0064 0065 0066 0067 0068 0069 0070 0071 0072 0073 0074 0075 0076 0077 0078 0079 0080 0081 0082 0083 0084 0085 0086 0087 0088 0089 0090 0091 0092 0093 0094 0095 0096 0097 0098 0099 0100 0101 0102 0103 0104 0105 0106 0107 0108 0109 0110 0111 0112 0113 0114 0115 0116 0117 0118 0119 0120 0121 0122 0123 0124 0125 0126 0127 0128 0129 0130 0131 0132 0133 0134 0135 0136 0137 0138 0139 0140 0141 0142 0143 0144 0145 0146 0147 0148 0149 0150 0151 0152 0153 0154 0155 0156 0157 0158 0159 0160 0161 0162 0163 0164 0165 0166 0167 0168 0169 0170 0171 0172 0173 0174 0175 0176 0177 0178 0179 0180 0183 0184 0185 0186 0187 0188 0189 0190 0191 0192 0193 0194 0195 0196', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-21">[BR-CL-21]-Item standard identifier scheme identifier MUST belong to the ISO 6523 ICD
      code list</assert>
      </rule>

  

      <rule context="@unitCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' 10 11 13 14 15 20 21 22 23 24 25 27 28 33 34 35 37 38 40 41 56 57 58 59 60 61 64 66 74 76 77 78 80 81 84 85 87 89 91 1I 2A 2B 2C 2G 2H 2I 2J 2K 2L 2M 2N 2P 2Q 2R 2U 2X 2Y 2Z 3B 3C 4C 4G 4H 4K 4L 4M 4N 4O 4P 4Q 4R 4T 4U 4W 4X 5A 5B 5E 5J A1 A10 A11 A12 A13 A14 A15 A16 A17 A18 A19 A2 A20 A21 A22 A23 A24 A25 A26 A27 A28 A29 A3 A30 A31 A32 A33 A34 A35 A36 A37 A38 A39 A4 A40 A41 A42 A43 A44 A45 A47 A48 A49 A5 A50 A51 A52 A53 A54 A55 A56 A57 A58 A59 A6 A60 A61 A62 A63 A64 A65 A66 A67 A68 A69 A7 A70 A71 A73 A74 A75 A76 A77 A78 A79 A8 A80 A81 A82 A83 A84 A85 A86 A87 A88 A89 A9 A90 A91 A93 A94 A95 A96 A97 A98 A99 AA AB ACR ACT AD AE AH AI AK AL AMH AMP ANN APZ AQ ARE AS ASM ASU ATM ATT AY AZ B1 B10 B11 B12 B13 B14 B15 B16 B17 B18 B19 B20 B21 B22 B23 B24 B25 B26 B27 B28 B29 B3 B30 B31 B32 B33 B34 B35 B36 B37 B38 B39 B4 B40 B41 B42 B43 B44 B45 B46 B47 B48 B49 B50 B51 B52 B53 B54 B55 B56 B57 B58 B59 B60 B61 B62 B63 B64 B65 B66 B67 B68 B69 B7 B70 B71 B72 B73 B74 B75 B76 B77 B78 B79 B8 B80 B81 B82 B83 B84 B85 B86 B87 B88 B89 B90 B91 B92 B93 B94 B95 B96 B97 B98 B99 BAR BB BFT BHP BIL BLD BLL BP BQL BTU BUA BUI C0 C10 C11 C12 C13 C14 C15 C16 C17 C18 C19 C20 C21 C22 C23 C24 C25 C26 C27 C28 C29 C3 C30 C31 C32 C33 C34 C35 C36 C37 C38 C39 C40 C41 C42 C43 C44 C45 C46 C47 C48 C49 C50 C51 C52 C53 C54 C55 C56 C57 C58 C59 C60 C61 C62 C63 C64 C65 C66 C67 C68 C69 C7 C70 C71 C72 C73 C74 C75 C76 C78 C79 C8 C80 C81 C82 C83 C84 C85 C86 C87 C88 C89 C9 C90 C91 C92 C93 C94 C95 C96 C97 C99 CCT CDL CEL CEN CG CGM CKG CLF CLT CMK CMQ CMT CNP CNT COU CTG CTM CTN CUR CWA CWI D03 D04 D1 D10 D11 D12 D13 D15 D16 D17 D18 D19 D2 D20 D21 D22 D23 D24 D25 D26 D27 D29 D30 D31 D32 D33 D34 D35 D36 D37 D38 D39 D41 D42 D43 D44 D45 D46 D47 D48 D49 D5 D50 D51 D52 D53 D54 D55 D56 D57 D58 D59 D6 D60 D61 D62 D63 D65 D68 D69 D70 D71 D72 D73 D74 D75 D76 D77 D78 D80 D81 D82 D83 D85 D86 D87 D88 D89 D9 D91 D93 D94 D95 DAA DAD DAY DB DD DEC DG DJ DLT DMA DMK DMO DMQ DMT DN DPC DPR DPT DRA DRI DRL DT DTN DU DWT DX DZN DZP E01 E07 E08 E09 E10 E11 E12 E14 E15 E16 E17 E18 E19 E20 E21 E22 E23 E25 E27 E28 E30 E31 E32 E33 E34 E35 E36 E37 E38 E39 E4 E40 E41 E42 E43 E44 E45 E46 E47 E48 E49 E50 E51 E52 E53 E54 E55 E56 E57 E58 E59 E60 E61 E62 E63 E64 E65 E66 E67 E68 E69 E70 E71 E72 E73 E74 E75 E76 E77 E78 E79 E80 E81 E82 E83 E84 E85 E86 E87 E88 E89 E90 E91 E92 E93 E94 E95 E96 E97 E98 E99 EA EB EQ F01 F02 F03 F04 F05 F06 F07 F08 F10 F11 F12 F13 F14 F15 F16 F17 F18 F19 F20 F21 F22 F23 F24 F25 F26 F27 F28 F29 F30 F31 F32 F33 F34 F35 F36 F37 F38 F39 F40 F41 F42 F43 F44 F45 F46 F47 F48 F49 F50 F51 F52 F53 F54 F55 F56 F57 F58 F59 F60 F61 F62 F63 F64 F65 F66 F67 F68 F69 F70 F71 F72 F73 F74 F75 F76 F77 F78 F79 F80 F81 F82 F83 F84 F85 F86 F87 F88 F89 F90 F91 F92 F93 F94 F95 F96 F97 F98 F99 FAH FAR FBM FC FF FH FIT FL FOT FP FR FS FTK FTQ G01 G04 G05 G06 G08 G09 G10 G11 G12 G13 G14 G15 G16 G17 G18 G19 G2 G20 G21 G23 G24 G25 G26 G27 G28 G29 G3 G30 G31 G32 G33 G34 G35 G36 G37 G38 G39 G40 G41 G42 G43 G44 G45 G46 G47 G48 G49 G50 G51 G52 G53 G54 G55 G56 G57 G58 G59 G60 G61 G62 G63 G64 G65 G66 G67 G68 G69 G70 G71 G72 G73 G74 G75 G76 G77 G78 G79 G80 G81 G82 G83 G84 G85 G86 G87 G88 G89 G90 G91 G92 G93 G94 G95 G96 G97 G98 G99 GB GBQ GDW GE GF GFI GGR GIA GIC GII GIP GJ GL GLD GLI GLL GM GO GP GQ GRM GRN GRO GRT GT GV GWH H03 H04 H05 H06 H07 H08 H09 H10 H11 H12 H13 H14 H15 H16 H18 H19 H20 H21 H22 H23 H24 H25 H26 H27 H28 H29 H30 H31 H32 H33 H34 H35 H36 H37 H38 H39 H40 H41 H42 H43 H44 H45 H46 H47 H48 H49 H50 H51 H52 H53 H54 H55 H56 H57 H58 H59 H60 H61 H62 H63 H64 H65 H66 H67 H68 H69 H70 H71 H72 H73 H74 H75 H76 H77 H78 H79 H80 H81 H82 H83 H84 H85 H87 H88 H89 H90 H91 H92 H93 H94 H95 H96 H98 H99 HA HAR HBA HBX HC HDW HEA HGM HH HIU HJ HKM HLT HM HMQ HMT HN HP HPA HTZ HUR IA IE INH INK INQ ISD IU IV J10 J12 J13 J14 J15 J16 J17 J18 J19 J2 J20 J21 J22 J23 J24 J25 J26 J27 J28 J29 J30 J31 J32 J33 J34 J35 J36 J38 J39 J40 J41 J42 J43 J44 J45 J46 J47 J48 J49 J50 J51 J52 J53 J54 J55 J56 J57 J58 J59 J60 J61 J62 J63 J64 J65 J66 J67 J68 J69 J70 J71 J72 J73 J74 J75 J76 J78 J79 J81 J82 J83 J84 J85 J87 J89 J90 J91 J92 J93 J94 J95 J96 J97 J98 J99 JE JK JM JNT JOU JPS JWL K1 K10 K11 K12 K13 K14 K15 K16 K17 K18 K19 K2 K20 K21 K22 K23 K24 K25 K26 K27 K28 K3 K30 K31 K32 K33 K34 K35 K36 K37 K38 K39 K40 K41 K42 K43 K45 K46 K47 K48 K49 K5 K50 K51 K52 K53 K54 K55 K58 K59 K6 K60 K61 K62 K63 K64 K65 K66 K67 K68 K69 K70 K71 K73 K74 K75 K76 K77 K78 K79 K80 K81 K82 K83 K84 K85 K86 K87 K88 K89 K90 K91 K92 K93 K94 K95 K96 K97 K98 K99 KA KAT KB KBA KCC KDW KEL KGM KGS KHY KHZ KI KIC KIP KJ KJO KL KLK KLX KMA KMH KMK KMQ KMT KNI KNS KNT KO KPA KPH KPO KPP KR KSD KSH KT KTN KUR KVA KVR KVT KW KWH KWO KWT KX L10 L11 L12 L13 L14 L15 L16 L17 L18 L19 L2 L20 L21 L23 L24 L25 L26 L27 L28 L29 L30 L31 L32 L33 L34 L35 L36 L37 L38 L39 L40 L41 L42 L43 L44 L45 L46 L47 L48 L49 L50 L51 L52 L53 L54 L55 L56 L57 L58 L59 L60 L63 L64 L65 L66 L67 L68 L69 L70 L71 L72 L73 L74 L75 L76 L77 L78 L79 L80 L81 L82 L83 L84 L85 L86 L87 L88 L89 L90 L91 L92 L93 L94 L95 L96 L98 L99 LA LAC LBR LBT LD LEF LF LH LK LM LN LO LP LPA LR LS LTN LTR LUB LUM LUX LY M1 M10 M11 M12 M13 M14 M15 M16 M17 M18 M19 M20 M21 M22 M23 M24 M25 M26 M27 M29 M30 M31 M32 M33 M34 M35 M36 M37 M38 M39 M4 M40 M41 M42 M43 M44 M45 M46 M47 M48 M49 M5 M50 M51 M52 M53 M55 M56 M57 M58 M59 M60 M61 M62 M63 M64 M65 M66 M67 M68 M69 M7 M70 M71 M72 M73 M74 M75 M76 M77 M78 M79 M80 M81 M82 M83 M84 M85 M86 M87 M88 M89 M9 M90 M91 M92 M93 M94 M95 M96 M97 M98 M99 MAH MAL MAM MAR MAW MBE MBF MBR MC MCU MD MGM MHZ MIK MIL MIN MIO MIU MLD MLT MMK MMQ MMT MND MON MPA MQH MQS MSK MTK MTQ MTR MTS MVA MWH N1 N10 N11 N12 N13 N14 N15 N16 N17 N18 N19 N20 N21 N22 N23 N24 N25 N26 N27 N28 N29 N3 N30 N31 N32 N33 N34 N35 N36 N37 N38 N39 N40 N41 N42 N43 N44 N45 N46 N47 N48 N49 N50 N51 N52 N53 N54 N55 N56 N57 N58 N59 N60 N61 N62 N63 N64 N65 N66 N67 N68 N69 N70 N71 N72 N73 N74 N75 N76 N77 N78 N79 N80 N81 N82 N83 N84 N85 N86 N87 N88 N89 N90 N91 N92 N93 N94 N95 N96 N97 N98 N99 NA NAR NCL NEW NF NIL NIU NL NMI NMP NPR NPT NQ NR NT NTT NU NX OA ODE OHM ON ONZ OT OZ OZA OZI P1 P10 P11 P12 P13 P14 P15 P16 P17 P18 P19 P2 P20 P21 P22 P23 P24 P25 P26 P27 P28 P29 P30 P31 P32 P33 P34 P35 P36 P37 P38 P39 P40 P41 P42 P43 P44 P45 P46 P47 P48 P49 P5 P50 P51 P52 P53 P54 P55 P56 P57 P58 P59 P60 P61 P62 P63 P64 P65 P66 P67 P68 P69 P70 P71 P72 P73 P74 P75 P76 P77 P78 P79 P80 P81 P82 P83 P84 P85 P86 P87 P88 P89 P90 P91 P92 P93 P94 P95 P96 P97 P98 P99 PAL PD PFL PGL PI PLA PO PQ PR PS PT PTD PTI PTL Q10 Q11 Q12 Q13 Q14 Q15 Q16 Q17 Q18 Q19 Q20 Q21 Q22 Q23 Q24 Q25 Q26 Q27 Q28 Q3 QA QAN QB QR QT QTD QTI QTL QTR R1 R9 RH RM ROM RP RPM RPS RT S3 S4 SAN SCO SCR SEC SET SG SHT SIE SMI SQ SQR SR STC STI STK STL STN STW SW SX SYR T0 T3 TAH TAN TI TIC TIP TKM TMS TNE TP TPR TQD TRL TST TTS U1 U2 UA UB UC VA VLT VP W2 WA WB WCD WE WEB WEE WG WHR WM WSD WTT WW X1 YDK YDQ YRD Z11 ZP ZZ X43 X44 X1A X1B X1D X1F X1G X1W X2C X3A X3H X4A X4B X4C X4D X4F X4G X4H X5H X5L X5M X6H X6P X7A X7B X8A X8B X8C XAA XAB XAC XAD XAE XAF XAG XAH XAI XAJ XAL XAM XAP XAT XAV XB4 XBA XBB XBC XBD XBE XBF XBG XBH XBI XBJ XBK XBL XBM XBN XBO XBP XBQ XBR XBS XBT XBU XBV XBW XBX XBY XBZ XCA XCB XCC XCD XCE XCF XCG XCH XCI XCJ XCK XCL XCM XCN XCO XCP XCQ XCR XCS XCT XCU XCV XCW XCX XCY XCZ XDA XDB XDC XDG XDH XDI XDJ XDK XDL XDM XDN XDP XDR XDS XDT XDU XDV XDW XDX XDY XEC XED XEE XEF XEG XEH XEI XEN XFB XFC XFD XFE XFI XFL XFO XFP XFR XFT XFW XFX XGB XGI XGL XGR XGU XGY XGZ XHA XHB XHC XHG XHN XHR XIA XIB XIC XID XIE XIF XIG XIH XIK XIL XIN XIZ XJB XJC XJG XJR XJT XJY XKG XKI XLE XLG XLT XLU XLV XLZ XMA XMB XMC XME XMR XMS XMT XMW XMX XNA XNE XNF XNG XNS XNT XNU XNV XOA XOB XOC XOD XOE XOF XOK XOT XOU XP2 XPA XPB XPC XPD XPE XPF XPG XPH XPI XPJ XPK XPL XPN XPO XPP XPR XPT XPU XPV XPX XPY XPZ XQA XQB XQC XQD XQF XQG XQH XQJ XQK XQL XQM XQN XQP XQQ XQR XQS XRD XRG XRJ XRK XRL XRO XRT XRZ XSA XSB XSC XSD XSE XSH XSI XSK XSL XSM XSO XSP XSS XST XSU XSV XSW XSY XSZ XT1 XTB XTC XTD XTE XTG XTI XTK XTL XTN XTO XTR XTS XTT XTU XTV XTW XTY XTZ XUC XUN XVA XVG XVI XVK XVL XVN XVO XVP XVQ XVR XVS XVY XWA XWB XWC XWD XWF XWG XWH XWJ XWK XWL XWM XWN XWP XWQ XWR XWS XWT XWU XWV XWW XWX XWY XWZ XXA XXB XXC XXD XXF XXG XXH XXJ XXK XYA XYB XYC XYD XYF XYG XYH XYJ XYK XYL XYM XYN XYP XYQ XYR XYS XYT XYV XYW XYX XYY XYZ XZA XZB XZC XZD XZF XZG XZH XZJ XZK XZL XZM XZN XZP XZQ XZR XZS XZT XZU XZV XZW XZX XZY XZZ ', concat(' ', normalize-space(.), ' '))))"
                 flag="fatal"
                 id="BR-CL-23">[BR-CL-23]-Unit code MUST be coded according to the UN/ECE Recommendation 20 with Rec 21 extension</assert>
      </rule>

      <rule context="@mimeCode" flag="fatal">
         <assert test="((. = 'application/pdf' or . = 'image/png' or . = 'image/jpeg' or . = 'text/csv' or . = 'application/vnd.openxmlformats-officedocument. spreadsheetml.sheet' or . = 'application/vnd.oasis.opendocument.spreadsheet'))"
                 flag="fatal"
                 id="BR-CL-24">[BR-CL-24]-For Mime code in attribute use MIMEMediaType.</assert>
      </rule>

   </pattern>
</schema>
