/*

Created by:		Phillip Southern	@phil7s
Date:			07/09/2015
Description:	Demo example for presentation Configuration in Disguise.

Configuration used:
Field Sets for Contact fields and Campaign Member fields
Hierarchy Custom Setting: Environment_Settings__c to control filtering
List Custom Setting: Campaign_Type_Filter__c to control picklist value filtering
Custom Label on VF Page: ContactCMEdit_Label


*/

public class ContactCMEditController
{
	public Contact c {get;set;}
	private final ApexPages.StandardController controller;
	public List<CampaignMember> campaignMembers{get;set;}


	public ContactCMEditController(ApexPages.StandardController controller)
	{
		c = (Contact)controller.getRecord();
		this.controller = controller;

		initData();
		
	}

	private void initData()
	{
		//**Hiearchy Custom Setting
		Environment_Settings__c es = Environment_Settings__c.getinstance();

		campaignMembers = new List<CampaignMember>();

		//**Get Fields from Field Set for campaign member query
		String cmquery = 'Select Id';

		for(Schema.FieldSetMember f : SObjectType.CampaignMember.FieldSets.CM_Contact.getFields())
		{
			cmquery += ', ' + f.getFieldPath();
		}

		cmquery += ' from CampaignMember Where ContactId = \'' + c.Id + '\'';

		if(es.Active_Campaign_Filter__c==true) cmquery += ' AND Campaign.isActive = true';
		if(es.Campaign_Member_Status_Filter__c != null) cmquery += ' AND Status = \'' + es.Campaign_Member_Status_Filter__c + '\'';


		//**List Custom Setting to use for query filtering
		Set<String> campaignTypeValues = new Set<String>();
		for(Campaign_Type_Filter__c ctf : Campaign_Type_Filter__c.getall().values())
		{
			campaignTypeValues.add(ctf.Value__c);
		}

		if(!campaignTypeValues.isEmpty()) cmquery+= ' AND Campaign.Type IN :campaignTypeValues';

		//debug statement to check our query
		system.debug('**query: ' + cmquery);


		//**Dynamic query to loop through and add campaign memebers to List to view on VF page.
		for(Sobject s : database.query(cmquery))
		{
			campaignMembers.add((CampaignMember)s);
		}

	}

	//**Save override process (not using standard controller save)
	//**Update the contact and campaign members, then use the controller to view back into the record.
	public PageReference saveOvr()
	{
		update c;
		update campaignMembers;

		return controller.view();
	}
}