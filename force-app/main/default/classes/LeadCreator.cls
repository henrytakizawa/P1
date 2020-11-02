public class LeadCreator {

    public id contactId;
    public id leadId;
    public Lead l {get;set;}
    public ApexPages.StandardController stdCntrlr {get; set;}

    public LeadCreator(ApexPages.StandardController con){
        this.leadId=con.getId();
        this.ContactId=ApexPages.currentPage().getParameters().get('userId');
        stdCntrlr = con;
    }
    
    public Lead createLead(){
       return (new Lead(Company='web-to-lead', Status='Open - Not Contacted', MobilePhone='1231231234', FirstName=String.valueOf(User.FirstName)));
    }
    
    public void saveLeadInfo(){
        l = createLead();
        insert l;
    }
    
    public void setLeadInfo(){
        
        Contact theContact;
        Lead theLead;
        
        if(contactId!=null){
            
        	theContact=[SELECT id,FirstName,LastName
                      	FROM Contact
                       	WHERE id=:contactId];
            
        }else
            return;
        
        if (leadId!=null){
           	theLead=[SELECT id,FirstName,LastName
                   	FROM Lead
                 	WHERE id=:leadId];
            	theLead.FirstName = theContact.FirstName;
        	theLead.LastName = theContact.LastName;
        	theLead.status = 'Open - Not Contacted';
        	theLead.Company = 'web-to-lead';
        	theLead.MobilePhone = theContact.Phone;

       		insert theLead;    
        }else{
           	theLead.FirstName = theContact.FirstName;
        	theLead.LastName = theContact.LastName;
        	theLead.status = 'Open - Not Contacted';
        	theLead.Company = 'web-to-lead';
        	theLead.MobilePhone = theContact.Phone;
            
            	update theLead;

        }  
    }
}