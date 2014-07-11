<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                version="2.0"
                exclude-result-prefixes="fn">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
    
    <xsl:template match="/">
        <cwrc>
            <xsl:for-each select="catalogue/person">
                <entity>
                    <person>
                    <recordInfo>
                        <originInfo>
                            <projectId>orlando</projectId>
                        </originInfo>
                        <accessCondition type="use and reproduction">
                            Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons Attribution-NonCommercial 3.0 Unported License</a>.
                        </accessCondition>
                    </recordInfo>
                    
                    <identity>                        
                        <xsl:variable name="authorName">
                            <xsl:value-of select="@standard_name"/>
                        </xsl:variable>
                            
                        <xsl:variable name="surname">
                            <xsl:value-of select="fn:replace($authorName, ',.*', '')"/>
                        </xsl:variable>
                        <xsl:variable name="forename">
                            <xsl:value-of select="fn:replace(fn:replace(fn:normalize-space(fn:substring($authorName, fn:string-length($surname) + 2)), ',{2,2}', ','), ',$', '')"/>
                        </xsl:variable>
                        <preferredForm>
                            <xsl:choose>
                                <xsl:when test="fn:string-length($forename) > 0">
                                    <xsl:choose>
                                        <xsl:when test="fn:starts-with($forename, ',')">
                                            <namePart>
                                                <xsl:value-of select="$surname"/><xsl:text> </xsl:text><xsl:value-of select="$forename"/>
                                            </namePart>
                                        </xsl:when>
                                        <xsl:when test="fn:contains($forename, ',,')">
                                            <namePart>
                                                <xsl:value-of select="fn:replace($forename, ',{2,2}', ',')"/><xsl:text> </xsl:text><xsl:value-of select="$surname"/>
                                            </namePart>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <namePart partType="surname">
                                                <xsl:value-of select="$surname"/>
                                            </namePart>
                                            <namePart partType="forename">
                                                <xsl:value-of select="$forename"/>
                                            </namePart>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <namePart>
                                        <xsl:value-of select="$authorName"/>
                                    </namePart>
                                </xsl:otherwise>
                            </xsl:choose>
                        </preferredForm>
                        
                        <variantForms>
                            <variant>
                                <namePart>
                                    <xsl:value-of select="@standard_name"/>
                                </namePart>
                                <authorizedBy>
                                    <projectId>orlando</projectId>
                                </authorizedBy>
                            </variant>
                        </variantForms>
                    </identity>
                    <description>
                        <existDates>
                            <dateRange>
                                <xsl:if test="@birth">
                                    <fromDate>
                                        <standardDate>
                                            <xsl:value-of select="@birth"/>
                                        </standardDate>
                                        <dateType>birth</dateType>
                                    </fromDate>
                                </xsl:if>
                    
                                <xsl:if test="@death">
                                    <toDate>
                                        <standardDate>
                                            <xsl:value-of select="@death"/>
                                        </standardDate>
                                        <dateType>death</dateType>
                                    </toDate>
                                </xsl:if>
                            </dateRange>
                        </existDates>
                    </description>
                    </person>
                </entity>
            </xsl:for-each>
        </cwrc>
    </xsl:template>
</xsl:stylesheet>