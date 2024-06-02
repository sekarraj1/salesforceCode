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
}