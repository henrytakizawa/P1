public class HelpWizardExt {
    private ApexPages.StandardController parentSC;
    public Case newCase;
    public String selectReason {get;set;}
    
    public HelpWizardExt(ApexPages.StandardController sc){
        parentSC = sc;
        newCase = (Case)sc.getRecord();
    }
    public PageReference submitCase(){
        //perform final updates to case object
        newCase.Type = 'Postal';
        newCase.Priority = 'Medium'; //could check reason and change priority based on the type of problem
        newCase.Origin = 'Web';
        newCase.reason = selectReason;
        
        parentSC.save();
        return Page.HelpHome;
    }
    
    public PageReference goToSupportHome(){
        return Page.HelpHome;
    }
}