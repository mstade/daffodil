package se.stade.daffodil.metadata
{
    import org.flexunit.assertThat;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.notNullValue;
    
    public class MetadataTest
    {       
        [Test]
        public function shouldCreateMetadataWithEmptyParameterList():void
        {
            var metadata:Metadata = new Metadata("test");
            
            assertThat(metadata.name, equalTo("test"));
            assertThat(metadata.parameters, notNullValue());
            assertThat(metadata.parameters.length, equalTo(0));
        }
        
        [Test]
        public function shouldCreateMetadataWithAssignedParameterList():void
        {
            var parameters:Vector.<MetadataParameter> = new <MetadataParameter>[];
            var metadata:Metadata = new Metadata("test", parameters);
            
            assertThat(metadata.name, equalTo("test"));
            assertThat(metadata.parameters, equalTo(parameters));
        }
    }
}
