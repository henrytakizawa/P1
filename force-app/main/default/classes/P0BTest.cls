@isTest
public class P0BTest {
    
    @TestSetup
    static void MakeData(){
        List<Opportunity> newOpps = TestDataFactory.createOpportunity(10, date.newInstance(2011, 1, 1), 'testOpp');
        insert newOpps;
    }
    
    @isTest
    public static void testPastDueOpps(){
        P0B.closePastDueOpportunities();
        Opportunity testOpp = [SELECT Name, stageName FROM Opportunity WHERE Name LIKE 'testOpp%' LIMIT 1];
        System.assertEquals('Closed Lost', testOpp.StageName);
    }

    @isTest
    public static void nFibonacciTest(){
        system.assertEquals(55, p0b.nFibonacci(10));
        system.assertEquals(1, p0b.nFibonacci(1));
        system.assertEquals(1, p0b.nFibonacci(2));
        system.assertEquals(0, p0b.nFibonacci(0));    
    }
    
    @isTest
    public static void nFibonacciNegativeTest(){
        boolean errorCaught = false;
        try{
        	p0b.nFibonacci(-3);
    	}catch(nFibonacciException e){
        	system.debug(e.getMessage());
        	errorCaught = true;
    	}
    	system.assert(errorCaught);
    }
}