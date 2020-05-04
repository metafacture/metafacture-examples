// Die flux filtert mittels morph-cg-to-es.xml die Isil DE-605 aus
// This flux uses morph-cg-to-es.xml to filter records with holdings
// by Isil DE-605 from culturegraph aggregate marcxml. It then builds
// a concordance Id<->RVK which can be indexed directly into elasticsearch.
// Snippet from the output json:
//
//{"index":{"_index":"cgrvk","_type":"rvk"}}
//{"rvk":["CI 1100","5,1"],"hbzId":"HT018839495, HT018625006"}
//
// Use curl to bulk load the file:
//
//  curl -XPOST --header 'Content-Type: application/x-ndjson' -d @bulk.ndjson 'http://localhost:9200/_bulk'

default outfile = "bulk.ndjson";
default infile = FLUX_DIR + "aggregate_auslieferung_20191212.small.marcxml.gz";
default morphfile = FLUX_DIR + "morph-cg-to-es.xml";


infile|
open-file|
decode-xml|
split-xml-elements(topLevelElement="marc:collection",elementName="record")|
literal-to-object|
read-string|
decode-xml|
handle-marcxml|
filter(morphfile)|
morph(morphfile)|
encode-json|
json-to-elasticsearch-bulk(type="rvk", index="cgrvk")|
write(outfile);

