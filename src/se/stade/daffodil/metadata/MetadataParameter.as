package se.stade.daffodil.metadata
{
	public final class MetadataParameter
	{
		public function MetadataParameter(name:String, value:String)
		{
			_name = name;
			_value = value;
		}
		
		private var _name:String;
		public function get name():String
		{
			return _name;
		}
		
		private var _value:String;
		public function get value():String
		{
			return _value;
		}
	}
}