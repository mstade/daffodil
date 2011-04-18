package se.stade.daffodil
{
    import se.stade.daffodil.metadata.MetadataMapper;
    import se.stade.daffodil.metadata.MetadataReflection;
    import se.stade.daffodil.methods.MethodReflection;
    import se.stade.daffodil.properties.ConstantReflection;
    import se.stade.daffodil.properties.NamedPropertyReflection;
    import se.stade.daffodil.types.TypeReflection;

    internal final class MultipleReflections
    {
        public function MultipleReflections(cache:XMLDescriptionCache)
        {
            this.cache = cache;
        }
        
        private var cache:XMLDescriptionCache;
        
        public function metadata(name:String):MetadataReflection
        {
            return new MetadataMapper(name);
        }
        
        public function get types():TypeReflection
        {
            return new XMLTypeReflection(new XMLReflector(cache));
        }
        
        public function get methods():MethodReflection
        {
            return new XMLMethodReflection(new XMLReflector(cache));
        }
        
        public function get properties():NamedPropertyReflection
        {
            return new XMLNamedPropertyReflection(new XMLReflector(cache));
        }
        
        public function get constants():ConstantReflection
        {
            return new XMLConstantReflection(new XMLReflector(cache));
        }
    }
}