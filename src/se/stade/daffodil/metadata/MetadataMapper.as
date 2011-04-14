package se.stade.daffodil.metadata
{
	import flash.utils.getDefinitionByName;
	
	import se.stade.daffodil.Reflect;
	import se.stade.daffodil.Reflection;
	import se.stade.daffodil.Type;
	import se.stade.daffodil.properties.Property;

	public final class MetadataMapper implements MetadataReflection
	{
		public function MetadataMapper(name:String)
		{
			this.name = name;
		}

		private var name:String;
		private var metadata:Vector.<Metadata>;

		public function on(member:Type):MetadataReflection
		{
			metadata = new <Metadata>[];

			for each (var data:Metadata in member.metadata)
			{
				if (data.name == name)
					metadata.push(data);
			}

			return this;
		}
        
        public function get asDynamic():Object
        {
            var dynamic:Object = {};
            
            for each (var data:Metadata in metadata)
            {
                for each (var parameter:MetadataParameter in data.parameters)
                {
                    dynamic[parameter.name] = parseValue(parameter.name, parameter.value);
                }
            }
            
            return dynamic;
        }

        public function get asValue():String
        {
            for each (var data:Metadata in metadata)
            {
                for each (var parameter:MetadataParameter in data.parameters)
                {
                    return parseValue(parameter.name, parameter.value);
                }
            }
            
            return "";
        }

		public function asType(definition:Class):Array
		{
			var instances:Array = [];

			for each (var data:Metadata in metadata)
			{
				var instance:Object = new definition;

				for each (var parameter:MetadataParameter in data.parameters)
				{
					var property:Property;

					if (!parameter.name)
					{
						property = Reflect.first.property
                                          .named(parameter.value)
                                          .withWriteAccess
                                          .on(instance);
						
						if (!property)
							property = Reflect.first.property
                                              .withMetadata("DefaultProperty")
                                              .withWriteAccess
                                              .on(instance);
					}
					else
						property = Reflect.first.property
                                          .named(parameter.name)
                                          .withWriteAccess
                                          .on(instance);

					if (property)
						property.value = parseValue(parameter.name, parameter.value, property.type);
				}
				
				instances.push(instance);
			}

			return instances;
		}
		
		public function asOne(definition:Class):*
		{
			return asType(definition)[0];
		}
        
		private function parseValue(name:String, value:String, type:String = "*"):*
		{
            const booleanValues:Object = {
                "true": true,
                "false": false,
                "yes": true,
                "no": false
            };
            
			switch (type)
			{
				case "Number":
				case "int":
				case "uint":
					return parseFloat(value);

				case "Boolean":
					value = value.toLowerCase();
					return booleanValues[value] || (value && !name);

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