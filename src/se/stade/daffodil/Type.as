package se.stade.daffodil
{
	import se.stade.daffodil.metadata.Metadata;

	public interface Type
	{
		function get name():String;

		function get metadata():Vector.<Metadata>;
	}
}