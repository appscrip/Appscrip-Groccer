@isTest
public class CustomerAPITest {
    
    @isTest private static String forPostMethod(){
        
        CustomerAPI.FromJSON customer = new CustomerAPI.FromJSON();
        customer.name = 'New Test User';
        customer.mongoId = 'vnvnbvmn87687687ghjg7gjg7';
        customer.deviceName = 'Android';
        customer.email = 'user@gmail.com';
        customer.phone = '8107576862';
        customer.password = 'User@123.';
        customer.userType = 'Customer';
        customer.birthdate = '04/10/2019';
        customer.status = 'Active';   
        customer.picURL = 'https://googleimages.com/images/img1.jpg';
        customer.tAndC = true;
        customer.walletBalance = 100;
        customer.walletBlock =100;
        customer.walletHardLimit =100;
        customer.walletSoftLimit =100;
        customer.deviceType = 'Android';
        customer.countryCode = '+91';
        customer.deviceId = '2483';
        customer.appVersion = '1.0';
        customer.currentlyActive = true;
        customer.deviceOsVersion = '1.0';
        customer.lastLoginTime ='2 min ago';
        customer.longitude = 13.0196;
        customer.latitude = 77.5968;
        customer.createdDateAndTime = '2018-11-22 03:15:10';     
        customer.emailVerified = true;
        customer.mobileVerified = true;
        customer.registeredFromCity = 'Bangaluru';
        customer.socialMediaId = 'dkjashd48237972138'; 
        
        String myJson = JSON.serialize(customer);
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        String instanceURL =URL.getSalesforceBaseUrl().toExternalForm();
        request.requestURI = instanceURL+'/services/apexrest/Flexy_App/Contact';
        System.debug('instance url is ---> '+request.requestURI);
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(myJson);
        
        RestContext.request = request;
        RestContext.response = response;
        
        Contact con = new Contact();
        Date dt = Date.Parse('04/10/2019');
        con.lastName = 'New Test User';
        con.Mongo_Reference_Id__c = 'vnvnbvmn87687687ghjg7gjg7';
        con.Terms_Conditions__c = true;
        con.Device_Name__c = 'Android';
        con.email = 'user@gmail.com';
        con.phone = '8107576862';
        con.Encrp__c = 'User@123.';
        con.User_Type__c = 'Customer';
        con.Birthdate = dt;
        con.Customer_Status__c ='Active';
        con.Profile_Picture_URL__c = 'https://googleimages.com/images/img1.jpg';
        con.Terms_Conditions__c = true;
        con.Wallet_Balance__c = 100;
        con.Wallet_Block__c = 100;
        con.Wallet_Hard_Limit__c = 100;
        con.Wallet_Soft_Limit__c = 100;
        con.Device_Type__c = 'Android';
        con.Country_Code__c = '+91';
        con.Device_Id__c = '2483';
        con.App_Version__c = '1.0';
        con.Currently_Active__c = true;
        con.Device_OS_Version__c = '1.0';
        con.Last_Login__c = '2 min ago';
        con.Location__longitude__s = 13.0196;
        con.Location__latitude__s = 77.5968;
        con.Created_Date_And_Time__c = DateTime.valueOf('2018-11-22 03:15:10');
        con.Email_Verified__c = true;
        con.Mobile_Verified__c = true;
        con.Registered_From_City__c = 'Bangaluru';
        con.Social_Media_Id__c = 'dkjashd48237972138';     
        
       // Test.startTest();
            Database.SaveResult result = Database.insert(con);
            String message = CustomerAPI.returnCustomerInfo();
        //Test.stopTest();
        
        System.assert(result.isSuccess());  
        return message+'User has been created successfully.';       
    }
    
    @isTest private static String forPatchMethod(){
        
        CustomerAPI.FromJSON customer = new CustomerAPI.FromJSON();
        customer.name = 'New Test User';
        customer.mongoId = 'sdhgsdas43983jhff8347132jhf';
        customer.deviceName = 'Android';
        customer.email = 'user@gmail.com';
        customer.phone = '8107576862';
        customer.password = 'User@123.';
        customer.userType = 'Customer';
        customer.birthdate = '04/10/2019';
        customer.status = 'Active';
        customer.picURL = 'https://googleimages.com/images/img1.jpg';
        customer.tAndC = true;
        customer.walletBalance = 100;
        customer.walletBlock =100;
        customer.walletHardLimit =100;
        customer.walletSoftLimit =100;
        customer.deviceType = 'Android';
        customer.countryCode = '+91';
        customer.deviceId = '2483';
        customer.appVersion = '1.0';
        customer.currentlyActive = true;
        customer.deviceOsVersion = '1.0';
        customer.lastLoginTime ='2 min ago';
        customer.longitude = 13.0196;
        customer.latitude = 77.5968;
        customer.createdDateAndTime = '2018-11-22 03:15:10';     
        customer.emailVerified = true;
        customer.mobileVerified = true;
        customer.registeredFromCity = 'Bangaluru';
        customer.socialMediaId = 'dkjashd48237972138'; 
        
        String myJson = JSON.serialize(customer);
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        String instanceURL =URL.getSalesforceBaseUrl().toExternalForm();
        request.requestURI = instanceURL+'/services/apexrest/Flexy_App/Contact';
        System.debug('instance url is ---> '+request.requestURI);
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(myJson);
        
        RestContext.request = request;
        RestContext.response = response;
        
        Contact con = new Contact();
        Date dt = Date.Parse('04/10/2019');
        con.lastName = 'New Test User';
        con.Mongo_Reference_Id__c = 'sdhgsdas43983jhff8347132jhf';
        con.Terms_Conditions__c = true;
        con.Device_Name__c = 'Android';
        con.email = 'user@gmail.com';
        con.phone = '8107576862';
        con.Encrp__c = 'User@123.';
        con.User_Type__c = 'Customer';
        con.Birthdate = dt;
        con.Customer_Status__c ='Active';
        con.Profile_Picture_URL__c = 'https://googleimages.com/images/img1.jpg';
        con.Terms_Conditions__c = true;
        con.Wallet_Balance__c = 100;
        con.Wallet_Block__c = 100;
        con.Wallet_Hard_Limit__c = 100;
        con.Wallet_Soft_Limit__c = 100;
        con.Device_Type__c = 'Android';
        con.Country_Code__c = '+91';
        con.Device_Id__c = '2483';   
        con.App_Version__c = '1.0';
        con.Currently_Active__c = true;
        con.Device_OS_Version__c = '1.0';
        con.Last_Login__c = '2 min ago';
        con.Location__longitude__s = 13.0196;
        con.Location__latitude__s = 77.5968;
        con.Created_Date_And_Time__c = DateTime.valueOf('2018-11-22 03:15:10');
        con.Email_Verified__c = true;
        con.Mobile_Verified__c = true;
        con.Registered_From_City__c = 'Bangaluru';
        con.Social_Media_Id__c = 'dkjashd48237972138';     
        
        Test.startTest();
            Database.SaveResult result = Database.insert(con);
            String message = CustomerAPI.returnCustomerInfo();
        Test.stopTest();
   
        
        //first  Customer JSON for phone , email etc
        CustomerAPI.FromJSON customer1 = new CustomerAPI.FromJSON();
        customer1.mongoId = 'sdhgsdas43983jhff8347132jhf';
        customer1.email = 'user@gmail.com';
        customer1.phone = '8107576862';
        customer1.password = 'User@123.';
        customer1.countryCode = '+91';
        customer1.picURL = 'https://googleimages.com/images/img1.jpg';
        
        String myJson1 = JSON.serialize(customer1);
        RestRequest request1 = new RestRequest();
        RestResponse response1 = new RestResponse();
        String instanceURL1 =URL.getSalesforceBaseUrl().toExternalForm();
        request1.requestURI = instanceURL1+'/services/apexrest/Flexy_App/Contact';
        request1.httpMethod = 'PATCH';
        request1.requestBody = Blob.valueOf(myJson1);
        
        RestContext.request = request1;
        RestContext.response = response1;
        
        //First Contact
        Contact con1 = [Select  id ,Encrp__c,phone,Email,Profile_Picture_URL__c,Country_Code__c  From Contact Where
                       Mongo_Reference_Id__c =:customer1.mongoId ];
        
        if(customer1.password != Null && customer1.phone != Null && customer1.countryCode != Null && customer1.picURL != Null && 
           customer1.email != Null){
            con1.email = customer1.email;
            con1.phone = customer1.phone;
            con1.Encrp__c = customer1.password;
            con1.Country_Code__c = customer1.countryCode;
            con1.Profile_Picture_URL__c = customer1.picURL;
        }
        
        //Test.startTest();
            update con1;
            String message1 = CustomerAPI.updateCustomerInfo();
        //Test.stopTest();
       
        //Second JSON for wallet details
        CustomerAPI.FromJSON customer2 = new CustomerAPI.FromJSON();
        customer2.mongoId = 'sdhgsdas43983jhff8347132jhf';
        customer2.walletBalance = 100;
        customer2.walletBlock =100;
        customer2.walletHardLimit =100;
        customer2.walletSoftLimit =100;
        
        String myJson2 = JSON.serialize(customer2);
        RestRequest request2 = new RestRequest();
        RestResponse response2 = new RestResponse();
        String instanceURL2 =URL.getSalesforceBaseUrl().toExternalForm();
        request2.requestURI = instanceURL2+'/services/apexrest/Flexy_App/Contact';
        request2.httpMethod = 'PATCH';
        request2.requestBody = Blob.valueOf(myJson2);
        RestContext.request = request2;
        RestContext.response = response2;
        
        //for Second Contact Update for wallet details
        Contact con2 = [Select  id ,Wallet_Balance__c , Wallet_Block__c , Wallet_Hard_Limit__c , Wallet_Soft_Limit__c   From 
                        Contact Where Mongo_Reference_Id__c =:customer2.mongoId ];
        
        if(customer2.walletBalance != NULL && customer2.walletBlock != NULL && customer2.walletHardLimit != NULL && customer2.walletSoftLimit != NULL ){ 
             con2.Wallet_Balance__c = customer2.walletBalance;
             con2.Wallet_Block__c = customer2.walletBlock;
             con2.Wallet_Hard_Limit__c = customer2.walletHardLimit;
             con2.Wallet_Soft_Limit__c = customer2.walletSoftLimit;    
        }
        // Test.startTest();
            update con2;
            String message2 = CustomerAPI.updateCustomerInfo();
        //Test.stopTest();
        
         //Third  Customer JSON for Address Details Update
        CustomerAPI.FromJSON customer3 = new CustomerAPI.FromJSON();
        customer3.mongoId = 'sdhgsdas43983jhff8347132jhf';
        customer3.deviceOsVersion = '1.0'; 
        customer3.addressType = 'Home';
        customer3.flatNo ='147';
        customer3.landmark = 'Power House';
        customer3.addressLine1 ='1178 Aanand Nagar';
        customer3.addressLine2 = 'Near Sisodia Garden';
        customer3.city  = 'Jodhpur';
        customer3.state = 'Rajasthan';
        customer3.country = 'India';
        customer3.postalCode = '342001';
        
        String myJson3 = JSON.serialize(customer3);
        RestRequest request3 = new RestRequest();
        RestResponse response3 = new RestResponse();
        String instanceURL3 =URL.getSalesforceBaseUrl().toExternalForm();
        request3.requestURI = instanceURL3+'/services/apexrest/Flexy_App/Contact';
        request3.httpMethod = 'PATCH';
        request3.requestBody = Blob.valueOf(myJson3);
        
        RestContext.request = request3;
        RestContext.response = response3;
        
        //Third Contact For Address update
        Contact con3 = [Select  id ,Device_OS_Version__c,Address_Type__c,Flat_Number__c,Landmark__c,MailingStreet,Mailing_Street_2__c ,
                        MailingCity , MailingState , MailingCountry , MailingPostalCode From Contact 
                        where Mongo_Reference_Id__c =:customer3.mongoId ];
          if (customer3.addressType != Null){
            con3.Device_OS_Version__c =  customer3.deviceOsVersion; 
            con3.Address_Type__c = customer3.addressType;
            con3.Flat_Number__c = customer3.flatNo ;
            con3.Landmark__c = customer3.landmark; 
            con3.MailingStreet = customer3.addressLine1 ;
            con3.Mailing_Street_2__c = customer3.addressLine2 ; 
            con3.MailingCity =  customer3.city  ;
            con3.MailingState = customer3.state ;
            con3.MailingCountry =  customer3.country ; 
            con3.MailingPostalCode =  customer3.postalCode ; 
        }    
                               
        
       // Test.startTest();
            update con3;
            String message3 = CustomerAPI.updateCustomerInfo();
       // Test.stopTest();
        
        
        
      
        //else if(customer.lastLoginTime !=Null)
           // con.Last_Login__c = customer.lastLoginTime;
        
         
        
        
        return message3+'User has been updated successfully.';    
          
    } 

}