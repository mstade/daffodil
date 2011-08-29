package se.stade.daffodil
{
	import flash.utils.getQualifiedClassName;
	
	import se.stade.daffodil.methods.MethodReflection;
	import se.stade.daffodil.properties.ConstantReflection;
	import se.stade.daffodil.properties.NamedPropertyReflection;
	import se.stade.daffodil.types.TypeReflection;
	
	internal final class XMLTypeReflection extends XMLAbstractReflection implements TypeReflection
	{
		public function XMLTypeReflection(reflector:XMLReflector)
		{
			super(reflector);
			
			baseMatches
			= interfacesMatches
			= packageMatches
			= qualifiedNameMatches
			= methodsMatches
			= constantsMatches
			= propertiesMatches
			= alwaysMatches;
		}
		
		private var baseMatches:Function;
		private var interfacesMatches:Function;
		
		private var packageMatches:Function;
		private var qualifiedNameMatches:Function;
		
		private var methodsMatches:Function;
		private var constantsMatches:Function;
		private var propertiesMatches:Function;
        
        public function like(name:String):TypeReflection
        {
            nameMatches = function(input:XML):Boolean
            {
                var allTypes:XMLList = input.@name
                                       + input..extendsClass.@type
                                       + input..implementsInterface.@type;
                
                for each (var fullName:String in allTypes)
                {
                    if (fullName.substr(-name.length) == name)
                        return true;
                }
                
                return false;
            };
            
            return this;
        }
		
		public function named(name:String):TypeReflection
		{
			nameMatches = function(input:XML):Boolean
			{
                var allTypes:XMLList = input.@name
                                       + input..extendsClass.@type
                                       + input..implementsInterface.@type;
                
                for each (var fullName:String in allTypes)
                {
    				var typeName:String = fullName.substr(fullName.lastIndexOf(":") + 1);
                    
                    if (name == typeName)
                    {
                        return true;
                    }
                }
				
				return false;
			};
				
			return this;
		}
		
		public function inPackage(name:String):TypeReflection
		{
			packageMatches = function(input:XML):Boolean
			{
                var allTypes:XMLList = input.@name
                                       + input..extendsClass.@type
                                       + input..implementsInterface.@type;
                
                for each (var fullName:String in allTypes)
                {
    				var packageName:String = fullName.substr(0, Math.max(0, fullName.indexOf(":")));
                    
                    if (name == packageName)
                    {
                        return true;
                    }
                }
                
                return false;
			};
				
			return this;
		}
		
		public function withQualifiedName(name:String):TypeReflection
		{
			nameMatches = createNameMatcher(name);
			return this;
		}
		
		public function withMetadata(name:String):TypeReflection
		{
			metadataMatches = createMetadataMatcher(name);
			return this;
		}
		
		public function extending(type:*):TypeReflection
		{
			var qualifiedName:String = type is String ? type : getQualifiedClassName(type);
			
			baseMatches = function(input:XML):Boolean
			{
				return input..extendsClass.(@type == qualifiedName).length() > 0;
			};
			
			return this;
		}
		
		public function implementing(type:*):TypeReflection
		{
			var qualifiedName:String = type is String ? type : getQualifiedClassName(type);
			
			baseMatches = function(input:XML):Boolean
			{
				return input..implementsInterface.(@type == qualifiedName).length() > 0;
			};
			
			return this;
		}

		public function withMethods(reflection:MethodReflection):TypeReflection
		{
			methodsMatches = reflection.matches;
			return this;
		}
		
		public function withConstants(reflection:ConstantReflection):TypeReflection
		{
			constantsMatches = reflection.matches;
			return this;
		}

		public function withProperties(reflection:NamedPropertyReflection):TypeReflection
		{
			propertiesMatches = reflection.matches;
			return this;
		}
		
		public override function matches(input:*):Boolean
		{
			if (super.matches(input))
			{
				return baseMatches(input)
						&& interfacesMatches(input)
						&& packageMatches(input)
						&& qualifiedNameMatches(input)
						&& methodsMatches(input)
						&& constantsMatches(input)
						&& propertiesMatches(input);
			}
			
			return false;
		}
	}
}