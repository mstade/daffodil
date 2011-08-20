package se.stade.daffodil
{
	import se.stade.daffodil.metadata.Metadata;
	import se.stade.daffodil.metadata.MetadataParameter;
	import se.stade.daffodil.methods.Constructor;
	import se.stade.daffodil.methods.Delegate;
	import se.stade.daffodil.methods.Method;
	import se.stade.daffodil.methods.MethodReflection;
	import se.stade.daffodil.methods.Parameter;
	import se.stade.daffodil.properties.Accessor;
	import se.stade.daffodil.properties.Constant;
	import se.stade.daffodil.properties.ConstantReflection;
	import se.stade.daffodil.properties.NamedPropertyReflection;
	import se.stade.daffodil.properties.Property;
	import se.stade.daffodil.properties.Variable;
	import se.stade.daffodil.types.QualifiedType;
	import se.stade.daffodil.types.TypeReflection;
	
	internal final class XMLReflector
	{
		public function XMLReflector(cache:XMLDescriptionCache, limit:uint = uint.MAX_VALUE)
		{
			this.cache = cache;
            this.limit = limit;
		}
        
        private var limit:uint;
		private var cache:XMLDescriptionCache;
        
		internal var targets:Array;
		
		public function setTargets(target:Object, additionalTargets:Array):void
		{
			if (target is Array)
				targets = target.concat(additionalTargets);
			else
				targets = target ? [target].concat(additionalTargets) : additionalTargets;
		}
		
		public function getDescription(target:Object):XML
		{
			return cache.retrieve(target);
		}
        
		public function find(reflection:Reflection):*
		{
			var result:Array = [];
			
			reflection: for each (var target:Object in targets)
			{
				var parse:Function;
				var elements:XMLList;
				
				if (reflection is TypeReflection)
				{
					parse = parseType;
					elements = XMLList(cache.retrieve(target));
				}
				else if (reflection is MethodReflection)
				{
					parse = parseMethod;
					elements = cache.retrieve(target)..method;
				}
				else if (reflection is NamedPropertyReflection)
				{
					parse = parseProperty;
					
					var description:XML = cache.retrieve(target);
					elements = description..accessor + description..variable;
				}
				else if (reflection is ConstantReflection)
				{
					parse = parseConstant;
					elements = cache.retrieve(target)..constant;
				}
				
				for each (var input:XML in elements)
				{
					if (reflection.matches(input))
                    {
                        result.push(parse(input, target));
                        
                        if (result.length == limit)
                            break reflection;
                    }
				}
			}
			
			return limit == 1 ? result[0] : result;
		}
		
		private function parseType(type:XML, target:Object):QualifiedType
		{
			var metadata:Vector.<Metadata> = parseMetadata(type);
			var parameters:Vector.<Parameter> = parseParameters(type..constructor.parameter);
			var constructor:Method = new Constructor(type.@name, parameters, metadata);

            var extendedTypes:Vector.<String> = parseTypeNames(type..extendsClass);
			var interfaces:Vector.<String> = parseTypeNames(type..implementsInterface);
			
			return new QualifiedType(constructor, extendedTypes, interfaces); 
		}
		
		private function parseTypeNames(types:XMLList):Vector.<String>
		{
			var typeNames:Vector.<String> = new <String>[];
			
			for each (var type:XML in types.@type)
			{
				typeNames.push(type);
			}
			
			return typeNames;
		}
		
		private function parseMethod(method:XML, target:Object):Method
		{
			var name:String = method.@name;
			var metadata:Vector.<Metadata> = parseMetadata(method);
			var parameters:Vector.<Parameter> = parseParameters(method.parameter);
			
			return new Delegate(target, name, parameters, method.@returnType, metadata);
		}
		
		private function parseParameters(parameters:XMLList):Vector.<Parameter>
		{
			var parameterList:Vector.<Parameter> = new <Parameter>[];
			
			for each (var parameter:XML in parameters)
			{
				var type:String = parameter.@type;
				var index:int = int(parameter.@index);
				var isOptional:Boolean = parameter.@optional == "true";
				
				parameterList.push(new Parameter(type, index, isOptional));
			}
			
			return parameterList;
		}
		
		private function parseProperty(input:XML, target:Object):Property
		{
			var name:String = input.@name;
			var type:String = input.@type;
			
			var metadata:Vector.<Metadata> = parseMetadata(input);
			
			if (input.localName() == "variable")
				return new Variable(target, name, type, metadata);
			else
			{
				var isReadable:Boolean = (input.@access.toString().indexOf("read") >= 0);
				var isWritable:Boolean = (input.@access.toString().indexOf("write") >= 0);
				
				return new Accessor(target, name, type, isReadable, isWritable, metadata);
			}
		}

		private function parseConstant(input:XML, target:Object):Constant
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
				var parameters:Vector.<MetadataParameter> = new <MetadataParameter>[];
				
				for each (var parameter:XML in meta.arg)
				{
					parameters.push(new MetadataParameter(parameter.@key, parameter.@value));
				}
				
				metadata.push(new Metadata(meta.@name, parameters));
			}
			
			return metadata;
		}
	}
}