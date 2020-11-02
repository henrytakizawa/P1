public class POTSMyMailController {
    
    //get name of running user
    String un = UserInfo.getName();
    public List<Mail__c> returnedPackages {get;set;}
 
    //return a list of packages that are 'In Transit'
    public void getPackages() {
        //compare running user's name to addressee. Record Type must also be Package and Delivery Status must be In Transit
        String queryString = 'SELECT Name, Addressed_To__c, Mailing_Address__c, Delivery_Status__c, RecordTypeId FROM Mail__c WHERE RecordType.Name = \'Package\''+
            					' AND Delivery_Status__c = \'In Transit\' AND Addressed_To__c = :un';
		System.debug(un);
        returnedPackages =  Database.query(queryString);
    }
    
    //return a list of packages that are 'Delivered'
    public void getSentPackages() {
        //compare running user's name to addressee. Record Type must also be Package and Delivery Status must be Delivered  
        String queryString = 'SELECT Name, Addressed_To__c, Mailing_Address__c,  Delivery_Status__c, RecordTypeId FROM Mail__c WHERE Delivery_Status__c = \'Delivered\''+
            					'AND RecordType.Name = \'Package\' AND Addressed_To__c = :un';
        
        returnedPackages =  Database.query(queryString);
    }
}