package se.stade.daffodil
{
	import se.stade.daffodil.properties.ConstantReflection;
	
	internal final class XMLConstantReflection extends XMLAbstractReflection implements ConstantReflection
	{
		public function named(name:String):ConstantReflection
		{
			nameMatches = createNameMatcher(name);
			return this;
		}
		
		public function ofType(type:Class):ConstantReflection
		{
			returnTypeMatches = createReturnTypeMatcher(type, false);
			return this;
		}
		
		public function withMetadata(name:String):ConstantReflection
		{
			metadataMatches = createMetadataMatcher(name);
			return this;
		}
	}
}