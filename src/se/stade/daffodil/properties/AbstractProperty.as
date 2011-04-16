package se.stade.daffodil.properties
{
	import flash.system.ApplicationDomain;
	
	import se.stade.daffodil.Reflect;
	import se.stade.daffodil.Type;
	import se.stade.daffodil.metadata.Metadata;
	
	internal class AbstractProperty implements Type
	{
		public function AbstractProperty(owner:Object, name:String, type:String, metadata:Vector.<Metadata>)
		{
			this.owner = owner;
			
			_name = name;
			_type = type;
			
			_metadata = metadata || new Vector.<Metadata>;
		}
		
		protected var owner:Object;
		
		private var _name:String;
		public function get name():String
		{
			return _name;
		}
		
		private var _type:String;
		public function get type():String
		{
			return _type;
		}
		
		public function get value():*
		{
			return owner[name];
		}
		
		private var _metadata:Vector.<Metadata>;
		public function get metadata():Vector.<Metadata>
		{
			return _metadata;
		}
		
		public function definition(domain:ApplicationDomain = null):Class
		{
			return Reflect.definition(type, domain)
		}
	}
}