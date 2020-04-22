<xsl:stylesheet version="3.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples">
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:body//tei:p[not(ancestor::tei:note)]">
        <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n">
                <xsl:value-of select="count(preceding::tei:p[ancestor::tei:body and not(ancestor::tei:note) and not(ancestor::eg:egXML)]) + 1"/>
            </xsl:attribute>
            <xsl:copy-of select="@*[local-name()!='n']"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:body//tei:div[not(@type='bibliography')]">
        <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:variable name="level-3">
                <xsl:if test="./parent::tei:div/parent::tei:div">
                    <xsl:value-of select="concat('-', count(./parent::tei:div/parent::tei:div/preceding-sibling::tei:div) + 1)"/>        
                </xsl:if>
            </xsl:variable>
            <xsl:variable name="level-2">
                <xsl:if test="./parent::tei:div">
                    <xsl:value-of select="concat('-', count(./parent::tei:div/preceding-sibling::tei:div) + 1)"/>
                </xsl:if>
            </xsl:variable>
            <xsl:variable name="level-1">
                    <xsl:value-of select="concat('-', count(./preceding-sibling::tei:div) + 1)"/>                
            </xsl:variable>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('c', $level-3, $level-2, $level-1)"/>
            </xsl:attribute>
            <xsl:copy-of select="@*[local-name()!='id']"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:body//tei:note">
        <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:variable name="number">
                <xsl:value-of select="count(preceding::tei:note[ancestor::tei:body and not(ancestor::eg:egXML)]) + 1"/>
            </xsl:variable>
            <xsl:attribute name="n"><xsl:value-of select="$number"/></xsl:attribute>
            <xsl:attribute name="xml:id"><xsl:value-of select="concat('fn', $number)"/></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>