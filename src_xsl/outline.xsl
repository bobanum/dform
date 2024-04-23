<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:df="https://bobanum.github.io/dform"
	xmlns="http://www.w3.org/1999/xhtml"
	version="1.0">
	<xsl:template name="outline" mode="outline">
		<div id="outline">
			<ul>
				<xsl:apply-templates select="xs:element" mode="outline" />
			</ul>
		</div>
	</xsl:template>
	<xsl:template match="xs:annotation" mode="outline">
	</xsl:template>
	<xsl:template match="*" mode="outline">
		<xsl:param name="xpath" />
		<xsl:param name="name" />
		<li>
			<div>
				<xsl:value-of select="'@name'" /> : <xsl:value-of select="@name" />
			</div>
			<div>
				<xsl:value-of select="'@type'" /> : <xsl:value-of select="@type" />
			</div>
			<div>
				<xsl:value-of select="'name()'" /> : <xsl:value-of select="name()" />
			</div>
			<div>
				<xsl:value-of select="'$name'" /> : <xsl:value-of select="$name" />

			</div>
		</li>
	</xsl:template>
	<!-- Matches any element having a type defined elsewhere in the stylesheet -->
	<xsl:template match="xs:element[//*[@name = current()/@type]]" mode="outline">
		<xsl:param name="xpath" />
		<xsl:param name="name" select="@name" />
		<xsl:apply-templates select="//*[@name = current()/@type]" mode="outline">
			<xsl:with-param name="xpath" select="$xpath" />
			<xsl:with-param name="ref" select="current()" />
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="xs:complexType[@name]" mode="outline">
		<xsl:param name="xpath" />
		<xsl:param name="ref" select="." />
		<li>
			<xsl:call-template name="add-button">
				<xsl:with-param name="xpath" select="$xpath" />
				<xsl:with-param name="name" select="$ref/@name" />
			</xsl:call-template>
			<ul>
				<xsl:apply-templates mode="outline">
					<xsl:with-param name="xpath" select="concat($xpath, '/', $ref/@name)" />
				</xsl:apply-templates>
			</ul>
		</li>
	</xsl:template>
	<xsl:template match="xs:simpleContent" mode="outline">
		<xsl:param name="xpath" />
		<xsl:param name="ref" select="." />
		<xsl:apply-templates mode="outline">
			<xsl:with-param name="xpath" select="$xpath" />
			<xsl:with-param name="ref" select="$ref" />
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="xs:simpleContent/xs:extension" mode="outline">
		<xsl:param name="xpath" />
		<xsl:param name="ref" select="." />
		<ul>
			<xsl:apply-templates mode="outline">
				<xsl:with-param name="xpath" select="$xpath" />
				<xsl:with-param name="ref" select="$ref" />
			</xsl:apply-templates>
		</ul>
	</xsl:template>
	<xsl:template match="xs:sequence" mode="outline">
		<xsl:param name="xpath" />
		<xsl:param name="name" select="@name" />
		<xsl:apply-templates mode="outline">
			<xsl:with-param name="xpath" select="$xpath" />
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="xs:attribute" mode="outline">
		<xsl:param name="xpath" />
		<xsl:param name="name" select="@name" />
		<li>
			<xsl:call-template name="add-button">
				<xsl:with-param name="xpath" select="$xpath" />
				<xsl:with-param name="name" select="$name" />
			</xsl:call-template>
		</li>
	</xsl:template>
	<xsl:template match="xs:element" mode="outline">
		<xsl:param name="xpath" />
		<xsl:param name="name" select="@name" />
		<li>
			<xsl:call-template name="add-button">
				<xsl:with-param name="xpath" select="$xpath" />
				<xsl:with-param name="name" select="$name" />
			</xsl:call-template>
		</li>
	</xsl:template>
	<!-- *************************************** -->
	<xsl:template name="add-button" mode="outline">
		<xsl:param name="xpath" />
		<xsl:param name="ref" select="." />
		<xsl:param name="name" select="$ref/@name" />
		<xsl:param name="fn" select="'show'" />
		<xsl:variable name="at">
			<xsl:if test="local-name($ref)='attribute'">@</xsl:if>
		</xsl:variable>

		<button data-xpath="{$xpath}/{$at}{$name}" onclick="Form.{$fn}.apply(this, arguments)">
			<xsl:call-template name="documentation" />
		</button>
	</xsl:template>
	<!-- +++++++++++++++++++++++++++++++++++++++ -->
</xsl:stylesheet>