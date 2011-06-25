package se.stade.daffodil.methods
{
	import flash.errors.IllegalOperationError;
	
	import se.stade.daffodil.metadata.Metadata;

	public final class Delegate extends AbstractMethod implements Method
	{
		public function Delegate(owner:Object, name:String, parameters:Vector.<Parameter>, type:String, metadata:Vector.<Metadata>)
		{
			super(name, type, parameters, metadata);
			_owner = owner;
		}
		
		private var _owner:*;
        public function get owner():*
        {
            return _owner;
        }
		
		public function invoke(arguments:Array):*
		{
			if (name in owner == false)
				throw new IllegalOperationError("Method not found on owner");
			else if (owner[name] is Function == false)
				throw new IllegalOperationError("Member '" + name + "' on owner is not a Function");
            else if (arguments.length < minRequiredParameters)
                throw new IllegalOperationError("Method requires at least" + minRequiredParameters + " arguments, got " + arguments.length);
            
			var delegate:Function = owner[name] as Function;
			return delegate.apply(owner, arguments);
		}
		
		public function toString():String
		{
			return "[Function " + name + "(" + parameters.join(", ") + ")]";
		}
	}
}