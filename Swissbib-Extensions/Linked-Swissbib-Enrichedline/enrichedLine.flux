filesize    	= "10000";
records     	= "5000";
bulkheader      = "false";
index 		= "lsb";
compress 	= "false";
jsoncompliant 	= "true";
outdir 		= FLUX_DIR;
extension   	= "jsonld";

FLUX_DIR + "input.nt"|
open-file|
decode-ntriples(unicodeEscapeSeq="true")|
stream-to-triples(redirect="true")|
collect-triples|
stream-tee| {
    filter(FLUX_DIR + "enrichedPersonFilter.xml")|
    morph(FLUX_DIR + "enrichedPersonMorph.xml")|
    change-id(idname="id")|
    encode-esbulk(escapeChars="true", header=bulkheader, index=index, type="person")|
    write-esbulk(baseOutDir=outdir, fileSize=filesize, jsonCompliant=jsoncompliant, type="person", compress=compress, extension=extension)
}{
    filter(FLUX_DIR + "enrichedOrganisationFilter.xml")|
    morph(FLUX_DIR + "enrichedOrganisationMorph.xml")|
    change-id(idname="id")|
    encode-esbulk(escapeChars="true", header=bulkheader, index=index, type="organisation")|
    write-esbulk(baseOutDir=outdir, fileSize=filesize, jsonCompliant=jsoncompliant, type="organisation", compress=compress, extension=extension)
};
