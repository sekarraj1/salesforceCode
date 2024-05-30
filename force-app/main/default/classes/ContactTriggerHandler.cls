public with sharing class ContactTriggerHandler {
  /*
  Write a trigger to identify the most recent contact when inserted for each account and mark its 
  New_Contact__c field as checked and ensuring that the New_Contact__c field unchecked for the other
  contacts related to the same account
  */
    public static void updateRecentContacts(List<Contact> conList){
      Set<Id> accIds = new Set<Id>();
      Map<Id,Contact> recContMap = new Map<Id,Contact>();
      List<Contact> contactsToBeUpdated= new List<Contact>();
      for(Contact conR: conList){
        if(conR.AccountId != null){
          accIds.add(conR.AccountId);
        }
      }
      if(!accIds.isEmpty()){
        List<Contact> recentConList = [SELECT id,Name,AccountId,New_Contact__c FROM Contact
                                      WHERE AccountId IN :accIds order by CreatedDate DESC];
        for(Contact recCon:recentConList){
          if(!recContMap.containsKey(recCon.AccountId)){
            recContMap.put(recCon.AccountId,recCon);
          }
        }
        for(Contact recCon:recentConList){
          Contact recContact = recContMap.get(recCon.AccountId);
          if(recContact.Id ==recCon.Id ){
            recCon.New_Contact__c = true;
            contactsToBeUpdated.add(recCon);
          }
          else{
            if(recCon.New_Contact__c){
              recCon.New_Contact__c = false;
              contactsToBeUpdated.add(recCon);
            }
          }
        }
        if(!contactsToBeUpdated.isEmpty()){
        update contactsToBeUpdated;
        }
      }

    }

  /*
  When a contact is inserted on an account, check if the account has existing opportunities.
  If so, update the accounts description with total opportunity amount.if not, create a new opportunity.
  */
  public static void updateOppAmountOnAccountWhenContactIsCreated(List<Contact> contLst){

    Set<id> accIds = new Set<id>();
    List<Account> accToBeUpdated = new List<Account>();
    List<Opportunity> oppToBeCreate = new List<Opportunity>();
    Map<Id,Decimal> oppAmountMap = New Map<Id,Decimal>();
    if(!contLst.isEmpty()){
      for(Contact con:contLst){
        accIds.add(con.AccountId);
      }
    }
    if(!accIds.isEmpty()){
      List<Opportunity> oppList = [SELECT id,name,amount FROM Opportunity WHERE AccountId IN: accIds];
      if(!oppList.isEmpty()){
        Decimal totalAmount = 0;
        Id accountId;
        for(Opportunity opp:oppList){
          accountId = opp.Id;
          totalAmount += opp.Amount;
        }
        oppAmountMap.put(accountId,totalAmount);
      }
      
      if(oppList.isEmpty()){
        // create Opportunity
       Opportunity newOpp = new Opportunity();
       newOpp.Name = 'test';
       newOpp.AccountId = oppList[0].AccountId;
       oppToBeCreate.add(newOpp);
      }
      
      if(!oppAmountMap.isEmpty()){
        for(Id accIdFromOpp:oppAmountMap.keySet()){
          Account accUpdate = new Account(Id=accIdFromOpp);
          accUpdate.Description = 'Total Opportunity Amount' + oppAmountMap.get(accIdFromOpp);
          accToBeUpdated.add(accUpdate);
        }

      }
      if(!accToBeUpdated.isEmpty()){
        update accToBeUpdated;
      }
      if(!oppToBeCreate.isEmpty()){
        insert oppToBeCreate;
      }
      

    }
    

  }
}