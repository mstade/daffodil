package se.stade.daffodil
{
	import flash.system.ApplicationDomain;
	
	import se.stade.daffodil.metadata.Metadata;

	public interface Type
	{
		function get name():String;

		function get metadata():Vector.<Metadata>;
		
		function definition(domain:ApplicationDomain = null):Class;
	}
}