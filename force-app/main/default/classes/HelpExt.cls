public class HelpExt {
    public List<Case> openCases {get;set;}
    public List<Case> closedCases {get;set;}
    public String caseToComment {get;set;}
    
    //Custom controls for display table results
    Integer pageSize = 5;
    Integer indexOpen = 0;
    Integer indexClosed = 0;
    Integer totalOpenCases, totalClosedCases;
    //SOQL Query Strings
    String openCasesQuery = 'SELECT Subject, Status, Reason, CreatedDate FROM Case WHERE Status != \'Closed\' AND Type = \'Postal\' ORDER BY CreatedDate DESC LIMIT :pageSize OFFSET :indexOpen';
    String closedCasesQuery = 'SELECT Subject, CreatedDate, ClosedDate FROM Case WHERE Status = \'Closed\' AND Type = \'Postal\' LIMIT :pageSize OFFSET :indexClosed';
    //may need to restrict queries further if they are seeing cases they don't own
    
    public HelpExt(ApexPages.StandardController sc){
        
    }
    
    public HelpExt(ApexPages.StandardSetController ssc){
        openCases = Database.query(openCasesQuery);
        closedCases = Database.query(closedCasesQuery);
        //Get total number of active and inactive cases
        totalOpenCases = [SELECT Count() FROM Case WHERE Status != 'Closed' AND Type = 'Postal'];
        totalClosedCases = [SELECT Count() FROM Case WHERE Status = 'Closed' AND Type = 'Postal'];
    }
    
    public void nextOpenCases(){
        indexOpen += pageSize;
        if(indexOpen > totalOpenCases-1){
            indexOpen = 0;
        }
        openCases = Database.query(openCasesQuery);
    }
    
    public void nextClosedCases(){
        indexClosed += pageSize;
        if(indexClosed > totalClosedCases-1){
            indexClosed = 0;
        }
        closedCases = Database.query(closedCasesQuery);
    }
    
    public void prevOpenCases(){
        indexOpen -= pageSize;
        if(indexOpen < 0){
            indexOpen = totalOpenCases - Math.mod(totalOpenCases, pageSize);
        }
        openCases = Database.query(openCasesQuery);
    }
    
    public void prevClosedCases(){
        indexClosed -= pageSize;
        if(indexClosed < 0){
            indexClosed = totalClosedCases - Math.mod(totalClosedCases, pageSize);
        }
        closedCases = Database.query(closedCasesQuery);
    }
    
    public PageReference goToSupportWizard(){
        return Page.supportStart;
    }
    
    public PageReference addComment(){
        PageReference newPage = Page.commentPage;
        //pass case id from Add Comment button to new page
        newPage.getParameters().put('id', caseToComment);
        
        return newPage;
    }
}