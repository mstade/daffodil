package se.stade.daffodil
{
    import flash.utils.getQualifiedClassName;

    public function qualify(type:Class):String
    {
        try
        {
            return getQualifiedClassName(type);
        }
        catch (e:Error) {}
        
        return undefined;
    }
}