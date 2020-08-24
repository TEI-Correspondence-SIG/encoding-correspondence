# Publication workflow 

Open the project (.xpr) in Oxygen XML Editor

## Last file updates

1. Execute transformation tei-paragraph-numbering.xslt
2. Create URN via DNB
3. Create Zotero entry 
4. No examples in <p>?
5. Copy images in images and in html/img !!
6. Add author, if necessary, to the author index (author.xml)
7. Update index.xml 
8. Updates in xsl/correspondence-manual.xsl:
	1. Add page to main nav menu 
	2. Adapt template Public Peer Review Deadline, if necessary

## Checks

1. File name correct?
2. Value in TEI/@xml:id matches file name?
3. Check URN, URL and Zotero URL (esp. the last, cut collection out)
4. Authors available - and also @key?

## Generate HTML 

1. Execute transformation correspondence-manual.xslt on folder "tei-xml"
2. Check HTML output
3. Upload to server
4. Commit and push changes to GitHub