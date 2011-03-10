package se.stade.daffodil.metadata
{
	import se.stade.daffodil.Type;

	public interface MetadataReflection
	{
		function on(member:Type):MetadataReflection;
		function asType(definition:Class):Array;
		function asOne(definition:Class):*;
	}
}