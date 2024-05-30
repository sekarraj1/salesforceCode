trigger AccountTrigger on Account (after update,after insert) {
  if(Trigger.isAfter ){
    if(Trigger.isUpdate){
      AccountTriggerHandler.SendEmailWhenAccountUpdate(Trigger.new,trigger.oldMap);
    }
    if(Trigger.isInsert){
      AccountTriggerHandler.createContacts(Trigger.new);
    }
    
  }
}