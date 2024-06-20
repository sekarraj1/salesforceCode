trigger OpportunityTrigger on Opportunity (after insert,after update,after delete) {
  if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
    OpportunityTriggerHandler.SendEmailWhenOpportunityCU(Trigger.New);
    OpportunityTriggerHandler.UpdateAccountWithOpportunityName(Trigger.New,null);
  }
  if(Trigger.isAfter && Trigger.isUpdate){
    OpportunityTriggerHandler.updateAccountAndContact(Trigger.New,Trigger.oldMap);
  }

  if(trigger.isAfter && (trigger.isDelete)){
    OpportunityTriggerHandler.UpdateAccountWithOpportunityName(null,Trigger.oldMap);
  }
}