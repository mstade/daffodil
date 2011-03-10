package se.stade.daffodil
{

	public interface TypeInspector
	{
		function find(reflection:Reflection):Array;
		
		function findFirst(reflection:Reflection):Type;
	}
}