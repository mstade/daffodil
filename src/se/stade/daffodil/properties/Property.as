package se.stade.daffodil.properties
{
    import se.stade.daffodil.TypeMember;

    public interface Property extends TypeMember
    {
        function get value():*;

        function set value(newValue:*):void;

        function get isReadable():Boolean;

        function get isWritable():Boolean;
    }
}
