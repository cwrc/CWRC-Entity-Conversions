<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpath-functions" version="2.0" exclude-result-prefixes="fn">

    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>

    <xsl:variable name="occupationCheck">[^,],, ([a-z ]+)$</xsl:variable>

    <xsl:template match="/">
        <cwrc>
            <xsl:for-each select="AUTHORITYLIST/AUTHORITYITEM">
                <entity>
                    <person>
                        <recordInfo>
                            <originInfo>
                                <projectId>orlando</projectId>
                            </originInfo>
                            <xsl:if test="@PERSONTYPE">
                                <personTypes>
                                    <personType>orl&#58;<xsl:value-of select="fn:normalize-space(@PERSONTYPE)"/> </personType>
                                </personTypes>
                            </xsl:if>
                            <accessCondition type="use and reproduction">
                            Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.
                        </accessCondition>
                        </recordInfo>

                        <identity>
                            <xsl:if test="@STANDARD">
                                <xsl:variable name="removedDates">
                                    <xsl:value-of select="fn:replace(@STANDARD, '(m\.  ?(by)? ?\d+ ?)|(fl\.  ?(by)? ?\d+ ?)|(d\.  ?(by)? ?\d+ ?)|(b\. ?(by)? ?\d+ ?)|(\d+(/\d+)?.? ?- ?(by)? ?\d+(/\d+)?.?)', '')"/>
                                </xsl:variable>

                                <xsl:variable name="authorName">
                                    <xsl:choose>
                                        <xsl:when test="fn:matches($removedDates, $occupationCheck)">
                                            <xsl:value-of select="fn:replace($removedDates, ',, [a-z ]+$', '')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$removedDates"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
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
                            </xsl:if>

                            <xsl:if test="@DISPLAY">
                                <xsl:if test="@STANDARD = null">
                                    <preferredForm>
                                        <namePart>
                                            <xsl:value-of select="@DISPLAY"/>
                                        </namePart>
                                    </preferredForm>
                                </xsl:if>
                                <displayLabel>
                                    <xsl:value-of select="@DISPLAY"/>
                                </displayLabel>
                            </xsl:if>

                            <variantForms>
                                <xsl:if test="@STANDARD">
                                    <variant>
                                        <namePart>
                                            <xsl:value-of select="@STANDARD"/>
                                        </namePart>
                                        <authorizedBy>
                                            <projectId>orlando</projectId>
                                        </authorizedBy>
                                    </variant>
                                </xsl:if>
                                <xsl:for-each select="*">
                                    <variant>
                                        <variantType>
                                            <xsl:choose>
                                                <xsl:when test="name() = 'BIRTHNAME'">birthName</xsl:when>
                                                <xsl:when test="name() = 'MARRIED'">marriedName</xsl:when>
                                                <xsl:when test="name() = 'INDEXED'">indexedName</xsl:when>
                                                <xsl:when test="name() = 'PSEUDONYM'">pseudonym</xsl:when>
                                                <xsl:when test="name() = 'FORM'">usedForm</xsl:when>
                                                <xsl:when test="name() = 'NICKNAME'">nickname</xsl:when>
                                                <xsl:when test="name() = 'RELIGIOUSNAME'">religiousName</xsl:when>
                                                <xsl:when test="name() = 'ROYALNAME'">royalName</xsl:when>
                                                <xsl:when test="name() = 'SELFCONSTRUCTED'">selfConstructedName</xsl:when>
                                                <xsl:when test="name() = 'STYLED'">styledName</xsl:when>
                                                <xsl:when test="name() = 'TITLED'">titledName</xsl:when>
                                            </xsl:choose>
                                        </variantType>
                                        <namePart>
                                            <xsl:value-of select="."/>
                                        </namePart>
                                    </variant>
                                </xsl:for-each>
                            </variantForms>
                        </identity>
                        <description>
                            <xsl:analyze-string select="@STANDARD" regex="{$occupationCheck}">
                                <xsl:matching-substring>
                                    <xsl:variable name="occupationVar">
                                        <xsl:value-of select="fn:replace(regex-group(0), '.,, ', '')"/>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="fn:matches($occupationVar, '^((the elder)|(the younger)|(fils)|(pere)|(father)|(mother)|(son)|(daughter)|(neé))$')"> </xsl:when>
                                        <xsl:otherwise>
                                            <occupations>
                                                <occupation>
                                                    <term>
                                                        <xsl:value-of select="$occupationVar"/>
                                                    </term>
                                                </occupation>
                                            </occupations>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:matching-substring>
                            </xsl:analyze-string>
                            <existDates>
                                <xsl:analyze-string select="@STANDARD" regex="fl\. ?(by)? ?\d+">
                                    <xsl:matching-substring>
                                        <dateSingle>
                                            <textDate>
                                                <xsl:value-of select="regex-group(0)"/>
                                            </textDate>
                                            <standardDate>
                                                <xsl:value-of select="fn:replace(regex-group(0), '[^\d+]', '')"/>
                                            </standardDate>
                                            <dateType>flourish</dateType>
                                        </dateSingle>
                                    </xsl:matching-substring>
                                </xsl:analyze-string>

                                <xsl:analyze-string select="@STANDARD" regex="d\. ?(by)? ?\d+ ?">
                                    <xsl:matching-substring>
                                        <dateSingle>
                                            <textDate>
                                                <xsl:value-of select="regex-group(0)"/>
                                            </textDate>
                                            <standardDate>
                                                <xsl:value-of select="fn:replace(regex-group(0), '[^\d+]', '')"/>
                                            </standardDate>
                                            <dateType>death</dateType>
                                        </dateSingle>
                                    </xsl:matching-substring>
                                </xsl:analyze-string>

                                <xsl:analyze-string select="@STANDARD" regex="b\. ?(by)? ?\d+ ?">
                                    <xsl:matching-substring>
                                        <dateSingle>
                                            <textDate>
                                                <xsl:value-of select="regex-group(0)"/>
                                            </textDate>
                                            <standardDate>
                                                <xsl:value-of select="fn:replace(regex-group(0), '[^\d+]', '')"/>
                                            </standardDate>
                                            <dateType>birth</dateType>
                                        </dateSingle>
                                    </xsl:matching-substring>
                                </xsl:analyze-string>

                                <xsl:analyze-string select="@STANDARD" regex="\d+(/\d+)?.? ?- ?(by)? ?\d+(/\d+)?.?">
                                    <xsl:matching-substring>
                                        <xsl:analyze-string select="regex-group(0)" regex="\d+/\d+.? ?-">
                                            <xsl:matching-substring>
                                                <dateSingle>
                                                    <standardDate><xsl:value-of select="fn:replace(fn:replace(regex-group(0), '\d/', ''), '[^\d+]', '')"/>--</standardDate>
                                                    <dateType>birth</dateType>
                                                </dateSingle>
                                            </xsl:matching-substring>
                                        </xsl:analyze-string>
                                        <xsl:analyze-string select="regex-group(0)" regex="- ?(by)? ?\d+/\d+.?">
                                            <xsl:matching-substring>
                                                <dateSingle>
                                                    <standardDate><xsl:value-of select="fn:replace(fn:replace(regex-group(0), '\d/', ''), '[^\d+]', '')"/>--</standardDate>
                                                    <dateType>birth</dateType>
                                                </dateSingle>
                                            </xsl:matching-substring>
                                        </xsl:analyze-string>
                                        <xsl:choose>
                                            <xsl:when test="fn:contains(regex-group(0), '?')">
                                                <dateSingle>
                                                    <textDate>
                                                        <xsl:value-of select="regex-group(0)"/>
                                                    </textDate>
                                                </dateSingle>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:analyze-string select="regex-group(0)" regex="\d+(/\d+)? ?-">
                                                    <xsl:matching-substring>
                                                        <dateSingle>
                                                            <standardDate><xsl:value-of select="fn:replace(regex-group(0), '(/\d)|[^\d+]', '')"/>--</standardDate>
                                                            <dateType>birth</dateType>
                                                        </dateSingle>
                                                    </xsl:matching-substring>
                                                </xsl:analyze-string>

                                                <xsl:analyze-string select="regex-group(0)" regex="- ?(by)? ?\d+(/\d+)?">
                                                    <xsl:matching-substring>
                                                        <dateSingle>
                                                            <standardDate><xsl:value-of select="fn:replace(regex-group(0), '(/\d)|[^\d+]', '')"/>--</standardDate>
                                                            <dateType>death</dateType>
                                                        </dateSingle>
                                                    </xsl:matching-substring>
                                                </xsl:analyze-string>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:matching-substring>
                                </xsl:analyze-string>
                            </existDates>
                            <factuality>real</factuality>
                        </description>
                    </person>
                </entity>
            </xsl:for-each>
        </cwrc>
    </xsl:template>
</xsl:stylesheet>
