public class StoreTestclass {
 /* @isTest public static void myStore(){
       //Account acc;
      String recordType;
      //StoreApi.StoreJSON  a;
      
      List<Account> accList = new List <Account>();
      //first json
        StoreApi.StoreJSON a = new StoreApi.StoreJSON(); 
        a.Name = 'test1';
        a.mongoId='v64v65v44353453556';
        a.recordType='Franchises';
        a.appLogo='https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg';
        a.webLogo='https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg';
        a.averageDeliveryTime='11/10/2018 12:46 PM';
        a.commission=8;
        a.commissionType='Fixed';
        a.countryCode='91';
        a.email='indora.rahul29@gmail.com';     
        a.ownerName='Rahul';
        a.ownerPhone='9314299695';
        a.storeaddress='pratap chowk';    
        a.subCategory='New';
        a.category='New1';
        a.storeLandLine='9312929493';
        a.password='rt67';
        a.status =true;
        a.walletBalance=100;
        a.walletBlock=10;
        a.walletHardLimit=100;
        a.walletSoftLimit=3;
        a.billingCountry='India';
        a.billingCity='Bangalore';
        a.billingState='Karnatka';
        a.billingStreet='Rtnagar';
        a.billingPostalCode='334004';
        a.website='www.appscrip.com';
           
       // recordType = a.storeType;
        a.businessZoneName='NA';
        a.companyDriver='5'; 
        a.foodType='Food';   
       											 //a.Franchisee__c='';
        a.freeDeliveryAbove=100;
        							 			//a.Store_Average_Rating__c=500;
        a.storeDriver='49'; 
        a.description='Test Class Test';
        system.debug('------------M'+a);
      
        String myJSON = JSON.serialize(a);
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();

        request.requestUri ='https://manishappscrip-dev-ed.my.salesforce.com/services/apexrest/Flexy_App/Store';
        request.httpMethod = 'POST';
		request.requestBody = Blob.valueof(myJSON);
        
		RestContext.request = request;
        RestContext.response = res;
      
         //first Account
     // for(integer i=0; i<2; i++){   
      Account acc= new Account();
        acc.name='test1';
        if(a.recordType =='Franchises'){
       		acc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Franchises').getRecordTypeId(); 
        }
        acc.Unique_Mongo_Id__c='v64v65v44353453556';
        acc.App_Logo__c='https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg';
        acc.Web_Logo__c='https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg';
        acc.Average_Delivery_Time__c='11/10/2018 12:46 PM';
        acc.Commission__c=8;
        acc.Commission_Type__c='Fixed';
        acc.Country_Code__c='91';
        acc.Email__c='indora.rahul29@gmail.com';
        acc.Owner_Name__c='Rahul';
        acc.Owner_Phone__c='9314299695';   
        acc.Store_Address__c='pratap chowk';
        acc.Store_Category__c='New';
        acc.Store_Sub_Category__c='New1';
        acc.Store_Landline_Number__c='9312929493';
        acc.Store_Password__c='rt67';
        acc.Status__c =true;
        acc.Wallet_Balance__c=100;
        acc.Wallet_Block__c=10;
        acc.Wallet_Hard_Limit__c=100;
        acc.Wallet_Soft_Limit__c=3;
        acc.BillingCountry='India';
        acc.BillingCity='Bangalore';
        acc.BillingState='Karnatka';
        acc.BillingStreet='Rtnagar';
        acc.BillingPostalCode='334004';
        acc.Website='www.appscrip.com';
        acc.Store_Type__c='Franchises';
        acc.Business_Zone_Name__c='NA';
        acc.Company_Driver__c='5'; 
        acc.Food_Type__c='Food';
        acc.Store_Driver__c='49';
        acc.Description='Test Class Test';
        insert acc;
        Account ac = StoreApi.returnStoreInfo();
        
      //Second Json
        StoreApi.StoreJSON a1 = new StoreApi.StoreJSON(); 
        a1.Name = 'test2';
        a1.mongoId='jkkjhkjhkkjhjjhkjhkhvjvhgkj';
        a1.recordType='Store'; 
        a1.appLogo='https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg';
        a1.webLogo='https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg';
        a1.averageDeliveryTime='11/10/2018 12:46 PM';
        a1.commission=8;
        a1.commissionType='Fixed';
        a1.countryCode='91';
        a1.email='indora.rahul29@gmail.com';     
        a1.ownerName='Rahul';
        a1.ownerPhone='9314299695';
        a1.storeaddress='pratap chowk';    
        a1.subCategory='New';
        a1.category='New1';
        a1.storeLandLine='9312929493';
        a1.password='rt67';
        a1.status =true;
        a1.walletBalance=100;
        a1.walletBlock=10;
        a1.walletHardLimit=100;
        a1.walletSoftLimit=3;
        a1.billingCountry='India';
        a1.billingCity='Bangalore';
        a1.billingState='Karnatka';
        a1.billingStreet='Rtnagar';
        a1.billingPostalCode='334004';
        a1.website='www.appscrip.com';
        a1.recordType='Franchises';   
             
       // recordType = a.storeType;
        a1.businessZoneName='NA';
        a1.companyDriver='5'; 
        a1.foodType='Food';   
       											 //a.Franchisee__c='';
        a1.freeDeliveryAbove=100;
        							 			//a.Store_Average_Rating__c=500;
        a1.storeDriver='49'; 
        a1.description='Test Class Test';
        system.debug('------------M'+a1);
      
        String myJSON2 = JSON.serialize(a1);
        RestRequest request2 = new RestRequest();
        RestResponse res2 = new RestResponse();

        request.requestUri ='https://manishappscrip-dev-ed.my.salesforce.com/services/apexrest/Flexy_App/Store';
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
        acc1.App_Logo__c='https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg';
        acc1.Web_Logo__c='https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg';
        acc1.Average_Delivery_Time__c='11/10/2018 12:46 PM';
        acc1.Commission__c=8;
        acc1.Commission_Type__c='Fixed';
        acc1.Country_Code__c='91';
        acc1.Email__c='indora.rahul29@gmail.com';
        acc1.Owner_Name__c='Rahul';
        acc1.Owner_Phone__c='9314299695';   
        acc1.Store_Address__c='pratap chowk';
        acc1.Store_Category__c='New';
        acc1.Store_Sub_Category__c='New1';
        acc1.Store_Landline_Number__c='9312929493';
        acc1.Store_Password__c='rt67';
        acc1.Status__c =true;
        acc1.Wallet_Balance__c=100;
        acc1.Wallet_Block__c=10;
        acc1.Wallet_Hard_Limit__c=100;
        acc1.Wallet_Soft_Limit__c=3;
        acc1.BillingCountry='India';
        acc1.BillingCity='Bangalore';
        acc1.BillingState='Karnatka';
        acc1.BillingStreet='Rtnagar';
        acc1.BillingPostalCode='334004';
        acc1.Website='www.appscrip.com';
        acc1.Store_Type__c='Store';
        acc1.Business_Zone_Name__c='NA';
        acc1.Company_Driver__c='5'; 
        acc1.Food_Type__c='Food';
        acc1.Store_Driver__c='49';
        acc1.Description='Test Class Test'; 
        insert acc1;
        System.debug('the list rec-----------'+acc);
	  Account ac1 = StoreApi.returnStoreInfo();
      
      //Third Json
      StoreApi.StoreJSON a2 = new StoreApi.StoreJSON(); 
        a2.Name = 'test1';
        a2.mongoId='jhjhgjhg6576r5hg7687gjhg';
        a2.parentMongoId = 'jkkjhkjhkkjhjjhkjhkhvjvhgkj';
        a2.recordType='Store'; 
        a2.appLogo='https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg';
        a2.webLogo='https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg';
        a2.averageDeliveryTime='11/10/2018 12:46 PM';
        a2.commission=8;
        a2.commissionType='Fixed';
        a2.countryCode='91';
        a2.email='indora.rahul29@gmail.com';     
        a2.ownerName='Rahul';
        a2.ownerPhone='9314299695';
        a2.storeaddress='pratap chowk';    
        a2.subCategory='New';
        a2.category='New1';
        a2.storeLandLine='9312929493';
        a2.password='rt67';
        a2.status =true;
        a2.walletBalance=100;
        a2.walletBlock=10;
        a2.walletHardLimit=100;
        a2.walletSoftLimit=3;
        a2.billingCountry='India';
        a2.billingCity='Bangalore';
        a2.billingState='Karnatka';
        a2.billingStreet='Rtnagar';
        a2.billingPostalCode='334004';
        a2.website='www.appscrip.com';
           
        a2.businessZoneName='NA';
        a2.companyDriver='5'; 
        a2.foodType='Food';   
       											 //a.Franchisee__c='';
        a2.freeDeliveryAbove=100;
        							 			//a.Store_Average_Rating__c=500;
        a2.storeDriver='49'; 
        a2.description='Test Class Test';
        system.debug('------------M'+a2);
      
        String myJSON3 = JSON.serialize(a2);
        RestRequest request3 = new RestRequest();
        RestResponse res3 = new RestResponse();

        request.requestUri ='https://manishappscrip-dev-ed.my.salesforce.com/services/apexrest/Flexy_App/Store';
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
        acc2.App_Logo__c='https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg';
        acc2.Web_Logo__c='https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg';
        acc2.Average_Delivery_Time__c='11/10/2018 12:46 PM';
        acc2.Commission__c=8;
        acc2.Commission_Type__c='Fixed';
        acc2.Country_Code__c='91';
        acc2.Email__c='indora.rahul29@gmail.com';
        acc2.Owner_Name__c='Rahul';
        acc2.Owner_Phone__c='9314299695';   
        acc2.Store_Address__c='pratap chowk';
        acc2.Store_Category__c='New';
        acc2.Store_Sub_Category__c='New1';
        acc2.Store_Landline_Number__c='9312929493';
        acc2.Store_Password__c='rt67';
        acc2.Status__c =true;
        acc2.Wallet_Balance__c=100;
        acc2.Wallet_Block__c=10;
        acc2.Wallet_Hard_Limit__c=100;
        acc2.Wallet_Soft_Limit__c=3;   
        acc2.BillingCountry='India';
        acc2.BillingCity='Bangalore';
        acc2.BillingState='Karnatka';
        acc2.BillingStreet='Rtnagar';
        acc2.BillingPostalCode='334004';
        acc2.Website='www.appscrip.com';
        acc2.Store_Type__c='Store';
        acc2.Business_Zone_Name__c='NA';
        acc2.Company_Driver__c='5'; 
        acc2.Food_Type__c='Food';
        acc2.Store_Driver__c='49';
        acc2.Description='Test Class Test'; 
        insert acc2;
        System.debug('the list rec-----------'+acc);
	    Account ac2 = StoreApi.returnStoreInfo();
      
      
      
    }
    */
    
}