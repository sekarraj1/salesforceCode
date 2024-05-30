public with sharing class ContactInfoController {
  @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
      return [SELECT id,name FROM Contact Limit 1000];
    }
}