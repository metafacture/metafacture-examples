Create a json file of concordance of Verbundbibliotheks-IDs <-> RVK
====================
This shows how to load the `culturegraph aggregate MARC21 XML` file,
selecting a Library Union Catalog based on an ISIL, get the IDs of the
libraries with the associated [RVK](https://de.wikipedia.org/wiki/Regensburger_Verbundklassifikation) and generate a json bulk file which can be indexed into elasticsearch.

# Installation
Until the next metafacture release (> 5.1.0, coming this year) the easiest way is to
load this prebundle:
```bash
wget http://lobid.org/download/tmp/dini-kim-2020_rvk/metafacture-core-rvk-dist.zip
unzip metafacture-core-rvk-dist.zip
cd metafacture-core-rvk-dist
```
# Run
```bash
bash flux.sh culturegraph_to_Rvk-Verbundbibliothek_concordance_jsonbulk.flux
```
The parameter after `flux.sh` (the flux file) can be the path to the flux file, e.g. the
flux from this repo. Just make sure that the files used in the flux (input, morph)
reside in the same directory as the flux itself (as it is in this repo).

Get the [full aggregate data dump](https://culturegraph:guhusu@data.dnb.de/aggregate_auslieferung_20191212.marcxml.gz) (~7GB), adjust the path in the morph.

# Index
_This shall work for all elasticsearch versions <8.0 where the "index-type" setting is still valid._

The generated `bulk.ndjson` looks like this:

> {"index":{"_index":"cgrvk","_type":"rvk"}}

> {"rvk":["CI 1125","CI 5604","CI 5603","IH 34381","CI 1100","CI 5310","EC 2430"],"id":"HT013166356, HT018625006, TT000577460"}

This is elasticsearch's bulk format, where the odd-numbered lines are the index'
metadata and the following even-numbered the actual data to be indexed.

Make sure your Elasticsearch is up and running. Index:
```
curl -XPOST --header 'Content-Type: application/x-ndjson' --data-binary @bulk.ndjson 'http://localhost:9200/_bulk'
```
*Note*: elasticsearch's default upload sizes are limited to the Elasticsearch HTTP receive buffer size (default 100 Mb). See the script `bulkIndexingEs.sh` how to split
the `bulk.ndjson` and index when your `bulk.ndjson` is bigger when using the
culturegraph's complete aggregate data.

Test-query:
```bash
curl 'localhost:9200/cgrvk/_search?q=id:HT018625006&pretty=true'
```

# Enrichment
The resulting elasticsearch index can be used to enrich your data.

*Note*: as you may have quite a lot of records (several millions) don't use
HTTP-Requests when doing lookups against the index but use native `TransportClients`
of Elasticsearch, thus avoiding the HTTP overhead for performance reasons. Elasticsearch 
provide the libraries for nearly all programming languages.
