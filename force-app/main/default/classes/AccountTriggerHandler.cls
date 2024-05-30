public with sharing class AccountTriggerHandler {
  /*
  When an account get updated send an email to the accounts owner with recent modified contact details 
  between the last update and current update of account
  */
    public static void SendEmailWhenAccountUpdate(List<Account> newAccList, Map<Id,Account> oldAccMap) {
      Map<Id,Datetime> accountUpdateTimeMap = new Map<Id,Datetime>();
      Account oldAcc = new Account();
      Set<Id> ownerIds = new set<Id>();
      Map<Id,String> emailIds = new Map<Id,String>();
      List<Messaging.SingleEmailMessage> emailsTosend = new List<Messaging.SingleEmailMessage>();

      if(!newAccList.isEmpty()){
        for(Account acc:newAccList){
          if(oldAccMap != null){
            oldAcc = oldAccMap.get(acc.Id);
            if(acc.LastModifiedDate != oldAccMap.get(acc.Id).LastModifiedDate){
              accountUpdateTimeMap.put(acc.Id,oldAccMap.get(acc.Id).LastModifiedDate);
              ownerIds.add(acc.OwnerId);
            }
          }  
        }
      }
      if(!accountUpdateTimeMap.isEmpty()){
        List<Contact> contList = [SELECT id,Name,AccountId,LastModifiedDate
                                  FROM Contact
                                  WHERE AccountId IN :accountUpdateTimeMap.keySet()
                                  AND LastModifiedDate >:accountUpdateTimeMap.values()
                                  AND LastModifiedDate <:system.now()];
        String emailBody = 'The following contacts has been updated: \n';
        for(contact c:contList){
          emailBody += 'Name: '+c.Name +'\n';
        }
        Map<Id,User> ownerMap = new Map<Id,User>([Select Id,name,Email from User where id In:ownerIds]);
        for(Account accLists: newAccList){
          if(ownerMap.containsKey(accLists.OwnerId)){
            emailIds.put(accLists.Id,ownerMap.get(accLists.OwnerId).email);
          }
        }
        if(!emailIds.isEmpty()){
          for(Id accountIds:emailIds.keySet()){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{emailIds.get(accountIds)});
            email.setPlainTextBody(emailBody);
            email.setSubject('Updated contact list');
            emailsTosend.add(email);
          }
        }  
        if(!emailsTosend.isEmpty()){
          //Messaging.sendEmail(emailsTosend);
        }

      }

    }

    /*
    Write an trigger to create the contacts based on the user input on the Number of contacts field in the 
    Account object and throw an error if user tries to create more than 10 contacts for the account
    */
    public static void createContacts(List<Account> accList){
      List<Contact> contactsToBeCreated = new List<Contact>();

      if(!accList.isEmpty()){
        for(Account acc:accList){
          if(acc.Number_of_Contacts__c != null && acc.Number_of_Contacts__c < 10 ){
            for(Integer i=0;i<=acc.Number_of_Contacts__c;i++){
              Contact cont = new Contact();
              cont.LastName = 'VapoRub' + i;
              cont.FirstName = 'Vicks' +1;
              cont.AccountId = acc.Id;
              contactsToBeCreated.add(cont);
            }
          }
          else{
            acc.addError('Maximum allowed contacts are 10');
          }

        }
        if(!contactsToBeCreated.isEmpty()){
          insert contactsToBeCreated;
        }

      }


    }
}