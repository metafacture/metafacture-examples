FLUX_DIR + "input.xml"|
open-file|
decode-xml|
handle-marcxml-sb|
write-kafka(host="localhost", port="9092", topic="test");
