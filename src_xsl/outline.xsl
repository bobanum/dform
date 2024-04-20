<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:df="https://bobanum.github.io/dform"
	xmlns="http://www.w3.org/1999/xhtml">
	<xsl:template name="outline">
		<xsl:comment>
			<xsl:text>name="outline" ici</xsl:text>
		</xsl:comment>
		<div id="outline">
			<ul>
				<h1>QUOI!!</h1>
				<xsl:apply-templates select="xs:element" mode="outline" />
			</ul>
		</div>
	</xsl:template>
	<xsl:template match="xs:attribute[not(@use='required')]" mode="outline">
		<xsl:param name="xpath" />	
		<xsl:comment>
			<xsl:text>match="xs:attribute" mode="outline"</xsl:text>
		</xsl:comment>
		criss
		<li>
			<button data-xpath="{$xpath}/@{@name}" onclick="Form.show.apply(this, arguments)">
				<xsl:call-template name="documentation" />
			</button>
		</li>
	</xsl:template>
	<xsl:template match="xs:complexType" mode="outline">
		<xsl:param name="instance" select="." />
		<xsl:param name="xpath" select="31" />
		<xsl:variable name="current-xpath" select="concat($xpath, '/',32, '/', $instance/@name)" />
		<xsl:comment>
			<xsl:text>match="xs:complexType" mode="outline</xsl:text>
		</xsl:comment>
		tour
		<li>
			<button data-xpath="{concat($xpath, '/',38, '/', $instance/@name)}" onclick="Form.show.apply(this, arguments)">
				<xsl:call-template name="documentation" />
			</button>
		</li>
		ici
		<xsl:apply-templates select="./xs:attribute|xs:simpleContent/xs:extension/xs:attribute" mode="outline">
			<xsl:with-param name="xpath" select="concat($xpath, '/',44, '/', $instance/@name)" />
		</xsl:apply-templates>
		milieu
		""<xsl:value-of select="concat($xpath, '/',47, '/', $instance/@name)" />""
		<xsl:apply-templates select="*[not(self::xs:attribute)]" mode="outline">
			<xsl:with-param name="xpath" select="concat($xpath, '/',50, '/', $instance/@name)" />
			<xsl:with-param name="test" select="51" />

		</xsl:apply-templates>
		la

	</xsl:template>
	<xsl:template match="xs:element" mode="outline">
		<xsl:param name="xpath" select="56" />
		<xsl:param name="test" select="59" />
		<xsl:comment>
			<xsl:text>match="xs:element" mode="outline"</xsl:text>
		</xsl:comment>
		calvert
		XPATH<xsl:value-of select="$xpath" />xpath
		TEST<xsl:value-of select="$test" />test
		<li>
			<button data-xpath="{$xpath}//{@name}" onclick="Form.show.apply(this, arguments)">
				<xsl:call-template name="documentation" />
			</button>
			<xsl:if test="//xs:complexType[@name = current()/@type]">
				<ul>
					<xsl:apply-templates select="//xs:complexType[@name = current()/@type]" mode="outline">
						<xsl:with-param name="instance" select="." />
						<xsl:with-param name="xpath" select="concat($xpath, '/',69)" />
					</xsl:apply-templates>
				</ul>
			</xsl:if>
		</li>
	</xsl:template>
</xsl:stylesheet>