public class AccountHealthController
{
    private final ApexPages.StandardController controller;
    public Account a {get;set;}
    
    public List<SelectOption> healthOptions{get;set;}
    public String healthSelected{get;set;}
    
    public String comments{get;set;}
    
    
    public AccountHealthController(ApexPages.StandardController controller)
    {
        this.controller = controller;
        a = (Account)controller.getRecord();
        
        healthOptions = new List<SelectOption>();
        healthOptions.add(new SelectOption('','--None--'));
        healthOptions.add(new SelectOption('Red','Red'));
        healthOptions.add(new SelectOption('Yellow','Yellow'));
        healthOptions.add(new SelectOption('Green', 'Green'));
        
    }
    
    public PageReference saveHealthCheck()
    {
        Map<String, Object> vars = new Map<String, Object>();
        vars.put('accountId',a.Id);
        vars.put('comments',comments);
        vars.put('status', healthSelected);
        
        Flow.Interview.Flow_Create_Followup followupFlow = new Flow.Interview.Flow_Create_Followup(vars);
        followupFlow.start();
        
        String followupId = (String) followupFlow.getVariableValue('followupObjectId');
        
        return new PageReference('/' + followupId);
    }

}