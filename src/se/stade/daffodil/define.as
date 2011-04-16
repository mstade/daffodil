package se.stade.daffodil
{
    import flash.system.ApplicationDomain;

    public function define(qualifiedName:String, domain:ApplicationDomain = null):Class
    {
        return Reflect.definition(qualifiedName, domain);
    }
}