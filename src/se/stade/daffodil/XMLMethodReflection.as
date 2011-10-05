package se.stade.daffodil
{
    import se.stade.daffodil.methods.MethodReflection;

    import flash.utils.getQualifiedClassName;

    internal final class XMLMethodReflection extends XMLAbstractReflection implements MethodReflection
    {
        public function XMLMethodReflection(reflector:XMLReflector)
        {
            super(reflector);
        }
        
        public function named(name:String):MethodReflection
        {
            nameMatches = createNameMatcher(name);
            return this;
        }
            
        public function withMetadata(name:String):MethodReflection
        {
            metadataMatches = createMetadataMatcher(name);
            return this;
        }
        
        public function get withArguments():MethodReflection
        {
            signatureMatches = function(input:XML):Boolean
            {
                return input.parameter.length() > 0;
            };
            
            return this;
        }

        public function get withoutArguments():MethodReflection
        {
            signatureMatches = function(input:XML):Boolean
            {
                return input.parameter.length() == 0;
            };
            
            return this;
        }

        public function get withOnlyOptionalArguments():MethodReflection
        {
            signatureMatches = function(input:XML):Boolean
            {
                var total:XMLList = input.parameter;
                if (!total.length())
                    return false;
                
                var optional:XMLList = input.parameter.(@optional == true);
                return total.length() == optional.length();
            };
                
            return this;
        }

        public function withArgumentCount(count:uint):MethodReflection
        {
            signatureMatches = function(input:XML):Boolean
            {
                return input.parameter.length() == count;
            };
            
            return this;
        }
        
        public function withSignature(type:Class, ... types):MethodReflection
        {
            var specifiedSignature:Array = [type].concat(types);
            
            signatureMatches = function(input:XML):Boolean
            {
                var reflectedSignature:XMLList = input.parameters.@type;
                
                if (reflectedSignature.length() != specifiedSignature.length)
                    return false;
                
                for (var i:int = 0; i < types.length; i++)
                {
                    var reflectedTypeName:String = reflectedSignature[0].toString();
                    var specifiedTypeName:String = getQualifiedClassName(specifiedSignature[i]);
                    
                    if (reflectedTypeName != specifiedTypeName)
                    {
                        var reflection:XML = reflector.getDescription(specifiedSignature[i]);
                        var baseTypes:XMLList = reflection.factory.extendsClass + reflection.factory.implementsInterface;
                        
                        if (baseTypes.(@type == specifiedType).length() == 0)
                            return false;
                    }
                }
                
                return true;
            };

            return this;
        }
        
        public function withReturnType(type:Class):MethodReflection
        {
            returnTypeMatches = createReturnTypeMatcher(type, true);
            return this;
        }
    }
}
