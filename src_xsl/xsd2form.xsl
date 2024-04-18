<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:df="https://bobanum.github.io/dform"
	xmlns="http://www.w3.org/1999/xhtml">
	<xsl:import href="src_xsl/utils.xsl"/>
	<xsl:import href="src_xsl/attributes.xsl"/>
	<xsl:import href="src_xsl/elements.xsl"/>
	<xsl:import href="src_xsl/restrictions.xsl"/>
	<xsl:import href="src_xsl/complexType.xsl"/>
	<xsl:output method="html" indent="yes"/>
	<xsl:variable name="lang" select="'fr'"/>
	<xsl:template match="xs:schema">
		<xsl:comment>
			<xsl:text>match="xs:schema" - </xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<div id="templates">
			<xsl:for-each select="//node()[not((not(@minOccurs) or @minOccurs='1') and (not(@maxOccurs) or @maxOccurs&lt;='1'))]">
				<div id="{generate-id(.)}">
					<xsl:apply-templates select="."/>
				</div>
			</xsl:for-each>
			<!-- <xsl:apply-templates select="//node()[not((not(@minOccurs) or @minOccurs='1') and (not(@maxOccurs) or @maxOccurs&lt;='1'))]" mode="template"/> -->
		</div>
		<form onsubmit="return Form.submit.apply(this, arguments)" action="" method="post">
			<div><button>Submit</button></div>
			<xsl:apply-templates select="xs:element"/>
			<div style="grid-row:3;grid-column:row"><button>Submit</button></div>
		</form>
	</xsl:template>
	<xsl:template match="xs:simpleContent">
		<xsl:comment>
			<xsl:text>match="xs:simpleContent" - </xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="xs:extension[@base='xs:string']">
		<xsl:comment>
			<xsl:text>match="xs:extension[@base='xs:string']" - </xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<div class="content">
			<label for="contenu">Contenu:</label>
			<input type="text" name="contenu"/>
		</div>
	</xsl:template>
	<xsl:template match="xs:element[(not(@minOccurs) or @minOccurs=1) and (not(@maxOccurs) or @maxOccurs=1)]" mode="minmax">
		<xsl:param name="xpath" />	
		<xsl:comment>
			<xsl:text>match="*[(not(@minOccurs) or @minOccurs=1) and (not(@maxOccurs) or @maxOccurs=1)]" mode="minmax" - </xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<xsl:apply-templates select=".">
			<xsl:with-param name="xpath" select="concat($xpath, '/', @name)"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="xs:sequence|xs:choice|xs:all|xs:group">
		<xsl:param name="xpath" />	
		<xsl:comment>
			<xsl:text>match="xs:sequence|xs:choice|xs:all|xs:group" - </xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<xsl:apply-templates mode="minmax">
			<xsl:with-param name="xpath" select="$xpath"/>
		</xsl:apply-templates>
	</xsl:template>
</xsl:stylesheet>
