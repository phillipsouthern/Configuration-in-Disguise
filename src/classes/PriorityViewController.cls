/*

Created by:		Phillip Southern	@phil7s
Date:			12/13/2016
Description:	Demo example for presentation Configuration in Disguise.


*/

public class PriorityViewController 
{
    
    public PriorityViewController()
    {
        
    }
    
    @AuraEnabled
    public static Integer getLimitNumber()
    {
        return Integer.valueof(Environment_Settings__c.getinstance().Priority_View_Number_to_Show__c);
    }

    @AuraEnabled
    public static List<Task> getTasks()
    {
        Environment_Settings__c es = Environment_Settings__c.getinstance();
        Integer limitNumber = Integer.valueof(es.Priority_View_Number_to_Show__c);
        return [select Id, Subject, ActivityDate, Status, Priority, Description 
                	from Task Order by ActivityDate DESC LIMIT :limitNumber];
    }
    
    @AuraEnabled
    public static List<Case> getCases()
    {
        Environment_Settings__c es = Environment_Settings__c.getinstance();
        Integer limitNumber = Integer.valueof(es.Priority_View_Number_to_Show__c);
        
        String caseQuery = 'select Id';
        for(Schema.FieldSetMember f : SobjectType.Case.FieldSets.PriorityViewCaseFields.getfields())
        {
            caseQuery += ', ' + f.getFieldPath();
        }
        
        Set<String> originValues = new Set<String>();
        for(Case_Origin_Filter__mdt originFilter : [Select Origin_Value__c from Case_Origin_Filter__mdt])
        {
            originValues.add(originFilter.Origin_value__c);
        }
        
		caseQuery += ' from Case Where Origin IN :originValues Order by CreatedDate DESC LIMIT :limitNumber';
      
        
        return ((List<Case>)database.query(caseQuery));
    }
}