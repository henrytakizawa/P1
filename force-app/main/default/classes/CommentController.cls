public class CommentController {
    //get parameter / case id
    public String caseId {get;set;}
    public String newComment {get;set;}
    public List<CaseComment> comments {get;set;}
    //Pagination variables
    Integer index, totalComments;
    Integer pageSize = 5;
    //Query
    String query = 'SELECT CreatedDate, CommentBody, CreatedById FROM CaseComment WHERE ParentId = :caseId ORDER BY CreatedDate DESC LIMIT :pageSize OFFSET :index';
    
    public CommentController(){
        
        caseId = ApexPages.currentPage().getParameters().get('id');
        index = 0;
        
        //query and get all case comments for caseid
        totalComments = [SELECT Count() FROM CaseComment WHERE ParentId = :caseId];
        comments = Database.query(query);
        
    }
    
    public PageReference addComment(){
        
        //check if textarea empty   
        if( !String.isBlank(newComment)){
            //build and insert case comment
            CaseComment cc = new CaseComment();
            cc.ParentId = caseid;
            cc.CommentBody = newComment;
            cc.IsPublished = true;
            
            insert cc;
        }
        
        PageReference refresh = ApexPages.currentPage();
        refresh.setRedirect(true);
        
        return refresh;
    }
    
    public PageReference goToSupportHome(){
        PageReference home = Page.HelpHome;
        home.setRedirect(true);
        
        return Page.HelpHome;
    }
    
    public void next(){
        index += pageSize;
        if(index > totalComments-1){
            index = 0;
        }
        comments = Database.query(query);
    }
    
    public void prev(){
        index -= pageSize;
        if(index < 0){
            index = totalComments - Math.mod(totalComments, pageSize);
        }
        comments = Database.query(query);
    }
    
}