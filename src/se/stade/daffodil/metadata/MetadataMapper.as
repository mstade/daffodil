package se.stade.daffodil.metadata
{
	import se.stade.daffodil.Reflect;
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
            
            if (member)
            {
    			for each (var data:Metadata in member.metadata)
    			{
    				if (data.name == name)
    					metadata.push(data);
    			}
            }

			return this;
		}
        
        public function get asObject():Object
        {
            var object:Object = {};
            
            for each (var data:Metadata in metadata)
            {
                for each (var parameter:MetadataParameter in data.parameters)
                {
                    object[parameter.name] = parameter.value;
                }
            }
            
            return object;
        }

        public function get asValue():String
        {
            for each (var data:Metadata in metadata)
            {
                for each (var parameter:MetadataParameter in data.parameters)
                {
                    return parameter.value;
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
					var property:Property = Reflect.first.property
                                                   .named(parameter.name || parameter.value)
                                                   .withWriteAccess
                                                   .on(instance)
                                            ||
                                            Reflect.first.property
                                                   .withMetadata("DefaultProperty")
                                                   .withWriteAccess
                                                   .on(instance);

					if (property)
						property.value = parameter.valueAs(property.type);
				}
				
				instances.push(instance);
			}

			return instances;
		}
		
		public function asOne(definition:Class):*
		{
			return asType(definition)[0];
		}
	}
}