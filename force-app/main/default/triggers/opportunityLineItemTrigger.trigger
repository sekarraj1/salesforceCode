trigger opportunityLineItemTrigger on OpportunityLineItem (after insert,after update,after delete) {
  set<Id> oppIds = new Set<Id>();
  set<Id> accIds = new Set<Id>();

  if(Trigger.isAfter && Trigger.isInsert){
    for(OpportunityLineItem opp:Trigger.new){
      oppIds.add(opp.OpportunityId);
    } 
  }
  if(Trigger.isAfter && Trigger.isDelete){
    for(OpportunityLineItem opp:Trigger.old){
      oppIds.add(opp.OpportunityId);
    } 
  }
  if(!oppIds.isEmpty()){
      for(Opportunity opp: [SELECT id,Name,AccountId FROM Opportunity WHERE Id IN:oppIds]){
        accIds.add(opp.AccountId);
    } 
  }
  if(!accIds.isEmpty()){
    OpportunityLineItemHandler.updateCountOnAccount(accIds);
  }
}