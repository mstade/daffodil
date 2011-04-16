package se.stade.daffodil.metadata
{
    import flash.system.ApplicationDomain;
    
    import se.stade.daffodil.TypeMember;

    public class MockMember implements TypeMember
    {
        public function get type():String
        {
            return "MockMember";
        }

        public function definition(domain:ApplicationDomain=null):Class
        {
            return MockMember;
        }

        public function get metadata():Vector.<Metadata>
        {
            return new <Metadata>[
                new Metadata("foo", 
                    new <MetadataParameter>[
                        new MetadataParameter("name", "bar")
                    ])
            ];
        }

        public function get name():String
        {
            return "MockMember";
        }
    }
}