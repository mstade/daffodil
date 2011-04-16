package se.stade.daffodil.properties
{
	import se.stade.daffodil.metadata.Metadata;

	public final class Constant extends AbstractProperty
	{
		public function Constant(owner:Object, name:String, type:String, metadata:Vector.<Metadata>)
		{
			super(owner, name, type, metadata);
		}
		
		public function toString():String
		{
			return "[Constant " + name + "]";
		}
	}
}