package se.stade.daffodil
{
	import se.stade.daffodil.properties.PropertyReflection;
	
	internal final class XMLPropertyReflection extends XMLAbstractReflection implements PropertyReflection
	{
		public function XMLPropertyReflection(reflector:XMLReflector)
		{
			super(reflector);
		}
		
		public function named(name:String):PropertyReflection
		{
			nameMatches = createNameMatcher(name);
			return this;
		}
		
		public function ofType(type:Class):PropertyReflection
		{
			returnTypeMatches = createReturnTypeMatcher(type, false);
			return this;
		}
		
		public function withMetadata(name:String):PropertyReflection
		{
			metadataMatches = createMetadataMatcher(name);
			return this;
		}
		
		public function get thatAreReadable():PropertyReflection
		{
			signatureMatches = function(input:XMLList):Boolean
			{
				return input.localName() == "variable" ||
					input.@access.toString().indexOf("read") >= 0;
			};
				
			return this;
		}
		
		public function get thatAreWritable():PropertyReflection
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