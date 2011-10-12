<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />


<xsl:param name="sha1" select="''" />


<xsl:template match="/">
	<xsl:apply-templates select="data/gist-by-id/entry" />
</xsl:template>


<xsl:template match="gist-by-id/entry">
	<p>
		So this is gist <a href="http://gist.github.com/{$gist-id}">
			#<xsl:value-of select="$gist-id" />
		</a>

		<xsl:if test="$sha1">
			@ 
			<a href="{$root}/view/{$gist-id}/{$sha1}">
				<xsl:value-of select="$sha1" />
			</a>
		</xsl:if>

		<br />
		You can <a href="{$root}/process/{$gist-id}/{$sha1}">process it</a> anytime
	</p>

	<p>It consists of the following files</p>
	
	<ul>
		<xsl:apply-templates select="/data/files-by-revision/entry" />
	</ul>



	<xsl:variable name="revisions" select="count(revisions-list/revision)"></xsl:variable>


	<form action="" method="post">


		<xsl:if test="$revisions = 1">
			<p>
				Now I want you to edit the xml file.
			</p>
		
			<textarea name="files[master.xml]">
				<xsl:value-of select="/data/files-by-revision/entry[filename/text() = 'master.xml']/content" />
			</textarea>
		</xsl:if>


		<xsl:if test="$revisions = 2">
			<p>
				Hey! you did it! Why don't you add another file?
			</p>

			<label>Filename</label>
			<input type="text" name="new-file[filename]" value="new-file.xml" />

			<div>
				<textarea name="new-file[content]">content of the new file</textarea>
			</div>
		</xsl:if>


		<xsl:if test="$revisions = 3">
			<xsl:variable name="fn" select="/data/files-by-revision/entry[last()]/filename"></xsl:variable>

			<p>
				That was easy... Now try to rename file <xsl:value-of select="$fn" />
			</p>

			<label>New filename</label>
			<input type="text" name="rename[{$fn}]" value="{$fn}" />
			
			<p>
				Remember to always send the data too, otherwise the file will be deleted!
			</p>
			
			<textarea name="files[{$fn}]">
				<xsl:value-of select="/data/files-by-revision/entry[last()]/content" />
			</textarea>
		</xsl:if>


		<xsl:if test="$revisions = 4">
			<xsl:variable name="fn" select="/data/files-by-revision/entry[last()]/filename"></xsl:variable>

			<p>
				Ok we're almost done. Now delete the file <xsl:value-of select="$fn" /> (just submit this form).
			</p>
			
			<input type="hidden" name="deletes[{$fn}]" value="Delete {$fn}" />
		</xsl:if>


		<xsl:if test="$revisions &gt;= 5">
			<p>
				Awesome mate! Feel free to <a href="{$root}/new">create a new gist</a>. These are the gist revisions: 
			</p>

			<ul>
				<xsl:apply-templates select="revisions-list/revision" />
			</ul>
		</xsl:if>




		<xsl:if test="$revisions &lt; 5">
			<input type="submit" name="action[update-gist]"/>
		</xsl:if>


	</form>
</xsl:template>



<xsl:template match="files-by-revision/entry">
	<li>
		<a href="http://gist.github.com/{$gist-id}/{$sha1}#file_{filename}">
			<xsl:value-of select="filename" />
		</a>
	</li>
</xsl:template>


<xsl:template match="revisions-list/revision">
	<li>
		<a href="{$root}/view/{$gist-id}/{@version}">
			<xsl:value-of select="@version" />
		</a> 
		( <xsl:value-of select="changes/@total" /> changes)
	</li>
</xsl:template>

</xsl:stylesheet>
