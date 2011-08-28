package se.stade.daffodil.types
{
	import se.stade.daffodil.Reflection;
	import se.stade.daffodil.methods.MethodReflection;
	import se.stade.daffodil.properties.ConstantReflection;
	import se.stade.daffodil.properties.NamedPropertyReflection;

	public interface TypeReflection extends Reflection
	{
        function like(name:String):TypeReflection;
		function named(name:String):TypeReflection;
		function inPackage(name:String):TypeReflection;
		function withQualifiedName(name:String):TypeReflection;
		
		function withMetadata(name:String):TypeReflection;
		
		function extendings(type:Class):TypeReflection;
		function implementing(type:Class):TypeReflection;
		
		function withMethods(reflection:MethodReflection):TypeReflection;
		function withConstants(reflection:ConstantReflection):TypeReflection;
		function withProperties(reflection:NamedPropertyReflection):TypeReflection;
	}
}