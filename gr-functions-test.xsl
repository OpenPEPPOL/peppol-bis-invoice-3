<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
    xmlns:i="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
      
    <xsl:template match="/">
        <xsl:value-of select="count(tokenize(/i:Invoice/cbc:ID,'\|'))"/>
    </xsl:template>
    
   
</xsl:stylesheet>