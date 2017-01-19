FLUX_DIR + "input.xml"|
open-file|
decode-xml|
handle-marcxml|
change-id("001")|
stream-to-triples(redirect="true")|
template("\"${s}\",\"${p}\",\"${o}\"")|
write-socket(port="7777"); // Implies that a client is listen to the port (e.g. a Spark instance); for testing you can use e.g. ncat: ncat localhost 7777
