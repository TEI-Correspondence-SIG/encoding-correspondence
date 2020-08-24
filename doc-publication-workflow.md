# Publication workflow 

Open the project (.xpr) in Oxygen XML Editor

1. Last file updates
1.1 Execute transformation tei-paragraph-numbering.xslt
1.2 Create URN via DNB
1.3 Create Zotero entry 
1.4 No examples in <p>?
1.5 Copy images in images and in html/img !!
1.6 Add author, if necessary, to the author index (author.xml)
1.7 Update index.xml 
1.8 Updates in xsl/correspondence-manual.xsl:
1.8.1 Add page to main nav menu 
1.8.2 Adapt template Public Peer Review Deadline, if necessary

2. Checks
2.1 File name correct?
2.2 Value in TEI/@xml:id matches file name?
2.3 Check URN, URL and Zotero URL (esp. the last, cut collection out)
2.4 Authors available - and also @key?

3. Print
3.1 Execute transformation correspondence-manual.xslt on folder "tei-xml"
3.2 Check HTML output
3.3 Upload to server
3.4 Push to GitHub