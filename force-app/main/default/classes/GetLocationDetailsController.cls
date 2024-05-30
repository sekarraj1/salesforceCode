public with sharing class GetLocationDetailsController {
  
    @AuraEnabled
    public static List<Country__c> getValuesFromTable() {
      return [SELECT id,Name From Country__c];
    }

    @AuraEnabled
    public static List<State__c> getStatesFromTable() {
      return [SELECT id,Name From State__c WHERE Country__r.Name =: 'India'];
    }
}