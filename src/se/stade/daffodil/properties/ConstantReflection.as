package se.stade.daffodil.properties
{
	import se.stade.daffodil.Reflection;

	public interface ConstantReflection extends Reflection
	{
		function named(name:String):ConstantReflection;
		function ofType(type:Class):ConstantReflection;
		function withMetadata(name:String):ConstantReflection;
	}
}