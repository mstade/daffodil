package se.stade.daffodil
{
	import se.stade.daffodil.metadata.Metadata;

	public interface TypeMember extends Type
	{
		function get type():String;
        
        function get owner():*;
	}
}