<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                version="2.0"
                exclude-result-prefixes="fn">
    <xsl:template match="/">
        <cwrc>
            <xsl:variable name="allReligi">
                <xsl:apply-templates select="ceww/writer/religi"/>
            </xsl:variable>
            <xsl:variable name="allDegree">
                <xsl:apply-templates select="ceww/writer/degree"/>
            </xsl:variable>
            <xsl:variable name="allLitera">
                <xsl:apply-templates select="ceww/writer/litera"/>
            </xsl:variable>
            
            <xsl:for-each-group select="$allReligi/organization" group-by="identity/preferredForm">
                <entity>
                <xsl:choose>
                    <xsl:when test="count(current-group()) ne 1">
                        <organization>
                            <recordInfo>
                                <originInfo>
                                    <projectId>ceww</projectId>
                                </originInfo>
                                <accessCondition type="use and reproduction">
                                    Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons Attribution-NonCommercial 3.0 Unported License</a>.
                                </accessCondition>
                            </recordInfo>
                            <identity>
                                <preferredForm>
                                    <namePart>
                                        <xsl:value-of select='current-grouping-key()'/>
                                    </namePart>
                                </preferredForm>
                                <variantForms>
                                    <xsl:for-each select="current-group()/identity/variantForms/variant">
                                        <xsl:copy-of select="."/>
                                    </xsl:for-each>
                                </variantForms>
                            </identity>
                            <description>
                                <orgTypes>
                                    <orgType>religious</orgType>
                                </orgTypes>
                            </description>
                        </organization>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
                </entity>
            </xsl:for-each-group>
            
            <xsl:for-each-group select="$allDegree/organization" group-by="identity/preferredForm">
                <entity>
                <xsl:choose>
                    <xsl:when test="count(current-group()) ne 1">
                        <organization>
                            <recordInfo>
                                <originInfo>
                                    <projectId>ceww</projectId>
                                </originInfo>
                                <accessCondition type="use and reproduction">
                                    Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons Attribution-NonCommercial 3.0 Unported License</a>.
                                </accessCondition>
                            </recordInfo>
                            <identity>
                                <preferredForm>
                                    <namePart>
                                        <xsl:value-of select='current-grouping-key()'/>
                                    </namePart>
                                </preferredForm>
                                <variantForms>
                                    <xsl:for-each select="current-group()/identity/variantForms/variant">
                                        <xsl:copy-of select="."/>
                                    </xsl:for-each>
                                </variantForms>
                            </identity>
                            <description>
                                <orgTypes>
                                    <orgType>academic</orgType>
                                </orgTypes>
                            </description>
                        </organization>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
                </entity>
            </xsl:for-each-group>
            
            <xsl:for-each-group select="$allLitera/organization" group-by="identity/preferredForm">
                <entity>
                <xsl:choose>
                    <xsl:when test="count(current-group()) ne 1">
                        <organization>
                            <recordInfo>
                                <originInfo>
                                    <projectId>ceww</projectId>
                                </originInfo>
                                <accessCondition type="use and reproduction">
                                    Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons Attribution-NonCommercial 3.0 Unported License</a>.
                                </accessCondition>
                            </recordInfo>
                            <identity>
                                <preferredForm>
                                    <namePart>
                                        <xsl:value-of select='current-grouping-key()'/>
                                    </namePart>
                                </preferredForm>
                                <variantForms>
                                    <xsl:for-each select="current-group()/identity/variantForms/variant">
                                        <xsl:copy-of select="."/>
                                    </xsl:for-each>
                                </variantForms>
                            </identity>
                            <description>
                                <orgTypes>
                                    <orgType>literary</orgType>
                                </orgTypes>
                            </description>
                        </organization>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
                </entity>
            </xsl:for-each-group>
            <!--<xsl:for-each select="ceww/writer">
                <xsl:apply-templates select="religi|degree|litera"/>
            </xsl:for-each>-->
        </cwrc>
    </xsl:template>
    
    <xsl:template match="religi">
        <!-- This is done to avoid false matches inside brackets. -->
        <xsl:variable name="replacedTokens">
            <xsl:for-each select='fn:tokenize(., "[,;]")'>
                <xsl:choose>
                    <xsl:when test="fn:matches(., '.*\([^\)]*$')">
                        <xsl:value-of select="."/>,
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>30285201-6bb3-487a-b437-754314182726
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:for-each select='fn:tokenize($replacedTokens, "30285201-6bb3-487a-b437-754314182726")'>
            <xsl:variable name="trimName">
                <xsl:value-of select="fn:normalize-space(.)"/>
            </xsl:variable>
            
            <xsl:if test="fn:string-length($trimName) > 0">
                <organization>
                    <recordInfo>
                        <originInfo>
                            <projectId>ceww</projectId>
                        </originInfo>
                        <accessCondition type="use and reproduction">
                            Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons Attribution-NonCommercial 3.0 Unported License</a>.
                        </accessCondition>
                    </recordInfo>
                    <identity>
                        <preferredForm>
                            <namePart>
                                <xsl:value-of select='fn:normalize-space(fn:replace($trimName, "\(.*\)", ""))'/>
                            </namePart>
                        </preferredForm>
                        <variantForms>
                            <xsl:variable name="variantNames">
                                <xsl:value-of select='fn:normalize-space(fn:replace($trimName, "(^[^\(]+[\(]?)|[\)]$"," "))'/>
                            </xsl:variable>
                            <xsl:if test="fn:string-length($variantNames) > 0">
                                <xsl:for-each select='fn:normalize-space(fn:tokenize($variantNames, "[,;]"))'>
                                    <xsl:if test="(not(fn:contains(., '?')))">
                                        <variant>
                                            <namePart>
                                                <xsl:value-of select="."/>
                                            </namePart>
                                        </variant>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:if>
                        </variantForms>
                    </identity>
                    <description>
                        <orgTypes>
                            <orgType>religious</orgType>
                        </orgTypes>
                    </description>
                </organization>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="degree">
        <!-- This is done to avoid false matches inside brackets. -->
        <xsl:variable name="replacedTokens">
            <xsl:for-each select='fn:tokenize(., "[,;]")'>
                <xsl:choose>
                    <xsl:when test="fn:matches(., '.*\([^\)]*$')">
                        <xsl:value-of select="."/>,
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>30285201-6bb3-487a-b437-754314182726
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:for-each select='fn:tokenize($replacedTokens, "30285201-6bb3-487a-b437-754314182726")'>
            <xsl:variable name="trimName">
                <xsl:value-of select='fn:normalize-space(fn:replace(., "^.+, *", ""))'/>
            </xsl:variable>
            
            <xsl:if test="fn:string-length($trimName) > 0">
                <organization>
                    <recordInfo>
                        <originInfo>
                            <projectId>ceww</projectId>
                        </originInfo>
                        <accessCondition type="use and reproduction">
                            Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons Attribution-NonCommercial 3.0 Unported License</a>.
                        </accessCondition>
                    </recordInfo>
                    <identity>
                        <preferredForm>
                            <namePart>
                                <xsl:value-of select='fn:normalize-space(fn:replace($trimName, "\(.*\)", ""))'/>
                            </namePart>
                        </preferredForm>
                    </identity>
                    <description>
                        <orgTypes>
                            <orgType>academic</orgType>
                        </orgTypes>
                    </description>
                </organization>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="litera">
        <!-- This is done to avoid false matches inside brackets. -->
        <xsl:variable name="replacedTokens">
            <xsl:for-each select='fn:tokenize(., "[,;]")'>
                <xsl:choose>
                    <xsl:when test="fn:matches(., '.*\([^\)]*$')">
                        <xsl:value-of select="."/>,
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>30285201-6bb3-487a-b437-754314182726
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:for-each select='fn:tokenize($replacedTokens, "30285201-6bb3-487a-b437-754314182726")'>
            <xsl:variable name="trimName">
                <xsl:value-of select="fn:normalize-space(.)"/>
            </xsl:variable>
            
            <xsl:if test="fn:string-length($trimName) > 0">
                <organization>
                    <recordInfo>
                        <originInfo>
                            <projectId>ceww</projectId>
                        </originInfo>
                        <accessCondition type="use and reproduction">
                            Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons Attribution-NonCommercial 3.0 Unported License</a>.
                        </accessCondition>
                    </recordInfo>
                    <identity>
                        <preferredForm>
                            <namePart>
                                <xsl:value-of select='$trimName'/>
                            </namePart>
                        </preferredForm>
                    </identity>
                    <description>
                        <orgTypes>
                            <orgType>literary</orgType>
                        </orgTypes>
                    </description>
                    
                    <xsl:if test="fn:matches($trimName, '.*\(.+\).*')">
                        <xsl:variable name="place" select="fn:replace(fn:replace($trimName, '.*\(', ''), '\).*', '')"/>
                        
                        <xsl:if test="not(fn:matches(fn:lower-case($place), 'founder|organizaer|president|director|conver|mad club'))">
                            <relations>
                                <relation type="basedIn">
                                    <placeRef>
                                        <place>
                                            <xsl:value-of select="$place"/>
                                        </place>
                                    </placeRef>
                                </relation>
                            </relations>
                        </xsl:if>
                    </xsl:if>
                </organization>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>