public class contactUserExtension {
    
    public Id getContactId(){
        User u = [SELECT Id, ContactId FROM USER WHERE Id=:UserInfo.getUserId() LIMIT 1];
        return u.ContactId; 
    }

    //public boolean pageLoaded{get;set;}
    
    public contactUserExtension(ApexPages.StandardController sc){
        //this.pageLoaded = false;
    }
}