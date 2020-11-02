@isTest
public class TestContactTrigger {

    @testSetup
    public static void contactTriggerTestSetup(){
        Account a1 = new Account(Name = 'Joe Johnson', ShippingCity = 'New York',
                                 ShippingState = 'NY', ShippingCountry = 'United States',
                                 ShippingStreet = '123 Chambers St', ShippingPostalCode = '10019',
                                 Phone = '212-345-6789');
        
        Account a2 = new Account(Name = 'Moe Manson', ShippingCity = 'New York',
                                 ShippingState = 'NY', ShippingCountry = 'United States',
                                 ShippingStreet = '312 Chambers St', ShippingPostalCode = '10019',
                                 Phone = '212-357-6809');
            
        List<Account> aList = new List<Account>();
        aList.add(a1);
        aList.add(a2);
        insert aList;
    }
    
    @isTest 
    public static void contactTriggerRelatedAccExistsTest(){
        Account a1 = [SELECT ID FROM Account WHERE Name = 'Joe Johnson'];
        Contact c1 = new Contact(FirstName = 'Joe', LastName = 'Johnson',
                                 MailingCity = 'New York', MailingState = 'NY',
                                 MailingCountry = 'United States', MailingStreet = '123 Chambers St',
                                 MailingPostalCode = '10019', Phone = '212-345-6789',
                                AccountId = a1.Id);
        
        Test.startTest();
        insert c1;
        Test.stopTest();
        
        system.assert(c1.AccountId == a1.Id);
    }
    
    @isTest
    public static void contactTriggerDetailMatchTest(){
        Contact c2 = new Contact(FirstName = 'Moe', LastName = 'Manson',
                                 MailingCity = 'New York', MailingState = 'NY',
                                 MailingCountry = 'United States', MailingStreet = '312 Chambers St',
                                 MailingPostalCode = '10019', Phone = '212-357-6809');
        Account a2 = [SELECT ID FROM Account WHERE Name = 'Moe Manson'];
        
        Test.startTest();
        insert c2;
        Test.stopTest();
        
        system.assert(c2.AccountId == a2.Id);
    }
    
    @isTest
    public static void contactTriggerNoMatchTest(){
        Contact c3 = new Contact(FirstName = 'Dan', LastName = 'Danson',
                                 MailingCity = 'New York', MailingState = 'NY',
                                 MailingCountry = 'United States', MailingStreet = '231 Chambers St',
                                 MailingPostalCode = '10019', Phone = '212-468-3579');
        
        Test.startTest();
        insert c3;
        Test.stopTest();
        
        
    }
    
    
}