package se.stade.daffodil.methods
{
	import flash.errors.IllegalOperationError;
	
	import se.stade.daffodil.metadata.Metadata;

	public final class Delegate extends AbstractMethod implements Method
	{
		public function Delegate(owner:Object, name:String, parameters:Vector.<Parameter>, type:String, metadata:Vector.<Metadata>)
		{
			super(name, type, parameters, metadata);
			this.owner = owner;
		}
		
		private var owner:Object;
		
		public function invoke(... parameters):*
		{
			if (name in owner == false)
				throw new IllegalOperationError("Method not found on owner");
			else if (owner[name] is Function == false)
				throw new IllegalOperationError("Member '" + name + "' on owner is not a Function");
			
			if (parameters.length == 1 && parameters[0] is Array)
			{
				parameters = parameters[0];
			}
			
			var delegate:Function = owner[name] as Function;
			return delegate.apply(owner, parameters);
		}
		
		public function toString():String
		{
			return "[Function " + name + "(" + parameters.join(", ") + ")]";
		}
	}
}