default indir   = "/data/sbdump/marcDataCBS";
default path    = FLUX_DIR + "output/";

"http://sru.swissbib.ch/sru/search/defaultdb?query=&operation=searchRetrieve&recordSchema=info%3Asrw%2Fschema%2F1%2Fmarcxml-v1.1-light&maximumRecords=${cs}&startRecord=${pa}&recordPacking=XML&availableDBs=defaultdb&sortKeys=Submit+query"|
open-multi-http(lowerBound="0", upperBound="5000", chunkSize="50")|
decode-xml|
handle-marcxml-sru|
filter(FLUX_DIR + "245aFilter.xml")|
stream-tee|{
    morph(FLUX_DIR + "neoContribMorph.xml")|
    stream-to-triples(redirect="false")|
    sort-triples(by="OBJECT")|
    filter-duplicate-objects|
    template("${o}")|
    write-csv(path=path, filenamePrefix="contrib", header="contribId:ID(c)")
}{
    morph(FLUX_DIR + "neoRelaMorph.xml")|
    stream-to-triples(redirect="true")|
    template("${s},${o}")|
    write-csv(path=path, filenamePrefix="rela", header=":START_ID(r),:END_ID(c)")
}{
    morph(FLUX_DIR + "neoResourceMorph.xml")|
    stream-to-triples(redirect="true")|
    template("${s},${o}")|
    write-csv(path=path, filenamePrefix="res", header="resId:ID(r),sysno")
};
