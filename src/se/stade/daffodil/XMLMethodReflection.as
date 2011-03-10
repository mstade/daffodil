package se.stade.daffodil
{
	import flash.utils.getQualifiedClassName;
	
	import se.stade.daffodil.methods.MethodReflection;

	internal final class XMLMethodReflection extends XMLAbstractReflection implements MethodReflection
	{
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
			types.unshift(type);
			
			signatureMatches = function(input:XML):Boolean
			{
				var typeNames:XMLList = input.parameters.@type;
				
				if (typeNames.length() !== types.length)
					return false;
				
				for (var i:int = 0; i < types.length; i++)
				{
					var qName:String = getQualifiedClassName(types[i]);
					
					if (typeNames[0].toString() != qName)
						return false;
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