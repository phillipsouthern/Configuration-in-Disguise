({
	doInit : function(component, event, helper) 
    {
		var action = component.get("c.getTasks");
        action.setCallback(this, function(a) {
            component.set("v.tasks", a.getReturnValue());
        });
        $A.enqueueAction(action);
        
        var action2 = component.get("c.getLimitNumber");
        action2.setCallback(this, function(a2){
        	component.set("v.rowlimit", a2.getReturnValue());
        });
    	$A.enqueueAction(action2);
        
        var action3 = component.get("c.getCases");
        action3.setCallback(this, function(a3){
        	component.set("v.cases", a3.getReturnValue());
        });
    	$A.enqueueAction(action3);
	}
})