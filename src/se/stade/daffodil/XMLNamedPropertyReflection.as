package se.stade.daffodil
{
	import se.stade.daffodil.properties.NamedPropertyReflection;
	
	internal final class XMLNamedPropertyReflection extends XMLPropertyReflection implements NamedPropertyReflection
	{
		public function XMLNamedPropertyReflection(reflector:XMLReflector)
		{
			super(reflector);
		}
		
		public function named(name:String):NamedPropertyReflection
		{
			nameMatches = createNameMatcher(name);
			return this;
		}
	}
}