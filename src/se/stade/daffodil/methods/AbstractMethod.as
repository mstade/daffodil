package se.stade.daffodil.methods
{
    import se.stade.daffodil.Type;
    import se.stade.daffodil.metadata.Metadata;

    internal class AbstractMethod implements Type
    {
        public function AbstractMethod(name:String, type:String, parameters:Vector.<Parameter> = null, metadata:Vector.<Metadata> = null)
        {
            _name = name;
            _type = type;
            
            _parameters = parameters || new Vector.<Parameter>;
            _parameters.fixed = true;
            
            _minRequiredParameters = 0;
            for each (var parameter:Parameter in parameters)
            {
                if (parameter.isOptional)
                    continue;
                else
                    _minRequiredParameters++;
            }
            
            _metadata = metadata || new Vector.<Metadata>;
            _metadata.fixed = true;
        }
        
        private var _name:String;
        public function get name():String
        {
            return _name;
        }
        
        private var _type:String;
        public function get type():String
        {
            return _type;
        }
        
        private var _parameters:Vector.<Parameter>;
        public function get parameters():Vector.<Parameter>
        {
            return _parameters;
        }
        
        private var _minRequiredParameters:uint;
        public function get minRequiredParameters():uint
        {
            return _minRequiredParameters;
        }
        
        private var _metadata:Vector.<Metadata>;
        public function get metadata():Vector.<Metadata>
        {
            return _metadata;
        }
    }
}
