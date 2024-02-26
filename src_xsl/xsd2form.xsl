<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns="http://www.w3.org/1999/xhtml">
	<xsl:import href="src_xsl/utils.xsl"/>
	<xsl:import href="src_xsl/attributes.xsl"/>
	<xsl:import href="src_xsl/elements.xsl"/>
	<xsl:import href="src_xsl/restrictions.xsl"/>
	<xsl:output method="html" indent="yes"/>
	<xsl:variable name="lang" select="'fr'"/>
	<xsl:template match="/zzz">
		<html>
			<head>
				<title>Form Generation</title>
			</head>
			<body>
				<h2>Form Generated from XSD</h2>
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="xs:schema">
		<form>
			<xsl:apply-templates select="xs:element"/>
		</form>
	</xsl:template>
	<xsl:template match="xs:complexType">
		<xsl:apply-templates select="xs:attribute"/>
		<xsl:apply-templates select="*[not(self::xs:attribute)]"/>

	</xsl:template>
	<xsl:template match="xs:simpleContent">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="xs:extension[@base='xs:string']">
		<xsl:apply-templates/>
		<div>
			<label for="contenu">Contenu:</label>
			<input type="text" name="contenu"/>
		</div>
	</xsl:template>
	<xsl:template match="xs:sequence">
		<xsl:for-each select="xs:element">
		<xsl:call-template name="minmax"/>
		</xsl:for-each>
		<!-- <xsl:apply-templates/> -->
	</xsl:template>

</xsl:stylesheet>
