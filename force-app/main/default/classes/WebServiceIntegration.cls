/*
  instanceUrl/services/apexrest/Account
*/

@RestResource(urlMapping='/Account/*')
global with sharing class WebServiceIntegration {

  @HttpGet  
  global Static Account getAccount() {
    Map<String,String> paramsMap = RestContext.request.params;
    String accid=paramsMap.get('id');
    Account acc = [SELECT id,Name From Account WHERE Id =:accid];
    return acc;
  }

  @HttpPost
  global Static Account createAccount(String Name,String Phone,String Website){
    Account acc = new Account();
    acc.Name = Name;
    acc.Phone=Phone;
    acc.Website = Website;
    insert acc;
    return acc;
  }

  @HttpDelete
  global Static String deleteAccount(){
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
    Account acc = [SELECT id,Name From Account WHERE Id =:accountId];
    try{
      Delete acc;
      return 'Success';
    } catch(Exception e){
      system.debug('error');
      return 'Error';
    }
  }

  @HttpPut
  global Static Account updateOrCreateAccount(){

  }

  @HttpPatch
  global static Account UpdateAccount(String Name){
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
    Account acc = [SELECT id,Name From Account WHERE Id =:accountId];
    acc.Name = Name;
    update acc;
    return acc;
  }
}