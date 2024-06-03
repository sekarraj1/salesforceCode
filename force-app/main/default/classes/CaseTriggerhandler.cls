public with sharing class CaseTriggerhandler {
    /*
    Write an apex trigger to link case to contact based on the supplied email.
    If the supplied email matches an existing contacts email the case should get linked to that contact otherwise 
    a new contact shoud get crated and linked to that case.
    */
    public static void linkContactToCase(List<Case> newCase){
      Set<String> emailSet = new Set<String>();
      Map<String,Id> contMap = new Map<String,Id>();
      List<Contact> contactsToBeUpdated = new List<Contact>();

      if(!newCase.isEmpty()){
        for(Case caseVal:newCase){
          if(caseVal.Supplied_Email__c != null){
            emailSet.add(caseVal.Supplied_Email__c);
          }
        }
      }
      if(!emailSet.isEmpty()){
        List<Contact> conList =[SELECT id,Name,Email FROM Contact 
                        WHERE Email IN:emailSet];
        if(!conList.isEmpty()){
          for(Contact con:conList){
            contMap.put(con.Email,con.Id);
          }
          if(!contMap.isEmpty()){
            for(Case caseVal:newCase){
              if(caseVal.Supplied_Email__c != null && contMap.containsKey(caseVal.Supplied_Email__c)){
                caseVal.ContactId = contMap.get(caseVal.Supplied_Email__c);
              } else {
                Contact conUpdate = new Contact();
                conUpdate.LastName = 'Test Contact';
                conUpdate.Email = contMap.get(caseVal.Supplied_Email__c);
                contactsToBeUpdated.add(conUpdate);
              }
            }
            if(!contactsToBeUpdated.isEmpty()){
              insert contactsToBeUpdated;
              for(Case caseVal:newCase){
                caseVal.ContactId = contMap.get(caseVal.Supplied_Email__c);
              }
            }
          }
        }

      }
    }

    /*
    Whenever create task checkbox is selected in the case, create a follow up task and 
    automatically assign it to the Primary contact of the case account.
    */
    public static void createTask(List<Case> newCase, Map<Id,Case> oldCaseMap){
      Set<Id> accIds = new Set<Id>();
      Map<Id,Id> contsMap = new Map<Id,Id>();
      List<Task> taskList =  new List<Task>();
      Case oldCase = new Case();
      if(!newCase.isEmpty()){
        for(Case cs:newCase){
          if(oldCaseMap != null){
            oldCase = oldCaseMap.get(cs.Id);
          }
          if((oldCase == null || oldCase.Create_Task__c ==false) && cs.AccountId !=null && cs.Create_Task__c){
            accIds.add(cs.AccountId);
          }
        }
      }
      if(!accIds.isEmpty()){
        List<Contact> contList = [SELECT id,Name,Primary_Contact__c FROM Contact
                                  WHERE AccountId IN:accIds and Primary_Contact__c = true LIMIT 1];
        if(!contList.isEmpty()){
          for(Contact con:contList){
            contsMap.put(con.AccountId,con.Id);
          }
          for(Case cs:newCase){
            if(cs.Create_Task__c && contsMap.containsKey(cs.AccountId)){
                Task newTask = new Task();
                newTask.Subject =  'Follow Up task';
               // newTask.WhoId = contsMap.containsKey(cs.AccountId);
                newTask.Status = 'Not Started';
                taskList.add(newTask);
            }
          }
          if(!taskList.isEmpty()){
            insert taskList;
          }
        }

      }

    }

}