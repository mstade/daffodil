package se.stade.daffodil
{
    public interface Reflection
    {
        function matches(input:*):Boolean;
        function on(target:Object, ... additionalTargets):*;
    }
}
