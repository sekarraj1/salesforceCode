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
}