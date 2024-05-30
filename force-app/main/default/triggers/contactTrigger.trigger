trigger contactTrigger on Contact (after insert) {
  if(trigger.isAfter && trigger.isInsert){
    ContactTriggerHandler.updateRecentContacts(Trigger.New);
  }
}