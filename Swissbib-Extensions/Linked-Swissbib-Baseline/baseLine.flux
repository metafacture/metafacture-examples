outdir      = FLUX_DIR;
filesize    = "10000";
esnodes     = "localhost:9300";
escluster   = "elasticsearch";
records     = "20000";
index       = "lsb";
compress    = "false";
extension   = "jsonld";

FLUX_DIR + "input.xml"|
open-file|
decode-xml|
handle-marcxml|
filter(FLUX_DIR + "245aFilter.xml")|
stream-tee| {
    morph(FLUX_DIR + "resourceMorph.xml")|
    change-id|
    encode-esbulk(escapeChars="true", header="true", index=index, type="bibliographicResource")|
    index-esbulk(esNodes=esnodes, esClustername=escluster, recordsPerUpload=records) // Requires a running Elasticsearch instance with default settings!
}{
    morph(FLUX_DIR + "documentMorph.xml")|
    change-id|
    encode-esbulk(escapeChars="true", header="true", index=index, type="document")|
    index-esbulk(esNodes=esnodes, esClustername=escluster, recordsPerUpload=records) // Requires a running Elasticsearch instance with default settings!
}{
    morph(FLUX_DIR + "organisationMorph.xml")|
    split-entities|
    change-id|
    encode-esbulk(escapeChars="true", header="false", index=index, type="organisation")|
    write-esbulk(baseOutDir=outdir, fileSize=filesize, jsonCompliant="true", type="organisation", compress=compress, extension=extension)
}{
    morph(FLUX_DIR + "itemMorph.xml")|
    split-entities|
    change-id|
    encode-esbulk(escapeChars="true", header="true", index=index, type="item")|
    index-esbulk(esNodes=esnodes, esClustername=escluster, recordsPerUpload=records) // Requires a running Elasticsearch instance with default settings!
}{
    change-id("245*.a")|
    morph(FLUX_DIR + "personMorph.xml")|
    split-entities|
    change-id|
    encode-esbulk(escapeChars="true", header="false", index=index, type="person")|
    write-esbulk(baseOutDir=outdir, fileSize=filesize, jsonCompliant="true", type="person", compress=compress, extension=extension)
};
