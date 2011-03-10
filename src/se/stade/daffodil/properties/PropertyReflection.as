package se.stade.daffodil.properties
{
	import se.stade.daffodil.Reflection;

	public interface PropertyReflection extends Reflection
	{
		function named(name:String):PropertyReflection;
		function ofType(type:Class):PropertyReflection;
		function withMetadata(name:String):PropertyReflection;
		
		function get thatAreReadable():PropertyReflection;
		function get thatAreWritable():PropertyReflection;
	}
}