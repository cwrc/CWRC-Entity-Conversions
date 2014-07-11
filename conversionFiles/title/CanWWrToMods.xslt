<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:title="org.ualberta.arc.mergecwrc.xslt.XSLTTitle"
                version="2.0"
                exclude-result-prefixes="fn">
    
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>    
    
    <xsl:template match="/canwwrfrom1950_production">
        <modsCollectionDefinition>
            <xsl:for-each select="works">
                <xsl:variable name="allTitles" select="title:extractTitles(name)"/>
                <xsl:variable name="category_id" select="category_id"/>
                <xsl:variable name="creator_id" select="creator_id"/>
                
                <mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/mods.xsd">
                    <genre authority="cwrc:entity">work</genre>
                    <genre authority="canwwr">
                        <xsl:value-of select="/canwwrfrom1950_production/categories[id = $category_id]/name"/>
                    </genre>
                    <xsl:for-each select="title:groupByGenre($allTitles/genre)">
                        <genre authority="tei:level">
                            <xsl:value-of select="."/>
                        </genre>
                    </xsl:for-each>
                    
                    
                    <xsl:for-each select="$allTitles">
                        <xsl:choose>
                            <xsl:when test="@isAlternative = 'true'">
                                <titleInfo type="alternative">
                                    <title>
                                        <xsl:value-of select="title"/>
                                    </title>
                                </titleInfo>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="@moreThanOne = 'true'">
                                        <titleInfo usage="primary">
                                            <title>
                                                <xsl:value-of select="title"/>
                                            </title>
                                        </titleInfo>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <titleInfo>
                                            <title>
                                                <xsl:value-of select="title"/>
                                            </title>
                                        </titleInfo>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    
                    <name>
                        <namePart>
                            <xsl:value-of select="/canwwrfrom1950_production/creators[id = $creator_id]/name"/>
                        </namePart>
                    </name>
                
                    <originInfo>
                        <dateIssued>
                            <xsl:value-of select="year"/>
                        </dateIssued>
                    </originInfo>
                   
                   <recordInfo>
                       <recordContentSource>Canadian Women Writers from 1950</recordContentSource>
                       <recordContentSource>canwwr</recordContentSource>
                       <recordIdentifier source="canwwr"><xsl:value-of select="id"/></recordIdentifier>
                   </recordInfo>
                   
                    <xsl:for-each select="$allTitles">
                        <xsl:for-each select="notes/note">
                            <note>
                                <xsl:value-of select="."/>
                            </note>
                        </xsl:for-each>
                    </xsl:for-each>
                    
                    <accessCondition type="use and reproduction">
                       Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons Attribution-NonCommercial 3.0 Unported License</a>.
                   </accessCondition>
                </mods>
            </xsl:for-each>
            <xsl:for-each select="criticalstudies">
                <xsl:variable name="allCritics" select="title:extractCriticNames(criticname)"/>
                
                <mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/mods.xsd">
                    <genre authority="cwrc:entity">work</genre>
                    <genre authority="canwwr">critical study</genre>
                    <genre authority="tei:level">a</genre>
                    <xsl:if test="articletitle != ''">
                        <titleInfo>
                            <title>
                                <xsl:value-of select="title:removeItalic(articletitle)"/>
                            </title>
                        </titleInfo>
                    </xsl:if>
                    <xsl:if test="book_periodical_title != ''">
                        <xsl:choose>
                            <xsl:when test="articletitle != ''">
                                <relatedItem type="host">
                                    <titleInfo>
                                        <title>
                                            <xsl:value-of select="title:addToTitleList(title:removeItalic(book_periodical_title))"/>
                                        </title>
                                    </titleInfo>
                                </relatedItem>
                            </xsl:when>
                            <xsl:otherwise>
                                <titleInfo>
                                    <title>
                                        <xsl:value-of select="title:removeItalic(book_periodical_title)"/>
                                    </title>
                                </titleInfo>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                    <xsl:for-each select="$allCritics">
                        <name>
                            <namePart>
                                <xsl:value-of select="namePart"/>
                            </namePart>
                            <xsl:if test="role">
                                <role>
                                    <roleTerm>
                                        <xsl:value-of select="role/roleTerm"/>
                                    </roleTerm>
                                </role>
                            </xsl:if>
                        </name>
                    </xsl:for-each>
                    <originInfo>
                        <dateIssued>
                            <xsl:value-of select="year"/>
                        </dateIssued>
                        <place>
                            <placeTerm>
                                <xsl:value-of select="title:getPlace(publishing_information)"/>
                            </placeTerm>
                        </place>
                    </originInfo>
                    
                    <recordInfo>
                       <recordContentSource>Canadian Women Writers from 1950</recordContentSource>
                       <recordContentSource>canwwr</recordContentSource>
                       <recordIdentifier source="canwwr"><xsl:value-of select="id"/></recordIdentifier>
                   </recordInfo>
                   
                   <accessCondition type="use and reproduction">
                       Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons Attribution-NonCommercial 3.0 Unported License</a>.
                   </accessCondition>
                </mods>
            </xsl:for-each>
            <xsl:for-each select="periodsandthemes">
                <mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/mods.xsd">
                    <genre authority="cwrc:entity">work</genre>
                    <genre authority="tei:level">m</genre>
                    <titleInfo>
                        <title>
                            <xsl:value-of select="title:removeItalic(name)"/>
                        </title>
                    </titleInfo>
                    
                    <recordInfo>
                       <recordContentSource>Canadian Women Writers from 1950</recordContentSource>
                       <recordContentSource>canwwr</recordContentSource>
                       <recordIdentifier source="canwwr"><xsl:value-of select="id"/></recordIdentifier>
                   </recordInfo>
                </mods>
            </xsl:for-each>
            <xsl:variable name="host_works" select="title:getTitleList()"/>
            <xsl:for-each select="$host_works">
                <mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/mods.xsd">
                    <genre authority="cwrc:entity">work</genre>
                    <genre authority="tei:level">m</genre>
                    <titleInfo>
                        <title>
                            <xsl:value-of select="."/>
                        </title>
                    </titleInfo>
                    
                    <recordInfo>
                       <recordContentSource>Canadian Women Writers from 1950</recordContentSource>
                       <recordContentSource>canwwr</recordContentSource>
                   </recordInfo>
                   <accessCondition type="use and reproduction">
                       Use of this public-domain resource is governed by the <a rel="license" href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons Attribution-NonCommercial 3.0 Unported License</a>.
                   </accessCondition>
                </mods>
            </xsl:for-each>
        </modsCollectionDefinition>
    </xsl:template>
</xsl:stylesheet>