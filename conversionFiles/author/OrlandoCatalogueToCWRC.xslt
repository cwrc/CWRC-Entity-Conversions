<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpath-functions" version="2.0" exclude-result-prefixes="fn">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>

    <xsl:template match="/">
        <cwrc>
            <xsl:for-each select="catalogue/person">
                <entity>
                    <person>
                        <recordInfo>
                            <originInfo>
                                <projectId>orlando</projectId>
                                <recordCreationDate>
                                    <xsl:value-of select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
                                </recordCreationDate>
                                <recordChangeDate>
                                    <xsl:value-of select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
                                </recordChangeDate>
                            </originInfo>
                            <accessCondition type="use and reproduction">
                            Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.
                        </accessCondition>
                        </recordInfo>

                        <identity>
                            <xsl:variable name="authorName">
                                <xsl:value-of select="@standard_name"/>
                            </xsl:variable>

                            <xsl:variable name="family">
                                <xsl:value-of select="fn:replace($authorName, ',.*', '')"/>
                            </xsl:variable>
                            <xsl:variable name="given">
                                <xsl:value-of select="fn:replace(fn:replace(fn:normalize-space(fn:substring($authorName, fn:string-length($family) + 2)), ',{2,2}', ','), ',$', '')"/>
                            </xsl:variable>
                            <preferredForm>
                                <xsl:choose>
                                    <xsl:when test="fn:string-length($given) > 0">
                                        <xsl:choose>
                                            <xsl:when test="fn:starts-with($given, ',')">
                                                <namePart>
                                                    <xsl:value-of select="$family"/>
                                                    <xsl:text> </xsl:text>
                                                    <xsl:value-of select="$given"/>
                                                </namePart>
                                            </xsl:when>
                                            <xsl:when test="fn:contains($given, ',,')">
                                                <namePart>
                                                    <xsl:value-of select="fn:replace($given, ',{2,2}', ',')"/>
                                                    <xsl:text> </xsl:text>
                                                    <xsl:value-of select="$family"/>
                                                </namePart>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <namePart partType="family">
                                                    <xsl:value-of select="$family"/>
                                                </namePart>
                                                <namePart partType="given">
                                                    <xsl:value-of select="$given"/>
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
                                <xsl:if test="@birth">
                                    <dateSingle>
                                        <standardDate>
                                            <xsl:value-of select="@birth"/>
                                        </standardDate>
                                        <dateType>birth</dateType>
                                    </dateSingle>
                                </xsl:if>

                                <xsl:if test="@death">
                                    <dateSingle>
                                        <standardDate>
                                            <xsl:value-of select="@death"/>
                                        </standardDate>
                                        <dateType>death</dateType>
                                    </dateSingle>
                                </xsl:if>
                            </existDates>
                            <factuality>real</factuality>
                        </description>
                    </person>
                </entity>
            </xsl:for-each>
        </cwrc>
    </xsl:template>
</xsl:stylesheet>
