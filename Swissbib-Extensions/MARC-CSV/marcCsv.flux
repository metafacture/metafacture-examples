FLUX_DIR + "input.xml"|
open-file|
decode-xml|
handle-marcxml-sb|
write-csv(path=FLUX_DIR, linesPerFile="1000000", continuousFile="true", filetype="csv", filenamePrefix="sb");
