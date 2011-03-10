package se.stade.daffodil.types
{
	import flash.system.ApplicationDomain;
	
	import se.stade.daffodil.Reflect;
	import se.stade.daffodil.Type;
	import se.stade.daffodil.metadata.Metadata;
	import se.stade.daffodil.methods.Method;
	
	public class QualifiedType implements Type
	{
		public function QualifiedType(qualifiedName:String, constructor:Method, extendedTypes:Vector.<String>, interfaces:Vector.<String>)
		{
			_name = constructor.name;
			_constructor = constructor;
			_packageName = qualifiedName.substr(0, Math.max(0, qualifiedName.indexOf(":")));
			_qualifiedName = qualifiedName;
			_extendedTypes = extendedTypes || new Vector.<String>;
			_implementedInterfaces = implementedInterfaces || new Vector.<String>;
		}
		
		private var _name:String;
		public function get name():String
		{
			return _name;
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
		
		private var _qualifiedName:String;
		public function get qualifiedName():String
		{
			return _qualifiedName;
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
			return Reflect.definition(qualifiedName, domain)
		}
	}
}