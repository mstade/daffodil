package se.stade.daffodil.metadata
{
	import se.stade.daffodil.Type;

	public interface MetadataReflection
	{
        function get asValue():String;
        function get asObject():Object;
        
		function asType(definition:Class):Array;
		function on(member:Type):MetadataReflection;
	}
}