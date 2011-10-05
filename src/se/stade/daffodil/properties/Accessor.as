package se.stade.daffodil.properties
{
    import flash.errors.IllegalOperationError;
    
    import se.stade.daffodil.metadata.Metadata;

    public final class Accessor extends AbstractProperty implements Property
    {
        public function Accessor(owner:Object, name:String, type:String, isReadable:Boolean, isWritable:Boolean, metadata:Vector.<Metadata>)
        {
            super(owner, name, type, metadata);
            
            _isReadable = isReadable;
            _isWritable = isWritable;
        }
        
        public function set value(newValue:*):void
        {
            if (isWritable)
                owner[name] = newValue;
            else
                throw new IllegalOperationError("Property is not writable");
        }
        
        private var _isReadable:Boolean;
        public function get isReadable():Boolean
        {
            return _isReadable;
        }
        
        private var _isWritable:Boolean;
        public function get isWritable():Boolean
        {
            return _isWritable;
        }
        
        public function toString():String
        {
            return "[Property " + name + "]";
        }
    }
}
