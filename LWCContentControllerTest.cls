@isTest
private class LWCContentControllerTest {
      static testmethod void getHTTPResponse(){
          Test.startTest();
          // Set mock callout class 
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
    
            // Call method to test.
            // This causes a fake response to be sent
            // from the class that implements HttpCalloutMock. 
            HttpResponse res = CalloutClass.getInfoFromExternalService();
    
            // Verify response received contains fake values
            String contentType = res.getHeader('Content-Type');
            System.assert(contentType == 'application/json');
            String actualValue = res.getBody();
            String expectedValue = '{"items": [{"fields": {"title": "MarkDown Demo","body": {"content": [{"content": [{"value": "MarkDown Demo"}]}]}}}]}';
            System.assertEquals(actualValue, expectedValue);
            System.assertEquals(200, res.getStatusCode());
           	LWCContentController.parse(expectedValue);
          	LWCContentController.LWCRestMethod();
            Test.stopTest();
     }
    
    static testmethod void getContentDetail(){
        Test.startTest();
       
            List<Content__c> contentList = new List<Content__c>();
            Content__c content= new Content__c (title__c = 'Test' , body__c =  'Test Content')  ;
            contentList.add(content);
            Insert contentList;
        	
            string searchText = 'test';
            LWCContentController.getContents(searchText);
        	searchText = '';
        	LWCContentController.getContents(searchText);
        	string recordId = contentList[0].id;
        	LWCContentController.getContentDetail(recordId);
        Test.stopTest();
    }
}