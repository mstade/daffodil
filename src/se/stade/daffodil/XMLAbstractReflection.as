package se.stade.daffodil
{
	import flash.utils.getQualifiedClassName;

	internal class XMLAbstractReflection implements Reflection
	{
		protected static function createNameMatcher(name:String):Function
		{
			return function(input:XML):Boolean
			{
				return input.@name == name;
			}
		}
		
		protected static function createMetadataMatcher(name:String):Function
		{
			return function(input:XML):Boolean
			{
				for each (var metadata:XML in input.metadata)
				{
					if (metadata.@name == name)
						return true;
				}
				
				return false;
			}
		}
		
		protected static function createReturnTypeMatcher(type:Class, isMethod:Boolean):Function
		{
			var qName:String = getQualifiedClassName(type);
			
			if (isMethod) return function(input:XML):Boolean
			{
				return input.@returnType == qName;
			}
			else return function(input:XML):Boolean
			{
				return input.@type == qName;
			}
		}
		
		public function XMLAbstractReflection(reflector:XMLReflector)
		{
			this.reflector = reflector;
			
			nameMatches
			= signatureMatches
			= metadataMatches
			= returnTypeMatches
			= alwaysMatches;
		}
		
		protected function alwaysMatches(input:XML):Boolean
		{
			return true;
		}
		
		protected var reflector:XMLReflector;
		
		public function on(target:Object, ... additionalTargets):Array
		{
			reflector.setTargets(target, additionalTargets);
			return reflector.find(this);
		}
		
		protected var nameMatches:Function;
		protected var metadataMatches:Function;
		protected var signatureMatches:Function;
		protected var returnTypeMatches:Function;
		
		public function matches(input:*):Boolean
		{
			return input is XML
					&& nameMatches(input)
					&& metadataMatches(input)
					&& signatureMatches(input)
					&& returnTypeMatches(input);
		}
	}
}