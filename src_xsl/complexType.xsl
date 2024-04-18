<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:df="https://bobanum.github.io/dform"
	xmlns="http://www.w3.org/1999/xhtml">
	<xsl:template match="xs:complexType">
		<xsl:param name="instance" select="." />
		<xsl:param name="xpath" />
		<xsl:variable name="current-xpath" select="concat($xpath, '/', $instance/@name)" />
		<xsl:comment>
			<xsl:text>match="xs:complexType"</xsl:text>
		</xsl:comment>
		<fieldset class="{local-name()} {$instance/@name}" data-xpath="{$current-xpath}">
			<div class="attributes">
				<xsl:apply-templates select="./xs:attribute|xs:simpleContent/xs:extension/xs:attribute">
					<xsl:with-param name="xpath" select="$current-xpath" />
				</xsl:apply-templates>
			</div>
			<div class="elements">
				<xsl:apply-templates select="*[not(self::xs:attribute)]" mode="minmax">
					<xsl:with-param name="xpath" select="$current-xpath" />
				</xsl:apply-templates>
			</div>
		</fieldset>
	</xsl:template>
	<xsl:template match="xs:complexType[xs:simpleContent/xs:extension]">
		<xsl:param name="instance" select="." />
		<xsl:comment>
			<xsl:text>match="xs:complexType[xs:simpleContent/xs:extension]"</xsl:text>
		</xsl:comment>
		<div class="{local-name()} {$instance/@name}">
			<xsl:apply-templates select="." mode="attributes" />
			<div class="elements">
				<xsl:apply-templates select="*[not(self::xs:attribute)]" mode="minmax" />
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>