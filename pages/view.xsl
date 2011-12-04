<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/xpathr.xsl" />

<xsl:param name="url-f1" select="'master.xml'" />
<xsl:param name="url-f2" select="'master.xsl'" />

<!-- my revisions -->

<xsl:template name="xml-editor">
	<xsl:apply-templates select="files-by-revision/entry[filename/text() = $url-f1]" mode="view-xml" />
</xsl:template>

<xsl:template name="xslt-editor">
	<xsl:apply-templates select="files-by-revision/entry[filename/text() = $url-f2]" mode="view-xslt" />
</xsl:template>

<xsl:template match="files-by-revision/entry" mode="view-xml">
	<div class="code stretch xml">
		<xsl:call-template name="editor-textarea">
			<xsl:with-param name="label" select="'XML'" />
			<xsl:with-param name="type" select="'xml'" />
		</xsl:call-template>
	</div>
</xsl:template>

<xsl:template match="files-by-revision/entry" mode="view-xslt">
	<div class="code stretch xslt">
		<xsl:call-template name="editor-textarea">
			<xsl:with-param name="label" select="'XSLT'" />
			<xsl:with-param name="type" select="'xslt'" />
		</xsl:call-template>
	</div>
</xsl:template>

<xsl:template name="editor-textarea">
	<xsl:param name="label" />
	<xsl:param name="type" />
	<xsl:choose>
		<xsl:when test="$owner">
			<xsl:variable name="post" 
			select="/data/events/update-gist/data/item[@key = 'files']/item[@key = current()/filename]"></xsl:variable>

			<xsl:variable name="value">
				<xsl:if test="$post"><xsl:value-of select="$post" /></xsl:if>
				<xsl:if test="not($post)"><xsl:value-of select="content" /></xsl:if>
			</xsl:variable>
			<div class="label"><p><strong><xsl:value-of select="filename" /></strong></p></div>
			<textarea id="{$type}" name="files[{filename}]" cols="50" rows="20"><xsl:value-of select="$value" /></textarea>
		</xsl:when>
		<xsl:otherwise>
			<div class="label"><p><strong>XSLT</strong></p></div>
			<textarea id="{$type}" name="files[{filename}]" cols="50" rows="20"><xsl:value-of select="content" /></textarea>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:variable name="owner" select="$github-user = /data/gist-by-id/entry/user"></xsl:variable>

<xsl:template name="actions">
	<xsl:choose>
		<xsl:when test="$owner">
			<input type="submit" name="action[update-gist]" value="Save" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="$github-user">
				<input type="submit" name="action[fork-gist]" value="Fork" />
			</xsl:if>

			<xsl:if test="$github-user = ''">
				<a href="{$root}/authenticate">Login</a> to fork
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- /end my revisions -->

<xsl:template match="data">
	<xsl:apply-templates select="gist-by-id/entry" />
</xsl:template>


<xsl:template match="gist-by-id/entry">
	<form id="main" method="post" action="">
		<div id="head">
			<h2>
				gist #<xsl:value-of select="$gist-id" />
				<xsl:if test="$sha1">
					@ 
					<a href="{$root}/view/{$gist-id}/{$sha1}">
						<xsl:value-of select="substring($sha1, 1, 6)" />
					</a>
				</xsl:if>
			</h2>

			<div id="actions">
				<a href="{$root}/process/{$gist-id}/{$sha1}" class="process">Process</a>

				<xsl:choose>
					<xsl:when test="$owner">
						<input type="submit" name="action[update-gist]" value="Save" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="$github-user">
							<input type="submit" name="action[fork-gist]" value="Fork" />
						</xsl:if>

						<xsl:if test="$github-user = ''">
							<a href="{$root}/authenticate">Login</a> to fork
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</div>

			<xsl:apply-templates select="/data/events/update-gist" />
		</div>

		<div id="files">
			<xsl:apply-templates select="/data/files-by-revision/entry[filename/text() = $url-f1]" />
			<xsl:apply-templates select="/data/files-by-revision/entry[filename/text() = $url-f2]" />
		</div>

		<div id="meta">
			<div id="user">
				<img src="https://a248.e.akamai.net/assets.github.com/images/gravatars/gravatar-140.png" />
				<a href="https://gist.github.com/{user}">
					<xsl:value-of select="user" />
				</a>
			</div>

			<div id="revisions">
				<h4>Revisions</h4>
				<ul>
					<xsl:apply-templates select="revisions-list/revision" />
				</ul>
			</div>

			<xsl:if test="forks-list/fork">
				<div id="forks">
					<h4>Forks</h4>
					<ul>
						<xsl:apply-templates select="forks-list/fork" />
					</ul>
				</div>
			</xsl:if>
		</div>

	</form>
</xsl:template>


<xsl:template match="files-by-revision/entry">
	<div>
		<div class="meta">
			<h5><xsl:value-of select="filename" /></h5>

			<xsl:if test="count(/data/files-by-revision/entry) &gt; 2">
				<ul>
					<xsl:apply-templates select="/data/files-by-revision/entry" mode="list">
						<xsl:with-param name="current" select="filename" />
					</xsl:apply-templates>
				</ul>
			</xsl:if>
		</div>

		<xsl:choose>
			<xsl:when test="$owner">
				<xsl:variable name="post" 
				select="/data/events/update-gist/data/item[@key = 'files']/item[@key = current()/filename]"></xsl:variable>

				<xsl:variable name="value">
					<xsl:if test="$post"><xsl:value-of select="$post" /></xsl:if>
					<xsl:if test="not($post)"><xsl:value-of select="content" /></xsl:if>
				</xsl:variable>

				<textarea name="files[{filename}]"><xsl:value-of select="$value" /></textarea>
			</xsl:when>
			<xsl:otherwise>
				<pre><xsl:value-of select="content" /></pre>
			</xsl:otherwise>
		</xsl:choose>
	</div>
</xsl:template>


<xsl:template match="files-by-revision/entry" mode="list">
	<xsl:param name="current" />

	<xsl:if test="filename != $url-f1 and filename != $url-f2">
		<li>
			<a>
				<xsl:attribute name="href">
					<xsl:variable name="s1">
						<xsl:if test="$current = $url-f1">f1</xsl:if>
						<xsl:if test="$current = $url-f2">f2</xsl:if>
					</xsl:variable>

					<xsl:variable name="s2">
						<xsl:if test="$current = $url-f1">f2</xsl:if>
						<xsl:if test="$current = $url-f2">f1</xsl:if>
					</xsl:variable>

					<xsl:variable name="other">
						<xsl:if test="$current = $url-f1">
							<xsl:value-of select="$url-f2" />
						</xsl:if>
						<xsl:if test="$current = $url-f2">
							<xsl:value-of select="$url-f1" />
						</xsl:if>
					</xsl:variable>					

					<xsl:value-of select="concat($root, '/view/', $gist-id, '/', $sha1, '?', $s1, '=', filename, '&amp;', $s2, '=', $other)" />

				</xsl:attribute>


				<xsl:value-of select="filename" />
			</a>
		</li>
	</xsl:if>
</xsl:template>



<xsl:template match="revisions-list/revision" >
	<li>
		<xsl:if test="$sha1 = @version or ($sha1 = '' and position() = 1)">
			<xsl:attribute name="class">current</xsl:attribute>
		</xsl:if>

		<a href="{$root}/view/{$gist-id}/{@version}">
			<xsl:value-of select="substring(@version, 1, 6)" />
		</a>
	</li>
</xsl:template>

<xsl:template match="forks-list/fork">
	<li>
		<a href="{$root}/view/{@id}">
			<xsl:value-of select="@user" />
		</a>
	</li>
</xsl:template>



<xsl:template match="events/update-gist">
	<div class="error">
		<xsl:value-of select="message" />
	</div>
</xsl:template>

</xsl:stylesheet>
