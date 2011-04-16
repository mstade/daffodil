package se.stade.daffodil.properties
{
	import se.stade.daffodil.metadata.Metadata;

	public final class Variable extends AbstractProperty implements Property
	{
		public function Variable(owner:Object, name:String, type:String, metadata:Vector.<Metadata>)
		{
			super(owner, name, type, metadata);
		}
		
		public function set value(newValue:*):void
		{
			owner[name] = newValue;
		}
		
		public function get isReadable():Boolean
		{
			return true;
		}
		
		public function get isWritable():Boolean
		{
			return true;
		}
		
		public function toString():String
		{
			return "[Variable " + name + "]";
		}
	}
}