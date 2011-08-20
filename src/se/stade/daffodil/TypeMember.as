package se.stade.daffodil
{
	public interface TypeMember extends Type
	{
		function get type():String;
        
        function get owner():*;
	}
}