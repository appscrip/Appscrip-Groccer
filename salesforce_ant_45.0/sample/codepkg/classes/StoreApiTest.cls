@isTest 
public class StoreApiTest {
    
  @isTest public static void forPostMethod(){
     
        StoreApi.StoreJSON a = new StoreApi.StoreJSON(); 
        a.Name = 'test1';
        a.mongoId='v64v65v44353453556';
        a.recordType='Franchises';
  		String instanceURL =URL.getSalesforceBaseUrl().toExternalForm();
        System.debug('The URL IS----'+instanceURL);
        String myJSON = JSON.serialize(a);
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();

        request.requestUri ='instanceURL/services/apexrest/Flexy_App/Store';
        request.httpMethod = 'POST';
		request.requestBody = Blob.valueof(myJSON);
        
		RestContext.request = request;
        RestContext.response = res;
      
        //first Account
        Account acc= new Account();
        acc.name='test1';
        if(a.recordType =='Franchises'){
       		acc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Franchises').getRecordTypeId(); 
        }
        acc.Unique_Mongo_Id__c='v64v65v44353453556';
        //insert acc;
        //Account ac = StoreApi.returnStoreInfo();
        try{
            insert acc;
      		Account ac = StoreApi.returnStoreInfo();   
        }
        catch(Exception e) {
            system.assertEquals(e.getMessage(),e.getMessage());
        }
      
      //Second Json
        StoreApi.StoreJSON a1 = new StoreApi.StoreJSON(); 
        a1.Name = 'test2';
        a1.mongoId='jkkjhkjhkkjhjjhkjhkhvjvhgkj';
        a1.recordType='Store'; 
   
        String myJSON2 = JSON.serialize(a1);
        RestRequest request2 = new RestRequest();
        RestResponse res2 = new RestResponse();

        request.requestUri ='instanceURL/services/apexrest/Flexy_App/Store';
        request.httpMethod = 'POST';
		request.requestBody = Blob.valueof(myJSON2);
        
		RestContext.request = request2;
        RestContext.response = res2;   
      
      //Second Account 
        Account acc1= new Account();
        acc1.name='test2';
        if(a1.recordType=='Store'){  
            acc1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Store').getRecordTypeId();
            System.debug('Store RecordTYpe Id is '+acc.RecordTypeId);
        }
        acc1.Unique_Mongo_Id__c='jkkjhkjhkkjhjjhkjhkhvjvhgkj';
        //insert acc1;
        //Account ac1 = StoreApi.returnStoreInfo();
        try{
            insert acc1;
      		Account ac1 = StoreApi.returnStoreInfo();   
        }
        catch(Exception e) {
             system.assertEquals(e.getMessage(),e.getMessage());
        }
        
      //Third Json
      StoreApi.StoreJSON a2 = new StoreApi.StoreJSON(); 
        a2.Name = 'test1';
        a2.mongoId='jhjhgjhg6576r5hg7687gjhg';
        a2.parentMongoId = 'jkkjhkjhkkjhjjhkjhkhvjvhgkj';
        a2.recordType='Store'; 
      
        String myJSON3 = JSON.serialize(a2);
        RestRequest request3 = new RestRequest();
        RestResponse res3 = new RestResponse();

        request.requestUri ='instanceURL/services/apexrest/Flexy_App/Store';
        request.httpMethod = 'POST';
		request.requestBody = Blob.valueof(myJSON3);
        
		RestContext.request = request3;
        RestContext.response = res3;
      
      //Third Account
       Account acc2= new Account();
        acc2.name='test3';
       
        if(a2.recordType=='Store' && a2.parentMongoId != NULL && a2.parentMongoId !=''){
             acc2.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Store').getRecordTypeId();
             System.debug('Store RecordTYpe Id is '+acc2.RecordTypeId);
             Account accoun = [Select id , Name From Account where Unique_Mongo_Id__c =:a2.parentMongoId ];
             System.debug('-----------'+accoun);
             acc2.ParentId = accoun.id;
             acc2.Related_Store__c=accoun.id;         
        }
        acc2.Unique_Mongo_Id__c='jhjhgjhg6576r5hg7687gjhg';
       // insert acc2;
	   // Account ac2 = StoreApi.returnStoreInfo();
       try{
            insert acc2;
      		Account ac2 = StoreApi.returnStoreInfo();   
        }
       catch(Exception e) {
             system.assertEquals(e.getMessage(),e.getMessage());   
        }
  }
   
  
    @isTest public static String forPutMethod(){
        StoreApi.StoreJSON a = new StoreApi.StoreJSON();
        String ac;
        a.Name = 'test1';
        a.mongoId='6536c45b57866353';
        //a.appLogo='https://rahul.jpg';
        //a.commission=5;
        a.parentMongoId = '';
        a.email ='anuragtomar@gmail.com';
       a.ownerPhone ='9314299695';
        a.ownerName ='Anurag Tomar';
        a.averageDeliveryTime = '11/10/2018 12:46 PM';
        a.commission =7;
        a.walletBalance =100;
        a.walletBlock =1;
        a.walletHardLimit=100;
        a.walletSoftLimit =50;
        a.storeLandLine ='01473262730';
        a.billingCountry ='india';
        a.billingCity ='jaipur';
        a.billingState ='Rajasthan';
        a.billingStreet ='Pratapchowk';
        a.billingPostalCode ='312604';
        a.Status =true;
        a.commissionType ='Fixed';
        a.countryCode ='91';
        a.password ='12345';
        a.storeaddress ='AAgra';
        a.category ='A';
        a.subCategory ='a';
        a.appLogo ='https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg';
        a.webLogo ='https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg';
        a.storeDriver='3';
        a.companyDriver ='5';
        a.franchisee ='';
        a.freeDeliveryAbove =1;
        a.businessZoneName ='ra';
        a.foodType ='Food';
        a.averageRating =50000;
        a.storeType ='Store';
        a.recordType ='Store';
        a.website ='www.appscrip.com';
        a.description ='New In Your Area';
        String instanceURL =URL.getSalesforceBaseUrl().toExternalForm();
        System.debug('The URL IS----'+instanceURL);
        
        
       if(a.recordType=='Franchises'){
        String myJSON = JSON.serialize(a);
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();

        request.requestUri ='instanceURL/services/apexrest/Flexy_App/Store';
        request.httpMethod = 'PUT';
		request.requestBody = Blob.valueof(myJSON);
        
		RestContext.request = request;
        RestContext.response = res;
      
        //first Account
        List<Account> accList = new List<Account>();
        accList=[Select Id,Unique_Mongo_Id__c From Account Where Unique_Mongo_Id__c=:a.mongoId];
            if(accList.isEmpty()){
        Account acc= new Account();
        acc.name='test1';
        if(a.recordType =='Franchises'){
       		acc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Franchises').getRecordTypeId(); 
        }
        acc.Unique_Mongo_Id__c='v64v65v44353453556';
        insert acc;
         ac = StoreApi.deleteStoreInformation();
       }
      }
        
        //second json
     	StoreApi.StoreJSON a1 = new StoreApi.StoreJSON(); 
        a1.Name = 'test2';
        a1.mongoId='jkkjhkjhkkjhjjhkjhkhvjvhgkj';
        a1.recordType='Store'; 
        
        String myJSON = JSON.serialize(a1);
         RestRequest request = new RestRequest();
         RestResponse res = new RestResponse();
		
        request.requestUri ='instanceURL/services/apexrest/Flexy_App/Store';
        request.httpMethod = 'PUT';
		request.requestBody = Blob.valueof(myJSON);
        
		RestContext.request = request;
        RestContext.response = res;
      
        
        Account acc= new Account();
        acc.name='test1';
        
        if(a.recordType =='Store'){
       		acc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Store').getRecordTypeId(); 
        }
        acc.Unique_Mongo_Id__c='v64v65v44353453556';
        insert acc;
        ac = StoreApi.deleteStoreInformation();
        
        //third json
        StoreApi.StoreJSON a3 = new StoreApi.StoreJSON(); 
        a3.Name = 'test2';
        a3.mongoId='jkkjhkjhkkjhjjhkjhkhvjvhgkj';
        a3.recordType='Store'; 
        a3.walletBalance=0;
        a3.walletBlock=1;
        a3.walletHardLimit=2;
        a3.walletSoftLimit=3;
        String myJSON3 = JSON.serialize(a3);
         RestRequest request3 = new RestRequest();
         RestResponse res3 = new RestResponse();
		
        request3.requestUri ='instanceURL/services/apexrest/Flexy_App/Store';
        request3.httpMethod = 'PUT';
		request3.requestBody = Blob.valueof(myJSON3);
        
		RestContext.request = request;
        RestContext.response = res3;
      List<Account> accList1 = new List<Account>();
        
       accList1 = [Select Unique_Mongo_Id__c,Wallet_Balance__c,Wallet_Block__c,Wallet_Hard_Limit__c, Wallet_Soft_Limit__c 
                       from Account where Unique_Mongo_Id__c =:a3.mongoId ];
        if(accList1.isEmpty()){
        Account acc3;
        acc3.name='test1';
        acc3.Wallet_Balance__c=0;
        acc3.Wallet_Block__c=1;
        acc3.Wallet_Hard_Limit__c=2;
        acc3.Wallet_Soft_Limit__c=3;
        if(a.recordType =='Store'){
       		acc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Store').getRecordTypeId(); 
        }
        acc3.Unique_Mongo_Id__c='v64v65v44353453556';
        upsert acc3;
        }
        ac = StoreApi.deleteStoreInformation();
        
       
    return ac;     
    }   
    
}