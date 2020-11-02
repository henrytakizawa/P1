public class TrackingController {
    public String nameCase {get;set;}
    public List<Mail__c> matchingMail{get;set;}
    public String errorMessage {get;set;}
    
    public void returnMatchingPackages(){
        try{
            this.errorMessage = '';
            //should be Id, Name, Delivery_Status__c, Weight__c, Fragile__c, Mailing_Address__c, Insurance__c, Value__c, Missing__c
            String queryString = 'SELECT Id, Name, Delivery_Status__c, Weight__c, Fragile__c, Mailing_Address__c, Insurance__c, Value__c, Missing__c FROM Mail__c';
            String n;
            if(this.nameCase!=null){
                n= this.nameCase ;
                //in final should be WHERE Name in final
                queryString += ' WHERE Name LIKE :n';
            }
            List<Mail__c> cL = new List<Mail__c>();
            cL = Database.query(queryString);
            system.debug(cL);
            if(cL.size() == 0){
                this.errorMessage = 'Invalid Tracking Number please try again.';
            }else{
            	for(Mail__c c: cL){
                	if(Schema.SObjectType.Mail__c.fields.Delivery_Status__c.isAccessible()){
                	}else{
                    	c.Delivery_Status__c = null;
                	}
            	}
            }
            this.matchingMail = cL;
        }
        catch(Exception e){
            this.errorMessage = 'Please enter a Tracking Number in the above text box.';
            this.matchingMail = new List<Mail__c>();
        }
    }
}