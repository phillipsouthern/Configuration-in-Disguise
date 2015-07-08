/*
Contact field set
Campaign Member field set
Environment Settings custom hiearchy setting (only active campaigns, only not responded CMs)
Campaign Filter Settings custom list setting (campaign type filter)
Custom label

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
		//****Hiearchy Custom Setting
		Environment_Settings__c es = Environment_Settings__c.getinstance();

		campaignMembers = new List<CampaignMember>();

		//*****Get Fields from Field Set
		String cmquery = 'Select Id';

		for(Schema.FieldSetMember f : SObjectType.CampaignMember.FieldSets.CM_Contact.getFields())
		{
			cmquery += ', ' + f.getFieldPath();
		}

		cmquery += ' from CampaignMember Where ContactId = \'' + c.Id + '\'';

		if(es.Active_Campaign_Filter__c==true) cmquery += ' AND Campaign.isActive = true';
		if(es.Campaign_Member_Status_Filter__c != null) cmquery += ' AND Status = \'' + es.Campaign_Member_Status_Filter__c + '\'';

			//****List Custom Setting
		Set<String> campaignTypeValues = new Set<String>();
		for(Campaign_Type_Filter__c ctf : Campaign_Type_Filter__c.getall().values())
		{
			campaignTypeValues.add(ctf.Value__c);
		}

		if(!campaignTypeValues.isEmpty()) cmquery+= ' AND Campaign.Type IN :campaignTypeValues';
		//*****End - Get Fields from Field Set


		for(Sobject s : database.query(cmquery))
		{
			campaignMembers.add((CampaignMember)s);
		}

	}

	public PageReference saveOvr()
	{
		update c;
		update campaignMembers;

		return controller.view();
	}
}