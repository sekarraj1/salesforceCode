public class RetryableCallout {
  public void makeCallout(Integer retryCount) {
      HttpRequest req = new HttpRequest();
      req.setEndpoint('https://example.com/api');
      req.setMethod('GET');
      Http http = new Http();
      try {
          HttpResponse res = http.send(req);
          if (res.getStatusCode() != 200 && retryCount > 0) {
              System.debug('Retrying callout, attempts left: ' + retryCount);
              retryCallout(retryCount - 1);
          }
      } catch (Exception e) {
          if (retryCount > 0) {
              System.debug('Retrying due to exception: ' + e.getMessage());
              retryCallout(retryCount - 1);
          } else {
              System.debug('Max retries reached, logging error.');
          }
      }
  }

  @future(callout=true)
  public static void retryCallout(Integer retryCount) {
      RetryableCallout callout = new RetryableCallout();
      callout.makeCallout(retryCount);
  }
}
