trigger OpportunityTrigger on Opportunity (after insert,after update) {
  if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
    OpportunityTriggerHandler.SendEmailWhenOpportunityCU(Trigger.New);
  }
}