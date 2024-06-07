public with sharing class CalloutResponseWrapper {
    public List<String> animals;
    public static CalloutResponseWrapper parseResponse(String resBody){
      return (CalloutResponseWrapper) System.JSON.deserialize(resBody, CalloutResponseWrapper.class);
    }
}