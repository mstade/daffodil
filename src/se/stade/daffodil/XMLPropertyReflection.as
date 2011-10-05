package se.stade.daffodil
{
    import se.stade.daffodil.properties.PropertyReflection;
    
    internal class XMLPropertyReflection extends XMLAbstractReflection implements PropertyReflection
    {
        public function XMLPropertyReflection(reflector:XMLReflector)
        {
            super(reflector);
        }
        
        public final function ofType(type:Class):PropertyReflection
        {
            returnTypeMatches = createReturnTypeMatcher(type, false);
            return this;
        }
        
        public final function withMetadata(name:String):PropertyReflection
        {
            metadataMatches = createMetadataMatcher(name);
            return this;
        }
        
        public final function get withWriteAccess():PropertyReflection
        {
            signatureMatches = function(input:XML):Boolean
            {
                return input.localName() == "variable" ||
                    input.@access.toString().indexOf("read") >= 0;
            };
            
            return this;
        }
        
        public final function get withReadAccess():PropertyReflection
        {
            signatureMatches = function(input:XML):Boolean
            {
                return input.localName() == "variable" ||
                    input.@access.toString().indexOf("write") >= 0;
            };
            
            return this;
        }
    }
}
