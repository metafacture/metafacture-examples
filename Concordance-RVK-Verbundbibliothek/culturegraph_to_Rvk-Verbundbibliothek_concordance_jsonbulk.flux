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

default outfile = FLUX_DIR + "bulk.ndjson";
default infile = FLUX_DIR + "aggregate_auslieferung_20191212.small.marcxml.gz";
default fixfile = FLUX_DIR + "fix-cg-to-es.fix";


infile
| open-file
| decode-xml
| handle-marcxml
| fix(fixfile)
| encode-json
| json-to-elasticsearch-bulk(type="rvk", index="cgrvk")
| write(outfile)
;