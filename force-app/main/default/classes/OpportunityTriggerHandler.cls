public with sharing class OpportunityTriggerHandler {
  /*
    Whenever the opportunity is created and updated with the amount > 10000, send email to the owner
  */
    public static void SendEmailWhenOpportunityCU(List<Opportunity> oppList) {
      Set<Id> ownerIds = new Set<Id>();
      List<Messaging.SingleEmailMessage> emailsTosend = new List<Messaging.SingleEmailMessage>();
      if(!oppList.isEmpty()){
        for(Opportunity opp:oppList){
          if(opp.Amount != null && opp.Amount >10000 ){
            ownerIds.add(opp.OwnerId);
          }
        }
        if(!ownerIds.isEmpty()){
          Map<Id,User> ownerMap = new Map<Id,User>([Select Id,name from User where id In:ownerIds]);
          for(Opportunity oppL:oppList){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{oppL.OwnerId});
            String ownerName= ownerMap.containsKey(oppL.OwnerId) ? ownerMap.get(oppL.OwnerId).Name : '';
            email.setPlainTextBody('ownerName'+ownerName);
            email.setSubject('Dear' + ownerName +',\n\n'+'The opportunity '+oppL.name+'has an amount exceeding $10,000');
            emailsTosend.add(email);
          }
          if(!emailsTosend.isEmpty()){
            //Messaging.sendEmail(emailsTosend);
          }
        }

      }
    }

    /*
    Write a apex trigger that updates the accounts description with opportunity name that has the highest amount.
    */
    public static void UpdateAccountWithOpportunityName(List<Opportunity> oppList,Map<Id,Opportunity> oppMap){
      Set<Id> accIds = new Set<Id>();
      List<Account> accListToUpdate = new List<Account>();
      if(oppList !=null && !oppList.isEmpty()){
        for(Opportunity opp:oppList){
          accIds.add(opp.AccountId);
        }
      }
      if(oppMap != null && !oppMap.isEmpty()){
        for(Opportunity opp:oppMap.values()){
          accIds.add(opp.AccountId);
        }
      }
      if(!accIds.isEmpty()){
        List<Account> accList = [SELECT id,Name,Description, 
                                (SELECT id,Name,Amount FROM Opportunities ORDER BY Amount DESC) 
                                FROM Account WHERE Id IN:accIds];
        for(Account a:accList){
          if(a.Opportunities.size() > 0){
            Account acc = new Account(Id=a.Id);
            acc.Description = a.Opportunities[0].Name;
            accListToUpdate.add(acc);
          }
        }
        if(!accListToUpdate.isEmpty()){
          update accListToUpdate;
        }
      }
    }

    /*
    Whenever the opportunity type gets updated then insert a new opportunityContactRole according to the opportunity type.Delete the existing Opportunity
    ContactRole and If there is no contact present of the same type as the opportunity then show an error
    */
    public static void createOpportunityContactRole(List<Opportunity> oppList,Map<Id,Opportunity> oldOppMap){

    }

    /*
    Write a trigger to update account and contact status to active when the opportunity stage is closed won
    */
    public static void updateAccountAndContact(List<Opportunity> oppList,Map<Id,Opportunity>oldMapOpp){
      Set<Id> accIds=new Set<Id>();
      List<Account> accountsToBeUpdate = new List<Account>();
      List<Contact> contactsToBeUpdate = new List<Contact>();
      if(!oppList.isEmpty()){
        for(Opportunity opp:oppList){
          if(opp.StageName == 'Closed Won' && opp.StageName != oldMapOpp.get(opp.Id).StageName){
            accIds.add(opp.AccountId);
          }
        }
      }
      if(!accIds.isEmpty()){
        for(Account acc:[SELECT id,Name,Status__c ,(select Id,Name FROM Contacts) FROM Account WHERE Id In:accIds]){
          Account updateAccount = new Account();
          updateAccount.Id = acc.Id;
          updateAccount.Status__c = 'Active';
          accountsToBeUpdate.add(updateAccount);
          for(Contact con : acc.Contacts){
            Contact updateCon = new Contact();
            updateCon.Id = con.Id;
            updateCon.Status__c = 'Active';
            contactsToBeUpdate.add(updateCon);
          }
        }
      }
      if(!accountsToBeUpdate.isEmpty()){
        update accountsToBeUpdate;
      }
      if(!contactsToBeUpdate.isEmpty()){
        update contactsToBeUpdate;
      }
    }

    /*
    Write a trigger to update the Parent Account's Description field with the Second Highest Amount from Related Opportunities.
    */
    public static void updateAccountWithSecondHighestOppAmt(List<Opportunity> oppList, Map<Id,Opportunity> oldMapOpp){

      Set<Id> accIds = new Set<Id>();
      List<Account> accToBeUpdated = new List<Account>();
      if(!oppList.isEmpty()){
        for(Opportunity opp: oppList){
          accIds.add(opp.AccountId);
        }
      }
      if(!accIds.isEmpty()){
        List<Account> accList = [SELECT ID,Name,(Select id,Amount From Opportunities) FROM Account WHERE Id IN:accIds];
        for(Account acc:accList){
          Decimal highestAmount = 0;
          Decimal secondHighestAmt = 0;
          Account accUpdate = new Account();
          accUpdate.Id = acc.Id;
          for(Opportunity accOpp: acc.Opportunities){
            if(accOpp.Amount > highestAmount){
              secondHighestAmt = highestAmount;
              highestAmount = accOpp.Amount;
            } else if(accOpp.Amount > secondHighestAmt && accOpp.Amount < highestAmount){
              secondHighestAmt = accOpp.Amount;
            }
          }
          accUpdate.Description = secondHighestAmt;
          accToBeUpdated.add(accUpdate);

        }
      }
      if(!accToBeUpdated.isEmpty()){
        update accToBeUpdated;
      }

    }

}