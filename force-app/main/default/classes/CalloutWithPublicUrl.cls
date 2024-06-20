public with sharing class CalloutWithPublicUrl {
  /*
  Write a callout apex class and parse the response using Map in salesforce.
  Referrence from trailhead : https://trailhead.salesforce.com/content/learn/modules/apex_integration_services/apex_integration_rest_callouts
  */
    public static String getPublicInformationUsingMap() {
      Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setMethod('GET');
      req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
      HttpResponse res = h.send(req);
      if(res.getStatusCode() == 200){
        Map<String,Object> result = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
        List<Object> animals = (List<Object>)result.get('animals');
        for(Object an:animals){
          system.debug(an);
        }
      }
      return 'success';
    }
/*
  Write a callout apex class and parse the response using Wrapper class in salesforce.
  */
    public static String getPublicInformationUsingWrapperClass(){
      Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setMethod('GET');
      req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
      HttpResponse res = h.send(req);
      if(res.getStatusCode() == 200){
        String resBody = res.getBody();
        CalloutResponseWrapper resData = CalloutResponseWrapper.parseResponse(resBody);
        for(String an:resData.animals){
          system.debug(an);
        }
      }
      return 'success';
    }

    /*
    Get the country list - https://api.first.org/data/v1/countries
    */
    @AuraEnabled
    public static String getCountryList(){
      String resBody;
      Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setEndpoint('https://api.first.org/data/v1/countries');
      req.setMethod('GET');
      HttpResponse res = h.send(req);
      if(res.getStatusCode() == 200){
        resBody = res.getBody();
      }
      return resBody;
    }
}