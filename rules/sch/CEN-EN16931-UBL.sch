<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
        xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
        xmlns:cn="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
        xmlns:UBL="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
        queryBinding="xslt2">
  <title>EN16931  model bound to UBL</title>
  <ns prefix="ext"
       uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
  <ns prefix="cbc"
       uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
  <ns prefix="cac"
       uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
  <ns prefix="qdt"
       uri="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"/>
  <ns prefix="udt"
       uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"/>
  <ns prefix="cn"
       uri="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"/>
  <ns prefix="ubl"
       uri="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"/>
  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
  <phase id="EN16931model_phase">
      <active pattern="UBL-model"/>
  </phase>
  <phase id="codelist_phase">
      <active pattern="Codesmodel"/>
  </phase>
  
  
  <!--Suppressed abstract pattern model was here-->
  <!--Suppressed abstract pattern syntax was here-->
  
  
  <!--Start pattern based on abstract model--><pattern id="UBL-model">
      <rule context="cac:AdditionalDocumentReference">
         <assert test="(cbc:ID) != ''" flag="fatal" id="BR-52">[BR-52]-Each Additional supporting document (BG-24) shall contain a Supporting document reference (BT-122).    </assert>
      </rule>
          <rule context="ubl:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount">
         <assert test="((. &gt; 0) and (exists(//cbc:DueDate) or exists(//cac:PaymentTerms/cbc:Note))) or (. &lt;= 0)"
                 flag="fatal"
                 id="BR-CO-25">[BR-CO-25]-In case the Amount due for payment (BT-115) is positive, either the Payment due date (BT-9) or the Payment terms (BT-20) shall be present.</assert>
      </rule>
      <rule context="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID">
         <assert test="exists(@schemeID)" flag="fatal" id="BR-63">[BR-63]-The Buyer electronic address (BT-49) shall have a Scheme identifier.    </assert>
      </rule>
      <rule context="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress">
         <assert test="(cac:Country/cbc:IdentificationCode) != ''"
                 flag="fatal"
                 id="BR-11">[BR-11]-The Buyer postal address shall contain a Buyer country code (BT-55).</assert>
      </rule>
      <rule context="cac:PaymentMeans/cac:CardAccount">
         <assert test="string-length(cbc:PrimaryAccountNumberID)&gt;=4 and string-length(cbc:PrimaryAccountNumberID)&lt;=6"
                 flag="fatal"
                 id="BR-51">[BR-51]-The last 4 to 6 digits of the Payment card primary account number (BT-87) shall be present if Payment card information (BG-18) is provided in the Invoice.</assert>
      </rule>
      <rule context="cac:Delivery/cac:DeliveryLocation/cac:Address">
         <assert test="exists(cac:Country/cbc:IdentificationCode)"
                 flag="fatal"
                 id="BR-57">[BR-57]-Each Deliver to address (BG-15) shall contain a Deliver to country code (BT-80).</assert>
      </rule>
      <rule context="//ubl:Invoice/cac:AllowanceCharge[cbc:ChargeIndicator = 'false'] | //cn:CreditNote/cac:AllowanceCharge[cbc:ChargeIndicator = 'false']">
         <assert test="exists(cbc:Amount) " flag="fatal" id="BR-31">[BR-31]-Each Document level allowance (BG-20) shall have a Document level allowance amount (BT-92).</assert>
         <assert test="exists(cac:TaxCategory/cbc:ID)" flag="fatal" id="BR-32">[BR-32]-Each Document level allowance (BG-20) shall have a Document level allowance VAT category code (BT-95).</assert>
         <assert test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)"
                 flag="fatal"
                 id="BR-33">[BR-33]-Each Document level allowance (BG-20) shall have a Document level allowance reason (BT-97) or a Document level allowance reason code (BT-98).</assert>
         <assert test="true()" flag="fatal" id="BR-CO-05">[BR-CO-05]-Document level allowance reason code (BT-98) and Document level allowance reason (BT-97) shall indicate the same type of allowance.</assert>
         <assert test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)"
                 flag="fatal"
                 id="BR-CO-21">[BR-CO-21]-Each Document level allowance (BG-20) shall contain a Document level allowance reason (BT-97) or a Document level allowance reason code (BT-98), or both.</assert>
         <assert test="string-length(substring-after(cbc:Amount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-01">[BR-DEC-01]-The allowed maximum number of decimals for the Document level allowance amount (BT-92) is 2.</assert>
         <assert test="string-length(substring-after(cbc:BaseAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-02">[BR-DEC-02]-The allowed maximum number of decimals for the Document level allowance base amount (BT-93) is 2.    </assert>
      </rule>
      <rule context="//ubl:Invoice/cac:AllowanceCharge[cbc:ChargeIndicator = 'true'] | //cn:CreditNote/cac:AllowanceCharge[cbc:ChargeIndicator = 'true']">
         <assert test="exists(cbc:Amount)" flag="fatal" id="BR-36">[BR-36]-Each Document level charge (BG-21) shall have a Document level charge amount (BT-99).</assert>
         <assert test="exists(cac:TaxCategory/cbc:ID)" flag="fatal" id="BR-37">[BR-37]-Each Document level charge (BG-21) shall have a Document level charge VAT category code (BT-102).</assert>
         <assert test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)"
                 flag="fatal"
                 id="BR-38">[BR-38]-Each Document level charge (BG-21) shall have a Document level charge reason (BT-104) or a Document level charge reason code (BT-105).    </assert>
         <assert test="true()" flag="fatal" id="BR-CO-06">[BR-CO-06]-Document level charge reason code (BT-105) and Document level charge reason (BT-104) shall indicate the same type of charge.</assert>
         <assert test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)"
                 flag="fatal"
                 id="BR-CO-22">[BR-CO-22]-Each Document level charge (BG-21) shall contain a Document level charge reason (BT-104) or a Document level charge reason code (BT-105), or both.</assert>
         <assert test="string-length(substring-after(cbc:Amount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-05">[BR-DEC-05]-The allowed maximum number of decimals for the Document level charge amount (BT-99) is 2.</assert>
         <assert test="string-length(substring-after(cbc:BaseAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-06">[BR-DEC-06]-The allowed maximum number of decimals for the Document level charge base amount (BT-100) is 2.    </assert>
      </rule>
      <rule context="cac:LegalMonetaryTotal">
         <assert test="exists(cbc:LineExtensionAmount)" flag="fatal" id="BR-12">[BR-12]-An Invoice shall have the Sum of Invoice line net amount (BT-106).</assert>
         <assert test="exists(cbc:TaxExclusiveAmount)" flag="fatal" id="BR-13">[BR-13]-An Invoice shall have the Invoice total amount without VAT (BT-109).</assert>
         <assert test="exists(cbc:TaxInclusiveAmount)" flag="fatal" id="BR-14">[BR-14]-An Invoice shall have the Invoice total amount with VAT (BT-112).</assert>
         <assert test="exists(cbc:PayableAmount)" flag="fatal" id="BR-15">[BR-15]-An Invoice shall have the Amount due for payment (BT-115).</assert>
         <assert test="(xs:decimal(cbc:LineExtensionAmount) = (round(sum(//cac:InvoiceLine/xs:decimal(cbc:LineExtensionAmount)) * 10 * 10) div 100)) or (xs:decimal(cbc:LineExtensionAmount) = (round(sum(//cac:CreditNoteLine/xs:decimal(cbc:LineExtensionAmount)) * 10 * 10) div 100))"
                 flag="fatal"
                 id="BR-CO-10">[BR-CO-10]-Sum of Invoice line net amount (BT-106) = Σ Invoice line net amount (BT-131).</assert>
         <assert test="xs:decimal(cbc:AllowanceTotalAmount) = (round(sum(../cac:AllowanceCharge[cbc:ChargeIndicator='false']/xs:decimal(cbc:Amount)) * 10 * 10) div 100) or not(cbc:AllowanceTotalAmount)"
                 flag="fatal"
                 id="BR-CO-11">[BR-CO-11]-Sum of allowances on document level (BT-107) = Σ Document level allowance amount (BT-92).</assert>
         <assert test="xs:decimal(cbc:ChargeTotalAmount) = (round(sum(../cac:AllowanceCharge[cbc:ChargeIndicator='true']/xs:decimal(cbc:Amount)) * 10 * 10) div 100) or not(cbc:ChargeTotalAmount)"
                 flag="fatal"
                 id="BR-CO-12">[BR-CO-12]-Sum of charges on document level (BT-108) = Σ Document level charge amount (BT-99).</assert>
         <assert test="((cbc:ChargeTotalAmount) and (cbc:AllowanceTotalAmount) and (xs:decimal(cbc:TaxExclusiveAmount) = round((xs:decimal(cbc:LineExtensionAmount) + xs:decimal(cbc:ChargeTotalAmount) - xs:decimal(cbc:AllowanceTotalAmount)) * 10 * 10) div 100 ))  or (not(cbc:ChargeTotalAmount) and (cbc:AllowanceTotalAmount) and (xs:decimal(cbc:TaxExclusiveAmount) = round((xs:decimal(cbc:LineExtensionAmount) - xs:decimal(cbc:AllowanceTotalAmount)) * 10 * 10 ) div 100)) or ((cbc:ChargeTotalAmount) and not(cbc:AllowanceTotalAmount) and (xs:decimal(cbc:TaxExclusiveAmount) = round((xs:decimal(cbc:LineExtensionAmount) + xs:decimal(cbc:ChargeTotalAmount)) * 10 * 10 ) div 100)) or (not(cbc:ChargeTotalAmount) and not(cbc:AllowanceTotalAmount) and (xs:decimal(cbc:TaxExclusiveAmount) = xs:decimal(cbc:LineExtensionAmount)))"
                 flag="fatal"
                 id="BR-CO-13">[BR-CO-13]-Invoice total amount without VAT (BT-109) = Σ Invoice line net amount (BT-131) - Sum of allowances on document level (BT-107) + Sum of charges on document level (BT-108).</assert>
         <assert test="(xs:decimal(cbc:PrepaidAmount) and not(xs:decimal(cbc:PayableRoundingAmount)) and (xs:decimal(cbc:PayableAmount) = (round((xs:decimal(cbc:TaxInclusiveAmount) - xs:decimal(cbc:PrepaidAmount)) * 10 * 10) div 100))) or (not(xs:decimal(cbc:PrepaidAmount)) and not(xs:decimal(cbc:PayableRoundingAmount)) and xs:decimal(cbc:PayableAmount) = xs:decimal(cbc:TaxInclusiveAmount)) or (xs:decimal(cbc:PrepaidAmount) and xs:decimal(cbc:PayableRoundingAmount) and ((round((xs:decimal(cbc:PayableAmount) - xs:decimal(cbc:PayableRoundingAmount)) * 10 * 10) div 100) = (round((xs:decimal(cbc:TaxInclusiveAmount) - xs:decimal(cbc:PrepaidAmount)) * 10 * 10) div 100))) or (not(xs:decimal(cbc:PrepaidAmount)) and xs:decimal(cbc:PayableRoundingAmount) and ((round((xs:decimal(cbc:PayableAmount) - xs:decimal(cbc:PayableRoundingAmount)) * 10 * 10) div 100) = xs:decimal(cbc:TaxInclusiveAmount))) "
                 flag="fatal"
                 id="BR-CO-16">[BR-CO-16]-Amount due for payment (BT-115) = Invoice total amount with VAT (BT-112) -Paid amount (BT-113) +Rounding amount (BT-114).</assert>
         <assert test="string-length(substring-after(cbc:LineExtensionAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-09">[BR-DEC-09]-The allowed maximum number of decimals for the Sum of Invoice line net amount (BT-106) is 2.</assert>
         <assert test="string-length(substring-after(cbc:AllowanceTotalAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-10">[BR-DEC-10]-The allowed maximum number of decimals for the Sum of allowanced on document level (BT-107) is 2.</assert>
         <assert test="string-length(substring-after(cbc:ChargeTotalAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-11">[BR-DEC-11]-The allowed maximum number of decimals for the Sum of charges on document level (BT-108) is 2.</assert>
         <assert test="string-length(substring-after(cbc:TaxExclusiveAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-12">[BR-DEC-12]-The allowed maximum number of decimals for the Invoice total amount without VAT (BT-109) is 2.    </assert>
         <assert test="string-length(substring-after(cbc:TaxInclusiveAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-14">[BR-DEC-14]-The allowed maximum number of decimals for the Invoice total amount with VAT (BT-112) is 2.</assert>
         <assert test="string-length(substring-after(cbc:PrepaidAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-16">[BR-DEC-16]-The allowed maximum number of decimals for the Paid amount (BT-113) is 2.</assert>
         <assert test="string-length(substring-after(cbc:PayableRoundingAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-17">[BR-DEC-17]-The allowed maximum number of decimals for the Rounding amount (BT-114) is 2.</assert>
         <assert test="string-length(substring-after(cbc:PayableAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-18">[BR-DEC-18]-The allowed maximum number of decimals for the Amount due for payment (BT-115) is 2.  </assert>
      </rule>
      <rule context="//ubl:Invoice | //cn:CreditNote">
         <assert test="(cbc:CustomizationID) != ''" flag="fatal" id="BR-01">[BR-01]-An Invoice shall have a Specification identifier (BT-24).   </assert>
         <assert test="(cbc:ID) !=''" flag="fatal" id="BR-02">[BR-02]-An Invoice shall have an Invoice number (BT-1).</assert>
         <assert test="(cbc:IssueDate) !=''" flag="fatal" id="BR-03">[BR-03]-An Invoice shall have an Invoice issue date (BT-2).</assert>
         <assert test="(cbc:InvoiceTypeCode) !='' or (cbc:CreditNoteTypeCode) !=''"
                 flag="fatal"
                 id="BR-04">[BR-04]-An Invoice shall have an Invoice type code (BT-3).</assert>
         <assert test="(cbc:DocumentCurrencyCode) !=''" flag="fatal" id="BR-05">[BR-05]-An Invoice shall have an Invoice currency code (BT-5).</assert>
         <assert test="(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName) !=''"
                 flag="fatal"
                 id="BR-06">[BR-06]-An Invoice shall contain the Seller name (BT-27).</assert>
         <assert test="(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName) !=''"
                 flag="fatal"
                 id="BR-07">[BR-07]-An Invoice shall contain the Buyer name (BT-44).</assert>
         <assert test="exists(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress)"
                 flag="fatal"
                 id="BR-08">[BR-08]-An Invoice shall contain the Seller postal address. </assert>
         <assert test="exists(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress)"
                 flag="fatal"
                 id="BR-10">[BR-10]-An Invoice shall contain the Buyer postal address (BG-8).</assert>
         <assert test="exists(cac:InvoiceLine) or exists(cac:CreditNoteLine)"
                 flag="fatal"
                 id="BR-16">[BR-16]-An Invoice shall have at least one Invoice line (BG-25)</assert>
         <assert test="every $taxcurrency in cbc:TaxCurrencyCode satisfies exists(//cac:TaxTotal/cbc:TaxAmount[@currencyID=$taxcurrency])"
                 flag="fatal"
                 id="BR-53">[BR-53]-If the VAT accounting currency code (BT-6) is present, then the Invoice total VAT amount in accounting currency (BT-111) shall be provided.</assert>
         <assert test="((exists(//cac:TaxCategory/cbc:ID[normalize-space(.) = 'AE']) or exists(//cac:ClassifiedTaxCategory/cbc:ID[normalize-space(.) = 'AE'])) and (count(//cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID) = 1) and (count(//cac:TaxCategory/cbc:ID[. != 'AE']) = 0 and count(//cac:ClassifiedTaxCategory/cbc:ID[normalize-space(.) != 'AE'])=0)) or (count(//cac:TaxCategory/cbc:ID[normalize-space(.) = 'AE']) = 0 and count(//cac:ClassifiedTaxCategory/cbc:ID[normalize-space(.) = 'AE'])=0)"
                 flag="fatal"
                 id="BR-AE-01">[BR-AE-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “Reverse charge” shall contain in the VATBReakdown (BG-23) exactly one VAT category code (BT-118) equal with "VAT reverse charge".</assert>
         <assert test="(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'AE']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID)) and (exists(//cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) or exists(//cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID))) or not(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'AE']))"
                 flag="fatal"
                 id="BR-AE-02">[BR-AE-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “Reverse charge” shall contain the Seller VAT Identifier (BT-31), the Seller Tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63) and the Buyer VAT identifier (BT-48) and/or the Buyer legal registration identifier (BT-47).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID) = 'AE']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID)) and (exists(//cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) or exists(//cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID) = 'AE']))"
                 flag="fatal"
                 id="BR-AE-03">[BR-AE-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “Reverse charge” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63) and the Buyer VAT identifier (BT-48) and/or the Buyer legal registration identifier (BT-47).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID) = 'AE']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID)) and (exists(//cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) or exists(//cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID) = 'AE']))"
                 flag="fatal"
                 id="BR-AE-04">[BR-AE-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “Reverse charge” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63) and the Buyer VAT identifier (BT-48) and/or the Buyer legal registration identifier (BT-47).</assert>
         <assert test="(exists(cbc:TaxPointDate) and not(cac:InvoicePeriod/cbc:DescriptionCode)) or (not(cbc:TaxPointDate) and exists(cac:InvoicePeriod/cbc:DescriptionCode)) or (not(cbc:TaxPointDate) and not(cac:InvoicePeriod/cbc:DescriptionCode))"
                 flag="fatal"
                 id="BR-CO-03">[BR-CO-03]-Value added tax point date (BT-7) and Value added tax point date code (BT-8) are mutually exclusive.</assert>
         <assert test="every $Currency in cbc:DocumentCurrencyCode satisfies cac:LegalMonetaryTotal/xs:decimal(cbc:TaxInclusiveAmount) = round( (cac:LegalMonetaryTotal/xs:decimal(cbc:TaxExclusiveAmount) + cac:TaxTotal/xs:decimal(cbc:TaxAmount[@currencyID=$Currency])) * 10 * 10) div 100"
                 flag="fatal"
                 id="BR-CO-15">[BR-CO-15]-Invoice total amount with VAT (BT-112) = Invoice total amount without VAT (BT-109) + Invoice total VAT amount (BT-110).</assert>
         <assert test="exists(cac:TaxTotal/cac:TaxSubtotal)"
                 flag="fatal"
                 id="BR-CO-18">[BR-CO-18]-An Invoice shall at least have one VATBReakdown group (BG-23).</assert>
         <assert test="(//cac:TaxTotal/cbc:TaxAmount[@currencyID = cbc:DocumentCurrencyCode] and (string-length(substring-after(//cac:TaxTotal/cbc:TaxAmount[@currencyID = cbc:DocumentCurrencyCode],'.'))&lt;=2)) or (not(//cac:TaxTotal/cbc:TaxAmount[@currencyID = cbc:DocumentCurrencyCode]))"
                 flag="fatal"
                 id="BR-DEC-13">[BR-DEC-13]-The allowed maximum number of decimals for the Invoice total VAT amount (BT-110) is 2.</assert>
         <assert test="(//cac:TaxTotal/cbc:TaxAmount[@currencyID = cbc:TaxCurrencyCode] and (string-length(substring-after(//cac:TaxTotal/cbc:TaxAmount[@currencyID = cbc:TaxCurrencyCode],'.'))&lt;=2)) or (not(//cac:TaxTotal/cbc:TaxAmount[@currencyID = cbc:TaxCurrencyCode]))"
                 flag="fatal"
                 id="BR-DEC-15">[BR-DEC-15]-The allowed maximum number of decimals for the Invoice total VAT amount in accounting currency (BT-111) is 2.</assert>
         <assert test="((exists(//cac:TaxCategory/cbc:ID[normalize-space(.) = 'E']) or exists(//cac:ClassifiedTaxCategory/cbc:ID[normalize-space(.) = 'E'])) and (count(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'E']) = 1)) or (not(//cac:TaxCategory/cbc:ID[normalize-space(.) = 'E']) and not(//cac:ClassifiedTaxCategory/cbc:ID[normalize-space(.) = 'E']))"
                 flag="fatal"
                 id="BR-E-01">[BR-E-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “Exempt from VAT” shall contain exactly one VATBReakdown (BG-23) with the VAT category code (BT-118) equal to "Exempt from VAT".</assert>
         <assert test="(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'E']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'E']))"
                 flag="fatal"
                 id="BR-E-02">[BR-E-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “Exempt from VAT” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='E']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='E']))"
                 flag="fatal"
                 id="BR-E-03">[BR-E-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “Exempt from VAT” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='E']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='E']))"
                 flag="fatal"
                 id="BR-E-04">[BR-E-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “Exempt from VAT” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="((exists(//cac:TaxCategory/cbc:ID[normalize-space(.) = 'G']) or exists(//cac:ClassifiedTaxCategory/cbc:ID[normalize-space(.) = 'G'])) and (count(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'G']) = 1)) or (not(//cac:TaxCategory/cbc:ID[normalize-space(.) = 'G']) and not(//cac:ClassifiedTaxCategory/cbc:ID[normalize-space(.) = 'G']))"
                 flag="fatal"
                 id="BR-G-01">[BR-G-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “Export outside the EU” shall contain in the VATBReakdown (BG-23) exactly one VAT category code (BT-118) equal with "Export outside the EU".</assert>
         <assert test="(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'G']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'G']))"
                 flag="fatal"
                 id="BR-G-02">[BR-G-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “Export outside the EU” shall contain the Seller VAT Identifier (BT-31) or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='G']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='G']))"
                 flag="fatal"
                 id="BR-G-03">[BR-G-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “Export outside the EU” shall contain the Seller VAT Identifier (BT-31) or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='G']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='G']))"
                 flag="fatal"
                 id="BR-G-04">[BR-G-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “Export outside the EU” shall contain the Seller VAT Identifier (BT-31) or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="((exists(//cac:TaxCategory/cbc:ID[normalize-space(.) = 'K']) or exists(//cac:ClassifiedTaxCategory/cbc:ID[normalize-space(.) = 'K'])) and (count(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'K']) = 1)) or (not(//cac:TaxCategory/cbc:ID[normalize-space(.) = 'K']) and not(//cac:ClassifiedTaxCategory/cbc:ID[normalize-space(.) = 'K']))"
                 flag="fatal"
                 id="BR-IC-01">[BR-IC-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “Intra-community supply” shall contain in the VATBReakdown (BG-23) exactly one VAT category code (BT-118) equal with "Intra-community supply".</assert>
         <assert test="(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'K']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID)) and (exists(//cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'K'])"
                 flag="fatal"
                 id="BR-IC-02">[BR-IC-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “Intra-community supply” shall contain the Seller VAT Identifier (BT-31) or the Seller tax representative VAT identifier (BT-63) and the Buyer VAT identifier (BT-48).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID) = 'K']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID)) and (exists(//cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID) = 'K']))"
                 flag="fatal"
                 id="BR-IC-03">[BR-IC-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “Intra-community supply” shall contain the Seller VAT Identifier (BT-31) or the Seller tax representative VAT identifier (BT-63) and the Buyer VAT identifier (BT-48).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID) = 'K']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID)) and (exists(//cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID) = 'K']))"
                 flag="fatal"
                 id="BR-IC-04">[BR-IC-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “Intra-community supply” shall contain the Seller VAT Identifier (BT-31) or the Seller tax representative VAT identifier (BT-63) and the Buyer VAT identifier (BT-48).</assert>
         <assert test="(exists(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'K'])  and (string-length(cac:Delivery/cbc:ActualDeliveryDate) &gt; 1 or (cac:InvoicePeriod/*))) or (not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'K']))"
                 flag="fatal"
                 id="BR-IC-11">[BR-IC-11]-In an Invoice with a VATBReakdown (BG-23) where the VAT category code (BT-118) is "Intra-community supply" the Actual delivery date (BT-72) or the Invoicing period (BG-14) shall not be blank.</assert>
         <assert test="(exists(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'K']) and (string-length(cac:Delivery/cac:DeliveryLocation/cac:Address/cac:Country/cbc:IdentificationCode) &gt;1)) or (not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'K']))"
                 flag="fatal"
                 id="BR-IC-12">[BR-IC-12]-In an Invoice with a VATBReakdown (BG-23) where the VAT category code (BT-118) is "Intra-community supply" the Deliver to country code (BT-80) shall not be blank.</assert>
         <assert test="((count(//cac:AllowanceCharge/cac:TaxCategory[normalize-space(cbc:ID) = 'L']) + count(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'L'])) &gt; 0 and count(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[cbc:ID = 'L']) &gt; 0) or ((count(//cac:AllowanceCharge/cac:TaxCategory[normalize-space(cbc:ID) = 'L']) + count(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'L'])) = 0 and count(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[normalize-space(cbc:ID) = 'L']) = 0)"
                 flag="fatal"
                 id="BR-IG-01">[BR-IG-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “IGIC” shall contain in the VATBReakdown (BG-23) at least one VAT category code (BT-118) equal with "IGIC".</assert>
         <assert test="(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'L']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'L']))"
                 flag="fatal"
                 id="BR-IG-02">[BR-IG-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “IGIC” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='L']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='L']))"
                 flag="fatal"
                 id="BR-IG-03">[BR-IG-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “IGIC” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[cbc:ID='L']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[cbc:ID='L']))"
                 flag="fatal"
                 id="BR-IG-04">[BR-IG-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “IGIC” shall contain the Seller VAT Identifier (BT-31), the Seller Tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="((count(//cac:AllowanceCharge/cac:TaxCategory[normalize-space(cbc:ID) = 'M']) + count(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'M'])) &gt; 0 and count(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[cbc:ID = 'M']) &gt; 0) or ((count(//cac:AllowanceCharge/cac:TaxCategory[normalize-space(cbc:ID) = 'M']) + count(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'M'])) = 0 and count(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[normalize-space(cbc:ID) = 'M']) = 0)"
                 flag="fatal"
                 id="BR-IP-01">[BR-IP-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “IPSI” shall contain in the VATBReakdown (BG-23) at least one VAT category code (BT-118) equal with "IPSI".</assert>
         <assert test="(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'M']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'M']))"
                 flag="fatal"
                 id="BR-IP-02">[BR-IP-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “IPSI” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='M']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='M']))"
                 flag="fatal"
                 id="BR-IP-03">[BR-IP-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “IPSI” shall contain the Seller VAT Identifier (BT-31), the Seller Tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='M']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='M']))"
                 flag="fatal"
                 id="BR-IP-04">[BR-IP-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “IPSI” shall contain the Seller VAT Identifier (BT-31), the Seller Tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="((exists(//cac:TaxCategory/cbc:ID[normalize-space(.) = 'O']) or exists(//cac:ClassifiedTaxCategory/cbc:ID[normalize-space(.) = 'O'])) and (count(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'O']) = 1)) or (not(//cac:TaxCategory/cbc:ID[normalize-space(.) = 'O']) and not(//cac:ClassifiedTaxCategory/cbc:ID[normalize-space(.) = 'O']))"
                 flag="fatal"
                 id="BR-O-01">[BR-O-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “Not subject to VAT” shall contain exactly one VATBReakdown group (BG-23) with the VAT category code (BT-118) equal to "Not subject to VAT".</assert>
         <assert test="(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'O']) and (not(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) and not(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) and not(//cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'O'])"
                 flag="fatal"
                 id="BR-O-02">[BR-O-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “Not subject to VAT” shall not contain the Seller VAT identifier (BT-31), the Seller tax representative VAT identifier (BT-63) or the Buyer VAT identifier (BT-46).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID) = 'O']) and (not(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) and not(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) and not(//cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID) = 'O']))"
                 flag="fatal"
                 id="BR-O-03">[BR-O-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “Not subject to VAT” shall not contain the Seller VAT identifier (BT-31), the Seller tax representative VAT identifier (BT-63) or the Buyer VAT identifier (BT-48).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID) = 'O']) and (not(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) and not(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID) and not(//cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID) = 'O']))"
                 flag="fatal"
                 id="BR-O-04">[BR-O-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “Not subject to VAT” shall not contain the Seller VAT identifier (BT-31), the Seller tax representative VAT identifier (BT-63) or the Buyer VAT identifier (BT-48).</assert>
         <assert test="(exists(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'O']) and count(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[normalize-space(cbc:ID) != 'O']) = 0) or not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'O'])"
                 flag="fatal"
                 id="BR-O-11">[BR-O-11]-An Invoice that contains a VATBReakdown group (BG-23) with a VAT category code (BT-118) "Not subject to VAT" shall not contain other VATBReakdown groups (BG-23).    </assert>
         <assert test="(exists(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'O']) and count(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) != 'O']) = 0) or not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'O'])"
                 flag="fatal"
                 id="BR-O-12">[BR-O-12]-An Invoice that contains a VATBReakdown group (BG-23) with a VAT category code (BT-118) "Not subject to VAT" shall not contain an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is not "Not subject to VAT".</assert>
         <assert test="(exists(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'O']) and count(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID) != 'O']) = 0) or not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'O'])"
                 flag="fatal"
                 id="BR-O-13">[BR-O-13]-An Invoice that contains a VATBReakdown group (BG-23) with a VAT category code (BT-118) "Not subject to VAT" shall not contain Document level allowances (BG-20) where Document level allowance VAT category code (BT-95) is not "Not subject to VAT".</assert>
         <assert test="(exists(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'O']) and count(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID) != 'O']) = 0) or not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'O'])"
                 flag="fatal"
                 id="BR-O-14">[BR-O-14]-An Invoice that contains a VATBReakdown group (BG-23) with a VAT category code (BT-118) "Not subject to VAT" shall not contain Document level charges (BG-21) where Document level charge VAT category code (BT-102) is not "Not subject to VAT".</assert>
         <assert test="((count(//cac:AllowanceCharge/cac:TaxCategory[normalize-space(cbc:ID) = 'S']) + count(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'S'])) &gt; 0 and count(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[normalize-space(cbc:ID) = 'S']) &gt; 0) or ((count(//cac:AllowanceCharge/cac:TaxCategory[normalize-space(cbc:ID) = 'S']) + count(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'S'])) = 0 and count(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[normalize-space(cbc:ID) = 'S']) = 0)"
                 flag="fatal"
                 id="BR-S-01">[BR-S-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “Standard rated” shall contain in the VATBReakdown (BG-23) at least one VAT category code (BT-118) equal with "Standard rated".</assert>
         <assert test="(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'S']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'S']))"
                 flag="fatal"
                 id="BR-S-02">[BR-S-02]-An Invoice that contains an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is “Standard rated” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='S']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='S']))"
                 flag="fatal"
                 id="BR-S-03">[BR-S-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “Standard rated” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='S']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='S']))"
                 flag="fatal"
                 id="BR-S-04">[BR-S-04]-An Invoice that contains a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is “Standard rated” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="((exists(//cac:TaxCategory/cbc:ID[normalize-space(.) = 'Z']) or exists(//cac:ClassifiedTaxCategory/cbc:ID[normalize-space(.) = 'Z'])) and (count(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID[normalize-space(.) = 'Z']) = 1)) or (not(//cac:TaxCategory/cbc:ID[normalize-space(.) = 'Z']) and not(//cac:ClassifiedTaxCategory/cbc:ID[normalize-space(.) = 'Z']))"
                 flag="fatal"
                 id="BR-Z-01">[BR-Z-01]-An Invoice that contains an Invoice line (BG-25), a Document level allowance (BG-20) or a Document level charge (BG-21) where the VAT category code (BT-151, BT-95 or BT-102) is “Zero rated” shall contain in the VATBReakdown (BG-23) exactly one VAT category code (BT-118) equal with "Zero rated".    </assert>
         <assert test="(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'Z']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'Z']))"
                 flag="fatal"
                 id="BR-Z-02">[BR-Z-02]-An Invoice that contains an Invoice line where the Invoiced item VAT category code (BT-151) is “Zero rated” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='Z']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID) = 'Z']))"
                 flag="fatal"
                 id="BR-Z-03">[BR-Z-03]-An Invoice that contains a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is “Zero rated” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
         <assert test="(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='Z']) and (exists(//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID)or exists(//cac:TaxRepresentativeParty/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID))) or not(exists(//cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID) = 'Z']))"
                 flag="fatal"
                 id="BR-Z-04">[BR-Z-04]-An Invoice that contains a Document level charge where the Document level charge VAT category code (BT-102) is “Zero rated” shall contain the Seller VAT Identifier (BT-31), the Seller tax registration identifier (BT-32) and/or the Seller tax representative VAT identifier (BT-63).</assert>
      </rule>
      <rule context="cac:InvoiceLine | cac:CreditNoteLine">
         <assert test="(cbc:ID) != ''" flag="fatal" id="BR-21">[BR-21]-Each Invoice line (BG-25) shall have an Invoice line identifier (BT-126).</assert>
         <assert test="exists(cbc:InvoicedQuantity) or exists(cbc:CreditedQuantity)"
                 flag="fatal"
                 id="BR-22">[BR-22]-Each Invoice line (BG-25) shall have an Invoiced quantity (BT-129).</assert>
         <assert test="exists(cbc:InvoicedQuantity/@unitCode) or exists(cbc:CreditedQuantity/@unitCode)"
                 flag="fatal"
                 id="BR-23">[BR-23]-An Invoice line (BG-25) shall have an Invoiced quantity unit of measure code (BT-130).</assert>
         <assert test="exists(cbc:LineExtensionAmount)" flag="fatal" id="BR-24">[BR-24]-Each Invoice line (BG-25) shall have an Invoice line net amount (BT-131).</assert>
         <assert test="(cac:Item/cbc:Name) != ''" flag="fatal" id="BR-25">[BR-25]-Each Invoice line (BG-25) shall contain the Item name (BT-153).</assert>
         <assert test="exists(cac:Price/cbc:PriceAmount)" flag="fatal" id="BR-26">[BR-26]-Each Invoice line (BG-25) shall contain the Item net price (BT-146).</assert>
         <assert test="(cac:Price/cbc:PriceAmount) &gt;= 0" flag="fatal" id="BR-27">[BR-27]-The Item net price (BT-146) shall NOT be negative.</assert>
         <assert test="(cac:Price/cac:AllowanceCharge/cbc:BaseAmount) &gt;= 0 or not(exists(cac:Price/cac:AllowanceCharge/cbc:BaseAmount))"
                 flag="fatal"
                 id="BR-28">[BR-28]-The Item gross price (BT-148) shall NOT be negative.</assert>
         <assert test="(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)"
                 flag="fatal"
                 id="BR-CO-04">[BR-CO-04]-Each Invoice line (BG-25) shall be categorized with an Invoiced item VAT category code (BT-151).</assert>
         <assert test="string-length(substring-after(cbc:LineExtensionAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-23">[BR-DEC-23]-The allowed maximum number of decimals for the Invoice line net amount (BT-131) is 2.    </assert>
      </rule>
      <rule context="//cac:InvoiceLine/cac:AllowanceCharge[cbc:ChargeIndicator = 'false'] | //cac:CreditNoteLine/cac:AllowanceCharge[cbc:ChargeIndicator = 'false']">
         <assert test="exists(cbc:Amount)" flag="fatal" id="BR-41">[BR-41]-Each Invoice line allowance (BG-27) shall have an Invoice line allowance amount (BT-136).</assert>
         <assert test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)"
                 flag="fatal"
                 id="BR-42">[BR-42]-Each Invoice line allowance (BG-27) shall have an Invoice line allowance reason (BT-139) or an Invoice line allowance reason code (BT-140).</assert>
         <assert test="true()" flag="fatal" id="BR-CO-07">[BR-CO-07]-Invoice line allowance reason code (BT-140) and Invoice line allowance reason (BT-139) shall indicate the same type of allowance reason.</assert>
         <assert test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)"
                 flag="fatal"
                 id="BR-CO-23">[BR-CO-23]-Each Invoice line allowance (BG-27) shall contain an Invoice line allowance reason (BT-139) or an Invoice line allowance reason code (BT-140), or both.</assert>
         <assert test="string-length(substring-after(cbc:Amount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-24">[BR-DEC-24]-The allowed maximum number of decimals for the Invoice line allowance amount (BT-136) is 2.</assert>
         <assert test="string-length(substring-after(cbc:BaseAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-25">[BR-DEC-25]-The allowed maximum number of decimals for the Invoice line allowance base amount (BT-137) is 2.    </assert>
      </rule>
      <rule context="//cac:InvoiceLine/cac:AllowanceCharge[cbc:ChargeIndicator = 'true'] | //cac:CreditNoteLine/cac:AllowanceCharge[cbc:ChargeIndicator = 'true']">
         <assert test="exists(cbc:Amount)" flag="fatal" id="BR-43">[BR-43]-Each Invoice line charge (BG-28) shall have an Invoice line charge amount (BT-141).</assert>
         <assert test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)"
                 flag="fatal"
                 id="BR-44">[BR-44]-Each Invoice line charge shall have an Invoice line charge reason or an invoice line allowance reason code. </assert>
         <assert test="true()" flag="fatal" id="BR-CO-08">[BR-CO-08]-Invoice line charge reason code (BT-145) and Invoice line charge reason (BT144) shall indicate the same type of charge reason.</assert>
         <assert test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)"
                 flag="fatal"
                 id="BR-CO-24">[BR-CO-24]-Each Invoice line charge (BG-28) shall contain an Invoice line charge reason (BT-144) or an Invoice line charge reason code (BT-145), or both.</assert>
         <assert test="string-length(substring-after(cbc:Amount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-27">[BR-DEC-27]-The allowed maximum number of decimals for the Invoice line charge amount (BT-141) is 2.</assert>
         <assert test="string-length(substring-after(cbc:BaseAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-28">[BR-DEC-28]-The allowed maximum number of decimals for the Invoice line charge base amount (BT-142) is 2.    </assert>
      </rule>
      <rule context="cac:InvoiceLine/cac:InvoicePeriod | cac:CreditNoteLine/cac:InvoicePeriod">
         <assert test="(exists(cbc:EndDate) and exists(cbc:StartDate) and (cbc:EndDate) &gt;= (cbc:StartDate)) or not(exists(cbc:StartDate)) or not(exists(cbc:EndDate))"
                 flag="fatal"
                 id="BR-30">[BR-30]-If both Invoice line period start date (BT-134) and Invoice line period end date (BT-135) are given then the Invoice line period end date (BT-135) shall be later or equal to the Invoice line period start date (BT-134).</assert>
         <assert test="exists(cbc:StartDate) or exists(cbc:EndDate)"
                 flag="fatal"
                 id="BR-CO-20">[BR-CO-20]-If Invoice line period (BG-26) is used, the Invoice line period start date (BT-134) or the Invoice line period end date (BT-135) shall be filled, or both.</assert>
      </rule>
      <rule context="cac:InvoicePeriod">
         <assert test="(exists(cbc:EndDate) and exists(cbc:StartDate) and (cbc:EndDate) &gt;= (cbc:StartDate)) or not(exists(cbc:StartDate)) or not(exists(cbc:EndDate))"
                 flag="fatal"
                 id="BR-29">[BR-29]-If both Invoicing period start date (BT-73) and Invoicing period end date (BT-74) are given then the Invoicing period end date (BT-74) shall be later or equal to the Invoicing period start date (BT-73).</assert>
         <assert test="exists(cbc:StartDate) or exists(cbc:EndDate)"
                 flag="fatal"
                 id="BR-CO-19">[BR-CO-19]-If Invoicing period (BG-14) is used, the Invoicing period start date (BT-73) or the Invoicing period end date (BT-74) shall be filled, or both.</assert>
      </rule>
      <rule context="//cac:AdditionalItemProperty">
         <assert test="exists(cbc:Name) and exists(cbc:Value)"
                 flag="fatal"
                 id="BR-54">[BR-54]-Each Item attribute (BG-32) shall contain an Item attribute name (BT-160) and an Item attribute value (BT-161).</assert>
      </rule>
      <rule context="cac:InvoiceLine/cac:Item/cac:CommodityClassification/cbc:ItemClassificationCode | cac:CreditNoteLine/cac:Item/cac:CommodityClassification/cbc:ItemClassificationCode ">
         <assert test="exists(@listID)" flag="fatal" id="BR-65">[BR-65]-The Item classification identifier (BT-158) shall have a Scheme identifier.</assert>
      </rule>
      <rule context="cac:InvoiceLine/cac:Item/cac:StandardItemIdentification/cbc:ID | cac:CreditNoteLine/cac:Item/cac:StandardItemIdentification/cbc:ID">
         <assert test="exists(@schemeID)" flag="fatal" id="BR-64">[BR-64]-The Item standard identifier (BT-157) shall have a Scheme identifier.</assert>
      </rule>
      <rule context="//ubl:Invoice/cbc:Note | //cn:CreditNote/cac:Note">
         <assert test="(contains(.,'#') and ( ( contains(' AAA AAB AAC AAD AAE AAF AAG AAI AAJ AAK AAL AAM AAN AAO AAP AAQ AAR AAS AAT AAU AAV AAW AAX AAY AAZ ABA ABB ABC ABD ABE ABF ABG ABH ABI ABJ ABK ABL ABM ABN ABO ABP ABQ ABR ABS ABT ABU ABV ABW ABX ABZ ACA ACB ACC ACD ACE ACF ACG ACH ACI ACJ ACK ACL ACM ACN ACO ACP ACQ ACR ACS ACT ACU ACV ACW ACX ACY ACZ ADA ADB ADC ADD ADE ADF ADG ADH ADI ADJ ADK ADL ADM ADN ADO ADP ADQ ADR ADS ADT ADU ADV ADW ADX ADY ADZ AEA AEB AEC AED AEE AEF AEG AEH AEI AEJ AEK AEL AEM AEN AEO AEP AEQ AER AES AET AEU AEV AEW AEX AEY AEZ AFA AFB AFC AFD AFE AFF AFG AFH AFI AFJ AFK AFL AFM AFN AFO AFP AFQ AFR AFS AFT AFU AFV AFW AFX AFY AFZ AGA AGB AGC AGD AGE AGF AGG AGH AGI AGJ AGK AGL AGM AGN AGO AGP AGQ AGR AGS AGT AGU AGV AGW AGX AGY AGZ AHA AHB AHC AHD AHE AHF AHG AHH AHI AHJ AHK AHL AHM AHN AHO AHP AHQ AHR AHS AHT AHU AHV AHW AHX AHY AHZ AIA AIB AIC AID AIE AIF AIG AIH AII AIJ AIK AIL AIM AIN AIO AIP AIQ AIR AIS AIT AIU AIV AIW AIX AIY AIZ AJA AJB ALC ALD ALE ALF ALG ALH ALI ALJ ALK ALL ALM ALN ALO ALP ALQ ARR ARS AUT AUU AUV AUW AUX AUY AUZ AVA AVB AVC AVD AVE AVF BAG BAH BAI BAJ BAK BAL BAM BAN BAO BAP BAQ BLC BLD BLE BLF BLG BLH BLI BLJ BLK BLL BLM BLN BLO BLP BLQ BLR BLS BLT BLU BLV BLW BLX BLY BLZ BMA BMB BMC BMD BME CCI CEX CHG CIP CLP CLR COI CUR CUS DAR DCL DEL DIN DOC DUT EUR FBC GBL GEN GS7 HAN HAZ ICN IIN IMI IND INS INV IRP ITR ITS LAN LIN LOI MCO MDH MKS ORI OSI PAC PAI PAY PKG PKT PMD PMT PRD PRF PRI PUR QIN QQD QUT RAH REG RET REV RQR SAF SIC SIN SLR SPA SPG SPH SPP SPT SRN SSR SUR TCA TDT TRA TRR TXD WHI ZZZ ',substring-before(substring-after(.,'#'),'#') ) ) )) or not(contains(.,'#'))"
                 flag="fatal"
                 id="BR-CL-08">[BR-CL-08]-Invoiced note subject code SHOULD be coded using UNCL4451</assert>
      </rule>
      <rule context="cac:PayeeParty">
         <assert test="exists(cac:PartyName/cbc:Name) and (not(cac:PartyName/cbc:Name = ../cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name) and not(cac:PartyIdentification/cbc:ID = ../cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID) and not(cac:PartyLegalEntity/cbc:RegistrationName = ../cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName))"
                 flag="fatal"
                 id="BR-17">[BR-17]-The Payee name (BT-59) shall be provided in the Invoice, if the Payee (BG-10) is different from the Seller (BG-4)</assert>
      </rule>
      <rule context="cac:PaymentMeans[cbc:PaymentMeansCode='30' or cbc:PaymentMeansCode='58']/cac:PayeeFinancialAccount">
         <assert test="(cbc:ID) != ''" flag="fatal" id="BR-50">[BR-50]-A Payment account identifier (BT-84) shall be present if Credit transfer (BG-17) information is provided in the Invoice.</assert>
      </rule>
      <rule context="cac:PaymentMeans">
         <assert test="exists(cbc:PaymentMeansCode)" flag="fatal" id="BR-49">[BR-49]-A Payment instruction (BG-16) shall specify the Payment means type code (BT-81).</assert>
         <assert test="(exists(cac:PayeeFinancialAccount/cbc:ID) and ((normalize-space(cbc:PaymentMeansCode) = '30') or (normalize-space(cbc:PaymentMeansCode) = '58') )) or ((normalize-space(cbc:PaymentMeansCode) != '30') and (normalize-space(cbc:PaymentMeansCode) != '58'))"
                 flag="fatal"
                 id="BR-61">[BR-61]-If the Payment means type code (BT-81) means SEPA credit transfer, Local credit transfer or Non-SEPA international credit transfer, the Payment account identifier (BT-84) shall be present.</assert>
      </rule>
      <rule context="cac:BillingReference">
         <assert test="exists(cac:InvoiceDocumentReference/cbc:ID)"
                 flag="fatal"
                 id="BR-55">[BR-55]-Each Preceding Invoice reference (BG-3) shall contain a Preceding Invoice reference (BT-25).</assert>
      </rule>
      <rule context="cac:AccountingSupplierParty">
         <assert test="exists(cac:Party/cac:PartyTaxScheme/cbc:CompanyID) or exists(cac:Party/cac:PartyIdentification/cbc:ID) or exists(cac:Party/cac:PartyLegalEntity/cbc:CompanyID)"
                 flag="fatal"
                 id="BR-CO-26">[BR-CO-26]-In order for the buyer to automatically identify a supplier, the Seller identifier (BT-29), the Seller legal registration identifier (BT-30) and/or the Seller VAT identifier (BT-31) shall be present.  </assert>
      </rule>
      <rule context="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID">
         <assert test="exists(@schemeID)" flag="fatal" id="BR-62">[BR-62]-The Seller electronic address (BT-34) shall have a Scheme identifier.</assert>
      </rule>
      <rule context="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress">
         <assert test="(cac:Country/cbc:IdentificationCode) != ''"
                 flag="fatal"
                 id="BR-09">[BR-09]-The Seller postal address (BG-5) shall contain a Seller country code (BT-40).</assert>
      </rule>
      <rule context="cac:TaxRepresentativeParty">
         <assert test="(cac:PartyName/cbc:Name) != ''" flag="fatal" id="BR-18">[BR-18]-The Seller tax representative name (BT-62) shall be provided in the Invoice, if the Seller (BG-4) has a Seller tax representative party (BG-11)</assert>
         <assert test="exists(cac:PostalAddress)" flag="fatal" id="BR-19">[BR-19]-The Seller tax representative postal address (BG-12) shall be provided in the Invoice, if the Seller (BG-4) has a Seller tax representative party (BG-11).</assert>
         <assert test="exists(cac:PartyTaxScheme[cac:TaxScheme/cbc:ID = 'VAT']/cbc:CompanyID)"
                 flag="fatal"
                 id="BR-56">[BR-56]-Each Seller tax representative party (BG-11) shall have a Seller tax representative VAT identifier (BT-63).    </assert>
      </rule>
      <rule context="cac:TaxRepresentativeParty/cac:PostalAddress">
         <assert test="(cac:Country/cbc:IdentificationCode) != ''"
                 flag="fatal"
                 id="BR-20">[BR-20]-The Seller tax representative postal address (BG-12) shall contain a Tax representative country code (BT-69), if the Seller (BG-4) has a Seller tax representative party (BG-11).</assert>
      </rule>
      <rule context="//ubl:Invoice/cac:TaxTotal | //cn:CreditNote/cac:Taxtotal">
         <assert test="(xs:decimal(child::cbc:TaxAmount)= round((sum(cac:TaxSubtotal/xs:decimal(cbc:TaxAmount)) * 10 * 10)) div 100) or not(cac:TaxSubtotal)"
                 flag="fatal"
                 id="BR-CO-14">[BR-CO-14]-Invoice total VAT amount (BT-110) = Σ VAT category tax amount (BT-117).</assert>
      </rule>
      <rule context="cac:TaxTotal/cac:TaxSubtotal">
         <assert test="exists(cbc:TaxableAmount)" flag="fatal" id="BR-45">[BR-45]-Each VATBReakdown (BG-23) shall have a VAT category taxable amount (BT-116).</assert>
         <assert test="exists(cbc:TaxAmount)" flag="fatal" id="BR-46">[BR-46]-Each VATBReakdown (BG-23) shall have a VAT category tax amount (BT-117).</assert>
         <assert test="exists(cac:TaxCategory/cbc:ID)" flag="fatal" id="BR-47">[BR-47]-Each VATBReakdown (BG-23) shall be defined through a VAT category code (BT-118).</assert>
         <assert test="exists(cac:TaxCategory/cbc:Percent) or (normalize-space(cac:TaxCategory/cbc:ID)='O')"
                 flag="fatal"
                 id="BR-48">[BR-48]-Each VATBReakdown (BG-23) shall have a VAT category rate (BT-119), except if the Invoice is not subject to VAT.</assert>
         <assert test="(round(cac:TaxCategory/xs:decimal(cbc:Percent)) = 0 and (round(xs:decimal(cbc:TaxAmount)) = 0)) or (round(cac:TaxCategory/xs:decimal(cbc:Percent)) != 0 and (xs:decimal(cbc:TaxAmount) = round(xs:decimal(cbc:TaxableAmount) * (cac:TaxCategory/xs:decimal(cbc:Percent) div 100) * 10 * 10) div 100 )) or (not(exists(cac:TaxCategory/xs:decimal(cbc:Percent))) and (round(xs:decimal(cbc:TaxAmount)) = 0))"
                 flag="fatal"
                 id="BR-CO-17">[BR-CO-17]-VAT category tax amount (BT-117) = VAT category taxable amount (BT-116) x (VAT category rate (BT-119) / 100), rounded to two decimals.</assert>
         <assert test="string-length(substring-after(cbc:TaxableAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-19">[BR-DEC-19]-The allowed maximum number of decimals for the VAT category taxable amount (BT-116) is 2.</assert>
         <assert test="string-length(substring-after(cbc:TaxAmount,'.'))&lt;=2"
                 flag="fatal"
                 id="BR-DEC-20">[BR-DEC-20]-The allowed maximum number of decimals for the VAT category tax amount (BT-117) is 2.    </assert>
      </rule>
      <rule context="//cac:PartyTaxScheme[cac:TaxScheme/cbc:ID='VAT']">
         <assert test="( contains( 'AD AE AF AG AI AL AM AN AO AQ AR AS AT AU AW AX AZ BA BB BD BE BF BG BH BI BL BJ BM BN BO BR BS BT BV BW BY BZ CA CC CD CF CG CH CI CK CL CM CN CO CR CU CV CX CY CZ DE DJ DK DM DO DZ EC EE EG EH EL ER ES ET FI FJ FK FM FO FR GA GB GD GE GF GG GH GI GL GM GN GP GQ GR GS GT GU GW GY HK HM HN HR HT HU ID IE IL IM IN IO IQ IR IS IT JE JM JO JP KE KG KH KI KM KN KP KR KW KY KZ LA LB LC LI LK LR LS LT LU LV LY MA MC MD ME MF MG MH MK ML MM MN MO MP MQ MR MS MT MU MV MW MX MY MZ NA NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM PN PR PS PT PW PY QA RO RS RU RW SA SB SC SD SE SG SH SI SJ SK SL SM SN SO SR ST SV SY SZ TC TD TF TG TH TJ TK TL TM TN TO TR TT TV TW TZ UA UG UM US UY UZ VA VC VE VG VI VN VU WF WS YE YT ZA ZM ZW',substring(cbc:CompanyID,1,2) ) )"
                 flag="fatal"
                 id="BR-CO-09">[BR-CO-09]-The Seller VAT identifier (BT-31), the Seller tax representative VAT identifier (BT-63) and the Buyer VAT identifier (BT-48) shall have a prefix in accordance with ISO code ISO 3166-1 alpha-2 by which the country of issue may be identified. Nevertheless, Greece may use the prefix ‘EL’.</assert>
      </rule>
      <rule context="cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[normalize-space(cbc:ID) = 'AE']">
         <assert test="(exists(//cac:InvoiceLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:InvoiceLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='AE']/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='AE']/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='AE']/xs:decimal(cbc:Amount))))) or (exists(//cac:CreditNoteLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:CreditNoteLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='AE']/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='AE']/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='AE']/xs:decimal(cbc:Amount)))))"
                 flag="fatal"
                 id="BR-AE-08">[BR-AE-08]-In a VATBReakdown (BG-23) where the VAT category code (BT-118) is "Reverse charge" the VAT category taxable amount (BT-116) shall equal the sum of Invoice line net amounts (BT-131) minus the sum of Document level allowance amounts (BT-92) plus the sum of Document level charge amounts (BT-99) where the VAT category codes (BT-151, BT-95, BT-102) are “Reverse charge".</assert>
         <assert test="../cbc:TaxAmount = 0" flag="fatal" id="BR-AE-09">[BR-AE-09]-The VAT category tax amount (BT-117) in a VATBReakdown (BG-23) where the VAT category code (BT-118) is “Reverse charge” shall be 0 (zero).</assert>
         <assert test="exists(cbc:TaxExemptionReason) or exists(cbc:TaxExemptionReasonCode)"
                 flag="fatal"
                 id="BR-AE-10">[BR-AE-10]-A VATBReakdown (BG-23) with VAT Category code (BT-118) "Reverse charge" shall have a VAT exemption reason code (BT-121), meaning "Reverse charge" or the VAT exemption reason text (BT-120) "Reverse charge" (or the equivalent standard text in another language).</assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='AE']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-AE-06">[BR-AE-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "Reverse charge" the Document level allowance VAT rate (BT-96) shall be 0 (zero).</assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='AE']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-AE-07">[BR-AE-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "Reverse charge" the Document level charge VAT rate (BT-103) shall be 0 (zero).</assert>
      </rule>
      <rule context="cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'AE'] | cac:CreditNoteLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'AE']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-AE-05">[BR-AE-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "Reverse charge" the Invoiced item VAT rate (BT-152) shall be 0 (zero).</assert>
      </rule>
      <rule context="cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[normalize-space(cbc:ID) = 'E']">
         <assert test="(exists(//cac:InvoiceLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:InvoiceLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='E']/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='E']/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='E']/xs:decimal(cbc:Amount))))) or (exists(//cac:CreditNoteLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:CreditNoteLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='E']/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='E']/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='E']/xs:decimal(cbc:Amount)))))"
                 flag="fatal"
                 id="BR-E-08">[BR-E-08]-In a VATBReakdown (BG-23) where the VAT category code (BT-118) is "Exempt from VAT" the VAT category taxable amount (BT-116) shall equal the sum of Invoice line net amounts (BT-131) minus the sum of Document level allowance amounts (BT-92) plus the sum of Document level charge amounts (BT-99) where the VAT category codes (BT-151, BT-95, BT-102) are “Exempt from VAT".</assert>
         <assert test="../cbc:TaxAmount = 0" flag="fatal" id="BR-E-09">[BR-E-09]-The VAT category tax amount (BT-117) In a VATBReakdown (BG-23) where the VAT category code (BT-118) equals "Exempt from VAT" shall equal 0 (zero).</assert>
         <assert test="exists(cbc:TaxExemptionReason) or exists(cbc:TaxExemptionReasonCode)"
                 flag="fatal"
                 id="BR-E-10">[BR-E-10]-A VATBReakdown (BG-23) with VAT Category code (BT-118) "Exempt from VAT" shall have a VAT exemption reason code (BT-121) or a VAT exemption reason text (BT-120).    </assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='E']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-E-06">[BR-E-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "Exempt from VAT", the Document level allowance VAT rate (BT-96) shall be 0 (zero).    </assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='E']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-E-07">[BR-E-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "Exempt from VAT", the Document level charge VAT rate (BT-103) shall be 0 (zero).    </assert>
      </rule>
      <rule context="cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'E'] | cac:CreditNoteLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'E']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-E-05">[BR-E-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "Exempt from VAT", the Invoiced item VAT rate (BT-152) shall be 0 (zero).    </assert>
      </rule>
      <rule context="cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[normalize-space(cbc:ID) = 'G']">
         <assert test="(exists(//cac:InvoiceLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:InvoiceLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='G']/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='G']/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='G']/xs:decimal(cbc:Amount))))) or (exists(//cac:CreditNoteLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:CreditNoteLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='G']/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='G']/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='G']/xs:decimal(cbc:Amount)))))"
                 flag="fatal"
                 id="BR-G-08">[BR-G-08]-In a VATBReakdown (BG-23) where the VAT category code (BT-118) is "Export outside the EU" the VAT category taxable amount (BT-116) shall equal the sum of Invoice line net amounts (BT-131) minus the sum of Document level allowance amounts (BT-92) plus the sum of Document level charge amounts (BT-99) where the VAT category codes (BT-151, BT-95, BT-102) are “Export outside the EU".</assert>
         <assert test="../cbc:TaxAmount = 0" flag="fatal" id="BR-G-09">[BR-G-09]-The VAT category tax amount (BT-117) in a VATBReakdown (BG-23) where the VAT category code (BT-118) is “Export outside the EU” shall be 0 (zero).</assert>
         <assert test="exists(cbc:TaxExemptionReason) or exists(cbc:TaxExemptionReasonCode)"
                 flag="fatal"
                 id="BR-G-10">[BR-G-10]-A VATBReakdown (BG-23) with the VAT Category code (BT-118) "Export outside the EU" shall have a VAT exemption reason code (BT-121), meaning "Export outside the EU" or the VAT exemption reason text (BT-120) "Export outside the EU" (or the equivalent standard text in another language).</assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='G']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-G-06">[BR-G-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "Export outside the EU" the Document level allowance VAT rate (BT-96) shall be 0 (zero).</assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='G']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-G-07">[BR-G-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "Export outside the EU" the Document level charge VAT rate (BT-103) shall be 0 (zero).</assert>
      </rule>
      <rule context="cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'G'] | cac:CreditNoteLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'G']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-G-05">[BR-G-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "Export outside the EU" the Invoiced item VAT rate (BT-152) shall be 0 (zero).</assert>
      </rule>
      <rule context="cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[normalize-space(cbc:ID) = 'K']">
         <assert test="(exists(//cac:InvoiceLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:InvoiceLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='K']/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='K']/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='K']/xs:decimal(cbc:Amount))))) or (exists(//cac:CreditNoteLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:CreditNoteLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='K']/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='K']/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='K']/xs:decimal(cbc:Amount)))))"
                 flag="fatal"
                 id="BR-IC-08">[BR-IC-08]-In a VATBReakdown (BG-23) where the VAT category code (BT-118) is "Intra-community supply" the VAT category taxable amount (BT-116) shall equal the sum of Invoice line net amounts (BT-131) minus the sum of Document level allowance amounts (BT-92) plus the sum of Document level charge amounts (BT-99) where the VAT category codes (BT-151, BT-95, BT-102) are “Intra-community supply".</assert>
         <assert test="../cbc:TaxAmount = 0" flag="fatal" id="BR-IC-09">[BR-IC-09]-The VAT category tax amount (BT-117) in a VATBReakdown (BG-23) where the VAT category code (BT-118) is “Intra-community supply” shall be 0 (zero).</assert>
         <assert test="exists(cbc:TaxExemptionReason) or exists(cbc:TaxExemptionReasonCode)"
                 flag="fatal"
                 id="BR-IC-10">[BR-IC-10]-A VATBReakdown (BG-23) with the VAT Category code (BT-118) "Intra-community supply" shall have a VAT exemption reason code (BT-121), meaning "Intra-community supply" or the VAT exemption reason text (BT-120) "Intra-community supply" (or the equivalent standard text in another language).</assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='K']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-IC-06">[BR-IC-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "Intra-community supply" the Document level allowance VAT rate (BT-96) shall be 0 (zero).</assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='K']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-IC-07">[BR-IC-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "Intra-community supply" the Document level charge VAT rate (BT-103) shall be 0 (zero).</assert>
      </rule>
      <rule context="cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'K'] | cac:CreditNoteLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'K']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-IC-05">[BR-IC-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "Intracommunity supply" the Invoiced item VAT rate (BT-152) shall be 0 (zero).</assert>
      </rule>
      <rule context="cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[normalize-space(cbc:ID) = 'L']">
         <assert test="every $rate in round(cbc:Percent) satisfies ((exists(//cac:InvoiceLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:InvoiceLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='L'][cac:Item/cac:ClassifiedTaxCategory/round(cbc:Percent) =$rate]/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='L'][cac:TaxCategory/round(cbc:Percent) = $rate]/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='L'][cac:TaxCategory/round(cbc:Percent) = $rate]/xs:decimal(cbc:Amount))))) or (exists(//cac:CreditNoteLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:CreditNoteLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='L'][cac:Item/cac:ClassifiedTaxCategory/round(cbc:Percent) =$rate]/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='L'][cac:TaxCategory/round(cbc:Percent) = $rate]/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='L'][cac:TaxCategory/round(cbc:Percent) = $rate]/xs:decimal(cbc:Amount))))))"
                 flag="fatal"
                 id="BR-IG-08">[BR-IG-08]-For each different value of VAT category rate (BT-119) where the VAT category code (BT-118) is "IGIC", the VAT category taxable amount (BT-116) in a VATBReakdown (BG-23) shall equal the sum of Invoice line net amounts (BT-131) plus the sum of document level charge amounts (BT-99) minus the sum of document level allowance amounts (BT-92) where the VAT category code (BT-151, BT-102, BT-95) is “IGIC” and the VAT rate (BT-152, BT-103, BT-96) equals the VAT category rate (BT-119).</assert>
         <assert test="xs:decimal(../cbc:TaxAmount) = round((xs:decimal(../cbc:TaxableAmount) * (xs:decimal(cbc:Percent) div 100)) * 10 * 10) div 100 "
                 flag="fatal"
                 id="BR-IG-09">[BR-IG-09]-The VAT category tax amount (BT-117) in a VATBReakdown (BG-23) where VAT category code (BT-118) is "IGIC" shall equal the VAT category taxable amount (BT-116) multiplied by the VAT category rate (BT-119).</assert>
         <assert test="not(cbc:TaxExemptionReason) and not(cbc:TaxExemptionReasonCode)"
                 flag="fatal"
                 id="BR-IG-10">[BR-IG-10]-A VATBReakdown (BG-23) with VAT Category code (BT-118) "IGIC" shall not have a VAT exemption reason code (BT-121) or VAT exemption reason text (BT-120).    </assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='L']">
         <assert test="(cbc:Percent) &gt;= 0" flag="fatal" id="BR-IG-06">[BR-IG-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "IGIC" the Document level allowance VAT rate (BT-96) shall be 0 (zero) or greater than zero.      </assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='L']">
         <assert test="(cbc:Percent) &gt;= 0" flag="fatal" id="BR-IG-07">[BR-IG-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "IGIC" the Document level charge VAT rate (BT-103) shall be 0 (zero) or greater than zero.</assert>
      </rule>
      <rule context="cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'L']| cac:CreditNoteLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'L']">
         <assert test="(cbc:Percent) &gt;= 0" flag="fatal" id="BR-IG-05">[BR-IG-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "IGIC" the invoiced item VAT rate (BT-152) shall be 0 (zero) or greater than zero.    </assert>
      </rule>
      <rule context="cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[normalize-space(cbc:ID) = 'M']">
         <assert test="every $rate in round(cbc:Percent) satisfies ((exists(//cac:InvoiceLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:InvoiceLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='M'][cac:Item/cac:ClassifiedTaxCategory/round(cbc:Percent) =$rate]/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='M'][cac:TaxCategory/round(cbc:Percent) = $rate]/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='M'][cac:TaxCategory/round(cbc:Percent) = $rate]/xs:decimal(cbc:Amount))))) or (exists(//cac:CreditNoteLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:CreditNoteLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='M'][cac:Item/cac:ClassifiedTaxCategory/round(cbc:Percent) =$rate]/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='M'][cac:TaxCategory/round(cbc:Percent) = $rate]/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='M'][cac:TaxCategory/round(cbc:Percent) = $rate]/xs:decimal(cbc:Amount))))))"
                 flag="fatal"
                 id="BR-IP-08">[BR-IP-08]-For each different value of VAT category rate (BT-119) where the VAT category code (BT-118) is "IPSI", the VAT category taxable amount (BT-116) in a VATBReakdown (BG-23) shall equal the sum of Invoice line net amounts (BT-131) plus the sum of document level charge amounts (BT-99) minus the sum of document level allowance amounts (BT-92) where the VAT category code (BT-151, BT-102, BT-95) is “IPSI” and the VAT rate (BT-152, BT-103, BT-96) equals the VAT category rate (BT-119).</assert>
         <assert test="xs:decimal(../cbc:TaxAmount) = round((xs:decimal(../cbc:TaxableAmount) * (xs:decimal(cbc:Percent) div 100)) * 10 * 10) div 100 "
                 flag="fatal"
                 id="BR-IP-09">[BR-IP-09]-The VAT category tax amount (BT-117) in a VATBReakdown (BG-23) where VAT category code (BT-118) is "IPSI" shall equal the VAT category taxable amount (BT-116) multiplied by the VAT category rate (BT-119).</assert>
         <assert test="not(cbc:TaxExemptionReason) and not(cbc:TaxExemptionReasonCode)"
                 flag="fatal"
                 id="BR-IP-10">[BR-IP-10]-A VATBReakdown (BG-23) with VAT Category code (BT-118) "IPSI" shall not have a VAT exemption reason code (BT-121) or VAT exemption reason text (BT-120).     </assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='M']">
         <assert test="(cbc:Percent) &gt;= 0" flag="fatal" id="BR-IP-06">[BR-IP-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "IPSI" the Document level allowance VAT rate (BT-96) shall be 0 (zero) or greater than zero.      </assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='M']">
         <assert test="(cbc:Percent) &gt;= 0" flag="fatal" id="BR-IP-07">[BR-IP-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "IPSI" the Document level charge VAT rate (BT-103) shall be 0 (zero) or greater than zero.</assert>
      </rule>
      <rule context="cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'M']| cac:CreditNoteLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'M']">
         <assert test="(cbc:Percent) &gt;= 0" flag="fatal" id="BR-IP-05">[BR-IP-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "IPSI" the Invoiced item VAT rate (BT-152) shall be 0 (zero) or greater than zero.    </assert>
      </rule>
      <rule context="cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[normalize-space(cbc:ID) = 'O']">
         <assert test="(exists(//cac:InvoiceLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:InvoiceLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='O']/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='O']/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='O']/xs:decimal(cbc:Amount))))) or (exists(//cac:CreditNoteLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:CreditNoteLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='O']/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='O']/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='O']/xs:decimal(cbc:Amount)))))"
                 flag="fatal"
                 id="BR-O-08">[BR-O-08]-In a VATBReakdown (BG-23) where the VAT category code (BT-118) is " Not subject to VAT" the VAT category taxable amount (BT-116) shall equal the sum of Invoice line net amounts (BT-131) minus the sum of Document level allowance amounts (BT-92) plus the sum of Document level charge amounts (BT-99) where the VAT category codes (BT-151, BT-95, BT-102) are “Not subject to VAT".</assert>
         <assert test="../cbc:TaxAmount = 0" flag="fatal" id="BR-O-09">[BR-O-09]-The VAT category tax amount (BT-117) in a VATBReakdown (BG-23) where the VAT category code (BT-118) is “Not subject to VAT” shall be 0 (zero).</assert>
         <assert test="exists(cbc:TaxExemptionReason) or exists(cbc:TaxExemptionReasonCode)"
                 flag="fatal"
                 id="BR-O-10">[BR-O-10]-A VATBReakdown (BG-23) with VAT Category code (BT-118) " Not subject to VAT" shall have a VAT exemption reason code (BT-121), meaning " Not subject to VAT" or a VAT exemption reason text (BT-120) " Not subject to VAT" (or the equivalent standard text in another language).</assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='O']">
         <assert test="not(cbc:Percent)" flag="fatal" id="BR-O-06">[BR-O-06]-A Document level allowance (BG-20) where VAT category code (BT-95) is "Not subject to VAT" shall not contain a Document level allowance VAT rate (BT-96).</assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='O']">
         <assert test="not(cbc:Percent)" flag="fatal" id="BR-O-07">[BR-O-07]-A Document level charge (BG-21) where the VAT category code (BT-102) is "Not subject to VAT" shall not contain a Document level charge VAT rate (BT-103).</assert>
      </rule>
      <rule context="cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'O'] | cac:CreditNoteLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'O']">
         <assert test="not(cbc:Percent)" flag="fatal" id="BR-O-05">[BR-O-05]-An Invoice line (BG-25) where the VAT category code (BT-151) is "Not subject to VAT" shall not contain an Invoiced item VAT rate (BT-152).</assert>
      </rule>
      <rule context="cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[normalize-space(cbc:ID) = 'S']">
         <assert test="every $rate in round(cbc:Percent) satisfies ((exists(//cac:InvoiceLine) and (../cbc:TaxableAmount = (sum(../../../cac:InvoiceLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='S'][cac:Item/cac:ClassifiedTaxCategory/round(cbc:Percent) =$rate]/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='S'][cac:TaxCategory/round(cbc:Percent) = $rate]/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='S'][cac:TaxCategory/round(cbc:Percent) = $rate]/xs:decimal(cbc:Amount))))) or (exists(//cac:CreditNoteLine) and (../cbc:TaxableAmount = (sum(../../../cac:CreditNoteLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='S'][cac:Item/cac:ClassifiedTaxCategory/round(cbc:Percent) =$rate]/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='S'][cac:TaxCategory/round(cbc:Percent) = $rate]/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='S'][cac:TaxCategory/round(cbc:Percent) = $rate]/xs:decimal(cbc:Amount))))))"
                 flag="fatal"
                 id="BR-S-08">[BR-S-08]-For each different value of VAT category rate (BT-119) where the VAT category code (BT-118) is "Standard rated", the VAT category taxable amount (BT-116) in a VATBReakdown (BG-23) shall equal the sum of Invoice line net amounts (BT-131) plus the sum of document level charge amounts (BT-99) minus the sum of document level allowance amounts (BT-92) where the VAT category code (BT-151, BT-102, BT-95) is “Standard rated” and the VAT rate (BT-152, BT-103, BT-96) equals the VAT category rate (BT-119).</assert>
         <assert test="xs:decimal(../cbc:TaxAmount) = round((xs:decimal(../cbc:TaxableAmount) * (xs:decimal(cbc:Percent) div 100)) * 10 * 10) div 100 "
                 flag="fatal"
                 id="BR-S-09">[BR-S-09]-The VAT category tax amount (BT-117) in a VATBReakdown (BG-23) where VAT category code (BT-118) is "Standard rated" shall equal the VAT category taxable amount (BT-116) multiplied by the VAT category rate (BT-119).</assert>
         <assert test="not(cbc:TaxExemptionReason) and not(cbc:TaxExemptionReasonCode)"
                 flag="fatal"
                 id="BR-S-10">[BR-S-10]-A VATBReakdown (BG-23) with VAT Category code (BT-118) "Standard rate" shall not have a VAT exemption reason code (BT-121) or VAT exemption reason text (BT-120).    </assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='S']">
         <assert test="(cbc:Percent) &gt; 0" flag="fatal" id="BR-S-06">[BR-S-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "Standard rated" the Document level allowance VAT rate (BT-96) shall be greater than zero.</assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='S']">
         <assert test="(cbc:Percent) &gt; 0" flag="fatal" id="BR-S-07">[BR-S-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "Standard rated" the Document level charge VAT rate (BT-103) shall be greater than zero.  </assert>
      </rule>
      <rule context="cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'S'] | cac:CreditNoteLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'S']">
         <assert test="(cbc:Percent) &gt; 0" flag="fatal" id="BR-S-05">[BR-S-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "Standard rated" the Invoiced item VAT rate (BT-152) shall be greater than zero.    </assert>
      </rule>
      <rule context="cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory[normalize-space(cbc:ID) = 'Z']">
         <assert test="(exists(//cac:InvoiceLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:InvoiceLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='Z']/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='Z']/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='Z']/xs:decimal(cbc:Amount))))) or (exists(//cac:CreditNoteLine) and (xs:decimal(../cbc:TaxableAmount) = (sum(../../../cac:CreditNoteLine[normalize-space(cac:Item/cac:ClassifiedTaxCategory/cbc:ID)='Z']/xs:decimal(cbc:LineExtensionAmount)) + sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='true'][normalize-space(cac:TaxCategory/cbc:ID)='Z']/xs:decimal(cbc:Amount)) - sum(../../../cac:AllowanceCharge[cbc:ChargeIndicator='false'][normalize-space(cac:TaxCategory/cbc:ID)='Z']/xs:decimal(cbc:Amount)))))"
                 flag="fatal"
                 id="BR-Z-08">[BR-Z-08]-In a VATBReakdown (BG-23) where VAT category code (BT-118) is "Zero rated" the VAT category taxable amount (BT-116) shall equal the sum of Invoice line net amount (BT-131) minus the sum of Document level allowance amounts (BT-92) plus the sum of Document level charge amounts (BT-99) where the VAT category codes (BT-151, BT-95, BT-102) are “Zero rated".</assert>
         <assert test="../cbc:TaxAmount = 0" flag="fatal" id="BR-Z-09">[BR-Z-09]-The VAT category tax amount (BT-117) in a VATBReakdown (BG-23) where VAT category code (BT-118) is "Zero rated" shall equal 0 (zero).</assert>
         <assert test="not((cbc:TaxExemptionReason) or (cbc:TaxExemptionReasonCode))"
                 flag="fatal"
                 id="BR-Z-10">[BR-Z-10]-A VATBReakdown (BG-23) with VAT Category code (BT-118) "Zero rated" shall not have a VAT exemption reason code (BT-121) or VAT exemption reason text (BT-120).</assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='false']/cac:TaxCategory[normalize-space(cbc:ID)='Z']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-Z-06">[BR-Z-06]-In a Document level allowance (BG-20) where the Document level allowance VAT category code (BT-95) is "Zero rated" the Document level allowance VAT rate (BT-96) shall be 0 (zero).</assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator='true']/cac:TaxCategory[normalize-space(cbc:ID)='Z']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-Z-07">[BR-Z-07]-In a Document level charge (BG-21) where the Document level charge VAT category code (BT-102) is "Zero rated" the Document level charge VAT rate (BT-103) shall be 0 (zero).</assert>
      </rule>
      <rule context="cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'Z'] | cac:CreditNoteLine/cac:Item/cac:ClassifiedTaxCategory[normalize-space(cbc:ID) = 'Z']">
         <assert test="(cbc:Percent = 0)" flag="fatal" id="BR-Z-05">[BR-Z-05]-In an Invoice line (BG-25) where the Invoiced item VAT category code (BT-151) is "Zero rated" the Invoiced item VAT rate (BT-152) shall be 0 (zero).    </assert>
      </rule>
   </pattern>
  <!--Start pattern based on abstract syntax--><pattern id="UBL-syntax">
      <rule context="cac:AdditionalDocumentReference">
         <assert test="(count(cbc:DocumentType) &lt;= 1)" flag="warning" id="UBL-SR-33">[UBL-SR-33]-Supporting document description shall occur maximum once</assert>
      </rule>
      <rule context="//*[ends-with(name(), 'Amount') and not(ends-with(name(),'PriceAmount')) and not(ancestor::cac:Price/cac:AllowanceCharge)]">
         <assert test="string-length(substring-after(.,'.'))&lt;=2"
                 flag="fatal"
                 id="UBL-DT-01">[UBL-DT-01]-Amounts shall be decimal up to two fraction digits</assert>
      </rule>
      <rule context="//*[ends-with(name(), 'BinaryObject')]">
         <assert test="(@mimeCode)" flag="fatal" id="UBL-DT-06">[UBL-DT-06]-Binary object elements shall contain the mime code attribute</assert>
         <assert test="(@filename)" flag="fatal" id="UBL-DT-07">[UBL-DT-07]-Binary object elements shall contain the file name attribute</assert>
      </rule>
      <rule context="cac:Delivery">
         <assert test="(count(cac:DeliveryParty/cac:PartyName/cbc:Name) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-25">[UBL-SR-25]-Deliver to party name shall occur maximum once</assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator = 'false']">
         <assert test="(count(cbc:AllowanceChargeReason) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-30">[UBL-SR-30]-Document level allowance reason shall occur maximum once</assert>
      </rule>
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator = 'true']">
         <assert test="(count(cbc:AllowanceChargeReason) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-31">[UBL-SR-31]-Document level charge reason shall occur maximum once</assert>
      </rule>
      <rule context="/ubl:Invoice">
         <assert test="not(ext:UBLExtensions)" flag="warning" id="UBL-CR-001">[UBL-CR-001]-A UBL invoice should not include extensions</assert>
         <assert test="not(cbc:ProfileExecutionID)" flag="warning" id="UBL-CR-003">[UBL-CR-003]-A UBL invoice should not include the ProfileExecutionID </assert>
         <assert test="not(cbc:CopyIndicator)" flag="warning" id="UBL-CR-004">[UBL-CR-004]-A UBL invoice should not include the CopyIndicator </assert>
         <assert test="not(cbc:UUID)" flag="warning" id="UBL-CR-005">[UBL-CR-005]-A UBL invoice should not include the UUID </assert>
         <assert test="not(cbc:IssueTime)" flag="warning" id="UBL-CR-006">[UBL-CR-006]-A UBL invoice should not include the IssueTime </assert>
         <assert test="not(cbc:PricingCurrencyCode)" flag="warning" id="UBL-CR-007">[UBL-CR-007]-A UBL invoice should not include the PricingCurrencyCode</assert>
         <assert test="not(cbc:PaymentCurrencyCode)" flag="warning" id="UBL-CR-008">[UBL-CR-008]-A UBL invoice should not include the PaymentCurrencyCode</assert>
         <assert test="not(cbc:PaymentAlternativeCurrencyCode)"
                 flag="warning"
                 id="UBL-CR-009">[UBL-CR-009]-A UBL invoice should not include the PaymentAlternativeCurrencyCode</assert>
         <assert test="not(cbc:AccountingCostCode)" flag="warning" id="UBL-CR-010">[UBL-CR-010]-A UBL invoice should not include the AccountingCostCode</assert>
         <assert test="not(cbc:LineCountNumeric)" flag="warning" id="UBL-CR-011">[UBL-CR-011]-A UBL invoice should not include the LineCountNumeric</assert>
         <assert test="not(cac:InvoicePeriod/cbc:StartTime)"
                 flag="warning"
                 id="UBL-CR-012">[UBL-CR-012]-A UBL invoice should not include the InvoicePeriod StartTime</assert>
         <assert test="not(cac:InvoicePeriod/cbc:EndTime)"
                 flag="warning"
                 id="UBL-CR-013">[UBL-CR-013]-A UBL invoice should not include the InvoicePeriod EndTime</assert>
         <assert test="not(cac:InvoicePeriod/cbc:DurationMeasure)"
                 flag="warning"
                 id="UBL-CR-014">[UBL-CR-014]-A UBL invoice should not include the InvoicePeriod DurationMeasure</assert>
         <assert test="not(cac:InvoicePeriod/cbc:Description)"
                 flag="warning"
                 id="UBL-CR-015">[UBL-CR-015]-A UBL invoice should not include the InvoicePeriod Description</assert>
         <assert test="not(cac:OrderReference/cbc:CopyIndicator)"
                 flag="warning"
                 id="UBL-CR-016">[UBL-CR-016]-A UBL invoice should not include the OrderReference CopyIndicator</assert>
         <assert test="not(cac:OrderReference/cbc:UUID)"
                 flag="warning"
                 id="UBL-CR-017">[UBL-CR-017]-A UBL invoice should not include the OrderReference UUID</assert>
         <assert test="not(cac:OrderReference/cbc:IssueDate)"
                 flag="warning"
                 id="UBL-CR-018">[UBL-CR-018]-A UBL invoice should not include the OrderReference IssueDate</assert>
         <assert test="not(cac:OrderReference/cbc:IssueTime)"
                 flag="warning"
                 id="UBL-CR-019">[UBL-CR-019]-A UBL invoice should not include the OrderReference IssueTime</assert>
         <assert test="not(cac:OrderReference/cbc:CustomerReference)"
                 flag="warning"
                 id="UBL-CR-020">[UBL-CR-020]-A UBL invoice should not include the OrderReference CustomerReference</assert>
         <assert test="not(cac:OrderReference/cbc:OrderTypeCode)"
                 flag="warning"
                 id="UBL-CR-021">[UBL-CR-021]-A UBL invoice should not include the OrderReference OrderTypeCode</assert>
         <assert test="not(cac:OrderReference/cbc:DocumentReference)"
                 flag="warning"
                 id="UBL-CR-022">[UBL-CR-022]-A UBL invoice should not include the OrderReference DocumentReference</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cbc:CopyIndicator)"
                 flag="warning"
                 id="UBL-CR-023">[UBL-CR-023]-A UBL invoice should not include the BillingReference CopyIndicator</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cbc:UUID)"
                 flag="warning"
                 id="UBL-CR-024">[UBL-CR-024]-A UBL invoice should not include the BillingReference UUID</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cbc:IssueTime)"
                 flag="warning"
                 id="UBL-CR-025">[UBL-CR-025]-A UBL invoice should not include the BillingReference IssueTime</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cbc:DocumentTypeCode)"
                 flag="warning"
                 id="UBL-CR-026">[UBL-CR-026]-A UBL invoice should not include the BillingReference DocumentTypeCode</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cbc:DocumentType)"
                 flag="warning"
                 id="UBL-CR-027">[UBL-CR-027]-A UBL invoice should not include the BillingReference DocumentType</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cbc:Xpath)"
                 flag="warning"
                 id="UBL-CR-028">[UBL-CR-028]-A UBL invoice should not include the BillingReference Xpath</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cbc:LanguageID)"
                 flag="warning"
                 id="UBL-CR-029">[UBL-CR-029]-A UBL invoice should not include the BillingReference LanguageID</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cbc:LocaleCode)"
                 flag="warning"
                 id="UBL-CR-030">[UBL-CR-030]-A UBL invoice should not include the BillingReference LocaleCode</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cbc:VersionID)"
                 flag="warning"
                 id="UBL-CR-031">[UBL-CR-031]-A UBL invoice should not include the BillingReference VersionID</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cbc:DocumentStatusCode)"
                 flag="warning"
                 id="UBL-CR-032">[UBL-CR-032]-A UBL invoice should not include the BillingReference DocumentStatusCode</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cbc:DocumentDescription)"
                 flag="warning"
                 id="UBL-CR-033">[UBL-CR-033]-A UBL invoice should not include the BillingReference DocumenDescription</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cac:Attachment)"
                 flag="warning"
                 id="UBL-CR-034">[UBL-CR-034]-A UBL invoice should not include the BillingReference Attachment</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cac:ValidityPeriod)"
                 flag="warning"
                 id="UBL-CR-035">[UBL-CR-035]-A UBL invoice should not include the BillingReference ValidityPeriod</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cac:IssuerParty)"
                 flag="warning"
                 id="UBL-CR-036">[UBL-CR-036]-A UBL invoice should not include the BillingReference IssuerParty</assert>
         <assert test="not(cac:BillingReference/cac:InvoiceDocumentReference/cac:ResultOfVerification)"
                 flag="warning"
                 id="UBL-CR-037">[UBL-CR-037]-A UBL invoice should not include the BillingReference ResultOfVerification</assert>
         <assert test="not(cac:BillingReference/cac:SelfBilledInvoiceDocumentReference)"
                 flag="warning"
                 id="UBL-CR-038">[UBL-CR-038]-A UBL invoice should not include the BillingReference SelfBilledInvoiceDocumentReference</assert>
         <assert test="not(cac:BillingReference/cac:CreditNoteDocumentReference)"
                 flag="warning"
                 id="UBL-CR-039">[UBL-CR-039]-A UBL invoice should not include the BillingReference CreditNoteDocumentReference</assert>
         <assert test="not(cac:BillingReference/cac:SelfBilledCreditNoteDocumentReference)"
                 flag="warning"
                 id="UBL-CR-040">[UBL-CR-040]-A UBL invoice should not include the BillingReference SelfBilledCreditNoteDocumentReference</assert>
         <assert test="not(cac:BillingReference/cac:DebitNoteDocumentReference)"
                 flag="warning"
                 id="UBL-CR-041">[UBL-CR-041]-A UBL invoice should not include the BillingReference DebitNoteDocumentReference</assert>
         <assert test="not(cac:BillingReference/cac:ReminderDocumentReference)"
                 flag="warning"
                 id="UBL-CR-042">[UBL-CR-042]-A UBL invoice should not include the BillingReference ReminderDocumentReference</assert>
         <assert test="not(cac:BillingReference/cac:AdditionalDocumentReference)"
                 flag="warning"
                 id="UBL-CR-043">[UBL-CR-043]-A UBL invoice should not include the BillingReference AdditionalDocumentReference</assert>
         <assert test="not(cac:BillingReference/cac:BillingReferenceLine)"
                 flag="warning"
                 id="UBL-CR-044">[UBL-CR-044]-A UBL invoice should not include the BillingReference BillingReferenceLine</assert>
         <assert test="not(cac:DespatchDocumentReference/cbc:CopyIndicator)"
                 flag="warning"
                 id="UBL-CR-045">[UBL-CR-045]-A UBL invoice should not include the DespatchDocumentReference CopyIndicator</assert>
         <assert test="not(cac:DespatchDocumentReference/cbc:UUID)"
                 flag="warning"
                 id="UBL-CR-046">[UBL-CR-046]-A UBL invoice should not include the DespatchDocumentReference UUID</assert>
         <assert test="not(cac:DespatchDocumentReference/cbc:IssueDate)"
                 flag="warning"
                 id="UBL-CR-047">[UBL-CR-047]-A UBL invoice should not include the DespatchDocumentReference IssueDate</assert>
         <assert test="not(cac:DespatchDocumentReference/cbc:IssueTime)"
                 flag="warning"
                 id="UBL-CR-048">[UBL-CR-048]-A UBL invoice should not include the DespatchDocumentReference IssueTime</assert>
         <assert test="not(cac:DespatchDocumentReference/cbc:DocumentTypeCode)"
                 flag="warning"
                 id="UBL-CR-049">[UBL-CR-049]-A UBL invoice should not include the DespatchDocumentReference DocumentTypeCode</assert>
         <assert test="not(cac:DespatchDocumentReference/cbc:DocumentType)"
                 flag="warning"
                 id="UBL-CR-050">[UBL-CR-050]-A UBL invoice should not include the DespatchDocumentReference DocumentType</assert>
         <assert test="not(cac:DespatchDocumentReference/cbc:Xpath)"
                 flag="warning"
                 id="UBL-CR-051">[UBL-CR-051]-A UBL invoice should not include the DespatchDocumentReference Xpath</assert>
         <assert test="not(cac:DespatchDocumentReference/cbc:LanguageID)"
                 flag="warning"
                 id="UBL-CR-052">[UBL-CR-052]-A UBL invoice should not include the DespatchDocumentReference LanguageID</assert>
         <assert test="not(cac:DespatchDocumentReference/cbc:LocaleCode)"
                 flag="warning"
                 id="UBL-CR-053">[UBL-CR-053]-A UBL invoice should not include the DespatchDocumentReference LocaleCode</assert>
         <assert test="not(cac:DespatchDocumentReference/cbc:VersionID)"
                 flag="warning"
                 id="UBL-CR-054">[UBL-CR-054]-A UBL invoice should not include the DespatchDocumentReference VersionID</assert>
         <assert test="not(cac:DespatchDocumentReference/cbc:DocumentStatusCode)"
                 flag="warning"
                 id="UBL-CR-055">[UBL-CR-055]-A UBL invoice should not include the DespatchDocumentReference DocumentStatusCode</assert>
         <assert test="not(cac:DespatchDocumentReference/cbc:DocumentDescription)"
                 flag="warning"
                 id="UBL-CR-056">[UBL-CR-056]-A UBL invoice should not include the DespatchDocumentReference DocumentDescription</assert>
         <assert test="not(cac:DespatchDocumentReference/cac:Attachment)"
                 flag="warning"
                 id="UBL-CR-057">[UBL-CR-057]-A UBL invoice should not include the DespatchDocumentReference Attachment</assert>
         <assert test="not(cac:DespatchDocumentReference/cac:ValidityPeriod)"
                 flag="warning"
                 id="UBL-CR-058">[UBL-CR-058]-A UBL invoice should not include the DespatchDocumentReference ValidityPeriod</assert>
         <assert test="not(cac:DespatchDocumentReference/cac:IssuerParty)"
                 flag="warning"
                 id="UBL-CR-059">[UBL-CR-059]-A UBL invoice should not include the DespatchDocumentReference IssuerParty</assert>
         <assert test="not(cac:DespatchDocumentReference/cac:ResultOfVerification)"
                 flag="warning"
                 id="UBL-CR-060">[UBL-CR-060]-A UBL invoice should not include the DespatchDocumentReference ResultOfVerification</assert>
         <assert test="not(cac:ReceiptDocumentReference/cbc:CopyIndicator)"
                 flag="warning"
                 id="UBL-CR-061">[UBL-CR-061]-A UBL invoice should not include the ReceiptDocumentReference CopyIndicator</assert>
         <assert test="not(cac:ReceiptDocumentReference/cbc:UUID)"
                 flag="warning"
                 id="UBL-CR-062">[UBL-CR-062]-A UBL invoice should not include the ReceiptDocumentReference UUID</assert>
         <assert test="not(cac:ReceiptDocumentReference/cbc:IssueDate)"
                 flag="warning"
                 id="UBL-CR-063">[UBL-CR-063]-A UBL invoice should not include the ReceiptDocumentReference IssueDate</assert>
         <assert test="not(cac:ReceiptDocumentReference/cbc:IssueTime)"
                 flag="warning"
                 id="UBL-CR-064">[UBL-CR-064]-A UBL invoice should not include the ReceiptDocumentReference IssueTime</assert>
         <assert test="not(cac:ReceiptDocumentReference/cbc:DocumentTypeCode)"
                 flag="warning"
                 id="UBL-CR-065">[UBL-CR-065]-A UBL invoice should not include the ReceiptDocumentReference DocumentTypeCode</assert>
         <assert test="not(cac:ReceiptDocumentReference/cbc:DocumentType)"
                 flag="warning"
                 id="UBL-CR-066">[UBL-CR-066]-A UBL invoice should not include the ReceiptDocumentReference DocumentType</assert>
         <assert test="not(cac:ReceiptDocumentReference/cbc:Xpath)"
                 flag="warning"
                 id="UBL-CR-067">[UBL-CR-067]-A UBL invoice should not include the ReceiptDocumentReference Xpath</assert>
         <assert test="not(cac:ReceiptDocumentReference/cbc:LanguageID)"
                 flag="warning"
                 id="UBL-CR-068">[UBL-CR-068]-A UBL invoice should not include the ReceiptDocumentReference LanguageID</assert>
         <assert test="not(cac:ReceiptDocumentReference/cbc:LocaleCode)"
                 flag="warning"
                 id="UBL-CR-069">[UBL-CR-069]-A UBL invoice should not include the ReceiptDocumentReference LocaleCode</assert>
         <assert test="not(cac:ReceiptDocumentReference/cbc:VersionID)"
                 flag="warning"
                 id="UBL-CR-070">[UBL-CR-070]-A UBL invoice should not include the ReceiptDocumentReference VersionID</assert>
         <assert test="not(cac:ReceiptDocumentReference/cbc:DocumentStatusCode)"
                 flag="warning"
                 id="UBL-CR-071">[UBL-CR-071]-A UBL invoice should not include the ReceiptDocumentReference DocumentStatusCode</assert>
         <assert test="not(cac:ReceiptDocumentReference/cbc:DocumentDescription)"
                 flag="warning"
                 id="UBL-CR-072">[UBL-CR-072]-A UBL invoice should not include the ReceiptDocumentReference DocumentDescription</assert>
         <assert test="not(cac:ReceiptDocumentReference/cac:Attachment)"
                 flag="warning"
                 id="UBL-CR-073">[UBL-CR-073]-A UBL invoice should not include the ReceiptDocumentReference Attachment</assert>
         <assert test="not(cac:ReceiptDocumentReference/cac:ValidityPeriod)"
                 flag="warning"
                 id="UBL-CR-074">[UBL-CR-074]-A UBL invoice should not include the ReceiptDocumentReference ValidityPeriod</assert>
         <assert test="not(cac:ReceiptDocumentReference/cac:IssuerParty)"
                 flag="warning"
                 id="UBL-CR-075">[UBL-CR-075]-A UBL invoice should not include the ReceiptDocumentReference IssuerParty</assert>
         <assert test="not(cac:ReceiptDocumentReference/cac:ResultOfVerification)"
                 flag="warning"
                 id="UBL-CR-076">[UBL-CR-076]-A UBL invoice should not include the ReceiptDocumentReference ResultOfVerification</assert>
         <assert test="not(cac:StatementDocumentReference)"
                 flag="warning"
                 id="UBL-CR-077">[UBL-CR-077]-A UBL invoice should not include the StatementDocumentReference</assert>
         <assert test="not(cac:OriginatorDocumentReference/cbc:CopyIndicator)"
                 flag="warning"
                 id="UBL-CR-078">[UBL-CR-078]-A UBL invoice should not include the OriginatorDocumentReference CopyIndicator</assert>
         <assert test="not(cac:OriginatorDocumentReference/cbc:UUID)"
                 flag="warning"
                 id="UBL-CR-079">[UBL-CR-079]-A UBL invoice should not include the OriginatorDocumentReference UUID</assert>
         <assert test="not(cac:OriginatorDocumentReference/cbc:IssueDate)"
                 flag="warning"
                 id="UBL-CR-080">[UBL-CR-080]-A UBL invoice should not include the OriginatorDocumentReference IssueDate</assert>
         <assert test="not(cac:OriginatorDocumentReference/cbc:IssueTime)"
                 flag="warning"
                 id="UBL-CR-081">[UBL-CR-081]-A UBL invoice should not include the OriginatorDocumentReference IssueTime</assert>
         <assert test="not(cac:OriginatorDocumentReference/cbc:DocumentTypeCode)"
                 flag="warning"
                 id="UBL-CR-082">[UBL-CR-082]-A UBL invoice should not include the OriginatorDocumentReference DocumentTypeCode</assert>
         <assert test="not(cac:OriginatorDocumentReference/cbc:DocumentType)"
                 flag="warning"
                 id="UBL-CR-083">[UBL-CR-083]-A UBL invoice should not include the OriginatorDocumentReference DocumentType</assert>
         <assert test="not(cac:OriginatorDocumentReference/cbc:Xpath)"
                 flag="warning"
                 id="UBL-CR-084">[UBL-CR-084]-A UBL invoice should not include the OriginatorDocumentReference Xpath</assert>
         <assert test="not(cac:OriginatorDocumentReference/cbc:LanguageID)"
                 flag="warning"
                 id="UBL-CR-085">[UBL-CR-085]-A UBL invoice should not include the OriginatorDocumentReference LanguageID</assert>
         <assert test="not(cac:OriginatorDocumentReference/cbc:LocaleCode)"
                 flag="warning"
                 id="UBL-CR-086">[UBL-CR-086]-A UBL invoice should not include the OriginatorDocumentReference LocaleCode</assert>
         <assert test="not(cac:OriginatorDocumentReference/cbc:VersionID)"
                 flag="warning"
                 id="UBL-CR-087">[UBL-CR-087]-A UBL invoice should not include the OriginatorDocumentReference VersionID</assert>
         <assert test="not(cac:OriginatorDocumentReference/cbc:DocumentStatusCode)"
                 flag="warning"
                 id="UBL-CR-088">[UBL-CR-088]-A UBL invoice should not include the OriginatorDocumentReference DocumentStatusCode</assert>
         <assert test="not(cac:OriginatorDocumentReference/cbc:DocumentDescription)"
                 flag="warning"
                 id="UBL-CR-089">[UBL-CR-089]-A UBL invoice should not include the OriginatorDocumentReference DocumentDescription</assert>
         <assert test="not(cac:OriginatorDocumentReference/cac:Attachment)"
                 flag="warning"
                 id="UBL-CR-090">[UBL-CR-090]-A UBL invoice should not include the OriginatorDocumentReference Attachment</assert>
         <assert test="not(cac:OriginatorDocumentReference/cac:ValidityPeriod)"
                 flag="warning"
                 id="UBL-CR-091">[UBL-CR-091]-A UBL invoice should not include the OriginatorDocumentReference ValidityPeriod</assert>
         <assert test="not(cac:OriginatorDocumentReference/cac:IssuerParty)"
                 flag="warning"
                 id="UBL-CR-092">[UBL-CR-092]-A UBL invoice should not include the OriginatorDocumentReference IssuerParty</assert>
         <assert test="not(cac:OriginatorDocumentReference/cac:ResultOfVerification)"
                 flag="warning"
                 id="UBL-CR-093">[UBL-CR-093]-A UBL invoice should not include the OriginatorDocumentReference ResultOfVerification</assert>
         <assert test="not(cac:ContractDocumentReference/cbc:CopyIndicator)"
                 flag="warning"
                 id="UBL-CR-094">[UBL-CR-094]-A UBL invoice should not include the ContractDocumentReference CopyIndicator</assert>
         <assert test="not(cac:ContractDocumentReference/cbc:UUID)"
                 flag="warning"
                 id="UBL-CR-095">[UBL-CR-095]-A UBL invoice should not include the ContractDocumentReference UUID</assert>
         <assert test="not(cac:ContractDocumentReference/cbc:IssueDate)"
                 flag="warning"
                 id="UBL-CR-096">[UBL-CR-096]-A UBL invoice should not include the ContractDocumentReference IssueDate</assert>
         <assert test="not(cac:ContractDocumentReference/cbc:IssueTime)"
                 flag="warning"
                 id="UBL-CR-097">[UBL-CR-097]-A UBL invoice should not include the ContractDocumentReference IssueTime</assert>
         <assert test="not(cac:ContractDocumentReference/cbc:DocumentTypeCode)"
                 flag="warning"
                 id="UBL-CR-098">[UBL-CR-098]-A UBL invoice should not include the ContractDocumentReference DocumentTypeCode</assert>
         <assert test="not(cac:ContractDocumentReference/cbc:DocumentType)"
                 flag="warning"
                 id="UBL-CR-099">[UBL-CR-099]-A UBL invoice should not include the ContractDocumentReference DocumentType</assert>
         <assert test="not(cac:ContractDocumentReference/cbc:Xpath)"
                 flag="warning"
                 id="UBL-CR-100">[UBL-CR-100]-A UBL invoice should not include the ContractDocumentReference Xpath</assert>
         <assert test="not(cac:ContractDocumentReference/cbc:LanguageID)"
                 flag="warning"
                 id="UBL-CR-101">[UBL-CR-101]-A UBL invoice should not include the ContractDocumentReference LanguageID</assert>
         <assert test="not(cac:ContractDocumentReference/cbc:LocaleCode)"
                 flag="warning"
                 id="UBL-CR-102">[UBL-CR-102]-A UBL invoice should not include the ContractDocumentReference LocaleCode</assert>
         <assert test="not(cac:ContractDocumentReference/cbc:VersionID)"
                 flag="warning"
                 id="UBL-CR-103">[UBL-CR-103]-A UBL invoice should not include the ContractDocumentReference VersionID</assert>
         <assert test="not(cac:ContractDocumentReference/cbc:DocumentStatusCode)"
                 flag="warning"
                 id="UBL-CR-104">[UBL-CR-104]-A UBL invoice should not include the ContractDocumentReference DocumentStatusCode</assert>
         <assert test="not(cac:ContractDocumentReference/cbc:DocumentDescription)"
                 flag="warning"
                 id="UBL-CR-105">[UBL-CR-105]-A UBL invoice should not include the ContractDocumentReference DocumentDescription</assert>
         <assert test="not(cac:ContractDocumentReference/cac:Attachment)"
                 flag="warning"
                 id="UBL-CR-106">[UBL-CR-106]-A UBL invoice should not include the ContractDocumentReference Attachment</assert>
         <assert test="not(cac:ContractDocumentReference/cac:ValidityPeriod)"
                 flag="warning"
                 id="UBL-CR-107">[UBL-CR-107]-A UBL invoice should not include the ContractDocumentReference ValidityPeriod</assert>
         <assert test="not(cac:ContractDocumentReference/cac:IssuerParty)"
                 flag="warning"
                 id="UBL-CR-108">[UBL-CR-108]-A UBL invoice should not include the ContractDocumentReference IssuerParty</assert>
         <assert test="not(cac:ContractDocumentReference/cac:ResultOfVerification)"
                 flag="warning"
                 id="UBL-CR-109">[UBL-CR-109]-A UBL invoice should not include the ContractDocumentReference ResultOfVerification</assert>
         <assert test="not(cac:AdditionalDocumentReference/cbc:CopyIndicator)"
                 flag="warning"
                 id="UBL-CR-110">[UBL-CR-110]-A UBL invoice should not include the AdditionalDocumentReference CopyIndicator</assert>
         <assert test="not(cac:AdditionalDocumentReference/cbc:UUID)"
                 flag="warning"
                 id="UBL-CR-111">[UBL-CR-111]-A UBL invoice should not include the AdditionalDocumentReference UUID</assert>
         <assert test="not(cac:AdditionalDocumentReference/cbc:IssueDate)"
                 flag="warning"
                 id="UBL-CR-112">[UBL-CR-112]-A UBL invoice should not include the AdditionalDocumentReference IssueDate</assert>
         <assert test="not(cac:AdditionalDocumentReference/cbc:IssueTime)"
                 flag="warning"
                 id="UBL-CR-113">[UBL-CR-113]-A UBL invoice should not include the AdditionalDocumentReference IssueTime</assert>
         <assert test="not(cac:AdditionalDocumentReference/cbc:DocumentType)"
                 flag="warning"
                 id="UBL-CR-114">[UBL-CR-114]-A UBL invoice should not include the AdditionalDocumentReference DocumentType</assert>
         <assert test="not(cac:AdditionalDocumentReference/cbc:Xpath)"
                 flag="warning"
                 id="UBL-CR-115">[UBL-CR-115]-A UBL invoice should not include the AdditionalDocumentReference Xpath</assert>
         <assert test="not(cac:AdditionalDocumentReference/cbc:LanguageID)"
                 flag="warning"
                 id="UBL-CR-116">[UBL-CR-116]-A UBL invoice should not include the AdditionalDocumentReference LanguageID</assert>
         <assert test="not(cac:AdditionalDocumentReference/cbc:LocaleCode)"
                 flag="warning"
                 id="UBL-CR-117">[UBL-CR-117]-A UBL invoice should not include the AdditionalDocumentReference LocaleCode</assert>
         <assert test="not(cac:AdditionalDocumentReference/cbc:VersionID)"
                 flag="warning"
                 id="UBL-CR-118">[UBL-CR-118]-A UBL invoice should not include the AdditionalDocumentReference VersionID</assert>
         <assert test="not(cac:AdditionalDocumentReference/cbc:DocumentStatusCode)"
                 flag="warning"
                 id="UBL-CR-119">[UBL-CR-119]-A UBL invoice should not include the AdditionalDocumentReference DocumentStatusCode</assert>
         <assert test="not(cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference/cbc:DocumentHash)"
                 flag="warning"
                 id="UBL-CR-121">[UBL-CR-121]-A UBL invoice should not include the AdditionalDocumentReference Attachment External DocumentHash</assert>
         <assert test="not(cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference/cbc:HashAlgorithmMethod)"
                 flag="warning"
                 id="UBL-CR-122">[UBL-CR-122]-A UBL invoice should not include the AdditionalDocumentReference Attachment External HashAlgorithmMethod</assert>
         <assert test="not(cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference/cbc:ExpiryDate)"
                 flag="warning"
                 id="UBL-CR-123">[UBL-CR-123]-A UBL invoice should not include the AdditionalDocumentReference Attachment External ExpiryDate</assert>
         <assert test="not(cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference/cbc:ExpiryTime)"
                 flag="warning"
                 id="UBL-CR-124">[UBL-CR-124]-A UBL invoice should not include the AdditionalDocumentReference Attachment External ExpiryTime</assert>
         <assert test="not(cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference/cbc:MimeCode)"
                 flag="warning"
                 id="UBL-CR-125">[UBL-CR-125]-A UBL invoice should not include the AdditionalDocumentReference Attachment External MimeCode</assert>
         <assert test="not(cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference/cbc:FormatCode)"
                 flag="warning"
                 id="UBL-CR-126">[UBL-CR-126]-A UBL invoice should not include the AdditionalDocumentReference Attachment External FormatCode</assert>
         <assert test="not(cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference/cbc:EncodingCode)"
                 flag="warning"
                 id="UBL-CR-127">[UBL-CR-127]-A UBL invoice should not include the AdditionalDocumentReference Attachment External EncodingCode</assert>
         <assert test="not(cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference/cbc:CharacterSetCode)"
                 flag="warning"
                 id="UBL-CR-128">[UBL-CR-128]-A UBL invoice should not include the AdditionalDocumentReference Attachment External CharacterSetCode</assert>
         <assert test="not(cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference/cbc:FileName)"
                 flag="warning"
                 id="UBL-CR-129">[UBL-CR-129]-A UBL invoice should not include the AdditionalDocumentReference Attachment External FileName</assert>
         <assert test="not(cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference/cbc:Description)"
                 flag="warning"
                 id="UBL-CR-130">[UBL-CR-130]-A UBL invoice should not include the AdditionalDocumentReference Attachment External Descriprion</assert>
         <assert test="not(cac:AdditionalDocumentReference/cac:ValidityPeriod)"
                 flag="warning"
                 id="UBL-CR-131">[UBL-CR-131]-A UBL invoice should not include the AdditionalDocumentReference ValidityPeriod</assert>
         <assert test="not(cac:AdditionalDocumentReference/cac:IssuerParty)"
                 flag="warning"
                 id="UBL-CR-132">[UBL-CR-132]-A UBL invoice should not include the AdditionalDocumentReference IssuerParty</assert>
         <assert test="not(cac:AdditionalDocumentReference/cac:ResultOfVerification)"
                 flag="warning"
                 id="UBL-CR-133">[UBL-CR-133]-A UBL invoice should not include the AdditionalDocumentReference ResultOfVerification</assert>
         <assert test="not(cac:ProjectReference/cbc:UUID)"
                 flag="warning"
                 id="UBL-CR-134">[UBL-CR-134]-A UBL invoice should not include the ProjectReference UUID</assert>
         <assert test="not(cac:ProjectReference/cbc:IssueDate)"
                 flag="warning"
                 id="UBL-CR-135">[UBL-CR-135]-A UBL invoice should not include the ProjectReference IssueDate</assert>
         <assert test="not(cac:ProjectReference/cac:WorkPhaseReference)"
                 flag="warning"
                 id="UBL-CR-136">[UBL-CR-136]-A UBL invoice should not include the ProjectReference WorkPhaseReference</assert>
         <assert test="not(cac:Signature)" flag="warning" id="UBL-CR-137">[UBL-CR-137]-A UBL invoice should not include the Signature</assert>
         <assert test="not(cac:AccountingSupplierParty/cbc:CustomerAssignedAccountID)"
                 flag="warning"
                 id="UBL-CR-138">[UBL-CR-138]-A UBL invoice should not include the AccountingSupplierParty CustomerAssignedAccountID</assert>
         <assert test="not(cac:AccountingSupplierParty/cbc:AdditionalAccountID)"
                 flag="warning"
                 id="UBL-CR-139">[UBL-CR-139]-A UBL invoice should not include the AccountingSupplierParty AdditionalAccountID</assert>
         <assert test="not(cac:AccountingSupplierParty/cbc:DataSendingCapability)"
                 flag="warning"
                 id="UBL-CR-140">[UBL-CR-140]-A UBL invoice should not include the AccountingSupplierParty DataSendingCapability</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cbc:MarkCareIndicator)"
                 flag="warning"
                 id="UBL-CR-141">[UBL-CR-141]-A UBL invoice should not include the AccountingSupplierParty Party MarkCareIndicator</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cbc:MarkAttentionIndicator)"
                 flag="warning"
                 id="UBL-CR-142">[UBL-CR-142]-A UBL invoice should not include the AccountingSupplierParty Party MarkAttentionIndicator</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cbc:WebsiteURI)"
                 flag="warning"
                 id="UBL-CR-143">[UBL-CR-143]-A UBL invoice should not include the AccountingSupplierParty Party WebsiteURI</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cbc:LogoReferenceID)"
                 flag="warning"
                 id="UBL-CR-144">[UBL-CR-144]-A UBL invoice should not include the AccountingSupplierParty Party LogoReferenceID</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cbc:IndustryClassificationCode)"
                 flag="warning"
                 id="UBL-CR-145">[UBL-CR-145]-A UBL invoice should not include the AccountingSupplierParty Party IndustryClassificationCode</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:Language)"
                 flag="warning"
                 id="UBL-CR-146">[UBL-CR-146]-A UBL invoice should not include the AccountingSupplierParty Party Language</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:ID)"
                 flag="warning"
                 id="UBL-CR-147">[UBL-CR-147]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress ID</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:AddressTypeCode)"
                 flag="warning"
                 id="UBL-CR-148">[UBL-CR-148]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress AddressTypeCode</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:AddressFormatCode)"
                 flag="warning"
                 id="UBL-CR-149">[UBL-CR-149]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress AddressFormatCode</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:Postbox)"
                 flag="warning"
                 id="UBL-CR-150">[UBL-CR-150]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress Postbox</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:Floor)"
                 flag="warning"
                 id="UBL-CR-151">[UBL-CR-151]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress Floor</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:Room)"
                 flag="warning"
                 id="UBL-CR-152">[UBL-CR-152]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress Room</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:BlockName)"
                 flag="warning"
                 id="UBL-CR-153">[UBL-CR-153]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress BlockName</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:BuildingName)"
                 flag="warning"
                 id="UBL-CR-154">[UBL-CR-154]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress BuildingName</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber)"
                 flag="warning"
                 id="UBL-CR-155">[UBL-CR-155]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress BuildingNumber</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:InhouseMail)"
                 flag="warning"
                 id="UBL-CR-156">[UBL-CR-156]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress InhouseMail</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:Department)"
                 flag="warning"
                 id="UBL-CR-157">[UBL-CR-157]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress Department</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:MarkAttention)"
                 flag="warning"
                 id="UBL-CR-158">[UBL-CR-158]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress MarkAttention</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:MarkCare)"
                 flag="warning"
                 id="UBL-CR-159">[UBL-CR-159]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress MarkCare</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:PlotIdentification)"
                 flag="warning"
                 id="UBL-CR-160">[UBL-CR-160]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress PlotIdentification</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CitySubdivisionName)"
                 flag="warning"
                 id="UBL-CR-161">[UBL-CR-161]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress CitySubdivisionName</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CountrySubentityCode)"
                 flag="warning"
                 id="UBL-CR-162">[UBL-CR-162]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress CountrySubentityCode</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:Region)"
                 flag="warning"
                 id="UBL-CR-163">[UBL-CR-163]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress Region</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:District)"
                 flag="warning"
                 id="UBL-CR-164">[UBL-CR-164]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress District</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:TimezoneOffset)"
                 flag="warning"
                 id="UBL-CR-165">[UBL-CR-165]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress TimezoneOffset</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-166">[UBL-CR-166]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress Country Name</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:LocationCoordinate)"
                 flag="warning"
                 id="UBL-CR-167">[UBL-CR-167]-A UBL invoice should not include the AccountingSupplierParty Party PostalAddress LocationCoordinate</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation)"
                 flag="warning"
                 id="UBL-CR-168">[UBL-CR-168]-A UBL invoice should not include the AccountingSupplierParty Party PhysicalLocation</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:RegistrationName)"
                 flag="warning"
                 id="UBL-CR-169">[UBL-CR-169]-A UBL invoice should not include the AccountingSupplierParty Party PartyTaxScheme RegistrationName</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:TaxLevelCode)"
                 flag="warning"
                 id="UBL-CR-170">[UBL-CR-170]-A UBL invoice should not include the AccountingSupplierParty Party PartyTaxScheme TaxLevelCode</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:ExemptionReasonCode)"
                 flag="warning"
                 id="UBL-CR-171">[UBL-CR-171]-A UBL invoice should not include the AccountingSupplierParty Party PartyTaxScheme ExemptionReasonCode</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:ExemptionReason)"
                 flag="warning"
                 id="UBL-CR-172">[UBL-CR-172]-A UBL invoice should not include the AccountingSupplierParty Party PartyTaxScheme ExemptionReason</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:RegistrationAddress)"
                 flag="warning"
                 id="UBL-CR-173">[UBL-CR-173]-A UBL invoice should not include the AccountingSupplierParty Party PartyTaxScheme RegistrationAddress</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-174">[UBL-CR-174]-A UBL invoice should not include the AccountingSupplierParty Party PartyTaxScheme TaxScheme Name</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:TaxTypeCode)"
                 flag="warning"
                 id="UBL-CR-175">[UBL-CR-175]-A UBL invoice should not include the AccountingSupplierParty Party PartyTaxScheme TaxScheme TaxTypeCode</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:CurrencyCode)"
                 flag="warning"
                 id="UBL-CR-176">[UBL-CR-176]-A UBL invoice should not include the AccountingSupplierParty Party PartyTaxScheme TaxScheme CurrencyCode</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cac:JurisdictionRegionAddress)"
                 flag="warning"
                 id="UBL-CR-177">[UBL-CR-177]-A UBL invoice should not include the AccountingSupplierParty Party PartyTaxScheme TaxScheme JurisdictionRegionAddress</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationDate)"
                 flag="warning"
                 id="UBL-CR-178">[UBL-CR-178]-A UBL invoice should not include the AccountingSupplierParty Party PartyLegalEntity RegistrationDate</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationExpirationDate)"
                 flag="warning"
                 id="UBL-CR-179">[UBL-CR-179]-A UBL invoice should not include the AccountingSupplierParty Party PartyLegalEntity RegistrationExpirationDate</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalFormCode)"
                 flag="warning"
                 id="UBL-CR-180">[UBL-CR-180]-A UBL invoice should not include the AccountingSupplierParty Party PartyLegalEntity CompanyLegalFormCode</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:SoleProprietorshipIndicator)"
                 flag="warning"
                 id="UBL-CR-181">[UBL-CR-181]-A UBL invoice should not include the AccountingSupplierParty Party PartyLegalEntity SoleProprietorshipIndicator</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLiquidationStatusCode)"
                 flag="warning"
                 id="UBL-CR-182">[UBL-CR-182]-A UBL invoice should not include the AccountingSupplierParty Party PartyLegalEntity CompanyLiquidationStatusCode</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CorporationStockAmount)"
                 flag="warning"
                 id="UBL-CR-183">[UBL-CR-183]-A UBL invoice should not include the AccountingSupplierParty Party PartyLegalEntity CorporationStockAmount</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:FullyPaidSharesIndicator)"
                 flag="warning"
                 id="UBL-CR-184">[UBL-CR-184]-A UBL invoice should not include the AccountingSupplierParty Party PartyLegalEntity FullyPaidSharesIndicator</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress)"
                 flag="warning"
                 id="UBL-CR-185">[UBL-CR-185]-A UBL invoice should not include the AccountingSupplierParty Party PartyLegalEntity RegistrationAddress</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:CorporateRegistrationScheme)"
                 flag="warning"
                 id="UBL-CR-186">[UBL-CR-186]-A UBL invoice should not include the AccountingSupplierParty Party PartyLegalEntity CorporateRegistrationScheme</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:HeadOfficeParty)"
                 flag="warning"
                 id="UBL-CR-187">[UBL-CR-187]-A UBL invoice should not include the AccountingSupplierParty Party PartyLegalEntity HeadOfficeParty</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:ShareholderParty)"
                 flag="warning"
                 id="UBL-CR-188">[UBL-CR-188]-A UBL invoice should not include the AccountingSupplierParty Party PartyLegalEntity ShareholderParty</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ID)"
                 flag="warning"
                 id="UBL-CR-189">[UBL-CR-189]-A UBL invoice should not include the AccountingSupplierParty Party Contact ID</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telefax)"
                 flag="warning"
                 id="UBL-CR-190">[UBL-CR-190]-A UBL invoice should not include the AccountingSupplierParty Party Contact Telefax</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Note)"
                 flag="warning"
                 id="UBL-CR-191">[UBL-CR-191]-A UBL invoice should not include the AccountingSupplierParty Party Contact Note</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:Contact/cac:OtherCommunication)"
                 flag="warning"
                 id="UBL-CR-192">[UBL-CR-192]-A UBL invoice should not include the AccountingSupplierParty Party Contact OtherCommunication</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:Person)"
                 flag="warning"
                 id="UBL-CR-193">[UBL-CR-193]-A UBL invoice should not include the AccountingSupplierParty Party Person</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:AgentParty)"
                 flag="warning"
                 id="UBL-CR-194">[UBL-CR-194]-A UBL invoice should not include the AccountingSupplierParty Party AgentParty</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:ServiceProviderParty)"
                 flag="warning"
                 id="UBL-CR-195">[UBL-CR-195]-A UBL invoice should not include the AccountingSupplierParty Party ServiceProviderParty</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:PowerOfAttorney)"
                 flag="warning"
                 id="UBL-CR-196">[UBL-CR-196]-A UBL invoice should not include the AccountingSupplierParty Party PowerOfAttorney</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:Party/cac:FinancialAccount)"
                 flag="warning"
                 id="UBL-CR-197">[UBL-CR-197]-A UBL invoice should not include the AccountingSupplierParty Party FinancialAccount</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:DespatchContact)"
                 flag="warning"
                 id="UBL-CR-198">[UBL-CR-198]-A UBL invoice should not include the AccountingSupplierParty DespatchContact</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:AccountingContact)"
                 flag="warning"
                 id="UBL-CR-199">[UBL-CR-199]-A UBL invoice should not include the AccountingSupplierParty AccountingContact</assert>
         <assert test="not(cac:AccountingSupplierParty/cac:SellerContact)"
                 flag="warning"
                 id="UBL-CR-200">[UBL-CR-200]-A UBL invoice should not include the AccountingSupplierParty SellerContact</assert>
         <assert test="not(cac:AccountingCustomerParty/cbc:CustomerAssignedAccountID)"
                 flag="warning"
                 id="UBL-CR-201">[UBL-CR-201]-A UBL invoice should not include the AccountingCustomerParty CustomerAssignedAccountID</assert>
         <assert test="not(cac:AccountingCustomerParty/cbc:SupplierAssignedAccountID)"
                 flag="warning"
                 id="UBL-CR-202">[UBL-CR-202]-A UBL invoice should not include the AccountingCustomerParty SupplierAssignedAccountID</assert>
         <assert test="not(cac:AccountingCustomerParty/cbc:AdditionalAccountID)"
                 flag="warning"
                 id="UBL-CR-203">[UBL-CR-203]-A UBL invoice should not include the AccountingCustomerParty AdditionalAccountID</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cbc:MarkCareIndicator)"
                 flag="warning"
                 id="UBL-CR-204">[UBL-CR-204]-A UBL invoice should not include the AccountingCustomerParty Party MarkCareIndicator</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cbc:MarkAttentionIndicator)"
                 flag="warning"
                 id="UBL-CR-205">[UBL-CR-205]-A UBL invoice should not include the AccountingCustomerParty Party MarkAttentionIndicator</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cbc:WebsiteURI)"
                 flag="warning"
                 id="UBL-CR-206">[UBL-CR-206]-A UBL invoice should not include the AccountingCustomerParty Party WebsiteURI</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cbc:LogoReferenceID)"
                 flag="warning"
                 id="UBL-CR-207">[UBL-CR-207]-A UBL invoice should not include the AccountingCustomerParty Party LogoReferenceID</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cbc:IndustryClassificationCode)"
                 flag="warning"
                 id="UBL-CR-208">[UBL-CR-208]-A UBL invoice should not include the AccountingCustomerParty Party IndustryClassificationCode</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:Language)"
                 flag="warning"
                 id="UBL-CR-209">[UBL-CR-209]-A UBL invoice should not include the AccountingCustomerParty Party Language</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:ID)"
                 flag="warning"
                 id="UBL-CR-210">[UBL-CR-210]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress ID</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:AddressTypeCode)"
                 flag="warning"
                 id="UBL-CR-211">[UBL-CR-211]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress AddressTypeCode</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:AddressFormatCode)"
                 flag="warning"
                 id="UBL-CR-212">[UBL-CR-212]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress AddressFormatCode</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Postbox)"
                 flag="warning"
                 id="UBL-CR-213">[UBL-CR-213]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress Postbox</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Floor)"
                 flag="warning"
                 id="UBL-CR-214">[UBL-CR-214]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress Floor</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Room)"
                 flag="warning"
                 id="UBL-CR-215">[UBL-CR-215]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress Room</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:BlockName)"
                 flag="warning"
                 id="UBL-CR-216">[UBL-CR-216]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress BlockName</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:BuildingName)"
                 flag="warning"
                 id="UBL-CR-217">[UBL-CR-217]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress BuildingName</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber)"
                 flag="warning"
                 id="UBL-CR-218">[UBL-CR-218]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress BuildingNumber</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:InhouseMail)"
                 flag="warning"
                 id="UBL-CR-219">[UBL-CR-219]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress InhouseMail</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Department)"
                 flag="warning"
                 id="UBL-CR-220">[UBL-CR-220]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress Department</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:MarkAttention)"
                 flag="warning"
                 id="UBL-CR-221">[UBL-CR-221]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress MarkAttention</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:MarkCare)"
                 flag="warning"
                 id="UBL-CR-222">[UBL-CR-222]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress MarkCare</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PlotIdentification)"
                 flag="warning"
                 id="UBL-CR-223">[UBL-CR-223]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress PlotIdentification</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CitySubdivisionName)"
                 flag="warning"
                 id="UBL-CR-224">[UBL-CR-224]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress CitySubdivisionName</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CountrySubentityCode)"
                 flag="warning"
                 id="UBL-CR-225">[UBL-CR-225]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress CountrySubentityCode</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Region)"
                 flag="warning"
                 id="UBL-CR-226">[UBL-CR-226]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress Region</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:District)"
                 flag="warning"
                 id="UBL-CR-227">[UBL-CR-227]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress District</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:TimezoneOffset)"
                 flag="warning"
                 id="UBL-CR-228">[UBL-CR-228]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress TimezoneOffset</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-229">[UBL-CR-229]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress Country Name</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:LocationCoordinate)"
                 flag="warning"
                 id="UBL-CR-230">[UBL-CR-230]-A UBL invoice should not include the AccountingCustomerParty Party PostalAddress LocationCoordinate</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation)"
                 flag="warning"
                 id="UBL-CR-231">[UBL-CR-231]-A UBL invoice should not include the AccountingCustomerParty Party PhysicalLocation</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:RegistrationName)"
                 flag="warning"
                 id="UBL-CR-232">[UBL-CR-232]-A UBL invoice should not include the AccountingCustomerParty Party PartyTaxScheme RegistrationName</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:TaxLevelCode)"
                 flag="warning"
                 id="UBL-CR-233">[UBL-CR-233]-A UBL invoice should not include the AccountingCustomerParty Party PartyTaxScheme TaxLevelCode</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:ExemptionReasonCode)"
                 flag="warning"
                 id="UBL-CR-234">[UBL-CR-234]-A UBL invoice should not include the AccountingCustomerParty Party PartyTaxScheme ExemptionReasonCode</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:ExemptionReason)"
                 flag="warning"
                 id="UBL-CR-235">[UBL-CR-235]-A UBL invoice should not include the AccountingCustomerParty Party PartyTaxScheme ExemptionReason</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:RegistrationAddress)"
                 flag="warning"
                 id="UBL-CR-236">[UBL-CR-236]-A UBL invoice should not include the AccountingCustomerParty Party PartyTaxScheme RegistrationAddress</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-237">[UBL-CR-237]-A UBL invoice should not include the AccountingCustomerParty Party PartyTaxScheme TaxScheme Name</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:TaxTypeCode)"
                 flag="warning"
                 id="UBL-CR-238">[UBL-CR-238]-A UBL invoice should not include the AccountingCustomerParty Party PartyTaxScheme TaxScheme TaxTypeCode</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:CurrencyCode)"
                 flag="warning"
                 id="UBL-CR-239">[UBL-CR-239]-A UBL invoice should not include the AccountingCustomerParty Party PartyTaxScheme TaxScheme CurrencyCode</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cac:JurisdictionRegionAddress)"
                 flag="warning"
                 id="UBL-CR-240">[UBL-CR-240]-A UBL invoice should not include the AccountingCustomerParty Party PartyTaxScheme TaxScheme JurisdictionRegionAddress</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationDate)"
                 flag="warning"
                 id="UBL-CR-241">[UBL-CR-241]-A UBL invoice should not include the AccountingCustomerParty Party PartyLegalEntity RegistrationDate</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationExpirationDate)"
                 flag="warning"
                 id="UBL-CR-242">[UBL-CR-242]-A UBL invoice should not include the AccountingCustomerParty Party PartyLegalEntity RegistrationExpirationDate</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalFormCode)"
                 flag="warning"
                 id="UBL-CR-243">[UBL-CR-243]-A UBL invoice should not include the AccountingCustomerParty Party PartyLegalEntity CompanyLegalFormCode</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalForm)"
                 flag="warning"
                 id="UBL-CR-244">[UBL-CR-244]-A UBL invoice should not include the AccountingCustomerParty Party PartyLegalEntity CompanyLegalForm</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:SoleProprietorshipIndicator)"
                 flag="warning"
                 id="UBL-CR-245">[UBL-CR-245]-A UBL invoice should not include the AccountingCustomerParty Party PartyLegalEntity SoleProprietorshipIndicator</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLiquidationStatusCode)"
                 flag="warning"
                 id="UBL-CR-246">[UBL-CR-246]-A UBL invoice should not include the AccountingCustomerParty Party PartyLegalEntity CompanyLiquidationStatusCode</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CorporationStockAmount)"
                 flag="warning"
                 id="UBL-CR-247">[UBL-CR-247]-A UBL invoice should not include the AccountingCustomerParty Party PartyLegalEntity CorporationStockAmount</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:FullyPaidSharesIndicator)"
                 flag="warning"
                 id="UBL-CR-248">[UBL-CR-248]-A UBL invoice should not include the AccountingCustomerParty Party PartyLegalEntity FullyPaidSharesIndicator</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress)"
                 flag="warning"
                 id="UBL-CR-249">[UBL-CR-249]-A UBL invoice should not include the AccountingCustomerParty Party PartyLegalEntity RegistrationAddress</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:CorporateRegistrationScheme)"
                 flag="warning"
                 id="UBL-CR-250">[UBL-CR-250]-A UBL invoice should not include the AccountingCustomerParty Party PartyLegalEntity CorporateRegistrationScheme</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:HeadOfficeParty)"
                 flag="warning"
                 id="UBL-CR-251">[UBL-CR-251]-A UBL invoice should not include the AccountingCustomerParty Party PartyLegalEntity HeadOfficeParty</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:ShareholderParty)"
                 flag="warning"
                 id="UBL-CR-252">[UBL-CR-252]-A UBL invoice should not include the AccountingCustomerParty Party PartyLegalEntity ShareholderParty</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ID)"
                 flag="warning"
                 id="UBL-CR-253">[UBL-CR-253]-A UBL invoice should not include the AccountingCustomerParty Party Contact ID</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telefax)"
                 flag="warning"
                 id="UBL-CR-254">[UBL-CR-254]-A UBL invoice should not include the AccountingCustomerParty Party Contact Telefax</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Note)"
                 flag="warning"
                 id="UBL-CR-255">[UBL-CR-255]-A UBL invoice should not include the AccountingCustomerParty Party Contact Note</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:Contact/cac:OtherCommunication)"
                 flag="warning"
                 id="UBL-CR-256">[UBL-CR-256]-A UBL invoice should not include the AccountingCustomerParty Party Contact OtherCommunication</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:Person)"
                 flag="warning"
                 id="UBL-CR-257">[UBL-CR-257]-A UBL invoice should not include the AccountingCustomerParty Party Person</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:AgentParty)"
                 flag="warning"
                 id="UBL-CR-258">[UBL-CR-258]-A UBL invoice should not include the AccountingCustomerParty Party AgentParty</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:ServiceProviderParty)"
                 flag="warning"
                 id="UBL-CR-259">[UBL-CR-259]-A UBL invoice should not include the AccountingCustomerParty Party ServiceProviderParty</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:PowerOfAttorney)"
                 flag="warning"
                 id="UBL-CR-260">[UBL-CR-260]-A UBL invoice should not include the AccountingCustomerParty Party PowerOfAttorney</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:Party/cac:FinancialAccount)"
                 flag="warning"
                 id="UBL-CR-261">[UBL-CR-261]-A UBL invoice should not include the AccountingCustomerParty Party FinancialAccount</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:DeliveryContact)"
                 flag="warning"
                 id="UBL-CR-262">[UBL-CR-262]-A UBL invoice should not include the AccountingCustomerParty DeliveryContact</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:AccountingContact)"
                 flag="warning"
                 id="UBL-CR-263">[UBL-CR-263]-A UBL invoice should not include the AccountingCustomerParty AccountingContact</assert>
         <assert test="not(cac:AccountingCustomerParty/cac:BuyerContact)"
                 flag="warning"
                 id="UBL-CR-264">[UBL-CR-264]-A UBL invoice should not include the AccountingCustomerParty BuyerContact</assert>
         <assert test="not(cac:PayeeParty/cbc:MarkCareIndicator)"
                 flag="warning"
                 id="UBL-CR-265">[UBL-CR-265]-A UBL invoice should not include the PayeeParty MarkCareIndicator</assert>
         <assert test="not(cac:PayeeParty/cbc:MarkAttentionIndicator)"
                 flag="warning"
                 id="UBL-CR-266">[UBL-CR-266]-A UBL invoice should not include the PayeeParty MarkAttentionIndicator</assert>
         <assert test="not(cac:PayeeParty/cbc:WebsiteURI)"
                 flag="warning"
                 id="UBL-CR-267">[UBL-CR-267]-A UBL invoice should not include the PayeeParty WebsiteURI</assert>
         <assert test="not(cac:PayeeParty/cbc:LogoReferenceID)"
                 flag="warning"
                 id="UBL-CR-268">[UBL-CR-268]-A UBL invoice should not include the PayeeParty LogoReferenceID</assert>
         <assert test="not(cac:PayeeParty/cbc:EndpointID)"
                 flag="warning"
                 id="UBL-CR-269">[UBL-CR-269]-A UBL invoice should not include the PayeeParty EndpointID</assert>
         <assert test="not(cac:PayeeParty/cbc:IndustryClassificationCode)"
                 flag="warning"
                 id="UBL-CR-270">[UBL-CR-270]-A UBL invoice should not include the PayeeParty IndustryClassificationCode</assert>
         <assert test="not(cac:PayeeParty/cac:Language)"
                 flag="warning"
                 id="UBL-CR-271">[UBL-CR-271]-A UBL invoice should not include the PayeeParty Language</assert>
         <assert test="not(cac:PayeeParty/cac:PostalAddress)"
                 flag="warning"
                 id="UBL-CR-272">[UBL-CR-272]-A UBL invoice should not include the PayeeParty PostalAddress</assert>
         <assert test="not(cac:PayeeParty/cac:PhysicalLocation)"
                 flag="warning"
                 id="UBL-CR-273">[UBL-CR-273]-A UBL invoice should not include the PayeeParty PhysicalLocation</assert>
         <assert test="not(cac:PayeeParty/cac:PartyTaxScheme)"
                 flag="warning"
                 id="UBL-CR-274">[UBL-CR-274]-A UBL invoice should not include the PayeeParty PartyTaxScheme</assert>
         <assert test="not(cac:PayeeParty/cac:PartyLegalEntity/cbc:RegistrationName)"
                 flag="warning"
                 id="UBL-CR-275">[UBL-CR-275]-A UBL invoice should not include the PayeeParty PartyLegalEntity RegistrationName</assert>
         <assert test="not(cac:PayeeParty/cac:PartyLegalEntity/cbc:RegistrationDate)"
                 flag="warning"
                 id="UBL-CR-276">[UBL-CR-276]-A UBL invoice should not include the PayeeParty PartyLegalEntity RegistrationDate</assert>
         <assert test="not(cac:PayeeParty/cac:PartyLegalEntity/cbc:RegistrationExpirationDate)"
                 flag="warning"
                 id="UBL-CR-277">[UBL-CR-277]-A UBL invoice should not include the PayeeParty PartyLegalEntity RegistrationExpirationDate</assert>
         <assert test="not(cac:PayeeParty/cac:PartyLegalEntity/cbc:CompanyLegalFormCode)"
                 flag="warning"
                 id="UBL-CR-278">[UBL-CR-278]-A UBL invoice should not include the PayeeParty PartyLegalEntity CompanyLegalFormCode</assert>
         <assert test="not(cac:PayeeParty/cac:PartyLegalEntity/cbc:CompanyLegalForm)"
                 flag="warning"
                 id="UBL-CR-279">[UBL-CR-279]-A UBL invoice should not include the PayeeParty PartyLegalEntity CompanyLegalForm</assert>
         <assert test="not(cac:PayeeParty/cac:PartyLegalEntity/cbc:SoleProprietorshipIndicator)"
                 flag="warning"
                 id="UBL-CR-280">[UBL-CR-280]-A UBL invoice should not include the PayeeParty PartyLegalEntity SoleProprietorshipIndicator</assert>
         <assert test="not(cac:PayeeParty/cac:PartyLegalEntity/cbc:CompanyLiquidationStatusCode)"
                 flag="warning"
                 id="UBL-CR-281">[UBL-CR-281]-A UBL invoice should not include the PayeeParty PartyLegalEntity CompanyLiquidationStatusCode</assert>
         <assert test="not(cac:PayeeParty/cac:PartyLegalEntity/cbc:CorporationStockAmount)"
                 flag="warning"
                 id="UBL-CR-282">[UBL-CR-282]-A UBL invoice should not include the PayeeParty PartyLegalEntity CorporationStockAmount</assert>
         <assert test="not(cac:PayeeParty/cac:PartyLegalEntity/cbc:FullyPaidSharesIndicator)"
                 flag="warning"
                 id="UBL-CR-283">[UBL-CR-283]-A UBL invoice should not include the PayeeParty PartyLegalEntity FullyPaidSharesIndicator</assert>
         <assert test="not(cac:PayeeParty/cac:PartyLegalEntity/cac:RegistrationAddress)"
                 flag="warning"
                 id="UBL-CR-284">[UBL-CR-284]-A UBL invoice should not include the PayeeParty PartyLegalEntity RegistrationAddress</assert>
         <assert test="not(cac:PayeeParty/cac:PartyLegalEntity/cac:CorporateRegistrationScheme)"
                 flag="warning"
                 id="UBL-CR-285">[UBL-CR-285]-A UBL invoice should not include the PayeeParty PartyLegalEntity CorporateRegistrationScheme</assert>
         <assert test="not(cac:PayeeParty/cac:PartyLegalEntity/cac:HeadOfficeParty)"
                 flag="warning"
                 id="UBL-CR-286">[UBL-CR-286]-A UBL invoice should not include the PayeeParty PartyLegalEntity HeadOfficeParty</assert>
         <assert test="not(cac:PayeeParty/cac:PartyLegalEntity/cac:ShareholderParty)"
                 flag="warning"
                 id="UBL-CR-287">[UBL-CR-287]-A UBL invoice should not include the PayeeParty PartyLegalEntity ShareholderParty</assert>
         <assert test="not(cac:PayeeParty/cac:Contact)"
                 flag="warning"
                 id="UBL-CR-288">[UBL-CR-288]-A UBL invoice should not include the PayeeParty Contact</assert>
         <assert test="not(cac:PayeeParty/cac:Person)"
                 flag="warning"
                 id="UBL-CR-289">[UBL-CR-289]-A UBL invoice should not include the PayeeParty Person</assert>
         <assert test="not(cac:PayeeParty/cac:AgentParty)"
                 flag="warning"
                 id="UBL-CR-290">[UBL-CR-290]-A UBL invoice should not include the PayeeParty AgentParty</assert>
         <assert test="not(cac:PayeeParty/cac:ServiceProviderParty)"
                 flag="warning"
                 id="UBL-CR-291">[UBL-CR-291]-A UBL invoice should not include the PayeeParty ServiceProviderParty</assert>
         <assert test="not(cac:PayeeParty/cac:PowerOfAttorney)"
                 flag="warning"
                 id="UBL-CR-292">[UBL-CR-292]-A UBL invoice should not include the PayeeParty PowerOfAttorney</assert>
         <assert test="not(cac:PayeeParty/cac:FinancialAccount)"
                 flag="warning"
                 id="UBL-CR-293">[UBL-CR-293]-A UBL invoice should not include the PayeeParty FinancialAccount</assert>
         <assert test="not(cac:BuyerCustomerParty)" flag="warning" id="UBL-CR-294">[UBL-CR-294]-A UBL invoice should not include the BuyerCustomerParty</assert>
         <assert test="not(cac:SellerCustomerParty)" flag="warning" id="UBL-CR-295">[UBL-CR-295]-A UBL invoice should not include the SellerCustomerParty</assert>
         <assert test="not(cac:TaxRepresentativeParty/cbc:MarkCareIndicator)"
                 flag="warning"
                 id="UBL-CR-296">[UBL-CR-296]-A UBL invoice should not include the TaxRepresentativeParty MarkCareIndicator</assert>
         <assert test="not(cac:TaxRepresentativeParty/cbc:MarkAttentionIndicator)"
                 flag="warning"
                 id="UBL-CR-297">[UBL-CR-297]-A UBL invoice should not include the TaxRepresentativeParty MarkAttentionIndicator</assert>
         <assert test="not(cac:TaxRepresentativeParty/cbc:WebsiteURI)"
                 flag="warning"
                 id="UBL-CR-298">[UBL-CR-298]-A UBL invoice should not include the TaxRepresentativeParty WebsiteURI</assert>
         <assert test="not(cac:TaxRepresentativeParty/cbc:LogoReferenceID)"
                 flag="warning"
                 id="UBL-CR-299">[UBL-CR-299]-A UBL invoice should not include the TaxRepresentativeParty LogoReferenceID</assert>
         <assert test="not(cac:TaxRepresentativeParty/cbc:EndpointID)"
                 flag="warning"
                 id="UBL-CR-300">[UBL-CR-300]-A UBL invoice should not include the TaxRepresentativeParty EndpointID</assert>
         <assert test="not(cac:TaxRepresentativeParty/cbc:IndustryClassificationCode)"
                 flag="warning"
                 id="UBL-CR-301">[UBL-CR-301]-A UBL invoice should not include the TaxRepresentativeParty IndustryClassificationCode</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PartyIdentification)"
                 flag="warning"
                 id="UBL-CR-302">[UBL-CR-302]-A UBL invoice should not include the TaxRepresentativeParty PartyIdentification</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:Language)"
                 flag="warning"
                 id="UBL-CR-303">[UBL-CR-303]-A UBL invoice should not include the TaxRepresentativeParty Language</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:ID)"
                 flag="warning"
                 id="UBL-CR-304">[UBL-CR-304]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress ID</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:AddressTypeCode)"
                 flag="warning"
                 id="UBL-CR-305">[UBL-CR-305]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress AddressTypeCode</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:AddressFormatCode)"
                 flag="warning"
                 id="UBL-CR-306">[UBL-CR-306]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress AddressFormatCode</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:Postbox)"
                 flag="warning"
                 id="UBL-CR-307">[UBL-CR-307]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress Postbox</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:Floor)"
                 flag="warning"
                 id="UBL-CR-308">[UBL-CR-308]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress Floor</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:Room)"
                 flag="warning"
                 id="UBL-CR-309">[UBL-CR-309]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress Room</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:BlockName)"
                 flag="warning"
                 id="UBL-CR-310">[UBL-CR-310]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress BlockName</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:BuildingName)"
                 flag="warning"
                 id="UBL-CR-311">[UBL-CR-311]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress BuildingName</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:BuildingNumber)"
                 flag="warning"
                 id="UBL-CR-312">[UBL-CR-312]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress BuildingNumber</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:InhouseMail)"
                 flag="warning"
                 id="UBL-CR-313">[UBL-CR-313]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress InhouseMail</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:Department)"
                 flag="warning"
                 id="UBL-CR-314">[UBL-CR-314]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress Department</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:MarkAttention)"
                 flag="warning"
                 id="UBL-CR-315">[UBL-CR-315]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress MarkAttention</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:MarkCare)"
                 flag="warning"
                 id="UBL-CR-316">[UBL-CR-316]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress MarkCare</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:PlotIdentification)"
                 flag="warning"
                 id="UBL-CR-317">[UBL-CR-317]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress PlotIdentification</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:CitySubdivisionName)"
                 flag="warning"
                 id="UBL-CR-318">[UBL-CR-318]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress CitySubdivisionName</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:CountrySubentityCode)"
                 flag="warning"
                 id="UBL-CR-319">[UBL-CR-319]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress CountrySubentityCode</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:Region)"
                 flag="warning"
                 id="UBL-CR-320">[UBL-CR-320]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress Region</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:District)"
                 flag="warning"
                 id="UBL-CR-321">[UBL-CR-321]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress District</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cbc:TimezoneOffset)"
                 flag="warning"
                 id="UBL-CR-322">[UBL-CR-322]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress TimezoneOffset</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cac:Country/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-323">[UBL-CR-323]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress Country Name</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PostalAddress/cac:LocationCoordinate)"
                 flag="warning"
                 id="UBL-CR-324">[UBL-CR-324]-A UBL invoice should not include the TaxRepresentativeParty PostalAddress LocationCoordinate</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PhysicalLocation)"
                 flag="warning"
                 id="UBL-CR-325">[UBL-CR-325]-A UBL invoice should not include the TaxRepresentativeParty PhysicalLocation</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PartyTaxScheme/cbc:RegistrationName)"
                 flag="warning"
                 id="UBL-CR-326">[UBL-CR-326]-A UBL invoice should not include the TaxRepresentativeParty PartyTaxScheme RegistrationName</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PartyTaxScheme/cbc:TaxLevelCode)"
                 flag="warning"
                 id="UBL-CR-327">[UBL-CR-327]-A UBL invoice should not include the TaxRepresentativeParty PartyTaxScheme TaxLevelCode</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PartyTaxScheme/cbc:ExemptionReasonCode)"
                 flag="warning"
                 id="UBL-CR-328">[UBL-CR-328]-A UBL invoice should not include the TaxRepresentativeParty PartyTaxScheme ExemptionReasonCode</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PartyTaxScheme/cbc:ExemptionReason)"
                 flag="warning"
                 id="UBL-CR-329">[UBL-CR-329]-A UBL invoice should not include the TaxRepresentativeParty PartyTaxScheme ExemptionReason</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PartyTaxScheme/cac:RegistrationAddress)"
                 flag="warning"
                 id="UBL-CR-330">[UBL-CR-330]-A UBL invoice should not include the TaxRepresentativeParty PartyTaxScheme RegistrationAddress</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-331">[UBL-CR-331]-A UBL invoice should not include the TaxRepresentativeParty PartyTaxScheme TaxScheme Name</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PartyTaxScheme/cac:TaxScheme/cbc:TaxTypeCode)"
                 flag="warning"
                 id="UBL-CR-332">[UBL-CR-332]-A UBL invoice should not include the TaxRepresentativeParty PartyTaxScheme TaxScheme TaxTypeCode</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PartyTaxScheme/cac:TaxScheme/cbc:CurrencyCode)"
                 flag="warning"
                 id="UBL-CR-333">[UBL-CR-333]-A UBL invoice should not include the TaxRepresentativeParty PartyTaxScheme TaxScheme CurrencyCode</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PartyTaxScheme/cac:TaxScheme/cac:JurisdictionRegionAddress)"
                 flag="warning"
                 id="UBL-CR-334">[UBL-CR-334]-A UBL invoice should not include the TaxRepresentativeParty PartyTaxScheme TaxScheme JurisdictionRegionAddress</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PartyLegalEntity)"
                 flag="warning"
                 id="UBL-CR-335">[UBL-CR-335]-A UBL invoice should not include the TaxRepresentativeParty PartyLegalEntity</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:Contact)"
                 flag="warning"
                 id="UBL-CR-336">[UBL-CR-336]-A UBL invoice should not include the TaxRepresentativeParty Contact</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:Person)"
                 flag="warning"
                 id="UBL-CR-337">[UBL-CR-337]-A UBL invoice should not include the TaxRepresentativeParty Person</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:AgentParty)"
                 flag="warning"
                 id="UBL-CR-338">[UBL-CR-338]-A UBL invoice should not include the TaxRepresentativeParty AgentParty</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:ServiceProviderParty)"
                 flag="warning"
                 id="UBL-CR-339">[UBL-CR-339]-A UBL invoice should not include the TaxRepresentativeParty ServiceProviderParty</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:PowerOfAttorney)"
                 flag="warning"
                 id="UBL-CR-340">[UBL-CR-340]-A UBL invoice should not include the TaxRepresentativeParty PowerOfAttorney</assert>
         <assert test="not(cac:TaxRepresentativeParty/cac:FinancialAccount)"
                 flag="warning"
                 id="UBL-CR-341">[UBL-CR-341]-A UBL invoice should not include the TaxRepresentativeParty FinancialAccount</assert>
         <assert test="not(cac:Delivery/cbc:ID)" flag="warning" id="UBL-CR-342">[UBL-CR-342]-A UBL invoice should not include the Delivery ID</assert>
         <assert test="not(cac:Delivery/cbc:Quantity)"
                 flag="warning"
                 id="UBL-CR-343">[UBL-CR-343]-A UBL invoice should not include the Delivery Quantity</assert>
         <assert test="not(cac:Delivery/cbc:MinimumQuantity)"
                 flag="warning"
                 id="UBL-CR-344">[UBL-CR-344]-A UBL invoice should not include the Delivery MinimumQuantity</assert>
         <assert test="not(cac:Delivery/cbc:MaximumQuantity)"
                 flag="warning"
                 id="UBL-CR-345">[UBL-CR-345]-A UBL invoice should not include the Delivery MaximumQuantity</assert>
         <assert test="not(cac:Delivery/cbc:ActualDeliveryTime)"
                 flag="warning"
                 id="UBL-CR-346">[UBL-CR-346]-A UBL invoice should not include the Delivery ActualDeliveryTime</assert>
         <assert test="not(cac:Delivery/cbc:LatestDeliveryDate)"
                 flag="warning"
                 id="UBL-CR-347">[UBL-CR-347]-A UBL invoice should not include the Delivery LatestDeliveryDate</assert>
         <assert test="not(cac:Delivery/cbc:LatestDeliveryTime)"
                 flag="warning"
                 id="UBL-CR-348">[UBL-CR-348]-A UBL invoice should not include the Delivery LatestDeliveryTime</assert>
         <assert test="not(cac:Delivery/cbc:ReleaseID)"
                 flag="warning"
                 id="UBL-CR-349">[UBL-CR-349]-A UBL invoice should not include the Delivery ReleaseID</assert>
         <assert test="not(cac:Delivery/cbc:TrackingID)"
                 flag="warning"
                 id="UBL-CR-350">[UBL-CR-350]-A UBL invoice should not include the Delivery TrackingID</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cbc:Description)"
                 flag="warning"
                 id="UBL-CR-351">[UBL-CR-351]-A UBL invoice should not include the Delivery DeliveryLocation Description</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cbc:Conditions)"
                 flag="warning"
                 id="UBL-CR-352">[UBL-CR-352]-A UBL invoice should not include the Delivery DeliveryLocation Conditions</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cbc:CountrySubentity)"
                 flag="warning"
                 id="UBL-CR-353">[UBL-CR-353]-A UBL invoice should not include the Delivery DeliveryLocation CountrySubentity</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cbc:CountrySubentityCode)"
                 flag="warning"
                 id="UBL-CR-354">[UBL-CR-354]-A UBL invoice should not include the Delivery DeliveryLocation CountrySubentityCode</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cbc:LocationTypeCode)"
                 flag="warning"
                 id="UBL-CR-355">[UBL-CR-355]-A UBL invoice should not include the Delivery DeliveryLocation LocationTypeCode</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cbc:InformationURI)"
                 flag="warning"
                 id="UBL-CR-356">[UBL-CR-356]-A UBL invoice should not include the Delivery DeliveryLocation InformationURI</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-357">[UBL-CR-357]-A UBL invoice should not include the Delivery DeliveryLocation Name</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:ValidationPeriod)"
                 flag="warning"
                 id="UBL-CR-358">[UBL-CR-358]-A UBL invoice should not include the Delivery DeliveryLocation ValidationPeriod</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:ID)"
                 flag="warning"
                 id="UBL-CR-359">[UBL-CR-359]-A UBL invoice should not include the Delivery DeliveryLocation Address ID</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:AddressTypeCode)"
                 flag="warning"
                 id="UBL-CR-360">[UBL-CR-360]-A UBL invoice should not include the Delivery DeliveryLocation Address AddressTypeCode</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:AddressFormatCode)"
                 flag="warning"
                 id="UBL-CR-361">[UBL-CR-361]-A UBL invoice should not include the Delivery DeliveryLocation Address AddressFormatCode</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:Postbox)"
                 flag="warning"
                 id="UBL-CR-362">[UBL-CR-362]-A UBL invoice should not include the Delivery DeliveryLocation Address Postbox</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:Floor)"
                 flag="warning"
                 id="UBL-CR-363">[UBL-CR-363]-A UBL invoice should not include the Delivery DeliveryLocation Address Floor</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:Room)"
                 flag="warning"
                 id="UBL-CR-364">[UBL-CR-364]-A UBL invoice should not include the Delivery DeliveryLocation Address Room</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:BlockName)"
                 flag="warning"
                 id="UBL-CR-365">[UBL-CR-365]-A UBL invoice should not include the Delivery DeliveryLocation Address BlockName</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:BuildingName)"
                 flag="warning"
                 id="UBL-CR-366">[UBL-CR-366]-A UBL invoice should not include the Delivery DeliveryLocation Address BuildingName</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:BuildingNumber)"
                 flag="warning"
                 id="UBL-CR-367">[UBL-CR-367]-A UBL invoice should not include the Delivery DeliveryLocation Address BuildingNumber</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:InhouseMail)"
                 flag="warning"
                 id="UBL-CR-368">[UBL-CR-368]-A UBL invoice should not include the Delivery DeliveryLocation Address InhouseMail</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:Department)"
                 flag="warning"
                 id="UBL-CR-369">[UBL-CR-369]-A UBL invoice should not include the Delivery DeliveryLocation Address Department</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:MarkAttention)"
                 flag="warning"
                 id="UBL-CR-370">[UBL-CR-370]-A UBL invoice should not include the Delivery DeliveryLocation Address MarkAttention</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:MarkCare)"
                 flag="warning"
                 id="UBL-CR-371">[UBL-CR-371]-A UBL invoice should not include the Delivery DeliveryLocation Address MarkCare</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:PlotIdentification)"
                 flag="warning"
                 id="UBL-CR-372">[UBL-CR-372]-A UBL invoice should not include the Delivery DeliveryLocation Address PlotIdentification</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:CitySubdivisionName)"
                 flag="warning"
                 id="UBL-CR-373">[UBL-CR-373]-A UBL invoice should not include the Delivery DeliveryLocation Address CitySubdivisionName</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:CountrySubentityCode)"
                 flag="warning"
                 id="UBL-CR-374">[UBL-CR-374]-A UBL invoice should not include the Delivery DeliveryLocation Address CountrySubentityCode</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:Region)"
                 flag="warning"
                 id="UBL-CR-375">[UBL-CR-375]-A UBL invoice should not include the Delivery DeliveryLocation Address Region</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:District)"
                 flag="warning"
                 id="UBL-CR-376">[UBL-CR-376]-A UBL invoice should not include the Delivery DeliveryLocation Address District</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cbc:TimezoneOffset)"
                 flag="warning"
                 id="UBL-CR-377">[UBL-CR-377]-A UBL invoice should not include the Delivery DeliveryLocation Address TimezoneOffset</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cac:Country/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-378">[UBL-CR-378]-A UBL invoice should not include the Delivery DeliveryLocation Address Country Name</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:Address/cac:LocationCoordinate)"
                 flag="warning"
                 id="UBL-CR-379">[UBL-CR-379]-A UBL invoice should not include the Delivery DeliveryLocation Address LocationCoordinate</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:SubsidiaryLocation)"
                 flag="warning"
                 id="UBL-CR-380">[UBL-CR-380]-A UBL invoice should not include the Delivery DeliveryLocation SubsidiaryLocation</assert>
         <assert test="not(cac:Delivery/cac:DeliveryLocation/cac:LocationCoordinate)"
                 flag="warning"
                 id="UBL-CR-381">[UBL-CR-381]-A UBL invoice should not include the Delivery DeliveryLocation LocationCoordinate</assert>
         <assert test="not(cac:Delivery/cac:AlternativeDeliveryLocation)"
                 flag="warning"
                 id="UBL-CR-382">[UBL-CR-382]-A UBL invoice should not include the Delivery AlternativeDeliveryLocation</assert>
         <assert test="not(cac:Delivery/cac:RequestedDeliveryPeriod)"
                 flag="warning"
                 id="UBL-CR-383">[UBL-CR-383]-A UBL invoice should not include the Delivery RequestedDeliveryPeriod</assert>
         <assert test="not(cac:Delivery/cac:PromisedDeliveryPeriod)"
                 flag="warning"
                 id="UBL-CR-384">[UBL-CR-384]-A UBL invoice should not include the Delivery PromisedDeliveryPeriod</assert>
         <assert test="not(cac:Delivery/cac:CarrierParty)"
                 flag="warning"
                 id="UBL-CR-385">[UBL-CR-385]-A UBL invoice should not include the Delivery CarrierParty</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cbc:MarkCareIndicator)"
                 flag="warning"
                 id="UBL-CR-386">[UBL-CR-386]-A UBL invoice should not include the DeliveryParty MarkCareIndicator</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cbc:MarkAttentionIndicator)"
                 flag="warning"
                 id="UBL-CR-387">[UBL-CR-387]-A UBL invoice should not include the DeliveryParty MarkAttentionIndicator</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cbc:WebsiteURI)"
                 flag="warning"
                 id="UBL-CR-388">[UBL-CR-388]-A UBL invoice should not include the DeliveryParty WebsiteURI</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cbc:LogoReferenceID)"
                 flag="warning"
                 id="UBL-CR-389">[UBL-CR-389]-A UBL invoice should not include the DeliveryParty LogoReferenceID</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cbc:EndpointID)"
                 flag="warning"
                 id="UBL-CR-390">[UBL-CR-390]-A UBL invoice should not include the DeliveryParty EndpointID</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cbc:IndustryClassificationCode)"
                 flag="warning"
                 id="UBL-CR-391">[UBL-CR-391]-A UBL invoice should not include the DeliveryParty IndustryClassificationCode</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cac:PartyIdentification)"
                 flag="warning"
                 id="UBL-CR-392">[UBL-CR-392]-A UBL invoice should not include the DeliveryParty PartyIdentification</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cac:Language)"
                 flag="warning"
                 id="UBL-CR-393">[UBL-CR-393]-A UBL invoice should not include the DeliveryParty Language</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cac:PostalAddress)"
                 flag="warning"
                 id="UBL-CR-394">[UBL-CR-394]-A UBL invoice should not include the DeliveryParty PostalAddress</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cac:PhysicalLocation)"
                 flag="warning"
                 id="UBL-CR-395">[UBL-CR-395]-A UBL invoice should not include the DeliveryParty PhysicalLocation</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cac:PartyTaxScheme)"
                 flag="warning"
                 id="UBL-CR-396">[UBL-CR-396]-A UBL invoice should not include the DeliveryParty PartyTaxScheme</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cac:PartyLegalEntity)"
                 flag="warning"
                 id="UBL-CR-397">[UBL-CR-397]-A UBL invoice should not include the DeliveryParty PartyLegalEntity</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cac:Contact)"
                 flag="warning"
                 id="UBL-CR-398">[UBL-CR-398]-A UBL invoice should not include the DeliveryParty Contact</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cac:Person)"
                 flag="warning"
                 id="UBL-CR-399">[UBL-CR-399]-A UBL invoice should not include the DeliveryParty Person</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cac:AgentParty)"
                 flag="warning"
                 id="UBL-CR-400">[UBL-CR-400]-A UBL invoice should not include the DeliveryParty AgentParty</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cac:ServiceProviderParty)"
                 flag="warning"
                 id="UBL-CR-401">[UBL-CR-401]-A UBL invoice should not include the DeliveryParty ServiceProviderParty</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cac:PowerOfAttorney)"
                 flag="warning"
                 id="UBL-CR-402">[UBL-CR-402]-A UBL invoice should not include the DeliveryParty PowerOfAttorney</assert>
         <assert test="not(cac:Delivery/cac:DeliveryParty/cac:FinancialAccount)"
                 flag="warning"
                 id="UBL-CR-403">[UBL-CR-403]-A UBL invoice should not include the DeliveryParty FinancialAccount</assert>
         <assert test="not(cac:Delivery/cac:NotifyParty)"
                 flag="warning"
                 id="UBL-CR-404">[UBL-CR-404]-A UBL invoice should not include the Delivery NotifyParty</assert>
         <assert test="not(cac:Delivery/cac:Despatch)"
                 flag="warning"
                 id="UBL-CR-405">[UBL-CR-405]-A UBL invoice should not include the Delivery Despatch</assert>
         <assert test="not(cac:Delivery/cac:DeliveryTerms)"
                 flag="warning"
                 id="UBL-CR-406">[UBL-CR-406]-A UBL invoice should not include the Delivery DeliveryTerms</assert>
         <assert test="not(cac:Delivery/cac:MinimumDeliveryUnit)"
                 flag="warning"
                 id="UBL-CR-407">[UBL-CR-407]-A UBL invoice should not include the Delivery MinimumDeliveryUnit</assert>
         <assert test="not(cac:Delivery/cac:MaximumDeliveryUnit)"
                 flag="warning"
                 id="UBL-CR-408">[UBL-CR-408]-A UBL invoice should not include the Delivery MaximumDeliveryUnit</assert>
         <assert test="not(cac:Delivery/cac:Shipment)"
                 flag="warning"
                 id="UBL-CR-409">[UBL-CR-409]-A UBL invoice should not include the Delivery Shipment</assert>
         <assert test="not(cac:DeliveryTerms)" flag="warning" id="UBL-CR-410">[UBL-CR-410]-A UBL invoice should not include the DeliveryTerms</assert>
         <assert test="not(cac:PaymentMeans/cbc:ID)" flag="warning" id="UBL-CR-411">[UBL-CR-411]-A UBL invoice should not include the PaymentMeans ID</assert>
         <assert test="not(cac:PaymentMeans/cbc:PaymentDueDate)"
                 flag="warning"
                 id="UBL-CR-412">[UBL-CR-412]-A UBL invoice should not include the PaymentMeans PaymentDueDate</assert>
         <assert test="not(cac:PaymentMeans/cbc:PaymentChannelCode)"
                 flag="warning"
                 id="UBL-CR-413">[UBL-CR-413]-A UBL invoice should not include the PaymentMeans PaymentChannelCode</assert>
         <assert test="not(cac:PaymentMeans/cbc:InstructionID)"
                 flag="warning"
                 id="UBL-CR-414">[UBL-CR-414]-A UBL invoice should not include the PaymentMeans InstructionID</assert>
         <assert test="not(cac:PaymentMeans/cac:CardAccount/cbc:CardTypeCode)"
                 flag="warning"
                 id="UBL-CR-415">[UBL-CR-415]-A UBL invoice should not include the PaymentMeans CardAccount CardTypeCode</assert>
         <assert test="not(cac:PaymentMeans/cac:CardAccount/cbc:ValidityStartDate)"
                 flag="warning"
                 id="UBL-CR-416">[UBL-CR-416]-A UBL invoice should not include the PaymentMeans CardAccount ValidityStartDate</assert>
         <assert test="not(cac:PaymentMeans/cac:CardAccount/cbc:ExpiryDate)"
                 flag="warning"
                 id="UBL-CR-417">[UBL-CR-417]-A UBL invoice should not include the PaymentMeans CardAccount ExpiryDate</assert>
         <assert test="not(cac:PaymentMeans/cac:CardAccount/cbc:IssuerID)"
                 flag="warning"
                 id="UBL-CR-418">[UBL-CR-418]-A UBL invoice should not include the PaymentMeans CardAccount IssuerID</assert>
         <assert test="not(cac:PaymentMeans/cac:CardAccount/cbc:IssuerNumberID)"
                 flag="warning"
                 id="UBL-CR-419">[UBL-CR-419]-A UBL invoice should not include the PaymentMeans CardAccount IssuerNumberID</assert>
         <assert test="not(cac:PaymentMeans/cac:CardAccount/cbc:CV2ID)"
                 flag="warning"
                 id="UBL-CR-420">[UBL-CR-420]-A UBL invoice should not include the PaymentMeans CardAccount CV2ID</assert>
         <assert test="not(cac:PaymentMeans/cac:CardAccount/cbc:CardChipCode)"
                 flag="warning"
                 id="UBL-CR-421">[UBL-CR-421]-A UBL invoice should not include the PaymentMeans CardAccount CardChipCode</assert>
         <assert test="not(cac:PaymentMeans/cac:CardAccount/cbc:ChipApplicationID)"
                 flag="warning"
                 id="UBL-CR-422">[UBL-CR-422]-A UBL invoice should not include the PaymentMeans CardAccount ChipApplicationID</assert>
         <assert test="not(cac:PaymentMeans/cac:PayerFinancialAccount)"
                 flag="warning"
                 id="UBL-CR-423">[UBL-CR-423]-A UBL invoice should not include the PaymentMeans PayerFinancialAccount</assert>
         <assert test="not(cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:AliasName)"
                 flag="warning"
                 id="UBL-CR-424">[UBL-CR-424]-A UBL invoice should not include the PaymentMeans PayeeFinancialAccount AliasName</assert>
         <assert test="not(cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:AccountTypeCode)"
                 flag="warning"
                 id="UBL-CR-425">[UBL-CR-425]-A UBL invoice should not include the PaymentMeans PayeeFinancialAccount AccountTypeCode</assert>
         <assert test="not(cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:AccountFormatCode)"
                 flag="warning"
                 id="UBL-CR-426">[UBL-CR-426]-A UBL invoice should not include the PaymentMeans PayeeFinancialAccount AccountFormatCode</assert>
         <assert test="not(cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:CurrencyCode)"
                 flag="warning"
                 id="UBL-CR-427">[UBL-CR-427]-A UBL invoice should not include the PaymentMeans PayeeFinancialAccount CurrencyCode</assert>
         <assert test="not(cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:PaymentNote)"
                 flag="warning"
                 id="UBL-CR-428">[UBL-CR-428]-A UBL invoice should not include the PaymentMeans PayeeFinancialAccount PaymentNote</assert>
         <assert test="not(cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-429">[UBL-CR-429]-A UBL invoice should not include the PaymentMeans PayeeFinancialAccount FinancialInstitutionBranch Name</assert>
         <assert test="not(cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-430">[UBL-CR-430]-A UBL invoice should not include the PaymentMeans PayeeFinancialAccount FinancialInstitutionBranch FinancialInstitution Name</assert>
         <assert test="not(cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cac:Address)"
                 flag="warning"
                 id="UBL-CR-431">[UBL-CR-431]-A UBL invoice should not include the PaymentMeans PayeeFinancialAccount FinancialInstitutionBranch FinancialInstitution Address</assert>
         <assert test="not(cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address)"
                 flag="warning"
                 id="UBL-CR-432">[UBL-CR-432]-A UBL invoice should not include the PaymentMeans PayeeFinancialAccount FinancialInstitutionBranch Address</assert>
         <assert test="not(cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country)"
                 flag="warning"
                 id="UBL-CR-433">[UBL-CR-433]-A UBL invoice should not include the PaymentMeans PayeeFinancialAccount Country</assert>
         <assert test="not(cac:PaymentMeans/cac:CreditAccount)"
                 flag="warning"
                 id="UBL-CR-434">[UBL-CR-434]-A UBL invoice should not include the PaymentMeans CreditAccount</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cbc:MandateTypeCode)"
                 flag="warning"
                 id="UBL-CR-435">[UBL-CR-435]-A UBL invoice should not include the PaymentMeans PaymentMandate MandateTypeCode</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cbc:MaximumPaymentInstructionsNumeric)"
                 flag="warning"
                 id="UBL-CR-436">[UBL-CR-436]-A UBL invoice should not include the PaymentMeans PaymentMandate MaximumPaymentInstructionsNumeric</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cbc:MaximumPaidAmount)"
                 flag="warning"
                 id="UBL-CR-437">[UBL-CR-437]-A UBL invoice should not include the PaymentMeans PaymentMandate MaximumPaidAmount</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cbc:SignatureID)"
                 flag="warning"
                 id="UBL-CR-438">[UBL-CR-438]-A UBL invoice should not include the PaymentMeans PaymentMandate SignatureID</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cac:PayerParty)"
                 flag="warning"
                 id="UBL-CR-439">[UBL-CR-439]-A UBL invoice should not include the PaymentMeans PaymentMandate PayerParty</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cac:PayerFinancialAccount/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-440">[UBL-CR-440]-A UBL invoice should not include the PaymentMeans PaymentMandate PayerFinancialAccount Name</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cac:PayerFinancialAccount/cbc:AliasName)"
                 flag="warning"
                 id="UBL-CR-441">[UBL-CR-441]-A UBL invoice should not include the PaymentMeans PaymentMandate PayerFinancialAccount AliasName</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cac:PayerFinancialAccount/cbc:AccountTypeCode)"
                 flag="warning"
                 id="UBL-CR-442">[UBL-CR-442]-A UBL invoice should not include the PaymentMeans PaymentMandate PayerFinancialAccount AccountTypeCode</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cac:PayerFinancialAccount/cbc:AccountFormatCode)"
                 flag="warning"
                 id="UBL-CR-443">[UBL-CR-443]-A UBL invoice should not include the PaymentMeans PaymentMandate PayerFinancialAccount AccountFormatCode</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cac:PayerFinancialAccount/cbc:CurrencyCode)"
                 flag="warning"
                 id="UBL-CR-444">[UBL-CR-444]-A UBL invoice should not include the PaymentMeans PaymentMandate PayerFinancialAccount CurrencyCode</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cac:PayerFinancialAccount/cbc:PaymentNote)"
                 flag="warning"
                 id="UBL-CR-445">[UBL-CR-445]-A UBL invoice should not include the PaymentMeans PaymentMandate PayerFinancialAccount PaymentNote</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cac:PayerFinancialAccount/cac:FinancialInstitutionBranch)"
                 flag="warning"
                 id="UBL-CR-446">[UBL-CR-446]-A UBL invoice should not include the PaymentMeans PaymentMandate PayerFinancialAccount FinancialInstitutionBranch</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cac:PayerFinancialAccount/cac:Country)"
                 flag="warning"
                 id="UBL-CR-447">[UBL-CR-447]-A UBL invoice should not include the PaymentMeans PaymentMandate PayerFinancialAccount Country</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cac:ValidityPeriod)"
                 flag="warning"
                 id="UBL-CR-448">[UBL-CR-448]-A UBL invoice should not include the PaymentMeans PaymentMandate ValidityPeriod</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cac:PaymentReversalPeriod)"
                 flag="warning"
                 id="UBL-CR-449">[UBL-CR-449]-A UBL invoice should not include the PaymentMeans PaymentMandate PaymentReversalPeriod</assert>
         <assert test="not(cac:PaymentMeans/cac:PaymentMandate/cac:Clause)"
                 flag="warning"
                 id="UBL-CR-450">[UBL-CR-450]-A UBL invoice should not include the PaymentMeans PaymentMandate Clause</assert>
         <assert test="not(cac:PaymentMeans/cac:TradeFinancing)"
                 flag="warning"
                 id="UBL-CR-451">[UBL-CR-451]-A UBL invoice should not include the PaymentMeans TradeFinancing</assert>
         <assert test="not(cac:PaymentTerms/cbc:ID)" flag="warning" id="UBL-CR-452">[UBL-CR-452]-A UBL invoice should not include the PaymentTerms ID</assert>
         <assert test="not(cac:PaymentTerms/cbc:PaymentMeansID)"
                 flag="warning"
                 id="UBL-CR-453">[UBL-CR-453]-A UBL invoice should not include the PaymentTerms PaymentMeansID</assert>
         <assert test="not(cac:PaymentTerms/cbc:PrepaidPaymentReferenceID)"
                 flag="warning"
                 id="UBL-CR-454">[UBL-CR-454]-A UBL invoice should not include the PaymentTerms PrepaidPaymentReferenceID</assert>
         <assert test="not(cac:PaymentTerms/cbc:ReferenceEventCode)"
                 flag="warning"
                 id="UBL-CR-455">[UBL-CR-455]-A UBL invoice should not include the PaymentTerms ReferenceEventCode</assert>
         <assert test="not(cac:PaymentTerms/cbc:SettlementDiscountPercent)"
                 flag="warning"
                 id="UBL-CR-456">[UBL-CR-456]-A UBL invoice should not include the PaymentTerms SettlementDiscountPercent</assert>
         <assert test="not(cac:PaymentTerms/cbc:PenaltySurchargePercent)"
                 flag="warning"
                 id="UBL-CR-457">[UBL-CR-457]-A UBL invoice should not include the PaymentTerms PenaltySurchargePercent</assert>
         <assert test="not(cac:PaymentTerms/cbc:PaymentPercent)"
                 flag="warning"
                 id="UBL-CR-458">[UBL-CR-458]-A UBL invoice should not include the PaymentTerms PaymentPercent</assert>
         <assert test="not(cac:PaymentTerms/cbc:Amount)"
                 flag="warning"
                 id="UBL-CR-459">[UBL-CR-459]-A UBL invoice should not include the PaymentTerms Amount</assert>
         <assert test="not(cac:PaymentTerms/cbc:SettlementDiscountAmount)"
                 flag="warning"
                 id="UBL-CR-460">[UBL-CR-460]-A UBL invoice should not include the PaymentTerms SettlementDiscountAmount</assert>
         <assert test="not(cac:PaymentTerms/cbc:PenaltyAmount)"
                 flag="warning"
                 id="UBL-CR-461">[UBL-CR-461]-A UBL invoice should not include the PaymentTerms PenaltyAmount</assert>
         <assert test="not(cac:PaymentTerms/cbc:PaymentTermsDetailsURI)"
                 flag="warning"
                 id="UBL-CR-462">[UBL-CR-462]-A UBL invoice should not include the PaymentTerms PaymentTermsDetailsURI</assert>
         <assert test="not(cac:PaymentTerms/cbc:PaymentDueDate)"
                 flag="warning"
                 id="UBL-CR-463">[UBL-CR-463]-A UBL invoice should not include the PaymentTerms PaymentDueDate</assert>
         <assert test="not(cac:PaymentTerms/cbc:InstallmentDueDate)"
                 flag="warning"
                 id="UBL-CR-464">[UBL-CR-464]-A UBL invoice should not include the PaymentTerms InstallmentDueDate</assert>
         <assert test="not(cac:PaymentTerms/cbc:InvoicingPartyReference)"
                 flag="warning"
                 id="UBL-CR-465">[UBL-CR-465]-A UBL invoice should not include the PaymentTerms InvoicingPartyReference</assert>
         <assert test="not(cac:PaymentTerms/cac:SettlementPeriod)"
                 flag="warning"
                 id="UBL-CR-466">[UBL-CR-466]-A UBL invoice should not include the PaymentTerms SettlementPeriod</assert>
         <assert test="not(cac:PaymentTerms/cac:PenaltyPeriod)"
                 flag="warning"
                 id="UBL-CR-467">[UBL-CR-467]-A UBL invoice should not include the PaymentTerms PenaltyPeriod</assert>
         <assert test="not(cac:PaymentTerms/cac:ExchangeRate)"
                 flag="warning"
                 id="UBL-CR-468">[UBL-CR-468]-A UBL invoice should not include the PaymentTerms ExchangeRate</assert>
         <assert test="not(cac:PaymentTerms/cac:ValidityPeriod)"
                 flag="warning"
                 id="UBL-CR-469">[UBL-CR-469]-A UBL invoice should not include the PaymentTerms ValidityPeriod</assert>
         <assert test="not(cac:PrepaidPayment)" flag="warning" id="UBL-CR-470">[UBL-CR-470]-A UBL invoice should not include the PrepaidPayment</assert>
         <assert test="not(cac:AllowanceCharge/cbc:ID)"
                 flag="warning"
                 id="UBL-CR-471">[UBL-CR-471]-A UBL invoice should not include the AllowanceCharge ID</assert>
         <assert test="not(cac:AllowanceCharge/cbc:PrepaidIndicator)"
                 flag="warning"
                 id="UBL-CR-472">[UBL-CR-472]-A UBL invoice should not include the AllowanceCharge PrepaidIndicator</assert>
         <assert test="not(cac:AllowanceCharge/cbc:SequenceNumeric)"
                 flag="warning"
                 id="UBL-CR-473">[UBL-CR-473]-A UBL invoice should not include the AllowanceCharge SequenceNumeric</assert>
         <assert test="not(cac:AllowanceCharge/cbc:AccountingCostCode)"
                 flag="warning"
                 id="UBL-CR-474">[UBL-CR-474]-A UBL invoice should not include the AllowanceCharge AccountingCostCode</assert>
         <assert test="not(cac:AllowanceCharge/cbc:AccountingCost)"
                 flag="warning"
                 id="UBL-CR-475">[UBL-CR-475]-A UBL invoice should not include the AllowanceCharge AccountingCost</assert>
         <assert test="not(cac:AllowanceCharge/cbc:PerUnitAmount)"
                 flag="warning"
                 id="UBL-CR-476">[UBL-CR-476]-A UBL invoice should not include the AllowanceCharge PerUnitAmount</assert>
         <assert test="not(cac:AllowanceCharge/cac:TaxCategory/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-477">[UBL-CR-477]-A UBL invoice should not include the AllowanceCharge TaxCategory Name</assert>
         <assert test="not(cac:AllowanceCharge/cac:TaxCategory/cbc:BaseUnitMeasure)"
                 flag="warning"
                 id="UBL-CR-478">[UBL-CR-478]-A UBL invoice should not include the AllowanceCharge TaxCategory BaseUnitMeasure</assert>
         <assert test="not(cac:AllowanceCharge/cac:TaxCategory/cbc:PerUnitAmount)"
                 flag="warning"
                 id="UBL-CR-479">[UBL-CR-479]-A UBL invoice should not include the AllowanceCharge TaxCategory PerUnitAmount</assert>
         <assert test="not(cac:AllowanceCharge/cac:TaxCategory/cbc:TaxExemptionReasonCode)"
                 flag="warning"
                 id="UBL-CR-480">[UBL-CR-480]-A UBL invoice should not include the AllowanceCharge TaxCategory TaxExemptionReasonCode</assert>
         <assert test="not(cac:AllowanceCharge/cac:TaxCategory/cbc:TaxExemptionReason)"
                 flag="warning"
                 id="UBL-CR-481">[UBL-CR-481]-A UBL invoice should not include the AllowanceCharge TaxCategory TaxExemptionReason</assert>
         <assert test="not(cac:AllowanceCharge/cac:TaxCategory/cbc:TierRange)"
                 flag="warning"
                 id="UBL-CR-482">[UBL-CR-482]-A UBL invoice should not include the AllowanceCharge TaxCategory TierRange</assert>
         <assert test="not(cac:AllowanceCharge/cac:TaxCategory/cbc:TierRatePercent)"
                 flag="warning"
                 id="UBL-CR-483">[UBL-CR-483]-A UBL invoice should not include the AllowanceCharge TaxCategory TierRatePercent</assert>
         <assert test="not(cac:AllowanceCharge/cac:TaxCategory/cac:TaxScheme/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-484">[UBL-CR-484]-A UBL invoice should not include the AllowanceCharge TaxCategory TaxScheme Name</assert>
         <assert test="not(cac:AllowanceCharge/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode)"
                 flag="warning"
                 id="UBL-CR-485">[UBL-CR-485]-A UBL invoice should not include the AllowanceCharge TaxCategory TaxScheme TaxTypeCode</assert>
         <assert test="not(cac:AllowanceCharge/cac:TaxCategory/cac:TaxScheme/cbc:CurrencyCode)"
                 flag="warning"
                 id="UBL-CR-486">[UBL-CR-486]-A UBL invoice should not include the AllowanceCharge TaxCategory TaxScheme CurrencyCode</assert>
         <assert test="not(cac:AllowanceCharge/cac:TaxCategory/cac:TaxScheme/cac:JurisdiccionRegionAddress)"
                 flag="warning"
                 id="UBL-CR-487">[UBL-CR-487]-A UBL invoice should not include the AllowanceCharge TaxCategory TaxScheme JurisdiccionRegionAddress</assert>
         <assert test="not(cac:AllowanceCharge/cac:TaxTotal)"
                 flag="warning"
                 id="UBL-CR-488">[UBL-CR-488]-A UBL invoice should not include the AllowanceCharge TaxTotal</assert>
         <assert test="not(cac:AllowanceCharge/cac:PaymentMeans)"
                 flag="warning"
                 id="UBL-CR-489">[UBL-CR-489]-A UBL invoice should not include the AllowanceCharge PaymentMeans</assert>
         <assert test="not(cac:TaxExchangeRate)" flag="warning" id="UBL-CR-490">[UBL-CR-490]-A UBL invoice should not include the TaxExchangeRate</assert>
         <assert test="not(cac:PricingExchangeRate)" flag="warning" id="UBL-CR-491">[UBL-CR-491]-A UBL invoice should not include the PricingExchangeRate</assert>
         <assert test="not(cac:PaymentExchangeRate)" flag="warning" id="UBL-CR-492">[UBL-CR-492]-A UBL invoice should not include the PaymentExchangeRate</assert>
         <assert test="not(cac:PaymentAlternativeExchangeRate)"
                 flag="warning"
                 id="UBL-CR-493">[UBL-CR-493]-A UBL invoice should not include the PaymentAlternativeExchangeRate</assert>
         <assert test="not(cac:TaxTotal/cbc:RoundingAmount)"
                 flag="warning"
                 id="UBL-CR-494">[UBL-CR-494]-A UBL invoice should not include the TaxTotal RoundingAmount</assert>
         <assert test="not(cac:TaxTotal/cbc:TaxEvidenceIndicator)"
                 flag="warning"
                 id="UBL-CR-495">[UBL-CR-495]-A UBL invoice should not include the TaxTotal TaxEvidenceIndicator</assert>
         <assert test="not(cac:TaxTotal/cbc:TaxIncludedIndicator)"
                 flag="warning"
                 id="UBL-CR-496">[UBL-CR-496]-A UBL invoice should not include the TaxTotal TaxIncludedIndicator</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cbc:CalculationSequenceNumeric)"
                 flag="warning"
                 id="UBL-CR-497">[UBL-CR-497]-A UBL invoice should not include the TaxTotal TaxSubtotal CalulationSequenceNumeric</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cbc:TransactionCurrencyTaxAmount)"
                 flag="warning"
                 id="UBL-CR-498">[UBL-CR-498]-A UBL invoice should not include the TaxTotal TaxSubtotal TransactionCurrencyTaxAmount</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cbc:Percent)"
                 flag="warning"
                 id="UBL-CR-499">[UBL-CR-499]-A UBL invoice should not include the TaxTotal TaxSubtotal Percent</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cbc:BaseUnitMeasure)"
                 flag="warning"
                 id="UBL-CR-500">[UBL-CR-500]-A UBL invoice should not include the TaxTotal TaxSubtotal BaseUnitMeasure</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cbc:PerUnitAmount)"
                 flag="warning"
                 id="UBL-CR-501">[UBL-CR-501]-A UBL invoice should not include the TaxTotal TaxSubtotal PerUnitAmount</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cbc:TierRange)"
                 flag="warning"
                 id="UBL-CR-502">[UBL-CR-502]-A UBL invoice should not include the TaxTotal TaxSubtotal TierRange</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cbc:TierRatePercent)"
                 flag="warning"
                 id="UBL-CR-503">[UBL-CR-503]-A UBL invoice should not include the TaxTotal TaxSubtotal TierRatePercent</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-504">[UBL-CR-504]-A UBL invoice should not include the TaxTotal TaxSubtotal TaxCategory Name</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:BaseUnitMeasure)"
                 flag="warning"
                 id="UBL-CR-505">[UBL-CR-505]-A UBL invoice should not include the TaxTotal TaxSubtotal TaxCategory BaseUnitMeasure</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:PerUnitAmount)"
                 flag="warning"
                 id="UBL-CR-506">[UBL-CR-506]-A UBL invoice should not include the TaxTotal TaxSubtotal TaxCategory PerUnitAmount</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:TierRange)"
                 flag="warning"
                 id="UBL-CR-507">[UBL-CR-507]-A UBL invoice should not include the TaxTotal TaxSubtotal TaxCategory TierRange</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:TierRatePercent)"
                 flag="warning"
                 id="UBL-CR-508">[UBL-CR-508]-A UBL invoice should not include the TaxTotal TaxSubtotal TaxCategory TierRatePercent</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-509">[UBL-CR-509]-A UBL invoice should not include the TaxTotal TaxSubtotal TaxCategory TaxScheme Name</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode)"
                 flag="warning"
                 id="UBL-CR-510">[UBL-CR-510]-A UBL invoice should not include the TaxTotal TaxSubtotal TaxCategory TaxScheme TaxTypeCode</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:CurrencyCode)"
                 flag="warning"
                 id="UBL-CR-511">[UBL-CR-511]-A UBL invoice should not include the TaxTotal TaxSubtotal TaxCategory TaxScheme CurrencyCode</assert>
         <assert test="not(cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cac:JurisdiccionRegionAddress)"
                 flag="warning"
                 id="UBL-CR-512">[UBL-CR-512]-A UBL invoice should not include the TaxTotal TaxSubtotal TaxCategory TaxScheme JurisdiccionRegionAddress</assert>
         <assert test="not(cac:WithholdingTaxTotal)" flag="warning" id="UBL-CR-513">[UBL-CR-513]-A UBL invoice should not include the WithholdingTaxTotal</assert>
         <assert test="not(cac:LegalMonetaryTotal/cbc:PayableAlternativeAmount)"
                 flag="warning"
                 id="UBL-CR-514">[UBL-CR-514]-A UBL invoice should not include the LegalMonetaryTotal PayableAlternativeAmount</assert>
         <assert test="not(cac:InvoiceLine/cbc:UUID)" flag="warning" id="UBL-CR-515">[UBL-CR-515]-A UBL invoice should not include the InvoiceLine UUID</assert>
         <assert test="not(cac:InvoiceLine/cbc:TaxPointDate)"
                 flag="warning"
                 id="UBL-CR-516">[UBL-CR-516]-A UBL invoice should not include the InvoiceLine TaxPointDate</assert>
         <assert test="not(cac:InvoiceLine/cbc:AccountingCostCode)"
                 flag="warning"
                 id="UBL-CR-517">[UBL-CR-517]-A UBL invoice should not include the InvoiceLine AccountingCostCode</assert>
         <assert test="not(cac:InvoiceLine/cbc:PaymentPurposeCode)"
                 flag="warning"
                 id="UBL-CR-518">[UBL-CR-518]-A UBL invoice should not include the InvoiceLine PaymentPurposeCode</assert>
         <assert test="not(cac:InvoiceLine/cbc:FreeOfChargeIndicator)"
                 flag="warning"
                 id="UBL-CR-519">[UBL-CR-519]-A UBL invoice should not include the InvoiceLine FreeOfChargeIndicator</assert>
         <assert test="not(cac:InvoiceLine/cac:InvoicePeriod/cbc:StartTime)"
                 flag="warning"
                 id="UBL-CR-520">[UBL-CR-520]-A UBL invoice should not include the InvoiceLine InvoicePeriod StartTime</assert>
         <assert test="not(cac:InvoiceLine/cac:InvoicePeriod/cbc:EndTime)"
                 flag="warning"
                 id="UBL-CR-521">[UBL-CR-521]-A UBL invoice should not include the InvoiceLine InvoicePeriod EndTime</assert>
         <assert test="not(cac:InvoiceLine/cac:InvoicePeriod/cbc:DurationMeasure)"
                 flag="warning"
                 id="UBL-CR-522">[UBL-CR-522]-A UBL invoice should not include the InvoiceLine InvoicePeriod DurationMeasure</assert>
         <assert test="not(cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode)"
                 flag="warning"
                 id="UBL-CR-523">[UBL-CR-523]-A UBL invoice should not include the InvoiceLine InvoicePeriod DescriptionCode</assert>
         <assert test="not(cac:InvoiceLine/cac:InvoicePeriod/cbc:Description)"
                 flag="warning"
                 id="UBL-CR-524">[UBL-CR-524]-A UBL invoice should not include the InvoiceLine InvoicePeriod Description</assert>
         <assert test="not(cac:InvoiceLine/cac:OrderLineReference/cbc:SalesOrderLineID)"
                 flag="warning"
                 id="UBL-CR-525">[UBL-CR-525]-A UBL invoice should not include the InvoiceLine OrderLineReference SalesOrderLineID</assert>
         <assert test="not(cac:InvoiceLine/cac:OrderLineReference/cbc:UUID)"
                 flag="warning"
                 id="UBL-CR-526">[UBL-CR-526]-A UBL invoice should not include the InvoiceLine OrderLineReference UUID</assert>
         <assert test="not(cac:InvoiceLine/cac:OrderLineReference/cbc:LineStatusCode)"
                 flag="warning"
                 id="UBL-CR-527">[UBL-CR-527]-A UBL invoice should not include the InvoiceLine OrderLineReference LineStatusCode</assert>
         <assert test="not(cac:InvoiceLine/cac:OrderLineReference/cbc:OrderReference)"
                 flag="warning"
                 id="UBL-CR-528">[UBL-CR-528]-A UBL invoice should not include the InvoiceLine OrderLineReference OrderReference</assert>
         <assert test="not(cac:InvoiceLine/cac:DespatchLineReference)"
                 flag="warning"
                 id="UBL-CR-529">[UBL-CR-529]-A UBL invoice should not include the InvoiceLine DespatchLineReference</assert>
         <assert test="not(cac:InvoiceLine/cac:ReceiptLineReference)"
                 flag="warning"
                 id="UBL-CR-530">[UBL-CR-530]-A UBL invoice should not include the InvoiceLine ReceiptLineReference</assert>
         <assert test="not(cac:InvoiceLine/cac:BillingReference)"
                 flag="warning"
                 id="UBL-CR-531">[UBL-CR-531]-A UBL invoice should not include the InvoiceLine BillingReference</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cbc:CopyIndicator)"
                 flag="warning"
                 id="UBL-CR-532">[UBL-CR-532]-A UBL invoice should not include the InvoiceLine DocumentReference CopyIndicator</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cbc:UUID)"
                 flag="warning"
                 id="UBL-CR-533">[UBL-CR-533]-A UBL invoice should not include the InvoiceLine DocumentReference UUID</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cbc:IssueDate)"
                 flag="warning"
                 id="UBL-CR-534">[UBL-CR-534]-A UBL invoice should not include the InvoiceLine DocumentReference IssueDate</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cbc:IssueTime)"
                 flag="warning"
                 id="UBL-CR-535">[UBL-CR-535]-A UBL invoice should not include the InvoiceLine DocumentReference IssueTime</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cbc:DocumentType)"
                 flag="warning"
                 id="UBL-CR-537">[UBL-CR-537]-A UBL invoice should not include the InvoiceLine DocumentReference DocumentType</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cbc:Xpath)"
                 flag="warning"
                 id="UBL-CR-538">[UBL-CR-538]-A UBL invoice should not include the InvoiceLine DocumentReference Xpath</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cbc:LanguageID)"
                 flag="warning"
                 id="UBL-CR-539">[UBL-CR-539]-A UBL invoice should not include the InvoiceLine DocumentReference LanguageID</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cbc:LocaleCode)"
                 flag="warning"
                 id="UBL-CR-540">[UBL-CR-540]-A UBL invoice should not include the InvoiceLine DocumentReference LocaleCode</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cbc:VersionID)"
                 flag="warning"
                 id="UBL-CR-541">[UBL-CR-541]-A UBL invoice should not include the InvoiceLine DocumentReference VersionID</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cbc:DocumentStatusCode)"
                 flag="warning"
                 id="UBL-CR-542">[UBL-CR-542]-A UBL invoice should not include the InvoiceLine DocumentReference DocumentStatusCode</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cbc:DocumentDescription)"
                 flag="warning"
                 id="UBL-CR-543">[UBL-CR-543]-A UBL invoice should not include the InvoiceLine DocumentReference DocumentDescription</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cac:Attachment)"
                 flag="warning"
                 id="UBL-CR-544">[UBL-CR-544]-A UBL invoice should not include the InvoiceLine DocumentReference Attachment</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cac:ValidityPeriod)"
                 flag="warning"
                 id="UBL-CR-545">[UBL-CR-545]-A UBL invoice should not include the InvoiceLine DocumentReference ValidityPeriod</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cac:IssuerParty)"
                 flag="warning"
                 id="UBL-CR-546">[UBL-CR-546]-A UBL invoice should not include the InvoiceLine DocumentReference IssuerParty</assert>
         <assert test="not(cac:InvoiceLine/cac:DocumentReference/cac:ResultOfVerification)"
                 flag="warning"
                 id="UBL-CR-547">[UBL-CR-547]-A UBL invoice should not include the InvoiceLine DocumentReference ResultOfVerification</assert>
         <assert test="not(cac:InvoiceLine/cac:PricingReference)"
                 flag="warning"
                 id="UBL-CR-548">[UBL-CR-548]-A UBL invoice should not include the InvoiceLine PricingReference</assert>
         <assert test="not(cac:InvoiceLine/cac:OriginatorParty)"
                 flag="warning"
                 id="UBL-CR-549">[UBL-CR-549]-A UBL invoice should not include the InvoiceLine OriginatorParty</assert>
         <assert test="not(cac:InvoiceLine/cac:Delivery)"
                 flag="warning"
                 id="UBL-CR-550">[UBL-CR-550]-A UBL invoice should not include the InvoiceLine Delivery</assert>
         <assert test="not(cac:InvoiceLine/cac:PaymentTerms)"
                 flag="warning"
                 id="UBL-CR-551">[UBL-CR-551]-A UBL invoice should not include the InvoiceLine PaymentTerms</assert>
         <assert test="not(cac:InvoiceLine/cac:AllowanceCharge/cbc:ID)"
                 flag="warning"
                 id="UBL-CR-552">[UBL-CR-552]-A UBL invoice should not include the InvoiceLine AllowanceCharge ID</assert>
         <assert test="not(cac:InvoiceLine/cac:AllowanceCharge/cbc:PrepaidIndicator)"
                 flag="warning"
                 id="UBL-CR-553">[UBL-CR-553]-A UBL invoice should not include the InvoiceLine AllowanceCharge PrepaidIndicator</assert>
         <assert test="not(cac:InvoiceLine/cac:AllowanceCharge/cbc:SequenceNumeric)"
                 flag="warning"
                 id="UBL-CR-554">[UBL-CR-554]-A UBL invoice should not include the InvoiceLine AllowanceCharge SequenceNumeric</assert>
         <assert test="not(cac:InvoiceLine/cac:AllowanceCharge/cbc:AccountingCostCode)"
                 flag="warning"
                 id="UBL-CR-555">[UBL-CR-555]-A UBL invoice should not include the InvoiceLine AllowanceCharge AccountingCostCode</assert>
         <assert test="not(cac:InvoiceLine/cac:AllowanceCharge/cbc:AccountingCost)"
                 flag="warning"
                 id="UBL-CR-556">[UBL-CR-556]-A UBL invoice should not include the InvoiceLine AllowanceCharge AccountingCost</assert>
         <assert test="not(cac:InvoiceLine/cac:AllowanceCharge/cbc:PerUnitAmount)"
                 flag="warning"
                 id="UBL-CR-557">[UBL-CR-557]-A UBL invoice should not include the InvoiceLine AllowanceCharge PerUnitAmount</assert>
         <assert test="not(cac:InvoiceLine/cac:AllowanceCharge/cac:TaxCategory)"
                 flag="warning"
                 id="UBL-CR-558">[UBL-CR-558]-A UBL invoice should not include the InvoiceLine AllowanceCharge TaxCategory</assert>
         <assert test="not(cac:InvoiceLine/cac:AllowanceCharge/cac:TaxTotal)"
                 flag="warning"
                 id="UBL-CR-559">[UBL-CR-559]-A UBL invoice should not include the InvoiceLine AllowanceCharge TaxTotal</assert>
         <assert test="not(cac:InvoiceLine/cac:AllowanceCharge/cac:PaymentMeans)"
                 flag="warning"
                 id="UBL-CR-560">[UBL-CR-560]-A UBL invoice should not include the InvoiceLine AllowanceCharge PaymentMeans</assert>
         <assert test="not(cac:InvoiceLine/cac:TaxTotal)"
                 flag="warning"
                 id="UBL-CR-561">[UBL-CR-561]-A UBL invoice should not include the InvoiceLine TaxTotal</assert>
         <assert test="not(cac:InvoiceLine/cac:WithholdingTaxTotal)"
                 flag="warning"
                 id="UBL-CR-562">[UBL-CR-562]-A UBL invoice should not include the InvoiceLine WithholdingTaxTotal</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cbc:PackQuantity)"
                 flag="warning"
                 id="UBL-CR-563">[UBL-CR-563]-A UBL invoice should not include the InvoiceLine Item PackQuantity</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cbc:PackSizeNumeric)"
                 flag="warning"
                 id="UBL-CR-564">[UBL-CR-564]-A UBL invoice should not include the InvoiceLine Item PackSizeNumeric</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cbc:CatalogueIndicator)"
                 flag="warning"
                 id="UBL-CR-565">[UBL-CR-565]-A UBL invoice should not include the InvoiceLine Item CatalogueIndicator</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cbc:HazardousRiskIndicator)"
                 flag="warning"
                 id="UBL-CR-566">[UBL-CR-566]-A UBL invoice should not include the InvoiceLine Item HazardousRiskIndicator</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cbc:AdditionalInformation)"
                 flag="warning"
                 id="UBL-CR-567">[UBL-CR-567]-A UBL invoice should not include the InvoiceLine Item AdditionalInformation</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cbc:Keyword)"
                 flag="warning"
                 id="UBL-CR-568">[UBL-CR-568]-A UBL invoice should not include the InvoiceLine Item Keyword</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cbc:BrandName)"
                 flag="warning"
                 id="UBL-CR-569">[UBL-CR-569]-A UBL invoice should not include the InvoiceLine Item BrandName</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cbc:ModelName)"
                 flag="warning"
                 id="UBL-CR-570">[UBL-CR-570]-A UBL invoice should not include the InvoiceLine Item ModelName</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:BuyersItemIdentification/cbc:ExtendedID)"
                 flag="warning"
                 id="UBL-CR-571">[UBL-CR-571]-A UBL invoice should not include the InvoiceLine Item BuyersItemIdentification ExtendedID</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:BuyersItemIdentification/cbc:BareCodeSymbologyID)"
                 flag="warning"
                 id="UBL-CR-572">[UBL-CR-572]-A UBL invoice should not include the InvoiceLine Item BuyersItemIdentification BareCodeSymbologyID</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:BuyersItemIdentification/cac:PhysicalAttribute)"
                 flag="warning"
                 id="UBL-CR-573">[UBL-CR-573]-A UBL invoice should not include the InvoiceLine Item BuyersItemIdentification PhysicalAttribute</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:BuyersItemIdentification/cac:MeasurementDimension)"
                 flag="warning"
                 id="UBL-CR-574">[UBL-CR-574]-A UBL invoice should not include the InvoiceLine Item BuyersItemIdentification MeasurementDimension</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:BuyersItemIdentification/cac:IssuerParty)"
                 flag="warning"
                 id="UBL-CR-575">[UBL-CR-575]-A UBL invoice should not include the InvoiceLine Item BuyersItemIdentification IssuerParty</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:SellersItemIdentification/cbc:ExtendedID)"
                 flag="warning"
                 id="UBL-CR-576">[UBL-CR-576]-A UBL invoice should not include the InvoiceLine Item SellersItemIdentification ExtendedID</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:SellersItemIdentification/cbc:BareCodeSymbologyID)"
                 flag="warning"
                 id="UBL-CR-577">[UBL-CR-577]-A UBL invoice should not include the InvoiceLine Item SellersItemIdentification BareCodeSymbologyID</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:SellersItemIdentification/cac:PhysicalAttribute)"
                 flag="warning"
                 id="UBL-CR-578">[UBL-CR-578]-A UBL invoice should not include the InvoiceLine Item SellersItemIdentification PhysicalAttribute</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:SellersItemIdentification/cac:MeasurementDimension)"
                 flag="warning"
                 id="UBL-CR-579">[UBL-CR-579]-A UBL invoice should not include the InvoiceLine Item SellersItemIdentification MeasurementDimension</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:SellersItemIdentification/cac:IssuerParty)"
                 flag="warning"
                 id="UBL-CR-580">[UBL-CR-580]-A UBL invoice should not include the InvoiceLine Item SellersItemIdentification IssuerParty</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ManufacturersItemIdentification)"
                 flag="warning"
                 id="UBL-CR-581">[UBL-CR-581]-A UBL invoice should not include the InvoiceLine Item ManufacturersItemIdentification</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:StandardItemIdentification/cbc:ExtendedID)"
                 flag="warning"
                 id="UBL-CR-582">[UBL-CR-582]-A UBL invoice should not include the InvoiceLine Item StandardItemIdentification ExtendedID</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:StandardItemIdentification/cbc:BareCodeSymbologyID)"
                 flag="warning"
                 id="UBL-CR-583">[UBL-CR-583]-A UBL invoice should not include the InvoiceLine Item StandardItemIdentification BareCodeSymbologyID</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:StandardItemIdentification/cac:PhysicalAttribute)"
                 flag="warning"
                 id="UBL-CR-584">[UBL-CR-584]-A UBL invoice should not include the InvoiceLine Item StandardItemIdentification PhysicalAttribute</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:StandardItemIdentification/cac:MeasurementDimension)"
                 flag="warning"
                 id="UBL-CR-585">[UBL-CR-585]-A UBL invoice should not include the InvoiceLine Item StandardItemIdentification MeasurementDimension</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:StandardItemIdentification/cac:IssuerParty)"
                 flag="warning"
                 id="UBL-CR-586">[UBL-CR-586]-A UBL invoice should not include the InvoiceLine Item StandardItemIdentification IssuerParty</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:CatalogueItemIdentification)"
                 flag="warning"
                 id="UBL-CR-587">[UBL-CR-587]-A UBL invoice should not include the InvoiceLine Item CatalogueItemIdentification</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:AdditionalItemIdentification)"
                 flag="warning"
                 id="UBL-CR-588">[UBL-CR-588]-A UBL invoice should not include the InvoiceLine Item AdditionalItemIdentification</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:CatalogueDocumentReference)"
                 flag="warning"
                 id="UBL-CR-589">[UBL-CR-589]-A UBL invoice should not include the InvoiceLine Item CatalogueDocumentReference</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ItemSpecificationDocumentReference)"
                 flag="warning"
                 id="UBL-CR-590">[UBL-CR-590]-A UBL invoice should not include the InvoiceLine Item ItemSpecificationDocumentReference</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:OriginCountry/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-591">[UBL-CR-591]-A UBL invoice should not include the InvoiceLine Item OriginCountry Name</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:CommodityClassification/cbc:NatureCode)"
                 flag="warning"
                 id="UBL-CR-592">[UBL-CR-592]-A UBL invoice should not include the InvoiceLine Item CommodityClassification NatureCode</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:CommodityClassification/cbc:CargoTypeCode)"
                 flag="warning"
                 id="UBL-CR-593">[UBL-CR-593]-A UBL invoice should not include the InvoiceLine Item CommodityClassification CargoTypeCode</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:CommodityClassification/cbc:CommodityCode)"
                 flag="warning"
                 id="UBL-CR-594">[UBL-CR-594]-A UBL invoice should not include the InvoiceLine Item CommodityClassification CommodityCode</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:TransactionConditions)"
                 flag="warning"
                 id="UBL-CR-595">[UBL-CR-595]-A UBL invoice should not include the InvoiceLine Item TransactionConditions</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:HazardousItem)"
                 flag="warning"
                 id="UBL-CR-596">[UBL-CR-596]-A UBL invoice should not include the InvoiceLine Item HazardousItem</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-597">[UBL-CR-597]-A UBL invoice should not include the InvoiceLine Item ClassifiedTaxCategory Name</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cbc:BaseUnitMeasure)"
                 flag="warning"
                 id="UBL-CR-598">[UBL-CR-598]-A UBL invoice should not include the InvoiceLine Item ClassifiedTaxCategory BaseUnitMeasure</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cbc:PerUnitAmount)"
                 flag="warning"
                 id="UBL-CR-599">[UBL-CR-599]-A UBL invoice should not include the InvoiceLine Item ClassifiedTaxCategory PerUnitAmount</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cbc:TaxExemptionReasonCode)"
                 flag="warning"
                 id="UBL-CR-600">[UBL-CR-600]-A UBL invoice should not include the InvoiceLine Item ClassifiedTaxCategory TaxExemptionReasonCode</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cbc:TaxExemptionReason)"
                 flag="warning"
                 id="UBL-CR-601">[UBL-CR-601]-A UBL invoice should not include the InvoiceLine Item ClassifiedTaxCategory TaxExemptionReason</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cbc:TierRange)"
                 flag="warning"
                 id="UBL-CR-602">[UBL-CR-602]-A UBL invoice should not include the InvoiceLine Item ClassifiedTaxCategory TierRange</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cbc:TierRatePercent)"
                 flag="warning"
                 id="UBL-CR-603">[UBL-CR-603]-A UBL invoice should not include the InvoiceLine Item ClassifiedTaxCategory TierRatePercent</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name)"
                 flag="warning"
                 id="UBL-CR-604">[UBL-CR-604]-A UBL invoice should not include the InvoiceLine Item ClassifiedTaxCategory TaxScheme Name</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:TaxTypeCode)"
                 flag="warning"
                 id="UBL-CR-605">[UBL-CR-605]-A UBL invoice should not include the InvoiceLine Item ClassifiedTaxCategory TaxScheme TaxTypeCode</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:CurrencyCode)"
                 flag="warning"
                 id="UBL-CR-606">[UBL-CR-606]-A UBL invoice should not include the InvoiceLine Item ClassifiedTaxCategory TaxScheme CurrencyCode</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cac:JurisdiccionRegionAddress)"
                 flag="warning"
                 id="UBL-CR-607">[UBL-CR-607]-A UBL invoice should not include the InvoiceLine Item ClassifiedTaxCategory TaxScheme JurisdiccionRegionAddress</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cbc:ID)"
                 flag="warning"
                 id="UBL-CR-608">[UBL-CR-608]-A UBL invoice should not include the InvoiceLine Item AdditionalItemProperty ID</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cbc:NameCode)"
                 flag="warning"
                 id="UBL-CR-609">[UBL-CR-609]-A UBL invoice should not include the InvoiceLine Item AdditionalItemProperty NameCode</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cbc:TestMethod)"
                 flag="warning"
                 id="UBL-CR-610">[UBL-CR-610]-A UBL invoice should not include the InvoiceLine Item AdditionalItemProperty TestMethod</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cbc:ValueQuantity)"
                 flag="warning"
                 id="UBL-CR-611">[UBL-CR-611]-A UBL invoice should not include the InvoiceLine Item AdditionalItemProperty ValueQuantity</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cbc:ValueQualifier)"
                 flag="warning"
                 id="UBL-CR-612">[UBL-CR-612]-A UBL invoice should not include the InvoiceLine Item AdditionalItemProperty ValueQualifier</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cbc:ImportanceCode)"
                 flag="warning"
                 id="UBL-CR-613">[UBL-CR-613]-A UBL invoice should not include the InvoiceLine Item AdditionalItemProperty ImportanceCode</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cbc:ListValue)"
                 flag="warning"
                 id="UBL-CR-614">[UBL-CR-614]-A UBL invoice should not include the InvoiceLine Item AdditionalItemProperty ListValue</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cac:UsabilityPeriod)"
                 flag="warning"
                 id="UBL-CR-615">[UBL-CR-615]-A UBL invoice should not include the InvoiceLine Item AdditionalItemProperty UsabilityPeriod</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cac:ItemPropertyGroup)"
                 flag="warning"
                 id="UBL-CR-616">[UBL-CR-616]-A UBL invoice should not include the InvoiceLine Item AdditionalItemProperty ItemPropertyGroup</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cac:RangeDimension)"
                 flag="warning"
                 id="UBL-CR-617">[UBL-CR-617]-A UBL invoice should not include the InvoiceLine Item AdditionalItemProperty RangeDimension</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cac:ItemPropertyRange)"
                 flag="warning"
                 id="UBL-CR-618">[UBL-CR-618]-A UBL invoice should not include the InvoiceLine Item AdditionalItemProperty ItemPropertyRange</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ManufacturerParty)"
                 flag="warning"
                 id="UBL-CR-619">[UBL-CR-619]-A UBL invoice should not include the InvoiceLine Item ManufacturerParty</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:InformationContentProviderParty)"
                 flag="warning"
                 id="UBL-CR-620">[UBL-CR-620]-A UBL invoice should not include the InvoiceLine Item InformationContentProviderParty</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:OriginAddress)"
                 flag="warning"
                 id="UBL-CR-621">[UBL-CR-621]-A UBL invoice should not include the InvoiceLine Item OriginAddress</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:ItemInstance)"
                 flag="warning"
                 id="UBL-CR-622">[UBL-CR-622]-A UBL invoice should not include the InvoiceLine Item ItemInstance</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Certificate)"
                 flag="warning"
                 id="UBL-CR-623">[UBL-CR-623]-A UBL invoice should not include the InvoiceLine Item Certificate</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Dimension)"
                 flag="warning"
                 id="UBL-CR-624">[UBL-CR-624]-A UBL invoice should not include the InvoiceLine Item Dimension</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cbc:PriceChangeReason)"
                 flag="warning"
                 id="UBL-CR-625">[UBL-CR-625]-A UBL invoice should not include the InvoiceLine Item Price PriceChangeReason</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cbc:PriceTypeCode)"
                 flag="warning"
                 id="UBL-CR-626">[UBL-CR-626]-A UBL invoice should not include the InvoiceLine Item Price PriceTypeCode</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cbc:PriceType)"
                 flag="warning"
                 id="UBL-CR-627">[UBL-CR-627]-A UBL invoice should not include the InvoiceLine Item Price PriceType</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cbc:OrderableUnitFactorRate)"
                 flag="warning"
                 id="UBL-CR-628">[UBL-CR-628]-A UBL invoice should not include the InvoiceLine Item Price OrderableUnitFactorRate</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cbc:ValidityPeriod)"
                 flag="warning"
                 id="UBL-CR-629">[UBL-CR-629]-A UBL invoice should not include the InvoiceLine Item Price ValidityPeriod</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cbc:PriceList)"
                 flag="warning"
                 id="UBL-CR-630">[UBL-CR-630]-A UBL invoice should not include the InvoiceLine Item Price PriceList</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cbc:OrderableUnitFactorRate)"
                 flag="warning"
                 id="UBL-CR-631">[UBL-CR-631]-A UBL invoice should not include the InvoiceLine Item Price OrderableUnitFactorRate</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cac:AllowanceCharge/cbc:ID)"
                 flag="warning"
                 id="UBL-CR-632">[UBL-CR-632]-A UBL invoice should not include the InvoiceLine Item Price AllowanceCharge ID</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cac:AllowanceCharge/cbc:AllowanceChargeReasonCode)"
                 flag="warning"
                 id="UBL-CR-633">[UBL-CR-633]-A UBL invoice should not include the InvoiceLine Item Price AllowanceCharge AllowanceChargeReasonCode</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cac:AllowanceCharge/cbc:AllowanceChargeReason)"
                 flag="warning"
                 id="UBL-CR-634">[UBL-CR-634]-A UBL invoice should not include the InvoiceLine Item Price AllowanceCharge AllowanceChargeReason</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cac:AllowanceCharge/cbc:MultiplierFactorNumeric)"
                 flag="warning"
                 id="UBL-CR-635">[UBL-CR-635]-A UBL invoice should not include the InvoiceLine Item Price AllowanceCharge MultiplierFactorNumeric</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cac:AllowanceCharge/cbc:PrepaidIndicator)"
                 flag="warning"
                 id="UBL-CR-636">[UBL-CR-636]-A UBL invoice should not include the InvoiceLine Item Price AllowanceCharge PrepaidIndicator</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cac:AllowanceCharge/cbc:SequenceNumeric)"
                 flag="warning"
                 id="UBL-CR-637">[UBL-CR-637]-A UBL invoice should not include the InvoiceLine Item Price AllowanceCharge SequenceNumeric</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cac:AllowanceCharge/cbc:AccountingCostCode)"
                 flag="warning"
                 id="UBL-CR-638">[UBL-CR-638]-A UBL invoice should not include the InvoiceLine Item Price AllowanceCharge AccountingCostCode</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cac:AllowanceCharge/cbc:AccountingCost)"
                 flag="warning"
                 id="UBL-CR-639">[UBL-CR-639]-A UBL invoice should not include the InvoiceLine Item Price AllowanceCharge AccountingCost</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cac:AllowanceCharge/cbc:PerUnitAmount)"
                 flag="warning"
                 id="UBL-CR-640">[UBL-CR-640]-A UBL invoice should not include the InvoiceLine Item Price AllowanceCharge PerUnitAmount</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cac:AllowanceCharge/cac:TaxCategory)"
                 flag="warning"
                 id="UBL-CR-641">[UBL-CR-641]-A UBL invoice should not include the InvoiceLine Item Price AllowanceCharge TaxCategory</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cac:AllowanceCharge/cac:TaxTotal)"
                 flag="warning"
                 id="UBL-CR-642">[UBL-CR-642]-A UBL invoice should not include the InvoiceLine Item Price AllowanceCharge TaxTotal</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cac:AllowanceCharge/cac:PaymentMeans)"
                 flag="warning"
                 id="UBL-CR-643">[UBL-CR-643]-A UBL invoice should not include the InvoiceLine Item Price AllowanceCharge PaymentMeans</assert>
         <assert test="not(cac:InvoiceLine/cac:Item/cac:Price/cac:PricingExchangeRate)"
                 flag="warning"
                 id="UBL-CR-644">[UBL-CR-644]-A UBL invoice should not include the InvoiceLine Item Price PricingExchangeRate</assert>
         <assert test="not(cac:InvoiceLine/cac:DeliveryTerms)"
                 flag="warning"
                 id="UBL-CR-645">[UBL-CR-645]-A UBL invoice should not include the InvoiceLine DeliveryTerms</assert>
         <assert test="not(cac:InvoiceLine/cac:SubInvoiceLine)"
                 flag="warning"
                 id="UBL-CR-646">[UBL-CR-646]-A UBL invoice should not include the InvoiceLine SubInvoiceLine</assert>
         <assert test="not(cac:InvoiceLine/cac:ItemPriceExtension)"
                 flag="warning"
                 id="UBL-CR-647">[UBL-CR-647]-A UBL invoice should not include the InvoiceLine ItemPriceExtension</assert>
         <assert test="not(//@schemeName)" flag="warning" id="UBL-DT-08">[UBL-DT-08]-Scheme name attribute should not be present</assert>
         <assert test="not(//@schemeAgencyName)" flag="warning" id="UBL-DT-09">[UBL-DT-09]-Scheme agency name attribute should not be present</assert>
         <assert test="not(//@schemeDataURI)" flag="warning" id="UBL-DT-10">[UBL-DT-10]-Scheme data uri attribute should not be present</assert>
         <assert test="not(//@schemeURI)" flag="warning" id="UBL-DT-11">[UBL-DT-11]-Scheme uri attribute should not be present</assert>
         <assert test="not(//@format)" flag="warning" id="UBL-DT-12">[UBL-DT-12]-Format attribute should not be present</assert>
         <assert test="not(//@unitCodeListIdentifier)" flag="warning" id="UBL-DT-13">[UBL-DT-13]-Unit code list identifier attribute should not be present</assert>
         <assert test="not(//@unitCodeListAgencyIdentifier)"
                 flag="warning"
                 id="UBL-DT-14">[UBL-DT-14]-Unit code list agency identifier attribute should not be present</assert>
         <assert test="not(//@unitCodeListAgencyName)" flag="warning" id="UBL-DT-15">[UBL-DT-15]-Unit code list agency name attribute should not be present</assert>
         <assert test="not(//@listAgencyName)" flag="warning" id="UBL-DT-16">[UBL-DT-16]-List agency name attribute should not be present</assert>
         <assert test="not(//@listName)" flag="warning" id="UBL-DT-17">[UBL-DT-17]-List name attribute should not be present</assert>
         <assert test="count(//@name) - count(//cbc:PaymentMeansCode/@name) &lt;= 0"
                 flag="warning"
                 id="UBL-DT-18">[UBL-DT-18]-Name attribute should not be present</assert>
         <assert test="not(//@languageID)" flag="warning" id="UBL-DT-19">[UBL-DT-19]-Language identifier attribute should not be present</assert>
         <assert test="not(//@listURI)" flag="warning" id="UBL-DT-20">[UBL-DT-20]-List uri attribute should not be present</assert>
         <assert test="not(//@listSchemeURI)" flag="warning" id="UBL-DT-21">[UBL-DT-21]-List scheme uri attribute should not be present</assert>
         <assert test="not(//@languageLocaleID)" flag="warning" id="UBL-DT-22">[UBL-DT-22]-Language local identifier attribute should not be present</assert>
         <assert test="not(//@uri)" flag="warning" id="UBL-DT-23">[UBL-DT-23]-Uri attribute should not be present</assert>
         <assert test="not(//@currencyCodeListVersionID)"
                 flag="warning"
                 id="UBL-DT-24">[UBL-DT-24]-Currency code list version id should not be present</assert>
         <assert test="not(//@characterSetCode)" flag="warning" id="UBL-DT-25">[UBL-DT-25]-CharacterSetCode attribute should not be present</assert>
         <assert test="not(//@encodingCode)" flag="warning" id="UBL-DT-26">[UBL-DT-26]-EncodingCode attribute should not be present</assert>
         <assert test="(count(cac:ContractDocumentReference/cbc:ID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-01">[UBL-SR-01]-Contract identifier shall occur maximum once.</assert>
         <assert test="(count(cac:ReceiptDocumentReference/cbc:ID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-02">[UBL-SR-02]-Receive advice identifier shall occur maximum once</assert>
         <assert test="(count(cac:DespatchDocumentReference/cbc:ID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-03">[UBL-SR-03]-Despatch advice identifier shall occur maximum once</assert>
         <assert test="(count(cac:AdditionalDocumentReference[cbc:DocumentTypeCode='130']/cbc:ID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-04">[UBL-SR-04]-Invoice object identifier shall occur maximum once</assert>
         <assert test="(count(cac:PaymentTerms/cbc:Note) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-05">[UBL-SR-05]-Payment terms shall occur maximum once</assert>
         <assert test="(count(cac:InvoiceDocumentReference) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-06">[UBL-SR-06]-Preceding invoice reference shall occur maximum once</assert>
         <assert test="(count(cac:InvoicePeriod) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-08">[UBL-SR-08]-Invoice period shall occur maximum once</assert>
         <assert test="(count(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-09">[UBL-SR-09]-Seller name shall occur maximum once</assert>
         <assert test="(count(cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-10">[UBL-SR-10]-Seller trader name shall occur maximum once</assert>
         <assert test="(count(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-11">[UBL-SR-11]-Seller legal registration identifier shall occur maximum once</assert>
         <assert test="(count(cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID='VAT']/cbc:CompanyID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-12">[UBL-SR-12]-Seller VAT identifier shall occur maximum once</assert>
         <assert test="(count(cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID!='VAT']/cbc:ID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-13">[UBL-SR-13]-Seller tax registration shall occur maximum once</assert>
         <assert test="(count(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyLegalForm) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-14">[UBL-SR-14]-Seller additional legal information shall occur maximum once</assert>
         <assert test="(count(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-15">[UBL-SR-15]-Buyer name shall occur maximum once</assert>
         <assert test="(count(cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-16">[UBL-SR-16]-Buyer identifier shall occur maximum once</assert>
         <assert test="(count(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-17">[UBL-SR-17]-Buyer legal registration identifier shall occur maximum once</assert>
         <assert test="(count(cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-18">[UBL-SR-18]-Buyer VAT identifier shall occur maximum once</assert>
         <assert test="(count(cac:Delivery) &lt;= 1)" flag="warning" id="UBL-SR-24">[UBL-SR-24]-Deliver to information shall occur maximum once</assert>
         <assert test="(count(cac:PayeeParty/cac:PartyIdentification/cbc:ID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-29">[UBL-SR-29]-Bank creditor reference shall occur maximum once</assert>
         <assert test="(count(cac:ProjectReference/cbc:ID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-39">[UBL-SR-39]-Project reference shall occur maximum once.</assert>
         <assert test="(count(cac:AccountingCustomerParty/cac:Party/cac:PartyName/cbc:Name) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-40">[UBL-SR-40]-Buyer trade name shall occur maximum once</assert>
      </rule>
      <rule context="cac:InvoiceLine">
         <assert test="(count(cbc:Note) &lt;= 1)" flag="warning" id="UBL-SR-34">[UBL-SR-34]-Invoice line note shall occur maximum once</assert>
         <assert test="(count(cac:OrderLineReference/cbc:LineID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-35">[UBL-SR-35]-Referenced purchase order line identifier shall occur maximum once</assert>
         <assert test="(count(cac:InvoicePeriod) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-36">[UBL-SR-36]-Invoice line period shall occur maximum once</assert>
         <assert test="(count(cac:Price/cac:AllowanceCharge/cbc:Amount) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-37">[UBL-SR-37]-Item price discount shall occur maximum once</assert>
         <assert test="(count(cac:Item/cac:ClassifiedTaxCategory/cbc:TaxExemptionReason) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-38">[UBL-SR-38]-Invoiced item VAT exemption reason text shall occur maximum once</assert>
      </rule>
      <rule context="cac:PayeeParty">
         <assert test="(count(cac:PartyName/cbc:Name) &lt;= 1) and ((cac:PartyName/cbc:Name) != (../cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName))"
                 flag="warning"
                 id="UBL-SR-19">[UBL-SR-19]-Payee name shall occur maximum once, if the Payee is different from the Seller</assert>
         <assert test="(count(cac:PartyIdentification/cbc:ID) &lt;= 1) and ((cac:PartyName/cbc:Name) != (../cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName))"
                 flag="warning"
                 id="UBL-SR-20">[UBL-SR-20]-Payee identifier shall occur maximum once, if the Payee is different from the Seller</assert>
         <assert test="(count(cac:PartyLegalEntity/cbc:CompanyID) &lt;= 1) and ((cac:PartyName/cbc:Name) != (../cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName))"
                 flag="warning"
                 id="UBL-SR-21">[UBL-SR-21]-Payee legal registration identifier shall occur maximum once, if the Payee is different from the Seller</assert>
      </rule>
      <rule context="cac:PaymentMeans">
         <assert test="(count(cbc:PaymentID) &lt;= 1)" flag="warning" id="UBL-SR-26">[UBL-SR-26]-Payment reference shall occur maximum once</assert>
         <assert test="(count(cbc:InstructionNote) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-27">[UBL-SR-27]-Payment means text shall occur maximum once</assert>
         <assert test="(count(cac:PaymentMandate/cbc:ID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-28">[UBL-SR-28]-Mandate reference identifier shall occur maximum once</assert>
      </rule>
      <rule context="cac:BillingReference">
         <assert test="(cac:InvoiceDocumentReference/cbc:ID)"
                 flag="warning"
                 id="UBL-SR-07">[UBL-SR-07]-If there is a preceding invoice reference, the preceding invoice number shall be present</assert>
      </rule>
      <rule context="cac:TaxRepresentativeParty">
         <assert test="(count(cac:Party/cac:PartyName/cbc:Name) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-22">[UBL-SR-22]-Seller tax representative name shall occur maximum once, if the Seller has a tax representative</assert>
         <assert test="(count(cac:Party/cac:PartyTaxScheme/cbc:CompanyID) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-23">[UBL-SR-23]-Seller tax representative VAT identifier shall occur maximum once, if the Seller has a tax representative</assert>
      </rule>
      <rule context="cac:TaxSubtotal">
         <assert test="(count(cac:TaxCategory/cbc:TaxExemptionReason) &lt;= 1)"
                 flag="warning"
                 id="UBL-SR-32">[UBL-SR-32]-VAT exemption reason text shall occur maximum once</assert>
      </rule>
   </pattern>
  
  
  <pattern id="Codesmodel">
      <rule context="cbc:InvoiceTypeCode | cbc:CreditNoteTypeCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' 80 81 82 83 84 130 202 203 204 211 261 262 295 296 308 325 326 380 381 383 384 385 386 387 388 389 390 393 394 395 396 420 456 457 458 527 532 575 623 633 751 780 935  ', concat(' ', normalize-space(.), ' '))))"
                 id="BR-CL-01"
                 flag="fatal">[BR-CL-01]-The document type code MUST be coded by the invoice and credit note related code lists of UNTDID 1001.</assert>
      </rule>
  
      <rule context="cbc:Amount | cbc:BaseAmount | cbc:PriceAmount | cbc:TaxAmount | cbc:TaxableAmount | cbc:LineExtensionAmount | cbc:TaxExclusiveAmount | cbc:TaxInclusiveAmount | cbc:AllowanceTotalAmount | cbc:ChargeTotalAmount | cbc:PrepaidAmount | cbc:PayableRoundingAmount | cbc:PayableAmount"
            flag="fatal">
         <assert test="((not(contains(normalize-space(@currencyID), ' ')) and contains(' AED AFN ALL AMD ANG AOA ARS AUD AWG AZN BAM BBD BDT BGN BHD BIF BMD BND BOB BOV BRL BSD BTN BWP BYR BZD CAD CDF CHE CHF CHW CLF CLP CNY COP COU CRC CUC CUP CVE CZK DJF DKK DOP DZD EGP ERN ETB EUR FJD FKP GBP GEL GHS GIP GMD GNF GTQ GYD HKD HNL HRK HTG HUF IDR ILS INR IQD IRR ISK JMD JOD JPY KES KGS KHR KMF KPW KRW KWD KYD KZT LAK LBP LKR LRD LSL LYD MAD MDL MGA MKD MMK MNT MOP MRO MUR MVR MWK MXN MXV MYR MZN NAD NGN NIO NOK NPR NZD OMR PAB PEN PGK PHP PKR PLN PYG QAR RON RSD RUB RWF SAR SBD SCR SDG SEK SGD SHP SLL SOS SRD SSP STD SVC SYP SZL THB TJS TMT TND TOP TRY TTD TWD TZS UAH UGX USD USN UYI UYU UZS VEF VND VUV WST XAF XAG XAU XBA XBB XBC XBD XCD XDR XOF XPD XPF XPT XSU XTS XUA XXX YER ZAR ZMW ZWL ', concat(' ', normalize-space(@currencyID), ' '))))"
                 id="BR-CL-03"
                 flag="fatal">[BR-CL-03]-currencyID MUST be coded using ISO code list 4217 alpha-3</assert>
      </rule>
  
      <rule context="cbc:DocumentCurrencyCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AED AFN ALL AMD ANG AOA ARS AUD AWG AZN BAM BBD BDT BGN BHD BIF BMD BND BOB BOV BRL BSD BTN BWP BYR BZD CAD CDF CHE CHF CHW CLF CLP CNY COP COU CRC CUC CUP CVE CZK DJF DKK DOP DZD EGP ERN ETB EUR FJD FKP GBP GEL GHS GIP GMD GNF GTQ GYD HKD HNL HRK HTG HUF IDR ILS INR IQD IRR ISK JMD JOD JPY KES KGS KHR KMF KPW KRW KWD KYD KZT LAK LBP LKR LRD LSL LYD MAD MDL MGA MKD MMK MNT MOP MRO MUR MVR MWK MXN MXV MYR MZN NAD NGN NIO NOK NPR NZD OMR PAB PEN PGK PHP PKR PLN PYG QAR RON RSD RUB RWF SAR SBD SCR SDG SEK SGD SHP SLL SOS SRD SSP STD SVC SYP SZL THB TJS TMT TND TOP TRY TTD TWD TZS UAH UGX USD USN UYI UYU UZS VEF VND VUV WST XAF XAG XAU XBA XBB XBC XBD XCD XDR XOF XPD XPF XPT XSU XTS XUA XXX YER ZAR ZMW ZWL ', concat(' ', normalize-space(.), ' '))))"
                 id="BR-CL-04"
                 flag="fatal">[BR-CL-04]-Invoice currency code MUST be coded using ISO code list 4217 alpha-3</assert>
      </rule>
      <rule context="cbc:TaxCurrencyCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AED AFN ALL AMD ANG AOA ARS AUD AWG AZN BAM BBD BDT BGN BHD BIF BMD BND BOB BOV BRL BSD BTN BWP BYR BZD CAD CDF CHE CHF CHW CLF CLP CNY COP COU CRC CUC CUP CVE CZK DJF DKK DOP DZD EGP ERN ETB EUR FJD FKP GBP GEL GHS GIP GMD GNF GTQ GYD HKD HNL HRK HTG HUF IDR ILS INR IQD IRR ISK JMD JOD JPY KES KGS KHR KMF KPW KRW KWD KYD KZT LAK LBP LKR LRD LSL LYD MAD MDL MGA MKD MMK MNT MOP MRO MUR MVR MWK MXN MXV MYR MZN NAD NGN NIO NOK NPR NZD OMR PAB PEN PGK PHP PKR PLN PYG QAR RON RSD RUB RWF SAR SBD SCR SDG SEK SGD SHP SLL SOS SRD SSP STD SVC SYP SZL THB TJS TMT TND TOP TRY TTD TWD TZS UAH UGX USD USN UYI UYU UZS VEF VND VUV WST XAF XAG XAU XBA XBB XBC XBD XCD XDR XOF XPD XPF XPT XSU XTS XUA XXX YER ZAR ZMW ZWL ', concat(' ', normalize-space(.), ' '))))"
                 id="BR-CL-05"
                 flag="fatal">[BR-CL-05]-Tax currency code MUST be coded using ISO code list 4217 alpha-3</assert>
      </rule>
 
      <rule context="cac:InvoicePeriod/cbc:DescriptionCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' 3 35 432 ', concat(' ', normalize-space(.), ' '))))"
                 id="BR-CL-06"
                 flag="fatal">[BR-CL-06]-Value added tax point date code MUST be coded using a restriction of
      UNTDID 2005iterm
      .</assert>
      </rule>
  
      <rule context="cac:AdditionalDocumentReference[cbc:DocumentTypeCode = '130']/cbc:ID[@schemeID] | cac:DocumentReference[cbc:DocumentTypeCode = '130']/cbc:ID[@schemeID]"
            flag="fatal">
         <assert test="((not(contains(normalize-space(@schemeID), ' ')) and contains(' AAA AAB AAC AAD AAE AAF AAG AAH AAI AAJ AAK AAL AAM AAN AAO AAP AAQ AAR AAS AAT AAU AAV AAW AAX AAY AAZ ABA ABB ABC ABD ABE ABF ABG ABH ABI ABJ ABK ABL ABM ABN ABO ABP ABQ ABR ABS ABT ABU ABV ABW ABX ABY ABZ AC ACA ACB ACC ACD ACE ACF ACG ACH ACI ACJ ACK ACL ACN ACO ACP ACQ ACR ACT ACU ACV ACW ACX ACY ACZ ADA ADB ADC ADD ADE ADF ADG ADI ADJ ADK ADL ADM ADN ADO ADP ADQ ADT ADU ADV ADW ADX ADY ADZ AE AEA AEB AEC AED AEE AEF AEG AEH AEI AEJ AEK AEL AEM AEN AEO AEP AEQ AER AES AET AEU AEV AEW AEX AEY AEZ AF AFA AFB AFC AFD AFE AFF AFG AFH AFI AFJ AFK AFL AFM AFN AFO AFP AFQ AFR AFS AFT AFU AFV AFW AFX AFY AFZ AGA AGB AGC AGD AGE AGF AGG AGH AGI AGJ AGK AGL AGM AGN AGO AGP AGQ AGR AGS AGT AGU AGV AGW AGX AGY AGZ AHA AHB AHC AHD AHE AHF AHG AHH AHI AHJ AHK AHL AHM AHN AHO AHP AHQ AHR AHS AHT AHU AHV AHX AHY AHZ AIA AIB AIC AID AIE AIF AIG AIH AII AIJ AIK AIL AIM AIN AIO AIP AIQ AIR AIS AIT AIU AIV AIW AIX AIY AIZ AJA AJB AJC AJD AJE AJF AJG AJH AJI AJJ AJK AJL AJM AJN AJO AJP AJQ AJR AJS AJT AJU AJV AJW AJX AJY AJZ AKA AKB AKC AKD AKE AKF AKG AKH AKI AKJ AKK AKL AKM AKN AKO AKP AKQ AKR AKS AKT AKU AKV AKW AKX AKY AKZ ALA ALB ALC ALD ALE ALF ALG ALH ALI ALJ ALK ALL ALM ALN ALO ALP ALQ ALR ALS ALT ALU ALV ALW ALX ALY ALZ AMA AMB AMC AMD AME AMF AMG AMH AMI AMJ AMK AML AMM AMN AMO AMP AMQ AMR AMS AMT AMU AMV AMW AMX AMY AMZ ANA ANB ANC AND ANE ANF ANG ANH ANI ANJ ANK ANL ANM ANN ANO ANP ANQ ANR ANS ANT ANU ANV ANW ANX ANY AOA AOD AOE AOF AOG AOH AOI AOJ AOK AOL AOM AON AOO AOP AOQ AOR AOS AOT AOU AOV AOW AOX AOY AOZ AP APA APB APC APD APE APF APG APH API APJ APK APL APM APN APO APP APQ APR APS APT APU APV APW APX APY APZ AQA AQB AQC AQD AQE AQF AQG AQH AQI AQJ AQK AQL AQM AQN AQO AQP AQQ AQR AQS AQT AQU AQV AQW AQX AQY AQZ ARA ARB ARC ARD ARE ARF ARG ARH ARI ARJ ARK ARL ARM ARN ARO ARP ARQ ARR ARS ART ARU ARV ARW ARX ARY ARZ ASA ASB ASC ASD ASE ASF ASG ASH ASI ASJ ASK ASL ASM ASN ASO ASP ASQ ASR ASS AST ASU ASV ASW ASX ASY ASZ ATA ATB ATC ATD ATE ATF ATG ATH ATI ATJ ATK ATL ATM ATN ATO ATP ATQ ATR ATS ATT ATU ATV ATW ATX ATY ATZ AU AUA AUB AUC AUD AUE AUF AUG AUH AUI AUJ AUK AUL AUM AUN AUO AUP AUQ AUR AUS AUT AUU AUV AUW AUX AUY AUZ AV AVA AVB AVC AVD AVE AVF AVG AVH AVI AVJ AVK AVL AVM AVN AVO AVP AVQ AVR AVS AVT AVU AVV AVW AVX AVY AVZ AWA AWB AWC AWD AWE AWF AWG AWH AWI AWJ AWK AWL AWM AWN AWO AWP AWQ AWR AWS AWT AWU AWV AWW AWX AWY AWZ AXA AXB AXC AXD AXE AXF AXG AXH AXI AXJ AXK AXL AXM AXN AXO AXP AXQ AXR BA BC BD BE BH BM BN BO BR BT BW CAS CAT CAU CAV CAW CAX CAY CAZ CBA CBB CD CEC CED CFE CFF CFO CG CH CK CKN CM CMR CN CNO COF CP CR CRN CS CST CT CU CV CW CZ DA DAN DB DI DL DM DQ DR EA EB ED EE EI EN EQ ER ERN ET EX FC FF FI FLW FN FO FS FT FV FX GA GC GD GDN GN HS HWB IA IB ICA ICE ICO II IL INB INN INO IP IS IT IV JB JE LA LAN LAR LB LC LI LO LRC LS MA MB MF MG MH MR MRN MS MSS MWB NA NF OH OI ON OP OR PB PC PD PE PF PI PK PL POR PP PQ PR PS PW PY RA RC RCN RE REN RF RR RT SA SB SD SE SEA SF SH SI SM SN SP SQ SRN SS STA SW SZ TB TCR TE TF TI TIN TL TN TP UAR UC UCN UN UO URI VA VC VGR VM VN VON VOR VP VR VS VT VV WE WM WN WR WS WY XA XC XP ZZZ ', concat(' ', normalize-space(@schemeID), ' '))))"
                 id="BR-CL-07"
                 flag="fatal">[BR-CL-07]-Object identifier identification scheme identifier MUST be coded using a restriction of UNTDID 1153.</assert>
      </rule>

<!-- 2018-11-13 - Added newest ICD values manually -->
      <rule context="cac:PartyIdentification/cbc:ID[@schemeID]" flag="fatal">
         <assert test="((not(contains(normalize-space(@schemeID), ' ')) and contains(' 0001 0002 0003 0004 0005 0006 0007 0008 0009 0010 0011 0012 0013 0014 0015 0016 0017 0018 0019 0020 0021 0022 0023 0024 0025 0026 0027 0028 0029 0030 0031 0032 0033 0034 0035 0036 0037 0038 0039 0040 0041 0042 0043 0044 0045 0046 0047 0048 0049 0050 0051 0052 0053 0054 0055 0056 0057 0058 0059 0060 0061 0062 0063 0064 0065 0066 0067 0068 0069 0070 0071 0072 0073 0074 0075 0076 0077 0078 0079 0080 0081 0082 0083 0084 0085 0086 0087 0088 0089 0090 0091 0092 0093 0094 0095 0096 0097 0098 0099 0100 0101 0102 0103 0104 0105 0106 0107 0108 0109 0110 0111 0112 0113 0114 0115 0116 0117 0118 0119 0120 0121 0122 0123 0124 0125 0126 0127 0128 0129 0130 0131 0132 0133 0134 0135 0136 0137 0138 0139 0140 0141 0142 0143 0144 0145 0146 0147 0148 0149 0150 0151 0152 0153 0154 0155 0156 0157 0158 0159 0160 0161 0162 0163 0164 0165 0166 0167 0168 0169 0170 0171 0172 0173 0174 0175 0176 0177 0178 0179 0180 0183 0184 0185 0186 0187 0188 0189 0190 0191 0192 0193 0194 0195 0196', concat(' ', normalize-space(@schemeID), ' '))))  or ((not(contains(normalize-space(@schemeID), ' ')) and contains(' SEPA ', concat(' ', normalize-space(@schemeID), ' '))) and ((ancestor::cac:AccountingSupplierParty) or (ancestor::cac:PayeeParty)))"
                 id="BR-CL-10"
                 flag="fatal">[BR-CL-10]-Any identifier identification scheme identifier MUST be coded using one of the ISO 6523 ICD list.</assert>
      </rule>
          <!-- 2018-11-13 - Added newest ICD values manually -->
      <rule context="cac:PartyLegalEntity/cbc:CompanyID[@schemeID]" flag="fatal">
              <assert test="((not(contains(normalize-space(@schemeID), ' ')) and contains(' 0001 0002 0003 0004 0005 0006 0007 0008 0009 0010 0011 0012 0013 0014 0015 0016 0017 0018 0019 0020 0021 0022 0023 0024 0025 0026 0027 0028 0029 0030 0031 0032 0033 0034 0035 0036 0037 0038 0039 0040 0041 0042 0043 0044 0045 0046 0047 0048 0049 0050 0051 0052 0053 0054 0055 0056 0057 0058 0059 0060 0061 0062 0063 0064 0065 0066 0067 0068 0069 0070 0071 0072 0073 0074 0075 0076 0077 0078 0079 0080 0081 0082 0083 0084 0085 0086 0087 0088 0089 0090 0091 0092 0093 0094 0095 0096 0097 0098 0099 0100 0101 0102 0103 0104 0105 0106 0107 0108 0109 0110 0111 0112 0113 0114 0115 0116 0117 0118 0119 0120 0121 0122 0123 0124 0125 0126 0127 0128 0129 0130 0131 0132 0133 0134 0135 0136 0137 0138 0139 0140 0141 0142 0143 0144 0145 0146 0147 0148 0149 0150 0151 0152 0153 0154 0155 0156 0157 0158 0159 0160 0161 0162 0163 0164 0165 0166 0167 0168 0169 0170 0171 0172 0173 0174 0175 0176 0177 0178 0179 0180 0183 0184 0185 0186 0187 0188 0189 0190 0191 0192 0193 0194 0195 0196', concat(' ', normalize-space(@schemeID), ' '))))"
                 id="BR-CL-11"
                 flag="fatal">[BR-CL-11]-Any registration identifier identification scheme identifier MUST be coded using one of the ISO 6523 ICD list.</assert>
      </rule>
  
      <rule context="cac:CommodityClassification/cbc:ItemClassificationCode[@listID]"
            flag="fatal">
         <assert test="((not(contains(normalize-space(@listID), ' ')) and contains(' AA AB AC AD AE AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW AX AY AZ BA BB BC BD BE BF BG BH BI BJ BK BL BM BN BO BP BQ BR BS BT BU BV BW BX BY BZ CC CG CL CR CV DR DW EC EF EN FS GB GN GS HS IB IN IS IT IZ MA MF MN MP NB ON PD PL PO PV QS RC RN RU RY SA SG SK SN SRS SRT SRU SRV SRW SRX SRY SRZ SS SSA SSB SSC SSD SSE SSF SSG SSH SSI SSJ SSK SSL SSM SSN SSO SSP SSQ SSR SSS SST SSU SSV SSW SSX SSY SSZ ST STA STB STC STD STE STF STG STH STI STJ STK STL STM STN STO STP STQ STR STS STT STU STV STW STX STY STZ SUA SUB SUC SUD SUE SUF SUG SUH SUI SUJ SUK SUL SUM TG TSN TSO TSP UA UP VN VP VS VX ZZZ ', concat(' ', normalize-space(@listID), ' '))))"
                 id="BR-CL-13"
                 flag="fatal">[BR-CL-13]-Item classification identifier identification scheme identifier MUST be
      coded using one of the UNTDID 7143 list.</assert>
      </rule>
  
  
      <rule context="cac:Country/cbc:IdentificationCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AD AE AF AG AI AL AM AN AO AQ AR AS AT AU AW AX AZ BA BB BD BE BF BG BH BI BL BJ BM BN BO BR BS BT BV BW BY BZ CA CC CD CF CG CH CI CK CL CM CN CO CR CU CV CX CY CZ DE DJ DK DM DO DZ EC EE EG EH ER ES ET FI FJ FK FM FO FR GA GB GD GE GF GG GH GI GL GM GN GP GQ GR GS GT GU GW GY HK HM HN HR HT HU ID IE IL IM IN IO IQ IR IS IT JE JM JO JP KE KG KH KI KM KN KP KR KW KY KZ LA LB LC LI LK LR LS LT LU LV LY MA MC MD ME MF MG MH MK ML MM MN MO MP MQ MR MS MT MU MV MW MX MY MZ NA NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM PN PR PS PT PW PY QA RO RS RU RW SA SB SC SD SE SG SH SI SJ SK SL SM SN SO SR ST SV SY SZ TC TD TF TG TH TJ TK TL TM TN TO TR TT TV TW TZ UA UG UM US UY UZ VA VC VE VG VI VN VU WF WS YE YT ZA ZM ZW ', concat(' ', normalize-space(.), ' '))))"
                 id="BR-CL-14"
                 flag="fatal">[BR-CL-14]-Country codes in an invoice MUST be coded using ISO code list 3166-1</assert>
      </rule>

      <rule context="cac:OriginCountry/cbc:IdentificationCode" flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AD AE AF AG AI AL AM AN AO AQ AR AS AT AU AW AX AZ BA BB BD BE BF BG BH BI BL BJ BM BN BO BR BS BT BV BW BY BZ CA CC CD CF CG CH CI CK CL CM CN CO CR CU CV CX CY CZ DE DJ DK DM DO DZ EC EE EG EH ER ES ET FI FJ FK FM FO FR GA GB GD GE GF GG GH GI GL GM GN GP GQ GR GS GT GU GW GY HK HM HN HR HT HU ID IE IL IM IN IO IQ IR IS IT JE JM JO JP KE KG KH KI KM KN KP KR KW KY KZ LA LB LC LI LK LR LS LT LU LV LY MA MC MD ME MF MG MH MK ML MM MN MO MP MQ MR MS MT MU MV MW MX MY MZ NA NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM PN PR PS PT PW PY QA RO RS RU RW SA SB SC SD SE SG SH SI SJ SK SL SM SN SO SR ST SV SY SZ TC TD TF TG TH TJ TK TL TM TN TO TR TT TV TW TZ UA UG UM US UY UZ VA VC VE VG VI VN VU WF WS YE YT ZA ZM ZW ', concat(' ', normalize-space(.), ' '))))"
                 id="BR-CL-15"
                 flag="fatal">[BR-CL-15]-Country codes in an invoice MUST be coded using ISO code list 3166-1</assert>
      </rule>
  
      <rule context="cac:PaymentMeans/cbc:PaymentMeansCode" flag="fatal">
         <assert test="( ( not(contains(normalize-space(.),' ')) and contains( ' 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 70 74 75 76 77 78 91 92 93 94 95 96 97 ZZZ ',concat(' ',normalize-space(.),' ') ) ) )"
                 id="BR-CL-16"
                 flag="fatal">[BR-CL-16]-Payment means in an invoice MUST be coded using UNCL4461 code list</assert>
      </rule>
  
      <rule context="cac:TaxCategory/cbc:ID" flag="fatal">
         <assert test="( ( not(contains(normalize-space(.),' ')) and contains( ' AE L M E S Z G O K ',concat(' ',normalize-space(.),' ') ) ) )"
                 id="BR-CL-17"
                 flag="fatal">[BR-CL-17]-Invoice tax categories MUST be coded using UNCL5305 code list</assert>
      </rule>
  
      <rule context="cac:ClassifiedTaxCategory/cbc:ID" flag="fatal">
         <assert test="( ( not(contains(normalize-space(.),' ')) and contains( ' AE L M E S Z G O K ',concat(' ',normalize-space(.),' ') ) ) )"
                 id="BR-CL-18"
                 flag="fatal">[BR-CL-18]-Invoice tax categories MUST be coded using UNCL5305 code list</assert>
      </rule>
  
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator = 'false']/cbc:AllowanceChargeReasonCode"
            flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 ZZZ ', concat(' ', normalize-space(.), ' '))))"
                 id="BR-CL-19"
                 flag="fatal">[BR-CL-19]-Coded allowance reasons MUST belong to the UNCL 5189 code list</assert>
      </rule>
  
      <rule context="cac:AllowanceCharge[cbc:ChargeIndicator = 'true']/cbc:AllowanceChargeReasonCode"
            flag="fatal">
         <assert test="((not(contains(normalize-space(.), ' ')) and contains(' AA AAA AAC AAD AAE AAF AAH AAI AAS AAT AAV AAY AAZ ABA ABB ABC ABD ABF ABK ABL ABN ABR ABS ABT ABU ACF ACG ACH ACI ACJ ACK ACL ACM ACS ADC ADE ADJ ADK ADL ADM ADN ADO ADP ADQ ADR ADT ADW ADY ADZ AEA AEB AEC AED AEF AEH AEI AEJ AEK AEL AEM AEN AEO AEP AES AET AEU AEV AEW AEX AEY AEZ AJ AU CA CAB CAD CAE CAF CAI CAJ CAK CAL CAM CAN CAO CAP CAQ CAR CAS CAT CAU CAV CAW CD CG CS CT DAB DAD DL EG EP ER FAA FAB FAC FC FH FI GAA HAA HD HH IAA IAB ID IF IR IS KO L1 LA LAA LAB LF MAE MI ML NAA OA PA PAA PC PL RAB RAC RAD RAF RE RF RH RV SA SAA SAD SAE SAI SG SH SM SU TAB TAC TT TV V1 V2 WH XAA YY ZZZ ', concat(' ', normalize-space(.), ' '))))"
                 id="BR-CL-20"
                 flag="fatal">[BR-CL-20]-Coded charge reasons MUST belong to the UNCL 7161 code list</assert>
      </rule>
          <!-- 2018-11-13 - Added newest ICD values manually -->
      <rule context="cac:StandardItemIdentification/cbc:ID[@schemeID]" flag="fatal">
              <assert test="((not(contains(normalize-space(@schemeID), ' ')) and contains(' 0001 0002 0003 0004 0005 0006 0007 0008 0009 0010 0011 0012 0013 0014 0015 0016 0017 0018 0019 0020 0021 0022 0023 0024 0025 0026 0027 0028 0029 0030 0031 0032 0033 0034 0035 0036 0037 0038 0039 0040 0041 0042 0043 0044 0045 0046 0047 0048 0049 0050 0051 0052 0053 0054 0055 0056 0057 0058 0059 0060 0061 0062 0063 0064 0065 0066 0067 0068 0069 0070 0071 0072 0073 0074 0075 0076 0077 0078 0079 0080 0081 0082 0083 0084 0085 0086 0087 0088 0089 0090 0091 0092 0093 0094 0095 0096 0097 0098 0099 0100 0101 0102 0103 0104 0105 0106 0107 0108 0109 0110 0111 0112 0113 0114 0115 0116 0117 0118 0119 0120 0121 0122 0123 0124 0125 0126 0127 0128 0129 0130 0131 0132 0133 0134 0135 0136 0137 0138 0139 0140 0141 0142 0143 0144 0145 0146 0147 0148 0149 0150 0151 0152 0153 0154 0155 0156 0157 0158 0159 0160 0161 0162 0163 0164 0165 0166 0167 0168 0169 0170 0171 0172 0173 0174 0175 0176 0177 0178 0179 0180 0183 0184 0185 0186 0187 0188 0189 0190 0191 0192 0193 0194 0195 0196', concat(' ', normalize-space(@schemeID), ' '))))"
                 id="BR-CL-21"
                 flag="fatal">[BR-CL-21]-Item standard identifier scheme identifier MUST belong to the ISO 6523 ICD code list</assert>
      </rule>
  
      <rule context="cbc:InvoicedQuantity[@unitCode] | cbc:BaseQuantity[@unitCode]"
            flag="fatal">
         <assert test="((not(contains(normalize-space(@unitCode), ' ')) and contains(' 10 11 13 14 15 20 21 22 23 24 25 27 28 33 34 35 37 38 40 41 56 57 58 59 60 61 64 66 74 76 77 78 80 81 84 85 87 89 91 1I 2A 2B 2C 2G 2H 2I 2J 2K 2L 2M 2N 2P 2Q 2R 2U 2X 2Y 2Z 3B 3C 4C 4G 4H 4K 4L 4M 4N 4O 4P 4Q 4R 4T 4U 4W 4X 5A 5B 5E 5J A1 A10 A11 A12 A13 A14 A15 A16 A17 A18 A19 A2 A20 A21 A22 A23 A24 A25 A26 A27 A28 A29 A3 A30 A31 A32 A33 A34 A35 A36 A37 A38 A39 A4 A40 A41 A42 A43 A44 A45 A47 A48 A49 A5 A50 A51 A52 A53 A54 A55 A56 A57 A58 A59 A6 A60 A61 A62 A63 A64 A65 A66 A67 A68 A69 A7 A70 A71 A73 A74 A75 A76 A77 A78 A79 A8 A80 A81 A82 A83 A84 A85 A86 A87 A88 A89 A9 A90 A91 A93 A94 A95 A96 A97 A98 A99 AA AB ACR ACT AD AE AH AI AK AL AMH AMP ANN APZ AQ ARE AS ASM ASU ATM ATT AY AZ B1 B10 B11 B12 B13 B14 B15 B16 B17 B18 B19 B20 B21 B22 B23 B24 B25 B26 B27 B28 B29 B3 B30 B31 B32 B33 B34 B35 B36 B37 B38 B39 B4 B40 B41 B42 B43 B44 B45 B46 B47 B48 B49 B50 B51 B52 B53 B54 B55 B56 B57 B58 B59 B60 B61 B62 B63 B64 B65 B66 B67 B68 B69 B7 B70 B71 B72 B73 B74 B75 B76 B77 B78 B79 B8 B80 B81 B82 B83 B84 B85 B86 B87 B88 B89 B90 B91 B92 B93 B94 B95 B96 B97 B98 B99 BAR BB BFT BHP BIL BLD BLL BP BQL BTU BUA BUI C0 C10 C11 C12 C13 C14 C15 C16 C17 C18 C19 C20 C21 C22 C23 C24 C25 C26 C27 C28 C29 C3 C30 C31 C32 C33 C34 C35 C36 C37 C38 C39 C40 C41 C42 C43 C44 C45 C46 C47 C48 C49 C50 C51 C52 C53 C54 C55 C56 C57 C58 C59 C60 C61 C62 C63 C64 C65 C66 C67 C68 C69 C7 C70 C71 C72 C73 C74 C75 C76 C78 C79 C8 C80 C81 C82 C83 C84 C85 C86 C87 C88 C89 C9 C90 C91 C92 C93 C94 C95 C96 C97 C99 CCT CDL CEL CEN CG CGM CKG CLF CLT CMK CMQ CMT CNP CNT COU CTG CTM CTN CUR CWA CWI D03 D04 D1 D10 D11 D12 D13 D15 D16 D17 D18 D19 D2 D20 D21 D22 D23 D24 D25 D26 D27 D29 D30 D31 D32 D33 D34 D35 D36 D37 D38 D39 D41 D42 D43 D44 D45 D46 D47 D48 D49 D5 D50 D51 D52 D53 D54 D55 D56 D57 D58 D59 D6 D60 D61 D62 D63 D65 D68 D69 D70 D71 D72 D73 D74 D75 D76 D77 D78 D80 D81 D82 D83 D85 D86 D87 D88 D89 D9 D91 D93 D94 D95 DAA DAD DAY DB DD DEC DG DJ DLT DMA DMK DMO DMQ DMT DN DPC DPR DPT DRA DRI DRL DT DTN DU DWT DX DZN DZP E01 E07 E08 E09 E10 E11 E12 E14 E15 E16 E17 E18 E19 E20 E21 E22 E23 E25 E27 E28 E30 E31 E32 E33 E34 E35 E36 E37 E38 E39 E4 E40 E41 E42 E43 E44 E45 E46 E47 E48 E49 E50 E51 E52 E53 E54 E55 E56 E57 E58 E59 E60 E61 E62 E63 E64 E65 E66 E67 E68 E69 E70 E71 E72 E73 E74 E75 E76 E77 E78 E79 E80 E81 E82 E83 E84 E85 E86 E87 E88 E89 E90 E91 E92 E93 E94 E95 E96 E97 E98 E99 EA EB EQ F01 F02 F03 F04 F05 F06 F07 F08 F10 F11 F12 F13 F14 F15 F16 F17 F18 F19 F20 F21 F22 F23 F24 F25 F26 F27 F28 F29 F30 F31 F32 F33 F34 F35 F36 F37 F38 F39 F40 F41 F42 F43 F44 F45 F46 F47 F48 F49 F50 F51 F52 F53 F54 F55 F56 F57 F58 F59 F60 F61 F62 F63 F64 F65 F66 F67 F68 F69 F70 F71 F72 F73 F74 F75 F76 F77 F78 F79 F80 F81 F82 F83 F84 F85 F86 F87 F88 F89 F90 F91 F92 F93 F94 F95 F96 F97 F98 F99 FAH FAR FBM FC FF FH FIT FL FOT FP FR FS FTK FTQ G01 G04 G05 G06 G08 G09 G10 G11 G12 G13 G14 G15 G16 G17 G18 G19 G2 G20 G21 G23 G24 G25 G26 G27 G28 G29 G3 G30 G31 G32 G33 G34 G35 G36 G37 G38 G39 G40 G41 G42 G43 G44 G45 G46 G47 G48 G49 G50 G51 G52 G53 G54 G55 G56 G57 G58 G59 G60 G61 G62 G63 G64 G65 G66 G67 G68 G69 G70 G71 G72 G73 G74 G75 G76 G77 G78 G79 G80 G81 G82 G83 G84 G85 G86 G87 G88 G89 G90 G91 G92 G93 G94 G95 G96 G97 G98 G99 GB GBQ GDW GE GF GFI GGR GIA GIC GII GIP GJ GL GLD GLI GLL GM GO GP GQ GRM GRN GRO GRT GT GV GWH H03 H04 H05 H06 H07 H08 H09 H10 H11 H12 H13 H14 H15 H16 H18 H19 H20 H21 H22 H23 H24 H25 H26 H27 H28 H29 H30 H31 H32 H33 H34 H35 H36 H37 H38 H39 H40 H41 H42 H43 H44 H45 H46 H47 H48 H49 H50 H51 H52 H53 H54 H55 H56 H57 H58 H59 H60 H61 H62 H63 H64 H65 H66 H67 H68 H69 H70 H71 H72 H73 H74 H75 H76 H77 H78 H79 H80 H81 H82 H83 H84 H85 H87 H88 H89 H90 H91 H92 H93 H94 H95 H96 H98 H99 HA HAR HBA HBX HC HDW HEA HGM HH HIU HJ HKM HLT HM HMQ HMT HN HP HPA HTZ HUR IA IE INH INK INQ ISD IU IV J10 J12 J13 J14 J15 J16 J17 J18 J19 J2 J20 J21 J22 J23 J24 J25 J26 J27 J28 J29 J30 J31 J32 J33 J34 J35 J36 J38 J39 J40 J41 J42 J43 J44 J45 J46 J47 J48 J49 J50 J51 J52 J53 J54 J55 J56 J57 J58 J59 J60 J61 J62 J63 J64 J65 J66 J67 J68 J69 J70 J71 J72 J73 J74 J75 J76 J78 J79 J81 J82 J83 J84 J85 J87 J89 J90 J91 J92 J93 J94 J95 J96 J97 J98 J99 JE JK JM JNT JOU JPS JWL K1 K10 K11 K12 K13 K14 K15 K16 K17 K18 K19 K2 K20 K21 K22 K23 K24 K25 K26 K27 K28 K3 K30 K31 K32 K33 K34 K35 K36 K37 K38 K39 K40 K41 K42 K43 K45 K46 K47 K48 K49 K5 K50 K51 K52 K53 K54 K55 K58 K59 K6 K60 K61 K62 K63 K64 K65 K66 K67 K68 K69 K70 K71 K73 K74 K75 K76 K77 K78 K79 K80 K81 K82 K83 K84 K85 K86 K87 K88 K89 K90 K91 K92 K93 K94 K95 K96 K97 K98 K99 KA KAT KB KBA KCC KDW KEL KGM KGS KHY KHZ KI KIC KIP KJ KJO KL KLK KLX KMA KMH KMK KMQ KMT KNI KNS KNT KO KPA KPH KPO KPP KR KSD KSH KT KTN KUR KVA KVR KVT KW KWH KWO KWT KX L10 L11 L12 L13 L14 L15 L16 L17 L18 L19 L2 L20 L21 L23 L24 L25 L26 L27 L28 L29 L30 L31 L32 L33 L34 L35 L36 L37 L38 L39 L40 L41 L42 L43 L44 L45 L46 L47 L48 L49 L50 L51 L52 L53 L54 L55 L56 L57 L58 L59 L60 L63 L64 L65 L66 L67 L68 L69 L70 L71 L72 L73 L74 L75 L76 L77 L78 L79 L80 L81 L82 L83 L84 L85 L86 L87 L88 L89 L90 L91 L92 L93 L94 L95 L96 L98 L99 LA LAC LBR LBT LD LEF LF LH LK LM LN LO LP LPA LR LS LTN LTR LUB LUM LUX LY M1 M10 M11 M12 M13 M14 M15 M16 M17 M18 M19 M20 M21 M22 M23 M24 M25 M26 M27 M29 M30 M31 M32 M33 M34 M35 M36 M37 M38 M39 M4 M40 M41 M42 M43 M44 M45 M46 M47 M48 M49 M5 M50 M51 M52 M53 M55 M56 M57 M58 M59 M60 M61 M62 M63 M64 M65 M66 M67 M68 M69 M7 M70 M71 M72 M73 M74 M75 M76 M77 M78 M79 M80 M81 M82 M83 M84 M85 M86 M87 M88 M89 M9 M90 M91 M92 M93 M94 M95 M96 M97 M98 M99 MAH MAL MAM MAR MAW MBE MBF MBR MC MCU MD MGM MHZ MIK MIL MIN MIO MIU MLD MLT MMK MMQ MMT MND MON MPA MQH MQS MSK MTK MTQ MTR MTS MVA MWH N1 N10 N11 N12 N13 N14 N15 N16 N17 N18 N19 N20 N21 N22 N23 N24 N25 N26 N27 N28 N29 N3 N30 N31 N32 N33 N34 N35 N36 N37 N38 N39 N40 N41 N42 N43 N44 N45 N46 N47 N48 N49 N50 N51 N52 N53 N54 N55 N56 N57 N58 N59 N60 N61 N62 N63 N64 N65 N66 N67 N68 N69 N70 N71 N72 N73 N74 N75 N76 N77 N78 N79 N80 N81 N82 N83 N84 N85 N86 N87 N88 N89 N90 N91 N92 N93 N94 N95 N96 N97 N98 N99 NA NAR NCL NEW NF NIL NIU NL NMI NMP NPR NPT NQ NR NT NTT NU NX OA ODE OHM ON ONZ OT OZ OZA OZI P1 P10 P11 P12 P13 P14 P15 P16 P17 P18 P19 P2 P20 P21 P22 P23 P24 P25 P26 P27 P28 P29 P30 P31 P32 P33 P34 P35 P36 P37 P38 P39 P40 P41 P42 P43 P44 P45 P46 P47 P48 P49 P5 P50 P51 P52 P53 P54 P55 P56 P57 P58 P59 P60 P61 P62 P63 P64 P65 P66 P67 P68 P69 P70 P71 P72 P73 P74 P75 P76 P77 P78 P79 P80 P81 P82 P83 P84 P85 P86 P87 P88 P89 P90 P91 P92 P93 P94 P95 P96 P97 P98 P99 PAL PD PFL PGL PI PLA PO PQ PR PS PT PTD PTI PTL Q10 Q11 Q12 Q13 Q14 Q15 Q16 Q17 Q18 Q19 Q20 Q21 Q22 Q23 Q24 Q25 Q26 Q27 Q28 Q3 QA QAN QB QR QT QTD QTI QTL QTR R1 R9 RH RM ROM RP RPM RPS RT S3 S4 SAN SCO SCR SEC SET SG SHT SIE SMI SQ SQR SR STC STI STK STL STN STW SW SX SYR T0 T3 TAH TAN TI TIC TIP TKM TMS TNE TP TPR TQD TRL TST TTS U1 U2 UA UB UC VA VLT VP W2 WA WB WCD WE WEB WEE WG WHR WM WSD WTT WW X1 YDK YDQ YRD Z11 ZP ZZ X43 X44 X1A X1B X1D X1F X1G X1W X2C X3A X3H X4A X4B X4C X4D X4F X4G X4H X5H X5L X5M X6H X6P X7A X7B X8A X8B X8C XAA XAB XAC XAD XAE XAF XAG XAH XAI XAJ XAL XAM XAP XAT XAV XB4 XBA XBB XBC XBD XBE XBF XBG XBH XBI XBJ XBK XBL XBM XBN XBO XBP XBQ XBR XBS XBT XBU XBV XBW XBX XBY XBZ XCA XCB XCC XCD XCE XCF XCG XCH XCI XCJ XCK XCL XCM XCN XCO XCP XCQ XCR XCS XCT XCU XCV XCW XCX XCY XCZ XDA XDB XDC XDG XDH XDI XDJ XDK XDL XDM XDN XDP XDR XDS XDT XDU XDV XDW XDX XDY XEC XED XEE XEF XEG XEH XEI XEN XFB XFC XFD XFE XFI XFL XFO XFP XFR XFT XFW XFX XGB XGI XGL XGR XGU XGY XGZ XHA XHB XHC XHG XHN XHR XIA XIB XIC XID XIE XIF XIG XIH XIK XIL XIN XIZ XJB XJC XJG XJR XJT XJY XKG XKI XLE XLG XLT XLU XLV XLZ XMA XMB XMC XME XMR XMS XMT XMW XMX XNA XNE XNF XNG XNS XNT XNU XNV XOA XOB XOC XOD XOE XOF XOK XOT XOU XP2 XPA XPB XPC XPD XPE XPF XPG XPH XPI XPJ XPK XPL XPN XPO XPP XPR XPT XPU XPV XPX XPY XPZ XQA XQB XQC XQD XQF XQG XQH XQJ XQK XQL XQM XQN XQP XQQ XQR XQS XRD XRG XRJ XRK XRL XRO XRT XRZ XSA XSB XSC XSD XSE XSH XSI XSK XSL XSM XSO XSP XSS XST XSU XSV XSW XSY XSZ XT1 XTB XTC XTD XTE XTG XTI XTK XTL XTN XTO XTR XTS XTT XTU XTV XTW XTY XTZ XUC XUN XVA XVG XVI XVK XVL XVN XVO XVP XVQ XVR XVS XVY XWA XWB XWC XWD XWF XWG XWH XWJ XWK XWL XWM XWN XWP XWQ XWR XWS XWT XWU XWV XWW XWX XWY XWZ XXA XXB XXC XXD XXF XXG XXH XXJ XXK XYA XYB XYC XYD XYF XYG XYH XYJ XYK XYL XYM XYN XYP XYQ XYR XYS XYT XYV XYW XYX XYY XYZ XZA XZB XZC XZD XZF XZG XZH XZJ XZK XZL XZM XZN XZP XZQ XZR XZS XZT XZU XZV XZW XZX XZY XZZ ', concat(' ', normalize-space(@unitCode), ' '))))"
                 id="BR-CL-23"
                 flag="fatal">[BR-CL-23]-Unit code MUST be coded according to the UN/ECE Recommendation 20 with
      Rec 21 extension</assert>
      </rule>
  
      <rule context="cbc:EmbeddedDocumentBinaryObject[@mimeCode]" flag="fatal">
         <assert test="((@mimeCode = 'application/pdf' or @mimeCode = 'image/png' or @mimeCode = 'image/jpeg' or @mimeCode = 'text/csv' or @mimeCode = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' or @mimeCode = 'application/vnd.oasis.opendocument.spreadsheet'))"
                 id="BR-CL-24"
                 flag="fatal">[BR-CL-24]-For Mime code in attribute use MIMEMediaType.</assert>
      </rule>
  
   </pattern>
</schema>
