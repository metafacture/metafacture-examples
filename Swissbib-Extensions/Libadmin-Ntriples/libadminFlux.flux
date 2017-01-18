"https://www.swissbib.ch/mapportal.json"|
open-http(encoding="UTF-8")|
read-json|
morph(FLUX_DIR + "libadminMorph.xml")|
split-entities|
change-id|
encode-ntriples|
write(FLUX_DIR + "output.nt", separator="");
