package se.stade.daffodil
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	internal final class XMLDescriptionCache
	{
		private var descriptions:Dictionary = new Dictionary(true);
		
		public function retrieve(key:*):XML
		{
			if (key is Class == false)
			{
				var qualifiedType:String = getQualifiedClassName(key);
				key = getDefinitionByName(qualifiedType);
			}
			
			if (key in descriptions == false)
			{
				descriptions[key] = describeType(key);
			}
				
			return descriptions[key];
		}
	}
}