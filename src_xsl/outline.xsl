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
			<xsl:with-param name="name" select="$name" />
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
			<xsl:apply-templates mode="outline">
				<xsl:with-param name="xpath" select="concat($xpath, '/', $ref/@name)" />
			</xsl:apply-templates>

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
		<xsl:apply-templates select="//*[@name = current()/@base]" mode="outline">
			<xsl:with-param name="xpath" select="$xpath" />
			<xsl:with-param name="name" select="$name" />
			<xsl:with-param name="ref" select="$ref" />
		</xsl:apply-templates>
		<xsl:for-each select="xs:attribute">
			<xsl:value-of select="@name" />

		</xsl:for-each>
		<!-- <xsl:apply-templates select="xs:attribute" mode="outline">
			<xsl:with-param name="xpath" select="$xpath" />
			<xsl:with-param name="name" select="$name" />
			<xsl:with-param name="ref" select="$ref" />
		</xsl:apply-templates>
	-->
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
			attribute
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

		<xsl:comment>
			<xsl:text>name="add-button" mode="outline"</xsl:text>
		</xsl:comment>
		<button data-xpath="{$xpath}/{$name}" onclick="Form.{$fn}.apply(this, arguments)">
			<xsl:call-template name="documentation" />
		</button>
	</xsl:template>
	<!-- +++++++++++++++++++++++++++++++++++++++ -->
	<xsl:template match="xs:attribute" mode="zzzoutline">
		<xsl:param name="xpath" />	
		<xsl:comment>
			<xsl:text>match="xs:attribute" mode="outline"</xsl:text>
		</xsl:comment> attribute <li>
			<button data-xpath="{$xpath}/@{@name}" onclick="Form.show.apply(this, arguments)">
				<xsl:call-template name="documentation" />
			</button>
		</li>
	</xsl:template>
	<xsl:template match="xs:complexType" mode="zzzoutline">
		<xsl:param name="instance" select="." />
		<xsl:param name="xpath" select="31" />
		<xsl:variable name="current-xpath" select="concat($xpath, '/',32, '/', $instance/@name)" />
		<xsl:comment>
			<xsl:text>match="xs:complexType" mode="outline</xsl:text>
		</xsl:comment>
		<li>
			<button data-xpath="{concat($xpath, '/',38, '/', $instance/@name)}" onclick="Form.show.apply(this, arguments)">
				<xsl:call-template name="documentation" />
			</button>
		</li>
		<xsl:apply-templates select="./xs:attribute|xs:simpleContent/xs:extension/xs:attribute" mode="outline">
			<xsl:with-param name="xpath" select="concat($xpath, '/',44, '/', $instance/@name)" />
		</xsl:apply-templates>
		<xsl:apply-templates select="./xs:sequence" mode="outline">
			<xsl:with-param name="xpath" select="concat($xpath, '/',50, '/', $instance/@name)" />
			<xsl:with-param name="test" select="51" />

		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="xs:sequence" mode="zzzoutline">
		<xsl:param name="xpath" select="56" />
		<xsl:param name="test" select="59" />
		<xsl:comment>
			<xsl:text>match="xs:element" mode="outline"</xsl:text>
		</xsl:comment>
	</xsl:template>
	<xsl:template match="xs:element" mode="zzzoutline">
		<xsl:param name="xpath" select="56" />
		<xsl:param name="test" select="59" />
		<xsl:comment>
			<xsl:text>match="xs:element" mode="outline"</xsl:text>
		</xsl:comment>
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