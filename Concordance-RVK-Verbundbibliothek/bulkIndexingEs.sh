#Upload sizes are limited to the Elasticsearch HTTP receive buffer size (default 100 Mb).
# 1. split bulk.ndjson
# Because every two lines are one complete bulk index request one must split them
# even-numbered. E.g.:
split --lines=1000000 bulk.ndjson
# 2. now all the resulting files can be indexed:
for i in $(ls x*); do
        echo $i;
        curl -H "Content-Type: application/x-ndjson" -XPOST locahost:9200/_bulk --data-binary "@$i" 2>&1>/dev/null
done
