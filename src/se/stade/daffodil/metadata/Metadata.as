package se.stade.daffodil.metadata
{
	public final class Metadata
	{
		public function Metadata(name:String, properties:Vector.<MetadataProperty> = null)
		{
			_name = name;
			_properties = properties || new Vector.<MetadataProperty>;
		}
		
		private var _name:String;
		public function get name():String
		{
			return _name;
		}
		
		private var _properties:Vector.<MetadataProperty>;
		public function get properties():Vector.<MetadataProperty>
		{
			return _properties;
		}
	}
}