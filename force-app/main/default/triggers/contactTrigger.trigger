trigger contactTrigger on Contact (after insert,after update,after delete) {
  if(trigger.isAfter && trigger.isInsert){
    ContactTriggerHandler.updateRecentContacts(Trigger.New);
    ContactTriggerHandler.updateOppAmountOnAccountWhenContactIsCreated(Trigger.New);
    ContactTriggerHandler.updateNumberOfContactsOnAccount(Trigger.New,null,null);
  }
  if(trigger.isAfter && trigger.isUpdate){
    ContactTriggerHandler.updateNumberOfContactsOnAccount(Trigger.New,Trigger.oldMap,Trigger.old);
  }
  if(trigger.isAfter && trigger.isDelete){
    ContactTriggerHandler.updateNumberOfContactsOnAccount(null,Trigger.oldMap,Trigger.old);
  }
}