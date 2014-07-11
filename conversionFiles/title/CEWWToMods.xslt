<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:title="org.ualberta.arc.mergecwrc.xslt.XSLTTitle"
                version="2.0"
                exclude-result-prefixes="fn">
    
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
    
    <xsl:template match="/ceww">
        <modsCollectionDefinition>
            <xsl:for-each select="writer">
                <xsl:variable name="authorName" select="title"/>
                <xsl:variable name="identiNum" select="identi"/>
                    
                <xsl:for-each select="book[@name = 'Books']|peiodi[@name = 'Periodicals']|unveri[@name = 'Unverified titles']">
                    <xsl:variable name="selectedType" select="@name"/>
                    <xsl:variable name="allTitles" select="title:readCEWWTitleEntries(., $selectedType)"/>
                                        
                    <xsl:for-each select="$allTitles">
                        <mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/mods.xsd">
                            <genre authority="cwrc:entity">work</genre>
                            
                            
                            <xsl:choose>
                                <xsl:when test="titles/title">
                                    <titleInfo usage="primary">
                                        <title>
                                            <xsl:value-of select="title"/>
                                        </title>
                                    </titleInfo>
                                    <xsl:for-each select="titles/title">
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
                                            <xsl:value-of select="title"/>
                                        </title>
                                    </titleInfo>
                                </xsl:otherwise>
                            </xsl:choose>
                                
                            <name>
                                <namePart>
                                    <xsl:value-of select="$authorName"/>
                                </namePart>
                            </name>
                            
                            <xsl:variable name="dates" select="dates/date"/>
                            <xsl:variable name="places" select="places/place"/>
                            <xsl:if test="title:addCEWWOriginInfo($dates, $places)">
                                <originInfo>
                                    <xsl:for-each select="dates/date">
                                        <dateIssued point='start'>
                                            <xsl:value-of select="."/>
                                        </dateIssued>
                                    </xsl:for-each>
                                
                                    <xsl:for-each select="places/place">
                                        <place>
                                            <placeTerm>
                                                <xsl:value-of select="."/>
                                            </placeTerm>
                                        </place>
                                    </xsl:for-each>
                                </originInfo>
                            </xsl:if>
                            
                            <recordInfo>
                                <recordContentSource>Canada's Early Women Writers</recordContentSource>
                                <recordContentSource>ceww</recordContentSource>
                                <recordIdentifier  source="ceww">
                                    <xsl:value-of select="$identiNum"/>
                                </recordIdentifier>
                            </recordInfo>
                            
                            <xsl:if test="$selectedType = 'Unverified titles'">
                                <note>Univerified authorship</note>
                            </xsl:if>
                            
                            <accessCondition type="use and reproduction">
                                Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons Attribution-NonCommercial 3.0 Unported License</a>.
                            </accessCondition>
                        </mods>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>
        </modsCollectionDefinition>
    </xsl:template>
</xsl:stylesheet>