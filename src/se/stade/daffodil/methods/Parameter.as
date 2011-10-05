package se.stade.daffodil.methods
{
    public final class Parameter
    {
        public function Parameter(type:String, index:int, isOptional:Boolean)
        {
            _type = type;
            _index = index;
            _isOptional = isOptional;
        }
        
        private var _type:String;
        public function get type():String
        {
            return _type;
        }
        
        private var _index:int;
        public function get index():int
        {
            return _index;
        }
        
        private var _isOptional:Boolean;
        public function get isOptional():Boolean
        {
            return _isOptional;
        }
        
        public function toString():String
        {
            return type.substr(type.lastIndexOf(":") + 1) + (isOptional ? "?" : "");
        }
    }
}
