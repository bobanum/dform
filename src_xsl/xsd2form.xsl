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
	<xsl:output method="html" indent="yes"/>
	<xsl:variable name="lang" select="'fr'"/>
	<xsl:template match="xs:schema">
		<xsl:comment>
			<xsl:text>xs:schema</xsl:text>
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
		<form>
			<xsl:apply-templates select="xs:element"/>
		</form>
	</xsl:template>
	<xsl:template match="xs:complexType">
		<xsl:param name="name" select="@name|../@name"/>
		<xsl:comment>
			<xsl:text>xs:complexType</xsl:text>
		</xsl:comment>
		<div class="{local-name()} {$name}">
			<xsl:apply-templates select="." mode="attributes"/>
			<xsl:apply-templates select="." mode="contents"/>
		</div>
	</xsl:template>
	<xsl:template match="xs:complexType" mode="attributes">
		<xsl:param name="name" select="@name|../@name"/>
		<xsl:comment>
			<xsl:text>match="xs:complexType" mode="attributes"</xsl:text>
		</xsl:comment>
		<div class="attributes">
			<xsl:apply-templates select="./xs:attribute|xs:simpleContent/xs:extension/xs:attribute"/>
		</div>
	</xsl:template>
	<xsl:template match="xs:complexType" mode="contents">
		<xsl:param name="name" select="@name|../@name"/>
		<xsl:comment>
			<xsl:text>match="xs:complexType" mode="contents"</xsl:text>
		</xsl:comment>
		<div class="elements">
			<xsl:apply-templates select="*[not(self::xs:attribute)]" mode="minmax"/>
		</div>
	</xsl:template>
	<xsl:template match="xs:complexType[xs:simpleContent/xs:extension]">
		<xsl:param name="name" select="@name|../@name"/>
		<xsl:comment>
			<xsl:text>xs:complexType[xs:simpleContent/xs:extension]</xsl:text>
		</xsl:comment>
		<div class="{local-name()} {$name}">
			<xsl:apply-templates select="." mode="attributes"/>
			<div class="elements yyy">
				<xsl:apply-templates select="*[not(self::xs:attribute)]" mode="minmax"/>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="*" mode="attributes">
		<xsl:comment>
			<xsl:text>match="*" mode="attributes"</xsl:text>
			<xsl:value-of select="concat('{',name(),'}')"/>
		</xsl:comment>
		<div class="attributes">
			<xsl:value-of select="count(xs:attributes)"/>
			<xsl:apply-templates select="xs:attribute"/>
		</div>
	</xsl:template>
	<xsl:template match="xs:simpleContent">
		<xsl:comment>
			<xsl:text>xs:simpleContent</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="xs:extension[@base='xs:string']">
		<xsl:comment>
			<xsl:text>xs:extension[@base='xs:string']</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<div class="content">
			<label for="contenu">Contenu:</label>
			<input type="text" name="contenu"/>
		</div>
	</xsl:template>
	<xsl:template match="*[(not(@minOccurs) or @minOccurs=1) and (not(@maxOccurs) or @maxOccurs=1)]" mode="minmax">
		<xsl:comment>
			<xsl:text>mode="minmax"</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<xsl:apply-templates select="."/>
	</xsl:template>
	<xsl:template match="xs:sequence|xs:choice|xs:all|xs:group">
		<xsl:comment>
			<xsl:text>xs:sequence|xs:choice|xs:all|xs:group</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<xsl:apply-templates mode="minmax"/>
	</xsl:template>
</xsl:stylesheet>
