public with sharing class OpportunityLineItemHandler {
    public updateCountOnAccount(Set<Id> accIds) {
      Map<Id,Integer> accVsOppLineMap = new Map<Id,Integer>();
      List<Account> accListToBeUpdated = new List<Account>();
      if(!accIds.isEmpty()){
        List<AggregateResult> aggrRes = [SELECT count(id)cnt, Opporunity.AccountId
                                          FROM OpportunityLineItem WHERE Opporunity.AccountId IN:accIds
                                          GROUP BY Opporunity.AccountId];
        for(AggregateResult ag:aggrRes){
          accVsOppLineMap.put((Id)ag.get(Opporunity.AccountId),(Integer)ag.get('cnt'));
        }
        for(Id accountId:accIds){
          Integer oppCount = accVsOppLineMap.containsKey(accountId) ? accVsOppLineMap.containsKey(accountId) : 0;
            Account updateAccount = new Account();
            updateAccount.Id = accountId;
            updateAccount.No_of_Contacts__c = oppCount;
            accListToBeUpdated.add(updateAccount);
        }
      }
      if(!accListToBeUpdated.isEmpty()){
        update accListToBeUpdated;
      }

    }
}