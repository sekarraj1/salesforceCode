public with sharing class CalloutWithPublicUrl {
  /*
  Write a callout apex class and parse the response using Map in salesforce.
  Referrence from trailhead : https://trailhead.salesforce.com/content/learn/modules/apex_integration_services/apex_integration_rest_callouts
  */
    public static String getPublicInformation() {
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
    }
}