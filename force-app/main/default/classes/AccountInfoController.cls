public with sharing class AccountInfoController {
    @AuraEnabled
    public static string getAccountList(Integer pageSize, Integer pageNumber){
      String jsonDT = '';
      try {
        Integer offset = (pageNumber-1)*pageSize;
        Integer totalRecords = [SELECT count() FROM ACCOUNT];
        Integer recordEnd = pageSize * pageNumber;
        AccountDTWrapper objDT = new AccountDTWrapper();
        objDT.pageSize = pageSize;
        objDT.pageNumber = pageNumber;
        objDT.recordStart = offset+1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.accounts = [SELECT Id, Name, AccountNumber, Industry, Phone FROM Account LIMIT :pageSize OFFSET :offset];
        jsonDT = JSON.serialize(objDT);
        return jsonDT;
      } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
      }
    }
    public class AccountDTWrapper{
      public Integer pageSize {get;set;}
      public Integer pageNumber {get;set;}
      public Integer totalRecords {get;set;}
      public Integer recordStart {get;set;}
      public Integer recordEnd {get;set;}
      public List<Account> accounts {get;set;}
    }
}