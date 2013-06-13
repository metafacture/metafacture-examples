import java.io.StringWriter;

import org.culturegraph.mf.morph.Metamorph;
import org.culturegraph.mf.stream.converter.bib.PicaDecoder;
import org.culturegraph.mf.stream.pipe.RdfMacroPipe;
import org.culturegraph.mf.stream.sink.ObjectJavaIoWriter;
import org.culturegraph.mf.stream.sink.SimpleXmlWriter;

public class PicaToRdfConverter {
	
	public final static String MORPH_DEFINITION = "dnb.title.definition.pica.xml";
	public final static String NAMESPACE_MAPPING = "lod-namespaces-title.properties";
	public final static String ROOT_TAG = "rdf:RDF";
	public final static String RECORD_TAG = "rdf:Description";
	
	final PicaDecoder picaDecoder;
	
	public PicaToRdfConverter() {
		picaDecoder = new PicaDecoder();	
		final PicaOccurenceRemover occurenceFilter = new PicaOccurenceRemover();
		final Metamorph metamorph = new Metamorph(MORPH_DEFINITION);
		final RdfMacroPipe rdfMacroPipe = new RdfMacroPipe();
		final SimpleXmlWriter xmlEncoder = new SimpleXmlWriter();	
		
		metamorph.setErrorHandler(new MetamorphErrorHandlerImpl());
		
		xmlEncoder.setRootTag(ROOT_TAG);
		xmlEncoder.setRecordTag(RECORD_TAG);
		xmlEncoder.setNamespaceFile(NAMESPACE_MAPPING);

		picaDecoder.setReceiver(occurenceFilter)
				.setReceiver(metamorph);
				.setReceiver(rdfMacroPipe);
				.setReceiver(xmlEncoder);	
	}
	
	public String convertPicaRecord(final String picaRecord) {
		final StringWriter stringWriter = new StringWriter();
		final ObjectJavaIoWriter<String> streamWriter = new ObjectJavaIoWriter<String>(stringWriter);
		
		xmlEncoder.setReceiver(streamWriter);
		
		this.picaDecoder.process(picaRecord);
		
		return stringWriter.toString();
	}
	
}
