package se.stade.daffodil
{
	import se.stade.daffodil.metadata.Metadata;
	import se.stade.daffodil.metadata.MetadataProperty;
	import se.stade.daffodil.methods.Delegate;
	import se.stade.daffodil.methods.Method;
	import se.stade.daffodil.methods.MethodReflection;
	import se.stade.daffodil.methods.Parameter;
	import se.stade.daffodil.properties.Accessor;
	import se.stade.daffodil.properties.Constant;
	import se.stade.daffodil.properties.ConstantReflection;
	import se.stade.daffodil.properties.Property;
	import se.stade.daffodil.properties.PropertyReflection;
	
	internal final class XMLReflector implements Reflector
	{
		public function XMLReflector(cache:XMLDescriptionCache, target:Object)
		{
			this.cache = cache;
			this.target = target;
		}
		
		protected var cache:XMLDescriptionCache;
		protected var target:Object;
		
		public function find(reflection:Reflection):Array
		{
			var elements:XMLList;
			var parse:Function;
			
			if (reflection is MethodReflection)
			{
				parse = parseMethod;
				elements = cache.retrieve(target).method
			}
			else if (reflection is PropertyReflection)
			{
				parse = parseProperty;
				
				var description:XML = cache.retrieve(target);
				elements = description.accessor + description.variable;
			}
			else if (reflection is ConstantReflection)
			{
				parse = parseConstant;
				elements = cache.retrieve(target).constant;
			}
			
			var members:Array = [];
			
			for each (var input:XML in elements)
			{
				if (reflection.matches(input))
					members[members.length] = parse(input);
			}
			
			return members;
		}
		
		private function parseMethod(method:XML):Method
		{
			var name:String = method.@name;
			var parameters:Vector.<Parameter> = new <Parameter>[];
			
			for each (var parameter:XML in method.parameter)
			{
				var type:String = parameter.@type;
				var index:int = int(parameter.@index);
				var isOptional:Boolean = parameter.@optional == "true";
				
				parameters.push(new Parameter(type, index, isOptional));
			}
			
			var metadata:Vector.<Metadata> = parseMetadata(method);
			
			return new Delegate(target, name, parameters, method.@returnType, metadata);
		}
		
		private function parseProperty(input:XML):Property
		{
			var name:String = input.@name;
			var type:String = input.@type;
			
			var metadata:Vector.<Metadata> = parseMetadata(input);
			
			var isReadable:Boolean = input.localName() == "variable" || input.@access.toString().indexOf("read") >= 0;
			var isWritable:Boolean = input.localName() == "variable" || input.@access.toString().indexOf("write") >= 0;
			
			return new Accessor(target, name, type, isReadable, isWritable, metadata);
		}

		private function parseConstant(input:XML):Constant
		{
			var name:String = input.@name;
			var type:String = input.@type;
			
			var metadata:Vector.<Metadata> = parseMetadata(input);
			
			return new Constant(target, name, type, metadata);
		}
		
		private function parseMetadata(input:XML):Vector.<Metadata>
		{
			var metadata:Vector.<Metadata> = new <Metadata>[];
			
			for each (var meta:XML in input.metadata)
			{
				var properties:Vector.<MetadataProperty> = new <MetadataProperty>[];
				
				for each (var property:XML in meta.arg)
				{
					properties.push(new MetadataProperty(property.@key, property.@value));
				}
				
				metadata.push(new Metadata(meta.@name, properties));
			}
			
			return metadata;
		}
	}
}