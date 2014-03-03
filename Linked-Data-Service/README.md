
Metamorph scripts of the <a href="http://www.dnb.de/DE/Service/DigitaleDienste/LinkedData/linkeddata.html">Linked Data Service</a> of the German National Library.

This example contains the following files:

* ```lod-namespaces-title.properties```: XML namespace mappings used in the RDF representation
* ```dnb.title.definition.pica.xml```: Metamorph definition for bibliographic data from PICA to RDF/XML
* ```PicaOccurenceRemover.java```: A helper module for preprocessing pica data before the transformation
* ```PicaToRdfConverter.java```: A class for converting single pica records into RDF/XML
