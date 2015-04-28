<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                version="2.0"
                exclude-result-prefixes="fn">
                    
    <xsl:template match="/">
        <cwrc>
            <xsl:variable name="toBeMerged">
                <xsl:for-each select="canwwr/criticalstudies/publishing_information">
                    <xsl:for-each select='fn:tokenize(., "[;]")'>
                    
                        <xsl:variable name="normalizedName">
                            <xsl:value-of select="fn:normalize-space(fn:replace(., '.+:', ''))"/>
                        </xsl:variable>
                    
                        <entry><xsl:value-of select="$normalizedName"/></entry>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:for-each-group select="$toBeMerged/entry" group-by=".">
                <entity>
                    <organization>
                        <recordInfo>
                            <orgTypes>
                                <orgType>publishing</orgType>
                            </orgTypes>
                            <originInfo>
                                <projectId>canwwr</projectId>
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
                            <preferredForm>
                                <namePart>
                                    <xsl:value-of select="current-grouping-key()"/>
                                </namePart>
                            </preferredForm>
                        </identity>
                    </organization>
                </entity>
            </xsl:for-each-group>
        </cwrc>
    </xsl:template>
</xsl:stylesheet>