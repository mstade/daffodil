package se.stade.daffodil
{
    import se.stade.daffodil.metadata.MetadataMapper;
    import se.stade.daffodil.metadata.MetadataReflection;
    import se.stade.daffodil.methods.MethodReflection;
    import se.stade.daffodil.properties.ConstantReflection;
    import se.stade.daffodil.properties.NamedPropertyReflection;
    import se.stade.daffodil.types.TypeReflection;

    internal final class SingleReflection
    {
        public function SingleReflection(cache:XMLDescriptionCache)
        {
            this.cache = cache;
        }
        
        private var cache:XMLDescriptionCache;
        
        public function metadata(name:String):MetadataReflection
        {
            return new MetadataMapper(name, 1);
        }
        
        public function get type():TypeReflection
        {
            return new XMLTypeReflection(new XMLReflector(cache, 1));
        }
        
        public function get method():MethodReflection
        {
            return new XMLMethodReflection(new XMLReflector(cache, 1));
        }
        
        public function get property():NamedPropertyReflection
        {
            return new XMLNamedPropertyReflection(new XMLReflector(cache, 1));
        }
        
        public function get constant():ConstantReflection
        {
            return new XMLConstantReflection(new XMLReflector(cache, 1));
        }
    }
}
