trigger OpportunityTrigger on Opportunity (after insert,after update,after delete) {
  if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
    OpportunityTriggerHandler.SendEmailWhenOpportunityCU(Trigger.New);
    OpportunityTriggerHandler.UpdateAccountWithOpportunityName(Trigger.New,null);
  }

  if(trigger.isAfter && (trigger.isDelete)){
    OpportunityTriggerHandler.UpdateAccountWithOpportunityName(null,Trigger.oldMap);
  }
}