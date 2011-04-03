package se.stade.daffodil.metadata
{
	import se.stade.daffodil.Type;

	public interface MetadataReflection
	{
        function get asValue():String;
        function get asDynamic():Object;
        
		function asType(definition:Class):*;
		function on(member:Type):MetadataReflection;
	}
}