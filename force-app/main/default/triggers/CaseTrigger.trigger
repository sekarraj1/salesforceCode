trigger CaseTrigger on Case (before insert,after insert,after update) {
  if(Trigger.isBefore && Trigger.isInsert){
    CaseTriggerhandler.linkContactToCase(Trigger.New);
  }
  if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
    CaseTriggerhandler.createTask(Trigger.New,Trigger.oldMap);
  }
  
}