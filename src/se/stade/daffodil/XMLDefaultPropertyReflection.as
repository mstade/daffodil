package se.stade.daffodil
{
    internal final class XMLDefaultPropertyReflection extends XMLPropertyReflection
    {
        public function XMLDefaultPropertyReflection(reflector:XMLReflector)
        {
            super(reflector);
        }
        
        public override function on(target:Object, ... additionalTargets):*
        {
            var targetType:Type = Reflect.first.type.on(target);
            var name:String = Reflect.first.metadata("DefaultProperty").on(targetType).into(String);
            
            nameMatches = createNameMatcher(name);
            
            return super.on.apply(this, [target].concat(additionalTargets));
        }
    }
}