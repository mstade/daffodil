package se.stade.daffodil.metadata
{
    import se.stade.daffodil.Reflect;

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
        
        public function valueAs(type:String):*
        {
            switch (type)
            {
                case "Number":
                case "int":
                case "uint":
                    return parseFloat(value);
                    
                case "Boolean":
                    const bool:Object = {
                        "true": true,
                        "false": false,
                        "yes": true,
                        "no": false
                    };
                        
                    var val:String = value.toLowerCase();
                    return bool[val] || (val && !name);
                    
                case "Date":
                    return new Date(Date.parse(value));
                    
                case "Class":
                    return Reflect.definition(value)
                    
                default:
                    return value;
            }
        }
	}
}