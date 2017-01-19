FLUX_DIR + "input.xml"|
open-file|
decode-xml|
handle-marcxml|
ext-filter(FLUX_DIR + "245aFilter.xml", filterNot="true")|
morph(FLUX_DIR + "withoutTitleMorph.xml")|
stream-to-triples(redirect="true")|
template("${s}")|
write("withoutTitle.txt");
