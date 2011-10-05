package se.stade.daffodil.properties
{
    public interface NamedPropertyReflection extends PropertyReflection
    {
        function named(name:String):NamedPropertyReflection;
    }
}
