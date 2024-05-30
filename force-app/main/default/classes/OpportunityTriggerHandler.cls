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
}