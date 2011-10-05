package se.stade.daffodil
{
    import flash.utils.getQualifiedClassName;

    public function qualify(type:*):String
    {
        try
        {
            return getQualifiedClassName(type);
        }
        catch (e:Error) {}
        
        return undefined;
    }
}
