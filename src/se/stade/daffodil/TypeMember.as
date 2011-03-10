package se.stade.daffodil
{
	import se.stade.daffodil.metadata.Metadata;

	public interface TypeMember
	{
		function get name():String;
		function get type():String;
		
		function get metadata():Vector.<Metadata>;
	}
}