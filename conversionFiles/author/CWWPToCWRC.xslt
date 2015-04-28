<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:mads="http://www.loc.gov/mads/v2" version="2.0" exclude-result-prefixes="mads fn">
    <xsl:variable name="dateReg">\( ?\d+.? ?- ?\d+.? ?\)</xsl:variable>

    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>

    <xsl:template match="/">
        <cwrc>
            <xsl:for-each select="mads:madsCollection/mads:mads">
                <entity>
                    <person>
                        <recordInfo>
                            <originInfo>
                                <projectId>canwwr</projectId>
                                <recordCreationDate>
                                    <xsl:value-of select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
                                </recordCreationDate>
                                <recordChangeDate>
                                    <xsl:value-of select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
                                </recordChangeDate>
                            </originInfo>
                            <personTypes>
                                <personType>creator</personType>
                            </personTypes>
                            <accessCondition type="use and reproduction">
                                Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.
                            </accessCondition>
                        </recordInfo>
                        <identity>
                            <xsl:for-each select="mads:authority/mads:name">
                                <xsl:choose>
                                    <xsl:when test="@type = 'personal'">
                                        <xsl:choose>
                                            <xsl:when test="(mads:namePart[@type = 'family']) and (mads:namePart[@type = 'given'])">
                                                <xsl:variable name="firstName">
                                                    <xsl:value-of select="fn:replace(mads:namePart[@type = 'given'], ' \( ?\d+ ?- ?\d+ ?\)', '')"/>
                                                </xsl:variable>
                                                <preferredForm>
                                                    <namePart partType="family">
                                                        <xsl:value-of select="mads:namePart[@type = 'family']"/>
                                                    </namePart>
                                                    <namePart partType="given">
                                                        <xsl:value-of select="$firstName"/>
                                                    </namePart>
                                                </preferredForm>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:variable name="authorName">
                                                    <xsl:value-of select="fn:replace(mads:namePart, ' \( ?\d+ ?- ?\d+ ?\)', '')"/>
                                                </xsl:variable>
                                                <preferredForm>
                                                    <namePart>
                                                        <xsl:value-of select="$authorName"/>
                                                    </namePart>
                                                </preferredForm>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>

                            <variantForms>
                                <xsl:for-each select="mads:variant/mads:name">
                                    <xsl:choose>
                                        <xsl:when test="@type = 'personal'">
                                            <variant>
                                                <xsl:choose>
                                                    <xsl:when test="(mads:namePart[@type = 'family']) and (mads:namePart[@type = 'given'])">
                                                        <namePart partType="family">
                                                            <xsl:value-of select="mads:namePart[@type = 'family']"/>
                                                        </namePart>
                                                        <namePart partType="given">
                                                            <xsl:value-of select="mads:namePart[@type = 'given']"/>
                                                        </namePart>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <namePart>
                                                            <xsl:value-of select="mads:namePart"/>
                                                        </namePart>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </variant>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:for-each>
                            </variantForms>
                        </identity>

                        <description>
                            <xsl:for-each select="mads:authority/mads:name">
                                <xsl:choose>
                                    <xsl:when test="@type = 'personal'">
                                        <xsl:for-each select="mads:namePart">
                                            <xsl:analyze-string select="." regex="{$dateReg}">
                                                <xsl:matching-substring>
                                                    <existDates>
                                                        <xsl:choose>
                                                            <xsl:when test="fn:contains(regex-group(0), '[^0-9-]')">
                                                                <dateSingle>
                                                                    <textDate>
                                                                        <xsl:value-of select="regex-group(0)"/>
                                                                    </textDate>
                                                                </dateSingle>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:analyze-string select="." regex="\( ?\d+ ?-">
                                                                    <xsl:matching-substring>
                                                                        <dateSingle>
                                                                            <standardDate><xsl:value-of select="fn:replace(regex-group(0), '[^\d+]', '')"/>--</standardDate>
                                                                            <dateType>birth</dateType>
                                                                        </dateSingle>
                                                                    </xsl:matching-substring>
                                                                </xsl:analyze-string>
                                                                <xsl:analyze-string select="." regex="- ?\d+ ?\)">
                                                                    <xsl:matching-substring>
                                                                        <dateSingle>
                                                                            <xsl:choose>
                                                                                <xsl:when test="fn:string-length(regex-group(0)) > 2">
                                                                                    <standardDate><xsl:value-of select="fn:replace(regex-group(0), '[^\d+]', '')"/>--</standardDate>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:variable name="startVal">
                                                                                        <xsl:analyze-string select="." regex="\( ?\d+ ?-">
                                                                                            <xsl:matching-substring>
                                                                                                <xsl:value-of select="fn:substring(fn:replace(regex-group(0), '[^\d+]', ''), 1, 2)"/>
                                                                                            </xsl:matching-substring>
                                                                                        </xsl:analyze-string>
                                                                                    </xsl:variable>
                                                                                    <standardDate><xsl:value-of select="$startVal"/><xsl:value-of select="fn:replace(regex-group(0), '[^\d+]', '')"/>--</standardDate>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                            <dateType>death</dateType>
                                                                        </dateSingle>
                                                                    </xsl:matching-substring>
                                                                </xsl:analyze-string>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </existDates>
                                                </xsl:matching-substring>
                                                <xsl:non-matching-substring> </xsl:non-matching-substring>
                                            </xsl:analyze-string>
                                        </xsl:for-each>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>
                            <factuality>real</factuality>
                        </description>
                    </person>
                </entity>
            </xsl:for-each>
        </cwrc>
    </xsl:template>
</xsl:stylesheet>
