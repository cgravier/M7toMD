<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:m7="urn:mpeg:mpeg7:schema:2004" 
xmlns:xsi="urn:mpeg:mpeg7:schema:2004"
xmlns:date="http://exslt.org/dates-and-times"
extension-element-prefixes="date"
exclude-result-prefixes="m7">

<xsl:output
method="html"
omit-xml-declaration="yes"
indent="yes"/>


<xsl:template match="/">
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;
</xsl:text>
 
		<html>
		<head>
			<title>
				<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Creation/Title"/>
			</title>
		</head>
		
		<div itemscope="" itemtype="http://schema.org/VideoObject">
		
		
		<div itemprop="headline" id="headline">
			<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Creation/Title"/>
		</div>
		
		<div itemprop="duration" id="duration">
			<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/MediaTime/MediaDuration" />
		</div>
		
		<xsl:variable name="begin">
			<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/UsageInformation/Availability/AvailabilityPeriod[@type='online']/TimePoint" />
		</xsl:variable> 
		
		<xsl:variable name="duration">
			<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/UsageInformation/Availability/AvailabilityPeriod[@type='online']/Duration" />
		</xsl:variable>
		
		<div itemprop="uploadDate" id="uploadDate">
			<xsl:value-of select="$begin"/>
		</div>
		
		<div itemprop="expires" id="expires">
			<xsl:value-of select="date:add($begin,$duration)"/>
		</div>
		
		<div itemprop="description" id="description">
			<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Creation/Abstract/FreeTextAnnotation" />
		
		<xsl:for-each select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Creation/Abstract/StructuredAnnotation">
				<xsl:value-of select="Who/Name"/><xsl:text> </xsl:text>
				<xsl:value-of select="WhatObject/Name"/><xsl:text> </xsl:text>
				<xsl:value-of select="WhatAction/Name"/><xsl:text> </xsl:text>
				<xsl:value-of select="Where/Name"/><xsl:text> </xsl:text>
				<xsl:value-of select="Why/Name"/><xsl:text> </xsl:text>
				<xsl:value-of select="How/Name"/><xsl:text> </xsl:text>
			</xsl:for-each>
			
		</div>
		
		<div itemprop="name" id="name">
			<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/MediaLocator/MediaUri" />
		</div>

		<div itemprop="keywords" id="keywords">
		
			<xsl:for-each select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Classification/Subject/KeywordAnnotation/Keyword">
				<xsl:value-of select="."/><xsl:text> </xsl:text>
			</xsl:for-each>
		
			<xsl:for-each select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Classification/Subject/StructuredAnnotation">
				<xsl:value-of select="Who/Name"/><xsl:text> </xsl:text>
				<xsl:value-of select="WhatObject/Name"/><xsl:text> </xsl:text>
				<xsl:value-of select="WhatAction/Name"/><xsl:text> </xsl:text>
				<xsl:value-of select="Where/Name"/><xsl:text> </xsl:text>
				<xsl:value-of select="Why/Name"/><xsl:text> </xsl:text>
				<xsl:value-of select="How/Name"/><xsl:text> </xsl:text>
			</xsl:for-each>
			
			<xsl:for-each select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Creation/Abstract/KeywordAnnotation/Keyword">
				<xsl:value-of select="."/><xsl:text> </xsl:text>
			</xsl:for-each>
		</div>
		
		<div>
		
			<xsl:for-each select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Classification/MediaReview">
			
			<div itemprop="reviews" itemscope="" itemtype="http://schema.org/Review">
				<div itemprop="author">
					<xsl:value-of select="Reviewer/Name/FamilyName"/><xsl:text> </xsl:text><xsl:value-of select="Reviewer/Name/GivenName"/>
				</div>
				<div itemprop="reviewRating" itemscope="" itemtype="http://schema.org/Rating">	
						
						<meta itemprop="worstRating">
							<xsl:attribute name="content">
								<xsl:value-of select="number(Rating/RatingScheme/@worst)" />
							</xsl:attribute>
						</meta>
						
      					<div itemprop="ratingValue"><xsl:value-of select="number(Rating/RatingValue)"/> </div> <!-- out of -->
      					<div itemprop="bestRating"><xsl:value-of select="number(Rating/RatingScheme/@best)"/> </div> <!-- stars -->
      					
      			</div>
      			
      		</div>
      		
      		</xsl:for-each>
      	</div>
      	
      	 <meta itemprop="interactioncount">
				<xsl:attribute name="content">
					<xsl:value-of select="concat('UserComments:',count(Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Classification/MediaReview/Rating))"/>
				</xsl:attribute>
			</meta>
      	
  		<div itemprop="aggregateRating" itemscope="" itemtype="http://schema.org/AggregateRating">
  		
  		    
  		
  		<div itemprop="ratingValue">
  		
  		    <xsl:call-template name="somme">
    			<xsl:with-param name="list_nodes" select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Classification/MediaReview/Rating"></xsl:with-param>
    			<xsl:with-param name="sub_result">0</xsl:with-param>
     			<xsl:with-param name="pos">1</xsl:with-param>
  			</xsl:call-template>
  		
  		</div> <!-- out of 5 by -->
  		
  		<div itemprop="reviewCount">
  			<xsl:value-of select="count(Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Classification/MediaReview/Rating)"/>
  		</div> <!-- reviewers.-->
  		


  		
   		</div>
   		

  		<xsl:for-each select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Creation/Creator">
  			 <xsl:choose>
     		 	<xsl:when test="Role/@href='urn:mpeg:mpeg7:cs:RoleCS:AUTHOR' and Agent/@*='PersonType'">
     		 				<div itemprop="author" itemscope="" itemtype="http://schema.org/Person">
								<div itemprop="givenName"><xsl:value-of select="Agent/Name/GivenName" /></div><xsl:text> </xsl:text>
     		 					<div itemprop="familyName"><xsl:value-of select="Agent/Name/FamilyName" /></div><xsl:text></xsl:text>
     		 				</div>	
				</xsl:when>
			</xsl:choose>
  		</xsl:for-each>

  		<xsl:for-each select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Creation/Creator">	
  			 <xsl:choose>
     		 	<xsl:when test="Role/@href='urn:mpeg:mpeg7:cs:RoleCS:AUTHOR' and Agent/@*='OrganizationType'">
     		 				<div itemprop="author" itemscope="" itemtype="http://schema.org/Organization" id="authororganization">
								<div itemprop="name"><xsl:value-of select="Agent/Name" /></div><xsl:text> </xsl:text>
     		 				</div>	
				</xsl:when>
			</xsl:choose>
  		</xsl:for-each>	
		
		
				<xsl:for-each select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Creation/Creator">
  			 		<xsl:choose>
     		 			<xsl:when test="Role/@href='urn:mpeg:mpeg7:cs:RoleCS:2001:PUBLISHER' and Agent/@*='OrganizationType'">
     		 					<div itemprop="publisher" itemscope="" itemtype="http://schema.org/Organization" id="publisher">
									<div itemprop="name"><xsl:value-of select="Agent/Name" /></div><xsl:text> </xsl:text>
     		 					</div>	
						</xsl:when>
					</xsl:choose>
  				</xsl:for-each>

		
		<div itemprop="dateCreated" id="dateCreated">
		<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Creation/CreationCoordinates/Date/TimePoint" />
		
		
				<div itemprop="dateModified" id="dateModified">
					<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/UsageInformation/Availability/AvailabilityPeriod/TimePoint" />
				</div>

	<div itemprop="datePublished" id="datePublished">
		<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Classification/Release/@date" /></div>
		
		
		<div itemprop="contentLocation" itemscope="" itemtype="http://schema.org/Place">
			<div itemprop="name">
				<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Creation/CreationCoordinates/Location/Name" />
			</div>
			
			<div itemprop="geo" itemscope="" itemtype="http://schema.org/GeoCoordinates">
			
				<div itemprop="elevation">
					<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Creation/CreationCoordinates/Location/GeographicPosition/Point/@altitude" />
				</div>
				
				<div itemprop="latitude">
					<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Creation/CreationCoordinates/Location/GeographicPosition/Point/@latitude" />
				</div>
				
				<div itemprop="longitude">
					<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Creation/CreationCoordinates/Location/GeographicPosition/Point/@longitude" />
				</div>
							
			</div>
			
		</div>

		<div itemprop="genre">
			<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Classification/Genre/Name"/>
		</div>
		
		<div itemprop="inLanguage">
			<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Classification/Language"/>
		</div>
		
		<meta itemprop="isFamilyFriendly">
			<xsl:attribute name="content">
				<xsl:choose>
      				<xsl:when test="Mpeg7/Description/MultimediaContent/Collection/Content/Video/CreationInformation/Classification/Target/@age > 10">
      					<xsl:value-of select="true" /> 
      			    </xsl:when>
    			 	<xsl:otherwise>
         				<xsl:value-of select="false" /> 
     				</xsl:otherwise>
     			</xsl:choose>
			</xsl:attribute>
		</meta>
		
		</div>
		
		
		<xsl:variable name="sizebytes">
			<xsl:value-of select="number(Mpeg7/Description/MultimediaContent/Collection/Content/Video/MediaInformation/MediaProfile/MediaFormat/FileSize)" />
		</xsl:variable>
		
		<xsl:choose>
      				<xsl:when test="$sizebytes > 1048576">
      					<div itemprop="contentSize" id="contentSize"><xsl:value-of select="$sizebytes div 1048576" /> Mo</div>
      			    </xsl:when>
    			 	<xsl:otherwise>
         				<div itemprop="contentSize" id="contentSize"><xsl:value-of select="$sizebytes div 1024" /> Ko</div>
     				</xsl:otherwise>
     	</xsl:choose>
		
		
		<div itemprop="bitrate" id="bitrate">
			<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/MediaInformation/MediaProfile/MediaFormat/BitRate" />
		</div>
		
		
		<div itemprop="height" id="height" itemtype="http://schema.org/Distance">
			<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/MediaInformation/MediaProfile/MediaFormat/VisualCoding/Frame/@height" /> px
		</div>
		
		
		<div itemprop="width" id="width" itemtype="http://schema.org/Distance">
			<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/MediaInformation/MediaProfile/MediaFormat/VisualCoding/Frame/@width" /> px
		</div>
		
	
		<div itemprop="encodingFormat" id="encodingvideoFormat">
			<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/MediaInformation/MediaProfile/MediaFormat/VisualCoding/Format/Name" />
		</div>
		
		<div itemprop="encodingFormat" id="encodingaudioFormat">
			<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/MediaInformation/MediaProfile/MediaFormat/AudioCoding/Format/Name" />
		</div>
		
		<div itemprop="contentUrl" id="contentUrl">
			<xsl:value-of select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/MediaLocator/MediaUri" />
		</div>
		
	
		<xsl:for-each select="Mpeg7/Description/MultimediaContent/Collection/Content/Video/UsageInformation/Availability/Dissemination/Location">
				<div itemprop="regionsAllowed" id="regionsAllowed" itemscope="" itemtype="http://schema.org/Place">
					<div itemprop="name" id="nameregion">
						<xsl:value-of select="Region"/>
					</div>
				</div>
		</xsl:for-each>
		
		</div>
	
	</html>
	
</xsl:template>

<!--
<xsl:template name="seq">
   <xsl:param name="idx"/>
	<xsl:choose>
		 <xsl:when test="not(count($list_nodes) + 1 = $pos)">
</xsl:template>	-->
	

<xsl:template name="somme">
   <xsl:param name="list_nodes"/>
   <xsl:param name="sub_result"/>
   <xsl:param name="pos"/>
   <xsl:choose>
      <xsl:when test="not(count($list_nodes) + 1 = $pos)">
      		<xsl:variable name="res">
      			<xsl:value-of select="number(($list_nodes[$pos]/RatingValue div ($list_nodes[$pos]/RatingScheme/@best - $list_nodes[$pos]/RatingScheme/@worst + 1)))" /> 
      		</xsl:variable>  		
    		<xsl:call-template name="somme">
            <xsl:with-param name="list_nodes" select="$list_nodes"/>
            <xsl:with-param name="sub_result" select="$sub_result + $res"/>
            <xsl:with-param name="pos" select="$pos + 1"/>
         </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
         <xsl:value-of select="format-number($sub_result div count($list_nodes) * 5, '##.00')"/>
     </xsl:otherwise>
  </xsl:choose>
</xsl:template>


</xsl:stylesheet>