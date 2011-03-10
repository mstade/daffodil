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
						property = Reflect.properties.named(parameter.value).thatAreWritable.on(instance)[0];
						
						if (property == false)
							property = Reflect.properties.withMetadata("DefaultProperty").thatAreWritable.on(instance)[0];
					}
					else
						property = Reflect.properties.named(parameter.name).thatAreWritable.on(instance)[0];

					if (property)
						property.value = parseValue(property.type, parameter.name, parameter.value);
				}
				
				instances.push(instance);
			}

			return instances;
		}
		
		public function asOne(definition:Class):*
		{
			return asType(definition)[0];
		}


		private function parseValue(type:String, name:String, value:String):*
		{
			switch (type)
			{
				case "Number":
				case "int":
				case "uint":
					return parseFloat(value);

				case "Boolean":
					value = value.toLowerCase();
					return value == "true"
						|| value == "yes"
						|| (!name && value);

				case "Date":
					return new Date(Date.parse(value));

				case "Class":
					return getDefinitionByName(value);

				default:
					return value;
			}
		}
	}
}