"http://sru.swissbib.ch/sru/search/defaultdb?query=&operation=searchRetrieve&recordSchema=info%3Asrw%2Fschema%2F1%2Fmarcxml-v1.1-light&maximumRecords=${cs}&startRecord=${pa}&recordPacking=XML&availableDBs=defaultdb&sortKeys=Submit+query"|
open-multi-http(lowerBound="0", upperBound="50", chunkSize="20")|
decode-xml|
handle-marcxml-sb|
//change-id("001")|
//stream-to-triples(redirect="true")|
//template("\"${s}\",\"${p}\",\"${o}\"")|
write-csv(path=FLUX_DIR, linesPerFile="1000000", continuousFile="true", filetype="csv", filenamePrefix="sb");
