<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
    xmlns:i="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
    xmlns:math="http://exslt.org/math"
    extension-element-prefixes="math"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
    
    <xsl:function name="i:TinVerification" as="xs:boolean">
        <xsl:param name="val" as="xs:string?"/>
        <xsl:variable name="digits" select="i:chars($val)"/>
        <xsl:variable name="checksum" select="
            (number($digits[8])*2) + 
            (number($digits[7])*4) + 
            (number($digits[6])*8) +
            (number($digits[5])*16) +
            (number($digits[4])*32) +
            (number($digits[3])*64) + 
            (number($digits[2])*128) +
            (number($digits[1])*256) "/>
        <xsl:value-of select="($checksum  mod 11) mod 10 = number($digits[9])"/>
    </xsl:function>
    
    <xsl:function name="i:chars" as="xs:string*">
        <xsl:param name="arg" as="xs:string?"/>
        
        <xsl:sequence select="
            for $ch in string-to-codepoints($arg)
            return codepoints-to-string($ch)
            "/>        
    </xsl:function>
    

    <xsl:template match="/">
        <xsl:value-of select="i:TinVerification('061828591')"/>
    </xsl:template>
    
</xsl:stylesheet>