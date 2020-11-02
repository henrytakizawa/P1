@isTest
public class TestDataFactory {

    public static List<Opportunity> createOpportunity(Integer n, Date testDate, String name){
        list<Opportunity> newOpps = new List<Opportunity>();
        for (integer i = 0; i < n; i++){
            Opportunity o = new Opportunity();
            o.name = name+i;
            o.StageName = 'New';
            o.CloseDate = testDate;
            newOpps.add(o);
        }
        return newOpps;
    }
}