public class ContactTriggerHandler {
    
    public static void checkAccountMatch(List<Contact> cList){
        List<Account> accList = [SELECT Name, Id, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingState, ShippingStreet, Phone FROM Account];
        for (Contact c : cList){
            for (Account a : accList){
                if (c.AccountId == a.Id){
                    System.debug('This contact already has a related account');
                    break;
                }
                else if (c.MailingCity == a.ShippingCity && c.MailingCountry == a.ShippingCountry &&
                          c.MailingPostalCode == a.ShippingPostalCode && c.MailingState == a.ShippingState &&
                          c.MailingStreet == a.ShippingStreet && c.Phone == a.Phone){
                    c.AccountId = a.Id;
                    System.debug('A matching account has been found and has been related to the new contact.');
                    break;
                }
                else {
                    continue;
                }
            }
        }
    }
}