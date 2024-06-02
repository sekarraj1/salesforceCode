trigger CaseTrigger on Case (before insert) {
  if(Trigger.isBefore && Trigger.isInsert){
    CaseTriggerhandler.linkContactToCase(Trigger.New);
  }
}