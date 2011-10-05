package se.stade.daffodil.metadata
{
    import flexunit.framework.Assert;
    
    import org.flexunit.assertThat;
    import org.hamcrest.core.isA;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.hasProperty;
    import org.hamcrest.object.notNullValue;
    
    import se.stade.daffodil.TypeMember;
    
    public class MetadataMapperTest
    {
        private var member:TypeMember;
        private var mapper:MetadataMapper;
        
        [Before]
        public function setUp():void
        {
            member = new MockMember;
            mapper = new MetadataMapper("foo", 1);
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
            var value:String = mapper.on(member).into(String);
        }
        
        [Test]
        public function shouldReturnInstanceOfCustomMetadata():void
        {
            var result:CustomMetadata = mapper.on(member).into(CustomMetadata);
            
            assertThat(result, notNullValue());
            assertThat(result.name, equalTo("bar"));
        }
    }
}
