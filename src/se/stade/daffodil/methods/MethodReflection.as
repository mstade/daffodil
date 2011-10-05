package se.stade.daffodil.methods
{
    import se.stade.daffodil.Reflection;

    public interface MethodReflection extends Reflection
    {
        function named(name:String):MethodReflection;
        
        function withMetadata(name:String):MethodReflection;
        
        function get withArguments():MethodReflection;

        function get withoutArguments():MethodReflection;

        function get withOnlyOptionalArguments():MethodReflection;
        
        function withArgumentCount(count:uint):MethodReflection;

        function withSignature(type:Class, ... types):MethodReflection;
        
        function withReturnType(type:Class):MethodReflection;
    }
}
