import org.apache.commons.lang.StringUtils;
import org.culturegraph.mf.framework.DefaultStreamPipe;
import org.culturegraph.mf.framework.StreamReceiver;

/**
 * Removes all Pica occurence suffices from entity names.
 */
public class PicaOccurenceRemover extends DefaultStreamPipe<StreamReceiver> {

	@Override
	public final void startRecord(final String identifier) {
		getReceiver().startRecord(identifier);
	}

	@Override
	public final void endRecord() {
		getReceiver().endRecord();
	}

	@Override
	public final void startEntity(final String name) {
		getReceiver().startEntity(StringUtils.substringBefore(name, "/"));
	}

	@Override
	public final void endEntity() {
		getReceiver().endEntity();
		
	}

	@Override
	public final void literal(final String name, final String value) {
		getReceiver().literal(name, value);
	}

}
