package se.stade.daffodil.types
{
	import flash.system.ApplicationDomain;
	
	import se.stade.daffodil.Reflect;
	import se.stade.daffodil.Type;
	import se.stade.daffodil.metadata.Metadata;
	import se.stade.daffodil.methods.Method;
	
	public final class QualifiedType implements Type
	{
		public function QualifiedType(constructor:Method, extendedTypes:Vector.<String>, implementedInterfaces:Vector.<String>)
		{
			_constructor = constructor;
			_packageName = qualifiedName.substr(0, Math.max(0, qualifiedName.indexOf(":")));
			_extendedTypes = extendedTypes || new Vector.<String>;
			_implementedInterfaces = implementedInterfaces || new Vector.<String>;
		}
		
		public function get name():String
		{
			return constructor.name;
		}
		
		private var _constructor:Method;
		public function get constructor():Method
		{
			return _constructor;
		}
		
		private var _packageName:String;
		public function get packageName():String
		{
			return _packageName;
		}
		
		public function get qualifiedName():String
		{
			return constructor.type;
		}
		
		private var _extendedTypes:Vector.<String>;
		public function get extendedTypes():Vector.<String>
		{
			return _extendedTypes;
		}
		
		private var _implementedInterfaces:Vector.<String>;
		public function get implementedInterfaces():Vector.<String>
		{
			return _implementedInterfaces;
		}
		
		public function get metadata():Vector.<Metadata>
		{
			return constructor.metadata;
		}
		
		public function toString():String
		{
			return "[QualifiedType " + qualifiedName + "]";
		}
		
		public function definition(domain:ApplicationDomain = null):Class
		{
			return Reflect.definition(qualifiedName, domain);
		}
	}
}