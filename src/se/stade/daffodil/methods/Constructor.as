package se.stade.daffodil.methods
{
	import flash.errors.IllegalOperationError;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import se.stade.daffodil.metadata.Metadata;

	public final class Constructor extends AbstractMethod implements Method
	{
		public function Constructor(qualifiedName:String, parameters:Vector.<Parameter> = null, metadata:Vector.<Metadata> = null)
		{
			var name:String = qualifiedName.substr(qualifiedName.lastIndexOf(":") + 1);
			super(name, qualifiedName, parameters, metadata);
            
			Definition = Class(getDefinitionByName(qualifiedName));
		}
		
		private var Definition:Class;
		
		public function invoke(... parameters):*
		{
			// TODO: Figure out a way to dynamically call a constructor with a variable parameterlist. This is fugly!
			if (parameters.length == 0)
				return new Definition();
			else if (parameters.length == 1)
				return new Definition(parameters[0]);
			else if (parameters.length == 2)
				return new Definition(parameters[0], parameters[1]);
			else if (parameters.length == 3)
				return new Definition(parameters[0], parameters[1], parameters[2]);
			else if (parameters.length == 4)
				return new Definition(parameters[0], parameters[1], parameters[2], parameters[3]);
			else if (parameters.length == 5)
				return new Definition(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4]);
			else if (parameters.length == 6)
				return new Definition(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5]);
			else if (parameters.length == 7)
				return new Definition(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5], parameters[6]);
			else if (parameters.length == 8)
				return new Definition(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5], parameters[6], parameters[7]);
			else if (parameters.length == 9)
				return new Definition(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5], parameters[6], parameters[7], parameters[8]);
			else if (parameters.length == 10)
				return new Definition(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5], parameters[6], parameters[7], parameters[8], parameters[9]);
			else
				throw new IllegalOperationError("I'm sorry, I can't handle more than 10 parameters. To be honest, if your class has 10 constructor parameters, it kind of smells.");
		}
		
		public function toString():String
		{
			return "[Class " + name + "(" + parameters.join(", ") + ")]";
		}
	}
}