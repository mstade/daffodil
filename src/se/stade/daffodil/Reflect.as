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

	public final class Reflect
	{
		private static var cache:XMLDescriptionCache = new XMLDescriptionCache();
		private static var metadataDefinitions:Dictionary = new Dictionary(true);
        
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
        
        public static function get first():SingleReflection
        {
            return new SingleReflection(cache);
        }
        
        public static function get all():MultipleReflections
        {
            return new MultipleReflections(cache);
        }
	}
}