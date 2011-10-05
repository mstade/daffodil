package se.stade.daffodil.metadata
{
    import se.stade.daffodil.Type;

    public interface MetadataReflection
    {
        function into(definition:Class):*;
        function on(member:Type):MetadataReflection;
    }
}
