package se.stade.daffodil.metadata
{
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasProperty;
	
	import se.stade.daffodil.TypeMember;
	
	public class MetadataMapperTest
	{
        private var member:TypeMember;
        private var mapper:MetadataMapper;
        
		[Before]
		public function setUp():void
		{
            member = new MockMember;
            mapper = new MetadataMapper("foo");
		}
        
        [Test]
        public function shouldReturnItself():void
        {
            var self:MetadataReflection = mapper.on(member);
            
            assertThat(self, equalTo(mapper));
        }
        
        [Test]
        public function shouldReturnValueOfMetadata():void
        {
            var value:String = mapper.on(member).asValue;
        }
		
		[Test]
		public function shouldReturnInstanceOfCustomMetadata():void
		{
            var result:Array = mapper.on(member).asType(CustomMetadata);
            
            assertThat(result.length, equalTo(1));
            assertThat(result[0], hasProperty("name"));
            assertThat(result[0].name, equalTo("bar"));
		}
	}
}