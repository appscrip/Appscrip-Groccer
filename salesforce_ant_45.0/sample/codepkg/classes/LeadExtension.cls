public class LeadExtension {
    public Lead l{get;set;}
    public LeadExtension(ApexPages.StandardController controller) {
        
        l = new Lead();
    }
    
    public void insertRecord(){
        insert l;
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, l.firstName+'    '+l.lastName+'    Record has been created successfully.'));
        l = new Lead();
           
    }
    
    public PageReference cancel(){
        
        PageReference pg = new PageReference('/apex/NewLead');
        pg.setRedirect(true);
        return pg;
    }

}