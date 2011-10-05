package se.stade.daffodil
{
    import se.stade.daffodil.properties.PropertyReflection;

    import flash.system.ApplicationDomain;

    public final class Reflect
    {
        private static var cache:XMLDescriptionCache = new XMLDescriptionCache();
        
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
