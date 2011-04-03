package se.stade.daffodil
{
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import se.stade.daffodil.metadata.MetadataMapper;
	import se.stade.daffodil.metadata.MetadataReflection;
	import se.stade.daffodil.methods.MethodReflection;
	import se.stade.daffodil.properties.ConstantReflection;
	import se.stade.daffodil.properties.NamedPropertyReflection;
	import se.stade.daffodil.properties.PropertyReflection;
	import se.stade.daffodil.types.TypeReflection;

	public class Reflect
	{
		private static var cache:XMLDescriptionCache = new XMLDescriptionCache();
		private static var metadataDefinitions:Dictionary = new Dictionary(true);
		
		public static function on(target:Object, ... additionalTargets):TypeInspector
		{
			var reflector:XMLReflector = new XMLReflector(cache);
			reflector.setTargets(target, additionalTargets);
			
			return reflector;
		}
		
		public static function metadata(name:String):MetadataReflection
		{
			return new MetadataMapper(name);
		}
        
        public static function get defaultProperty():PropertyReflection
        {
            return new XMLDefaultPropertyReflection(new XMLReflector(cache));
        }
		
		public static function definition(qualifiedName:String, domain:ApplicationDomain = null):Class
		{
			domain = domain || ApplicationDomain.currentDomain;
			
			if (domain.hasDefinition(qualifiedName))
				return domain.getDefinition(qualifiedName) as Class;
			
			return null;
		}
		
		public static function get types():TypeReflection
		{
			return new XMLTypeReflection(new XMLReflector(cache));
		}
		
		public static function get methods():MethodReflection
		{
			return new XMLMethodReflection(new XMLReflector(cache));
		}
		
		public static function get properties():NamedPropertyReflection
		{
			return new XMLNamedPropertyReflection(new XMLReflector(cache));
		}
		
		public static function get constants():ConstantReflection
		{
			return new XMLConstantReflection(new XMLReflector(cache));
		}
	}
}