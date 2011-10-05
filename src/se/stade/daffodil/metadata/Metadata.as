package se.stade.daffodil.metadata
{
    public final class Metadata
    {
        public function Metadata(name:String, parameters:Vector.<MetadataParameter> = null)
        {
            _name = name;
            _parameters = parameters || new Vector.<MetadataParameter>;
        }
        
        private var _name:String;
        public function get name():String
        {
            return _name;
        }
        
        private var _parameters:Vector.<MetadataParameter>;
        public function get parameters():Vector.<MetadataParameter>
        {
            return _parameters;
        }
    }
}
