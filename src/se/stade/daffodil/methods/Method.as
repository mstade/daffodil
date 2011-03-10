package se.stade.daffodil.methods
{
	import se.stade.daffodil.TypeMember;

	public interface Method extends TypeMember
	{
		function get parameters():Vector.<Parameter>;
		
		function invoke(... parameters):*;
	}
}