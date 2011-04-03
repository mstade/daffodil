package se.stade.daffodil.properties
{
	import se.stade.daffodil.Reflection;

	public interface NamedPropertyReflection extends PropertyReflection
	{
		function named(name:String):NamedPropertyReflection;
	}
}