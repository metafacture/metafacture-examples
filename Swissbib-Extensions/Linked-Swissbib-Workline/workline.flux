"http://sru.swissbib.ch/sru/search/defaultdb?query=&operation=searchRetrieve&recordSchema=info%3Asrw%2Fschema%2F1%2Fmarcxml-v1.1-light&maximumRecords=${cs}&startRecord=${pa}&recordPacking=XML&availableDBs=defaultdb&sortKeys=Submit+query"|
open-multi-http(lowerBound="0", upperBound="1000", chunkSize="50")|
decode-xml|
handle-marcxml-sru|
filter(FLUX_DIR + "245aFilter.xml")|
filter(FLUX_DIR + "workFilter.xml")|
morph(FLUX_DIR + "workMorph1.xml")|
stream-to-triples(redirect="true")|
sort-triples(by="all")|
collect-triples|
morph(FLUX_DIR + "workMorph2.xml")|
split-entities|
encode-esbulk(escapeChars="true", header="false", index="test", type="work")|
write-esbulk(baseOutDir=FLUX_DIR, fileSize="1000", jsonCompliant="true", type="work", subdirSize="0", compress="false", extension="jsonld");
