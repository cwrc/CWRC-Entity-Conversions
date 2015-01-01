<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                version="2.0"
                exclude-result-prefixes="fn">
    
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
    
    <xsl:template match="/">
        <modsCollectionDefinition>
            <xsl:for-each select="ORLANDO/title_group">
                <mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/mods.xsd">
                    <genre authority="cwrc:entity">work</genre>
                    <xsl:for-each select="title_sub_type">
                        <xsl:choose>
                            <xsl:when test="fn:lower-case(.) = 'analytic'">
                                <genre authority="tei:level">a</genre>
                            </xsl:when>
                            <xsl:when test="fn:lower-case(.) = 'journal'">
                                <genre authority="tei:level">j</genre>
                            </xsl:when>
                            <xsl:when test="fn:lower-case(.) = 'monographic'">
                                <genre authority="tei:level">m</genre>
                            </xsl:when>
                            <xsl:when test="fn:lower-case(.) = 'series'">
                                <genre authority="tei:level">s</genre>
                            </xsl:when>
                            <xsl:when test="fn:lower-case(.) = 'unpublished'">
                                <genre authority="tei:level">u</genre>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                    
                    <xsl:choose>
                        <xsl:when test="title_variant_array/title_variant">
                            <titleInfo usage="primary">
                                <title>
                                    <xsl:value-of select="title_reg"/>
                                </title>
                            </titleInfo>
                            <xsl:for-each select="title_variant_array/title_variant">
                                <titleInfo type="alternative">
                                    <title>
                                        <xsl:value-of select="."/>
                                    </title>
                                </titleInfo>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <titleInfo>
                                <title>
                                    <xsl:value-of select="title_reg"/>
                                </title>
                            </titleInfo>
                        </xsl:otherwise>
                    </xsl:choose>
                    <recordInfo>
                        <recordContentSource>The Orlando Project</recordContentSource>
                        <recordContentSource>orlando</recordContentSource>
                        <xsl:for-each select="title_src_id_array/title_src_id">
                            <recordIdentifier source="orlando">
                                <xsl:value-of select="."/>
                            </recordIdentifier>
                        </xsl:for-each>
                    </recordInfo>
                    <accessCondition type="use and reproduction">
                       Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.
                   </accessCondition>
                </mods>
            </xsl:for-each>
        </modsCollectionDefinition>
    </xsl:template>
</xsl:stylesheet>