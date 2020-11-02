public class CostEstimator {

    // public Mail__c ml{ get;set;}
    public Decimal weight {get;set;}
    public Decimal height {set;get;}
    public Decimal width {set;get;}
    public boolean isInsured {set;get;}
    public String stateFrom {get;set;}
    public String stateTo {get;set;}
    public String pkType {get;set;}
    public String pkSize {get;set;}
    public String pkClass {get;set;}
    public Decimal estCost {get;set;}
    public ApexPages.StandardController stdCntrlr {get; set;}
    
    public CostEstimator(ApexPages.StandardController stdController){
        stdCntrlr = stdController;
    }
    
    public List<SelectOption> getStates(){
        
        List<SelectOption> states = new List<SelectOption>();
            
        states.add(new SelectOption('AL', 'AL'));
        states.add(new SelectOption('AK', 'AK'));
        states.add(new SelectOption('AZ', 'AZ'));
        states.add(new SelectOption('AR', 'AR'));
        states.add(new SelectOption('CA', 'CA'));
        states.add(new SelectOption('CO', 'CO'));
        states.add(new SelectOption('CT', 'CT'));
        states.add(new SelectOption('DE', 'DE'));
        states.add(new SelectOption('FL', 'FL'));
        states.add(new SelectOption('GA', 'GA'));
        
        return states;
    }
    
    public List<SelectOption> getPackageType(){
        List<SelectOption> packageType = new List<SelectOption>();
        
        packageType.add(new SelectOption('Document', 'Document'));
        packageType.add(new SelectOption('Package', 'Package'));
        
        return packageType;
    }
    
    public List<SelectOption> getPackageSize(){
        List<SelectOption> packageSize = new List<SelectOption>();
        
        packageSize.add(new SelectOption('Small', 'Small'));
        packageSize.add(new SelectOption('Medium', 'Medium'));       
        packageSize.add(new SelectOption('Large', 'Large'));
        packageSize.add(new SelectOption('Extra Large', 'Extra Large'));
        
        return packageSize;
    }
    
    
    public List<SelectOption> getPackageClass(){
        List<SelectOption> packageClass = new List<SelectOption>();
        
        packageClass.add(new SelectOption('Economy', 'Economy'));
        packageClass.add(new SelectOption('Standard', 'Standard'));       
        packageClass.add(new SelectOption('Business', 'Business'));
        packageClass.add(new SelectOption('Express', 'Express'));
        
        return packageClass;
    }
    
    
    public Decimal calcCost(){
        Decimal size, pclass, ptype, insured, states;
        
        if(pkSize == 'small')
            size = 1.5;
        else if (pkSize == 'medium')
            size = 2;
        else if (pkSize == 'large')
        	size = 2.5;
        else
            size = 3.5;
        
        if(pktype == 'Document')
            ptype = 0.5;
        else
            ptype = 3.5;
        
        if (pkClass == 'Economy')
            pclass = 1.5;
        else if (pkClass == 'Standard')
            pclass = 2.5;
        else if (pkClass == 'Business')
            pclass = 5.5;
        else 
            pclass = 7.5;
        
        if (isInsured == true)
            insured = 0.5;
        else
            insured = 1;
        
        if (stateFrom == stateTo)
            states = 2;
        else 
            states = 1;
        
        return ((size + ptype * 1.5 + pclass * 0.5 * insured)/10) / states;
    }
    
    public void getEstimateCost(){
        this.estCost = calcCost();
    }
}