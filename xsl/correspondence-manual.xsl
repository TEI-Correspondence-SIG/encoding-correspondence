<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei-eg="http://www.tei-c.org/ns/Examples"
    xmlns:output="http://www.w3.org/2010/xslt-xquery-serialization"
    xmlns:ec="https://encoding-correspondence.bbaw.de"
    xmlns:java-urldecode="java.net.URLDecoder"
    exclude-result-prefixes="xs tei ec tei-eg java-urldecode output"
    version="3.0">
    
    <xsl:output method="html" encoding="UTF-8" version="5"/>
    
    <xsl:param name="page"/>
    <xsl:param name="tei-xml-path"/>
    
    
    <xsl:variable name="output">
        <output:serialization-parameters>
            <output:method value="xml"/>
        </output:serialization-parameters>
    </xsl:variable>
        
    <xsl:function name="ec:seperator">
        <xsl:param name="node"/>
        <xsl:param name="position"/>
        <xsl:choose>
            <xsl:when test="$position=1">
                <xsl:value-of select="$node"/>
            </xsl:when>
            <xsl:otherwise><xsl:text>, </xsl:text><xsl:value-of select="$node"/></xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="ec:zotero-api-url">
        <xsl:param name="url"/>
        <xsl:variable name="replace-base-url">
            <xsl:value-of select="replace($url, 'https://www.zotero.org/', 'https://api.zotero.org/')"/>
        </xsl:variable>
        <xsl:variable name="delete-group-name">
            <xsl:value-of select="replace($replace-base-url, 'encoding_correspondence/', '')"/>
        </xsl:variable>
        <xsl:variable name="delete-itemKey">
            <xsl:value-of select="replace($delete-group-name, 'itemKey/', '')"/>
        </xsl:variable>
        <xsl:variable name="append-format">
            <xsl:value-of select="concat($delete-itemKey, '?format=coins')"/>
        </xsl:variable>
        <xsl:value-of select="$append-format"/>
    </xsl:function>
    
    <xsl:template match="/">
        <html lang="en">
            <head>
                <!-- Required meta tags -->
                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
                        
                <!-- Bootstrap CSS -->
                <link rel="stylesheet" href="libs/bootstrap-4.3.1/css/bootstrap.min.css" />
                <link href="libs/fontawesome/css/all.css" rel="stylesheet" /> 
                <link href="libs/prism/prism.css" rel="stylesheet" />
                
                <link href="css/ec.css" rel="stylesheet"/>
                <xsl:if test="$page='index'">
                  <style>
                      .jumbotron {
                        background-color: #e0e0e; 
                      }
                    </style>
                </xsl:if>
                
                <xsl:choose>
                    <xsl:when test="$page='index'">
                        <title>Encoding Correspondence. A Manual for encoding letters and postcards in TEI-XML and DTABf</title>
                    </xsl:when>
                    <xsl:otherwise>
                        <title>Encoding Correspondence: <xsl:value-of select="//tei:titleStmt/tei:title"/></title>        
                    </xsl:otherwise>
                </xsl:choose>
                
                <!-- Matomo -->
                <script type="text/javascript">
                    var _paq = window._paq || [];
                    _paq.push(["setVisitorCookieTimeout", "604800"]);
                    _paq.push(["setSessionCookieTimeout", "0"]);
                    /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
                    _paq.push(['trackPageView']);
                    _paq.push(['enableLinkTracking']);
                    (function() {
                    var u="https://piwik.bbaw.de/";
                    _paq.push(['setTrackerUrl', u+'matomo.php']);
                    _paq.push(['setSiteId', '53']);
                    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
                    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
                    })();
                </script>
                <noscript><p><img src="https://piwik.bbaw.de/matomo.php?idsite=53&amp;rec=1" style="border:0;" alt="" /></p></noscript>
                <!-- End Matomo Code -->
            </head>
            <body>
                <nav class="navbar navbar-expand-lg navbar-dark">
                    <div class="container">
                        <a class="navbar-brand" href="index.html" title="To the homepage" alt="Go to home page of Encoding Correspondence">Encoding Correspondence</a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbar" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbar">
                            <ul class="navbar-nav">
                                <li class="nav-item">
                                    <a class="nav-link" href="introduction.html">Introduction</a>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="dropdown07" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Articles</a>
                                    <div class="dropdown-menu" aria-labelledby="dropdown07">
                                        <a class="dropdown-item" href="addresses.html">Addresses</a>
                                        <a class="dropdown-item" href="CMIF.html">Correspondence Metadata Interchange Format</a>
                                        <a class="dropdown-item" href="openers-closers.html">Letter Openers and Closers</a>
                                        <a class="dropdown-item" href="stamps-seals-postmarks.html">Postage Stamps, Seals, and Postmarks</a>
                                        <a class="dropdown-item" href="postscripts.html">Postscripts of Letters</a>
                                        <a class="dropdown-item" href="pre-printed-parts.html">Pre-printed parts: Letterheads and forms</a>
                                    </div>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="authors.html">Authors <span class="sr-only">(current)</span></a>
                                </li>
                            </ul>
                        </div>                    
                    </div>
                </nav>
                    <xsl:choose>
                        <xsl:when test="$page='index'">
                            <xsl:call-template name="homepage"/>
                        </xsl:when>
                        <xsl:when test="$page='authors'">
                            <xsl:call-template name="authors"/>
                        </xsl:when>
                        <xsl:when test="$page='legal'">
                            <xsl:call-template name="legal"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="article"/>
                        </xsl:otherwise>
                    </xsl:choose>
                <footer class="d-print-none">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-4">
                                <h4>Publication</h4>    
                                <p>Encoding Correspondence. A Manual for Encoding Letters and Postcards in TEI-XML and DTABf. Edited by Stefan Dumont, Susanne Haaf, and Sabine Seifert. Berlin 2019.</p>
                                <p>Source files on <i class="fab fa-github"></i>&#160;<a href="https://github.com/TEI-Correspondence-SIG/encoding-correspondence" target="_blank">GitHub</a>.</p>
                                <p>
                                    <a href="legal.html">Legal notice &amp; privacy</a></p>
                            </div>
                            <div class="col-md-4">
                                <h4>Licence</h4>
                                <p>This publication is available under the terms of the Creative Commons Licence <a target="_blank" href="https://creativecommons.org/licenses/by-sa/4.0/">CC BY-SA 4.0</a>.</p>
                                
                                <a  target="_blank" href="https://creativecommons.org/licenses/by-sa/4.0/"><img src="img/_general/by-sa.svg"/></a>
                            </div>
                            <div class="col-md-4">
                                <h4>Kindly supported by</h4>
                                <ul>
                                    <li><a href="https://www.clarin-d.net/en/" target="_blank">CLARIN-D</a></li>
                                    <li><a href="https://tei-c.org/activities/sig/correspondence/" target="_blank">TEI Correspondence SIG</a></li>
                                    <li><a href="http://www.bbaw.de/en/" target="_blank">Berlin-Brandenburg Academy of Sciences and Humanities</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </footer>
                <!-- Optional JavaScript -->
                <!-- jQuery first, then Popper.js, then Bootstrap JS -->
                <script src="libs/jquery/jquery-3.3.1.slim.min.js"></script>
                <script src="libs/popper.js/popper.min.js"></script>
                <script src="libs/bootstrap-4.3.1/js/bootstrap.min.js"></script>
                <script src="libs/prism/prism.js"></script>
                <xsl:if test="$page!='index' and $page!='authors' and $page!='introduction' and $page!='legal'">
                    <script src="https://hypothes.is/embed.js" async="async"></script>
                </xsl:if>
                <script>
                    $(function () {
                        $("[data-toggle='popover']").popover({
                            html : true,
                            trigger: 'focus',
                            content: function() {
                                var content = $(this).attr("data-popover-content");
                                return $(content).children(".popover-body").html();
                            }
                        });
                    })
                </script>
            </body>
        </html>
    </xsl:template>
    
    <!-- homepage -->
    <xsl:template name="homepage">
       <div class="jumbotron jumbotron-fluid">
           <div class="container">
               <h1 class="display-4"><xsl:value-of select="//tei:div[@xml:id='header']/tei:head[@type='main']"/></h1>
               <h2><xsl:value-of select="//tei:div[@xml:id='header']/tei:head[@type='sub']"/></h2>
               <hr class="my-4"/>
               <p class="lead"><xsl:value-of select="//tei:div[@xml:id='header']/tei:p"/></p>
               <div class="popover-block-container">
                   <a tabindex="0" type="button" class="popover-icon" data-popover-content="#photo-credits" data-toggle="popover" data-placement="right">
                       <i class="fa fa-info-circle"/>&#160;Photo credits
                   </a>
                   <div id="photo-credits" style="display:none;">
                       <div class="popover-body">
                           <a href="https://www.fontanearchiv.de/handschriften/12001597/">Letter from Theodor Fontane to Emilie Fontane, London, 12 December 1855</a>,
                           <a href="https://www.fontanearchiv.de/en/">Courtesy of Theodor-Fontane-Archiv, Potsdam</a>, Photo: Ernst Kaczynski, CC BY-SA-NC 3.0
                       </div>
                   </div>
               </div>
           </div>
       </div>
       <div class="container">
           <div class="row">
               <div class="col-md-4">
                   <xsl:apply-templates select="//tei:div[@xml:id='content']/tei:div[@n='1' or @n='2']" mode="homepage"/>
               </div>
               <div class="col-md-4">
                   <xsl:apply-templates select="//tei:div[@xml:id='content']/tei:div[@n='3']" mode="homepage"/>
               </div>
               <div class="col-md-4">
                   <xsl:apply-templates select="//tei:div[@xml:id='content']/tei:div[@n='4']" mode="homepage"/>
               </div>
           </div>
       </div>
    </xsl:template>
    
    <xsl:template match="tei:div" mode="homepage">
        <div class="card mb-4">
            <div class="card-body">
                <xsl:apply-templates mode="homepage"/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="tei:head" mode="homepage">
        <h3><xsl:value-of select="."/></h3>
    </xsl:template>

    <xsl:template match="tei:listBibl" mode="homepage">
        <xsl:apply-templates select="tei:head"/>
        <xsl:for-each select="tei:bibl">
            <p>
                <xsl:choose>
                    <xsl:when test=".//tei:ref">
                        <a href="{replace(.//tei:ref/@target, '\.xml', '.html')}"><xsl:value-of select=".//tei:title"/></a><br/>                        
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select=".//tei:title"/><br/>
                    </xsl:otherwise>
                </xsl:choose>
                <span class="byline"><xsl:value-of select="tei:author"/></span>
            </p>
        </xsl:for-each>
    </xsl:template>
    
    <!-- index of authors -->
    <xsl:template name="authors">
        <div id="content" class="container">
            <div class="row">
                <div id="authors" class="col-md-8 order-1">
                    <header>
                        <h1>Authors</h1>
                    </header>
                    <xsl:for-each select="//tei:person">
                        <xsl:variable name="id">
                            <xsl:value-of select="./@xml:id"/>
                        </xsl:variable>
                        <div>
                            <h3>
                                <xsl:value-of select="concat(.//tei:surname, ', ', .//tei:forename)"/>
                                <xsl:if test=".//tei:ptr">
                                    <a href="{.//tei:ptr/@target}" class="cv-link"><i class="far fa-address-card"></i></a>
                                </xsl:if>
                            </h3>
                            <p><xsl:apply-templates select="tei:note"/></p>
                            <h4>Articles:</h4>
                            <ul>
                                <xsl:for-each select="collection(concat('file:/', $tei-xml-path, '/tei-xml?select=*.xml'))//tei:TEI[.//tei:author/@key=$id]">
                                <li><a href="{@xml:id/data(.)}.html"><xsl:value-of select=".//tei:titleStmt/tei:title"/></a></li>
                            </xsl:for-each>
                            </ul>
                        </div>
                    </xsl:for-each>
                </div>
            </div>
        </div>
    </xsl:template>
    
    
    <!-- legal notice -->
    <xsl:template name="legal">
        <div id="content" class="container">
            <div class="row">
                <div class="col-md-8 order-1">
                    <header>
                        <h1><xsl:value-of select="//tei:titleStmt/tei:title"/></h1>
                    </header>
                    <xsl:apply-templates select="//tei:body/*" />
                </div>
                <div class="col-md-8 order-2">
                    <h2>Privacy</h2>
                    <iframe style="border: 0; height: 1500px; width: 800px;" src="https://dschutz.bbaw.de/"></iframe>
                    <h3>Use of the analysis tool Matomo</h3>
                    <p>This website uses Matomo (formerly Piwik), an open source software for statistical analysis of visitor access. 
                        Matomo uses so-called "cookies", text files which are stored on your computer and which allow an analysis of 
                        the use of the website. the website through you. The information generated by the cookie about your use 
                        of this website are stored on a server of the Berlin-Brandenburg Academy of Sciences and Humanities in Germany. The IP address 
                        is anonymized immediately after processing and before it is saved.</p>
                    <p>The purpose of the data collection is to improve the offer and to create usage statistics. The legal basis for data processing is Art. 6 Paragraph 1 S. 1 lit. b DSGVO (necessity to protect legitimate interests).</p>
                    <iframe frameborder="no" width="600px" height="200px" src="https://piwik.bbaw.de/index.php?module=CoreAdminHome&amp;action=optOut&amp;language=en"></iframe>
                </div>
            </div>
        </div>
    </xsl:template>
        
    <!-- articles -->
    <xsl:template name="article">
        <div id="content" class="container">
            <div class="row">
                <div class="col-md-4 order-2 d-print-none">
                    <xsl:if test="$page!='introduction'">
                        <xsl:call-template name="status"/>
                        <xsl:call-template name="toc"/>
                    </xsl:if>
                </div>
                <div class="col-md-8 order-1">
                    <article>
                        <header>
                            <h1><xsl:value-of select="//tei:titleStmt/tei:title"/></h1>
                            <p id="authors">
                                <xsl:for-each select="//tei:titleStmt/tei:author">
                                    <xsl:value-of select="ec:seperator(., position())"/>
                                </xsl:for-each>
                                <xsl:if test="//tei:titleStmt/tei:respStmt">
                                    <br/><xsl:value-of select="concat(' ', //tei:titleStmt/tei:respStmt/tei:resp, ' ', //tei:titleStmt/tei:respStmt/tei:persName)"/>
                                </xsl:if>
                            </p>
                        </header>
                        <section>
                            <xsl:apply-templates select="//tei:body"/>        
                        </section>
                        <xsl:call-template name="notes"/>
                        <xsl:call-template name="bibliography"/>
                        <xsl:call-template name="citation"/>
                        <xsl:if test="//tei:change[@n='1.1']">
                            <xsl:call-template name="editorial-note"/>
                        </xsl:if>
                    </article>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="status">
        <xsl:variable name="review-deadline">
            <xsl:choose>
                <xsl:when test="$page='adresses' or $page='stamps-seals-postmarks'">
                    <xsl:text>31 July 2020</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>30 May 2020</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <div id="status" class="card">
            <div class="card-body">
                <h5 class="card-title">Status of this article</h5>
                <xsl:choose>
                    <xsl:when test="//tei:change[last()]/@status='draft'">
                        <p class="status"><span class="dot dot-draft"></span>Draft. Public peer review in progress until <xsl:value-of select="$review-deadline"/>.</p>
                        <p>We kindly invite you to review and/or comment this article! Please do so via the web annotation service <a href="https://web.hypothes.is/">Hypothes.is</a> 
                            or with an e-mail to <a href="mailto:encoding-correspondence@bbaw.de">encoding-correspondence@bbaw.de</a>.</p>
                        <p>This article remains stable and <a href="#citation">citable</a> in the first version of this manual. The revised article will be published in the second edition of the manual.</p>
                    </xsl:when>
                </xsl:choose>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="toc">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Table of Content</h5>
                <ul id="toc">
                    <xsl:for-each select="//tei:body/tei:div[not(@type='bibliography')]">
                        <xsl:apply-templates select="." mode="toc"/>
                    </xsl:for-each>
                    <xsl:if test="//tei:note[@n]">
                        <li><a href="#notes">Notes</a></li>
                    </xsl:if>
                    <xsl:if test="//tei:div[@type='bibliography']">
                        <li><a href="#bibliography">Bibliography</a></li>
                    </xsl:if>
                        <li class="citation-link"><a href="#citation">Cite this article</a></li>
                </ul>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:div" mode="toc">
        <li><xsl:apply-templates select="./tei:head" mode="toc"/>
            <xsl:if test="tei:div">
                <ul>
                    <xsl:apply-templates select="tei:div" mode="toc"/>
                </ul>
            </xsl:if>
        </li>
    </xsl:template>
   
   <xsl:template match="tei:head" mode="toc">
       <a href="#{parent::tei:div/(@xml:id|@type)}"><xsl:value-of select="."/></a>
   </xsl:template>
    
    <!-- notes -->
    
    <xsl:template name="notes">
        <xsl:if test="//tei:note[@n]">
            <div id="notes">
                <h2>Notes</h2>
            <ul>
            <xsl:for-each select="//tei:note[@n]">
                <li><a id="note_{@xml:id}" class="note-number" href="#{@xml:id}">[<xsl:value-of select="@n"/>]</a><xsl:apply-templates/></li>
            </xsl:for-each>
            </ul>
            </div>
        </xsl:if>
    </xsl:template>
    
    <!-- bibliography -->
    
    <xsl:template name="bibliography">
        <div id="bibliography">
            <xsl:apply-templates select="//tei:div[@type='bibliography']/*"/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:listBibl/tei:bibl">
        <xsl:choose>
            <xsl:when test="@sameAs and matches(@sameAs, 'https://www.zotero.org')">
                <li>
                    <xsl:apply-templates/> <a class="zotero-link" href="{@sameAs}" target="_blank" title="Zotero record" alt="Link to Zotero record">Zotero</a>
                    <xsl:copy-of select="document(ec:zotero-api-url(@sameAs))"/> 
                </li>
            </xsl:when>
            <xsl:otherwise>
                <li><xsl:apply-templates/></li>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- citation -->
    
    <xsl:template name="citation">
        <xsl:variable name="version">
            <xsl:value-of select="max(.//tei:change/@n)"/>
        </xsl:variable>
        <xsl:variable name="url">
            <xsl:value-of select="//tei:publicationStmt/tei:idno[@type='url']"/>
        </xsl:variable>
        <div class="card" id="citation">
            <div class="card-body">
                <h4 class="card-title">Citation</h4>
                <xsl:for-each select="//tei:titleStmt/tei:author">
                    <xsl:value-of select="ec:seperator(., position())"/>
                </xsl:for-each><xsl:text>: </xsl:text>
                <xsl:value-of select="//tei:titleStmt/tei:title"/>
                <xsl:text>. In: Encoding Correspondence. A Manual for Encoding Letters and Postcards in TEI-XML and DTABf. Edited by Stefan Dumont, Susanne Haaf, and Sabine Seifert. Berlin 2019.</xsl:text>
                <!--<xsl:text> Version </xsl:text><xsl:value-of select="$version"/><xsl:text> from </xsl:text><xsl:value-of select="format-date(//tei:change[@n=$version]/@when, '[D].[M].[Y]')"/>-->
                <xsl:text> URL:&#160;</xsl:text><a href="{$url}"><xsl:value-of select="$url"/></a>
                <xsl:text> URN:&#160;</xsl:text><a href="https://nbn-resolving.org/{//tei:publicationStmt/tei:idno[@type='urn']/text()}"><xsl:value-of select="//tei:publicationStmt/tei:idno[@type='urn']"/></a>
                <xsl:if test="//tei:publicationStmt/tei:idno[@type='zotero']/text()">
                    <a class="zotero-link" href="{//tei:publicationStmt/tei:idno[@type='zotero']/text()}" target="_blank" title="Zotero record" alt="Link to Zotero record">Zotero</a><br/>
                    <xsl:copy-of select="document(ec:zotero-api-url(//tei:publicationStmt/tei:idno[@type='zotero']/text()))"/>
                </xsl:if>
                <p class="download-link"><i class="fa fa-download"></i>&#160;<a href="https://github.com/TEI-Correspondence-SIG/encoding-correspondence">Download TEI-XML source of this article on GitHub</a></p>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="editorial-note">
        <div class="card" id="editorial-note">
            <div class="card-body">
                <h4 class="card-title">Editorial Note</h4>
                <p>In this article, the following obvious misprints were corrected on <xsl:value-of select="format-date(//tei:change[@n='1.1']/@when, '[D] [MNn] [Y0000]')"/>: <i><xsl:value-of select="//tei:change[@n='1.1']/text()"/></i> In all other respects the article is unchanged in content and statement.</p>
            </div>
        </div>
        
    </xsl:template>
   
    
    <xsl:template match="tei:div">
        <xsl:choose>
            <xsl:when test="@type='bibliography'"/>
            <xsl:otherwise><div class="chapter" id="{@xml:id}"><xsl:apply-templates/></div></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:p" mode="#all">
        <p id="{@n}">
            <span class="paragraph-number">
                <xsl:choose>
                    <xsl:when test="matches(@n, '^\d$')">
                        <xsl:value-of select="concat('  ', @n)"/>                        
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@n"/>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="tei:head">
        <xsl:choose>
            <xsl:when test="count(./ancestor::tei:div) = 1">
                <h2><xsl:apply-templates/></h2>
            </xsl:when>
            <xsl:when test="count(./ancestor::tei:div) = 2">
                <h3><xsl:apply-templates/></h3>
            </xsl:when>
            <xsl:otherwise>
                <h4><xsl:apply-templates/></h4>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template match="tei:table">
        <table class="table">
            <xsl:apply-templates select="tei:row"/>
            <caption><xsl:apply-templates select="tei:head/node()"/></caption>
        </table>
    </xsl:template>
    
    <xsl:template match="tei:row">
        <tr><xsl:apply-templates/></tr>
    </xsl:template>
       
    <xsl:template match="tei:cell">
        <xsl:choose>
            <xsl:when test="parent::tei:row/@role='label'">
                <th><xsl:apply-templates/></th>        
            </xsl:when>
            <xsl:otherwise>
                <td><xsl:apply-templates/></td>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template match="tei:list|tei:listBibl">
        <xsl:apply-templates select="tei:head"/>
        <ul>
            <xsl:apply-templates select="tei:item|tei:bibl"/>
        </ul>
    </xsl:template>
    
    <xsl:template match="tei:list/tei:head">
        <h5><xsl:apply-templates/></h5>
    </xsl:template>
   

    <xsl:template match="tei:list/tei:item">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="tei:figure">
        <figure>
            <xsl:apply-templates select="tei-eg:egXML|tei:graphic"/>
            <figcaption><xsl:apply-templates select="tei:figDesc|tei:head/node()"/></figcaption>
        </figure>
    </xsl:template>
    
    <xsl:template match="tei-eg:egXML">
        <pre>
            <code class="language-xml">
                <xsl:value-of select="replace(replace(serialize(child::node(), $output/output:serialization-parameters), ' xmlns=&quot;http://www.tei-c.org/ns/Examples&quot;', ''), '[ ]{2,}', '')" />  
            </code>
        </pre>
    </xsl:template>
      
    <xsl:template match="tei:graphic">
        <xsl:variable name="path">
            <xsl:value-of select="concat('img/', substring-after(@url, 'images/'))"/>        
        </xsl:variable>
        <img src="{$path}"/>
    </xsl:template>
    
    <xsl:template match="tei:note[@n]">
        <a id="{@xml:id}" href="#note_{@xml:id}">[<xsl:value-of select="@n"/>]</a>
    </xsl:template>
    
    <xsl:template match="tei:ref" mode="#all">
        <xsl:choose>
            <xsl:when test="matches(@target, '^http')">
                <a href="{@target}" target="_blank"><xsl:apply-templates/></a>
            </xsl:when>
            <xsl:when test="matches(@target, '\.xml')">
                <a href="{replace(@target, 'xml', 'html')}"><xsl:apply-templates/></a>
            </xsl:when>
            <xsl:otherwise>
                <a href="{@target}"><xsl:apply-templates/></a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:hi">
        <xsl:choose>
            <xsl:when test="@rendition='#i'"><i><xsl:apply-templates/></i></xsl:when>
            <xsl:when test="@rendition='#b'"><span class="bold"><xsl:apply-templates/></span></xsl:when>
            <xsl:when test="@rendition='#monospace'"><span class="code"><xsl:apply-templates/></span></xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
   <xsl:template match="tei:cit">
       <blockquote>
           <p><xsl:apply-templates select="tei:quote"/></p>
           <cite><xsl:apply-templates select="tei:ref"/></cite>
       </blockquote>
   </xsl:template>
    
    <xsl:template match="tei:gi">
        <span class="code">&lt;<xsl:apply-templates/>&gt;</span>
    </xsl:template>
    
    <xsl:template match="tei:att">
        <span class="code">@<xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:val">
        <span class="code">"<xsl:apply-templates/>"</span>
    </xsl:template>
    
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    
</xsl:stylesheet>