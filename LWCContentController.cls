public with sharing class LWCContentController {
    @AuraEnabled (cacheable=true)
    public static List<Content__c> getContents(string searchText) {
        try {
                if(String.isEmpty(searchText)) {
                return [SELECT ID , Title__c FROM Content__c];
            }
            else {
                searchText = '%' + searchText +'%';
                return [SELECT ID , Title__c FROM Content__c WHERE Title__c LIKE :searchText ];
            }
          } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
  
     @AuraEnabled
     public static List<Content__c> getContentDetail(String id){
      try {
          return [SELECT ID , Title__c , Body__c FROM Content__c  WHERE id=:id];
      } catch (Exception e) {
          throw new AuraHandledException(e.getMessage());
      }
     }
  
     @AuraEnabled
     public static void LWCRestMethod(){
      String json;
      Http http = new Http();
      HttpRequest request = new HttpRequest();
      string endPointURL ='https://cdn.contentful.com/spaces/ps4qnom0hrr2/entries?access_token=APx3Mc693aAy9h2-nRc10VJGZvOMZeXJSsBLJRUgO4I&content_type=blogPage&select=fields';
      request.setEndpoint(endPointURL);
      request.setMethod('GET');
      HttpResponse response = http.send(request);
      json = response.getBody();
      
      LWCContentController obj = parse(json);
      List<Content__c> contentList = new List<Content__c> ();
      Content__c content;
      for(cls_items item : obj.items ){
        System.debug('body -- >' + item.fields.body);
        System.debug('body content ' + item.fields.body.content[0].content[0].value);
          content= new Content__c (title__c = item.fields.title , body__c =  item.fields.body.content[0].content[0].value)  ;
          contentList.add(content);
      }
      try{
        
        Insert contentList;
      }catch(Exception ex)       
      {
          System.debug(ex);
      }
    }
  
  
     public cls_sys sys;
      public Integer total;	//4
      public Integer skip;	//0
      public Integer limit_z;	//100
      public List<cls_items> items;
      class cls_sys {
          public String type;	//Array
      }
      public class cls_items {
          public cls_fields fields;
      }
      public class cls_fields {
          public String title;	//Smart watch - 2000
          public String description{get;set;}
          public cls_body body{get;set;}
      }
         public class cls_content {
          public cls_content[] content;
          public String nodeType;	//text
          public String value;	//Television (TV) is a telecommunication medium for transmitting moving images and sound. The term can refer to a television set, or the medium of television transmission. Television is a mass medium for advertising, entertainment, news, and sports.
          public cls_marks[] marks;
          public cls_data data;
      }
      public class cls_body {
          public String nodeType;	//document
          public cls_data data;
          public cls_content[] content;
      }
      public class cls_data {
      }
  
      public class cls_marks {
      }
  
      public static LWCContentController parse(String json){
          return (LWCContentController) System.JSON.deserialize(json, LWCContentController.class);
      }

      /*public static List<Content__c> getContents(string searchText , string id){
        try {
           string queryString;

            if(String.isEmpty(searchText) && String.isEmpty(id)){
               searchText = '';
            }
            else if(!String.isEmpty(searchText)){
                searchText = ' WHERE Title__c LIKE %' + searchText +'%';
            }
            else if(!String.isEmpty(id)){
               searchText = ' WHERE id= \''+id+'\''  ;
            }
            queryString = '[SELECT ID , Title__c FROM Content__c ' + searchText + ']';
               
           return Database.query(queryString) ;
           
          } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }*/
  
  }