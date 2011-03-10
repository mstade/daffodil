package se.stade.daffodil
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;

	internal final class XMLDescriptionCache
	{
		private var descriptions:Dictionary = new Dictionary(true);
		
		public function retrieve(key:*):XML
		{
			if (key in descriptions == false)
			{
				descriptions[key] = describeType(key);
			}
				
			return descriptions[key];
		}
	}
}