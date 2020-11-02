/////////////////////////////////////////////////////////////////
 //
 // Name: Project 0 Bravo
 // Author: Henry Takizawa (henry.takizawa@revature.net)
 // Date: 09/15/2020
 // Description: Series of apex methods to demonstrate
 // basic understanding of coding concepts.
 //
 /////////////////////////////////////////////////////////////////

public class P0B {

	/*
	 * 1. Return the nth Fibonacci number
 	 * Test Cases:
	 * Input: 0 Output: 0
	 * Input: 1 Output: 1
	 * Input: 2 Output: 1
	 * Input: 10 Output: 55
	 */
    
    public static Integer nFibonacci(Integer n){
        if (n<=1){
            return n;
        }
        else {
            return nFibonacci(n-1) + nFibonacci(n-2);
        }
    }
    
    /*
	 * 2. Sort a list of integers.
	 * Test Cases:
	 * Input: [2,4,5,1,3,1] Output: [1,1,2,3,4,5]
	 * Input: [5,4,3,2,1] Output: [1,2,3,4,5]
	 *
	 * Don't use the sort() method... that would be lame.
	 */

    public static List<Integer> sortList(List<Integer> intList){
        for (integer i = intList.size()-1; i>=0; i--){
            for (integer j =1; j<=i; j++){
                if (intList[j-1] > intList[j]){
                    integer temp = intList[j-1];
                    intList[j-1] = intList[j];
                    intList[j] = temp;
                }
            }
        }
        return intList; 
    }
    
    /*
	 * 3. Return the factorial of n.
	 * Test Cases:
	 * Input: 0 Output: 1
	 * Input: 1 Output: 1
	 * Input: 3 Output: 6
	 */
    
    public static Integer nFactorial(Integer n){
        if (n == 0){
            return 1;
        }
        else {
            return n*nFactorial(n-1);
        }
    }
    
    /*
	 * 4. Rotate left
	 * Given a list, list, and an integer, n, rotate the values in list left n times and return list
	 * Test Cases:
	 * Input: [1,2,3,4,5], 1 Output: [2,3,4,5,1]
	 * Input: [1,2,3,4,5], 6 Output: [2,3,4,5,1]
	 * Input: [1,2,3,4,5], 3 Output: [4,5,1,2,3]
	 */
	public static List<Integer> rotateLeftNTimes(List<Integer> nList, Integer n) {
        if (n == 0){
            return nList;
        }
        else if (n >= nList.size()){
            n = math.mod(n, nList.size());
            rotateLeftNTimes(nList, n);
        }
        else {
            List<Integer> temp = new List<Integer>();
            for (integer i = 0; i < n; i++){
                temp.add(nList[i]);
            }
            for (integer j = n; j < nList.size(); j++){
                nList[j-n] = nList[j];
            }
            for (integer k = 0; k < temp.size(); k++){
                nList[nList.size()-1-k] = temp[temp.size()-k-1];
            }
        }
        return nList;
    }
    
    /*
	 * 5. Balanced Brackets
	 * A bracket is any one of the following: (, ), {, }, [, or ]
	 *
	 * The following are balanced brackets:
	 * ( )
	 * ( ) ( )
	 * ( ( ) )
	 * ( { [ ] } )
	 *
	 * The following are NOT balanced brackets:
	 * (
	 * )
	 * ( ( )
	 * ( [ ) ]
	 *
	 * Return true if balanced
	 * Return false if not balanced
	 */
	 public static Boolean bracketsAreBalanced( String s ) {
         boolean result = true;
         List<String> stack = new List<String>();
         for (integer i = 0; i < s.length(); i++){
             if (s.mid(i,1).equals('(') || s.mid(i,1).equals('[') || s.mid(i,1).equals('{')){
                 stack.add(s.mid(i,1));
                 continue;
             }
             else {
                 switch on s.mid(i,1){
                     when ')'{
                         if (stack.get(stack.size()-1).equals('(')){
                             stack.remove(stack.size()-1);
                             continue;
                         }
                         else {
                             result = false;
                         }
                     }
                     when ']'{
                         if (stack.get(stack.size()-1).equals('[')){
                             stack.remove(stack.size()-1);
                             continue;
                         }
                         else {
                             result = false;
                         }
                     }
                     when '}'{
                         if (stack.get(stack.size()-1).equals('{')){
                             stack.remove(stack.size()-1);
                             continue;
                         }
                         else {
                             result = false;
                         }
                     }
                 }
             } 
         }
         return result;
     }
    
     /*
	 * 6. Create a method that retrieves a list of all accounts and updates those accounts.
	 * Create a custom field on the Account standard object called Size__c that will be a
	 * picklist containing small/medium/large.
	 * Create a method that retrieves a list of all accounts.
	 * - If an account has between 1-1000 employees then it is classified as small.
	 * - If an account has between 1001-10000 employees it is classified as medium.
	 * - If an account has more than 10000 employees it is classified as large.
	 * Update the Size__c field on each account to reflect the amount of employees in the Account.
	 */
	 public static void updateAccountSize() {
         List<Account> accList = [SELECT NumberOfEmployees, Size__c FROM Account];
         for (Account a : accList){
             if (a.NumberOfEmployees > 1 && a.NumberOfEmployees <= 1000){
                 a.Size__c = 'Small';
             }
             else if (a.NumberOfEmployees <= 10000){
                 a.Size__c = 'Medium';
             }
             else if (a.NumberOfEmployees > 10000){
                 a.Size__c = 'Large';
             }
         }
         update accList;
	 }

     /* 
	 * 7. Create a method that will find all leads that contain 'ca' in their fields.
	 * If a lead is located in California(CA), change their Lead Status field to 'Closed - Not
	 * Converted' and their description should display the message, "We are no longer doing
	 * business in California."
	 */
	 public static void updateCALeads() {
         List<Lead> caList = [SELECT Address, Status, Description FROM Lead WHERE State = 'ca'];
         for (Lead l : caList){
             l.Status = 'Closed - Not Converted';
             l.Description = 'We are no longer doing business in California.';
         }
         update caList;
     }

     /*
	 * 8. Create a method that will find all Opportunities which have already passed their Close Date
	 * and have a Stage field that is not 'Closed Won'. Since they have passed their Close Date and
	 * they are not marked as 'Closed Won', they should be marked as 'Closed Lost'.
	 */
	 public static void closePastDueOpportunities() {
         List<Opportunity> pastDues = [SELECT CloseDate, StageName FROM Opportunity WHERE CloseDate < TODAY AND StageName != 'Closed Won'];
         for (Opportunity o: pastDues){
             o.StageName = 'Closed Lost';
         }
         update pastDues;
	 }
}