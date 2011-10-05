package se.stade.daffodil.metadata
{
    import se.stade.daffodil.Reflect;
    import se.stade.daffodil.Type;
    import se.stade.daffodil.properties.Property;

    public final class MetadataMapper implements MetadataReflection
    {
        public function MetadataMapper(name:String, limit:uint = uint.MAX_VALUE)
        {
            this.name = name;
            this.limit = limit;
        }

        private var name:String;
        private var limit:uint;
        private var metadata:Vector.<Metadata>;

        public function on(member:Type):MetadataReflection
        {
            metadata = new <Metadata>[];
            
            if (member)
            {
                for each (var data:Metadata in member.metadata)
                {
                    if (data.name == name && metadata.length < limit)
                        metadata.push(data);
                }
            }

            return this;
        }
        
        private function createDynamicMaps():Array
        {
            var instances:Array = [];
            
            for each (var data:Metadata in metadata)
            {
                var object:Object = {};
                
                for each (var parameter:MetadataParameter in data.parameters)
                {
                    object[parameter.name] = parameter.value;
                }
                
                instances.push(object);
            }
            
            return instances;
        }
        
        private function createStaticMaps(Definition:Class):Array
        {
            var instances:Array = [];
            
            for each (var data:Metadata in metadata)
            {
                var instance:Object = new Definition;
                
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

        public function createValueList():Array
        {
            var values:Array = [];
            
            for each (var data:Metadata in metadata)
            {
                for each (var parameter:MetadataParameter in data.parameters)
                {
                    values.push(parameter.value);
                }
            }
            
            return values;
        }

        public function into(Definition:Class):*
        {
            var instances:Array;
            
            switch (Definition)
            {
                case Object:
                    instances = createDynamicMaps();
                    break;
                
                case String:
                    instances = createValueList();
                    break;
                
                default:
                    instances = createStaticMaps(Definition);
                    break;
            }
            
            return limit == 1 ? instances[0] : instances;
        }
    }
}
