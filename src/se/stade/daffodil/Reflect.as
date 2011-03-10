package se.stade.daffodil
{
	import se.stade.daffodil.methods.MethodReflection;
	import se.stade.daffodil.properties.ConstantReflection;
	import se.stade.daffodil.properties.PropertyReflection;

	public class Reflect
	{
		private static var cache:XMLDescriptionCache = new XMLDescriptionCache();
		
		public static function on(target:Object):Reflector
		{
			return new XMLReflector(cache, target);
		}
		
		public static function get methods():MethodReflection
		{
			return new XMLMethodReflection();
		}
		
		public static function get properties():PropertyReflection
		{
			return new XMLPropertyReflection();
		}
		
		public static function get constants():ConstantReflection
		{
			return new XMLConstantReflection();
		}
	}
}