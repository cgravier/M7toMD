<?php

$xp = new XsltProcessor();

// create a DOM document and load the XSL stylesheet
$xsl = new DomDocument;
$xsl->load('./m7tomd-2011.xsl');

// import the XSL styelsheet into the XSLT process
$xp->importStylesheet($xsl);
  
// create a DOM document and load the XML data
$xml_doc = new DomDocument;
$xml_doc->load('AliceSkateBoardPerformance.xml');

  // transform the XML into HTML using the XSL file
  if ($html = $xp->transformToXML($xml_doc)) {
      echo $html;
  } else {
      trigger_error('XSL transformation failed.', E_USER_ERROR);
  } 

?>
