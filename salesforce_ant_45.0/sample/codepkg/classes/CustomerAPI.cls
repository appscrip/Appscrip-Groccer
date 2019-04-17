@RestResource(urlMapping='/Contact/*')
global with sharing class CustomerAPI {
   public Static RestRequest request = RestContext.request;
   public Static RestResponse response = RestContext.response;
   public Static FromJSON jsonBody;
   
    @HttpPost
    global static String returnCustomerInfo() {   
        response.addHeader('Content-Type','application/json');
        Contact con;
        try {
            jsonBody  = (FromJSON) JSON.deserialize(request.requestBody.toString(),FromJSON.class);
            if(jsonBody != NULL){
                System.debug('The json is'+jsonBody);
                Date dt = Date.Parse(jsonBody.birthdate);
                con = new Contact();
                con.Mongo_Reference_Id__c = checkNull(jsonBody.mongoId);
                con.Device_Name__c = checkNull(jsonBody.deviceName);
                con.lastname = checkNull(jsonBody.name); 
                con.email = checkNull(jsonBody.email);
                con.phone = checkNull(jsonBody.phone);
                con.Encrp__c = checkNull(jsonBody.password);
                con.User_Type__c = checkNull(jsonBody.userType);
                con.Birthdate = dt;
                con.Customer_Status__c =checkNull(jsonBody.status);
                con.Profile_Picture_URL__c = checkNull(jsonBody.picURL);
                con.Terms_Conditions__c = jsonBody.tAndC;
                con.Wallet_Balance__c = jsonBody.walletBalance;
                con.Wallet_Block__c = jsonBody.walletBlock;
                con.Wallet_Hard_Limit__c = jsonBody.walletHardLimit;
                con.Wallet_Soft_Limit__c = jsonBody.walletSoftLimit;
                con.Device_Type__c = checkNull(jsonBody.deviceType);
                con.Country_Code__c = checkNull(jsonBody.countryCode);
        //------------------------Add More Field From Here ---------------------------------------------//        
                //con.Guest_Token__c = jsonBody.guestToken;
                con.Device_Id__c = checkNull(jsonBody.deviceId);
                con.App_Version__c = checkNull(jsonBody.appVersion);
                con.Currently_Active__c = jsonBody.currentlyActive;
                con.Device_OS_Version__c = checkNull(jsonBody.deviceOsVersion);
                con.Last_Login__c = checkNull(jsonBody.lastLoginTime);
                con.Location__longitude__s = jsonBody.longitude;
                con.Location__latitude__s = jsonBody.latitude;
                con.Created_Date_And_Time__c = DateTime.valueOf(checkNull(jsonBody.createdDateAndTime));
                //con.Created_By__c = checkNull(jsonBody.createdBy);
                con.Email_Verified__c = jsonBody.emailVerified;
                con.Mobile_Verified__c = jsonBody.mobileVerified;
                con.Registered_From_City__c = checkNull(jsonBody.registeredFromCity);
                con.Social_Media_Id__c = checkNull(jsonBody.socialMediaId);            
                
                Database.DMLOptions dml = new Database.DMLOptions(); 
                dml.DuplicateRuleHeader.allowSave = true;
                dml.DuplicateRuleHeader.runAsCurrentUser = true;
                //Account duplicateAccount = new Account(Name='dupe');
                Database.SaveResult sr = Database.insert(con,true);
                if (sr.isSuccess()) {  
                    System.debug('Contact has been inserted in Salesforce!');
                } 
            }     
        }
        Catch(Exception e){
            System.debug('The following error has occurred :' + e.getMessage());
        }
        System.debug('The Cont '+ con);
        if(con.id != NULL ){ 
            System.debug('The New Customer is created and name is '+ con.lastname);
            return 'returnClientInfo finished.' + jsonBody.name+ ' ' + jsonBody.phone+ ' '+ jsonBody.email + 'request=' + request ;  
        }
        return 'INVALID ID';
    } 
    
    @HttpPatch
    global static String updateCustomerInfo(){
        request.addHeader('Content-Type','application/json');
        List<Contact> customerList;
        try{
            jsonBody  = (FromJSON)JSON.deserialize(request.requestBody.toString(),FromJSON.class);
            System.debug('-----The Json Is-----1'+jsonBody);
            customerList = new List<Contact>();
            customerList = [Select  lastName , Mongo_Reference_Id__c , Encrp__c , phone , Email , Profile_Picture_URL__c , Country_Code__c , Address_Type__c , Flat_Number__c , Landmark__c , Wallet_Balance__c , Wallet_Block__c , Wallet_Hard_Limit__c , Wallet_Soft_Limit__c , 
                            MailingStreet , Mailing_Street_2__c , MailingCity , MailingState , MailingCountry , MailingPostalCode , Guest_Token__c , Device_Id__c , App_Version__c , Currently_Active__c , Device_OS_Version__c , Last_Login__c , Location__c, 
                            Created_Date_And_Time__c , Created_By__c , Email_Verified__c , Mobile_Verified__c , Registered_From_City__c , Social_Media_Id__c  From Contact Where Mongo_Reference_Id__c =:jsonBody.mongoId ];
             System.debug('------The customerList is-------2'+customerList);             
            //if(!customerList.isEmpty()){
                if(jsonBody.walletBalance != NULL && jsonBody.walletBlock != NULL && jsonBody.walletHardLimit != NULL && jsonBody.walletSoftLimit != NULL ){ 
                    customerList[0].Wallet_Balance__c = jsonBody.walletBalance;
                    customerList[0].Wallet_Block__c = jsonBody.walletBlock;
                    customerList[0].Wallet_Hard_Limit__c = jsonBody.walletHardLimit;
                    customerList[0].Wallet_Soft_Limit__c = jsonBody.walletSoftLimit;        
                }
                else if(jsonBody.password != Null && jsonBody.phone != Null && jsonBody.countryCode != Null && jsonBody.picURL != Null && jsonBody.email != Null){
                    customerList[0].Encrp__c = checkFieldValue(jsonBody.password , customerList[0].Encrp__c);
                    customerList[0].phone = checkFieldValue(jsonBody.phone , customerList[0].Phone);
                    customerList[0].Country_Code__c = checkFieldValue(jsonBody.countryCode , customerList[0].Country_Code__c);
                    customerList[0].Profile_Picture_URL__c = checkFieldValue(jsonBody.picURL , customerList[0].Profile_Picture_URL__c);
                    customerList[0].lastname = checkFieldValue(jsonBody.name , customerList[0].lastName);
                    //customerList[0].Last_Login__c = checkFieldValue(jsonBody.lastLogin , customerList[0].Last_Login__c);
                    customerList[0].Email = checkFieldValue(jsonBody.email , customerList[0].Email);   
                }
                else if(jsonBody.lastLoginTime != Null){
                    customerList[0].Last_Login__c = checkFieldValue(jsonBody.lastLoginTime , customerList[0].Last_Login__c);
               
                }
                else if(jsonBody.addressType != Null){
                    System.debug('---The addressType Is 3----'+jsonBody.addressType);
                    customerList[0].Device_OS_Version__c = checkFieldValue(jsonBody.deviceOsVersion , customerList[0].Device_OS_Version__c);
                    //customerList[0].Last_Login__c = checkFieldValue(jsonBody.lastLoginTime , customerList[0].Last_Login__c);    
                    customerList[0].Address_Type__c = checkFieldValue(jsonBody.addressType , customerList[0].Address_Type__c);
                    customerList[0].Flat_Number__c = checkFieldValue(jsonBody.flatNo , customerList[0].Flat_Number__c);
                    customerList[0].Landmark__c = checkFieldValue(jsonBody.landmark , customerList[0].Landmark__c);
                    customerList[0].MailingStreet = checkFieldValue(jsonBody.addressLine1 , customerList[0].MailingStreet);
                    customerList[0].Mailing_Street_2__c = checkFieldValue(jsonBody.addressLine2 , customerList[0].Mailing_Street_2__c) ;
                    customerList[0].MailingCity = checkFieldValue(jsonBody.city , customerList[0].MailingCity);
                    customerList[0].MailingState = checkFieldValue(jsonBody.state , customerList[0].MailingState);
                    customerList[0].MailingCountry = checkFieldValue(jsonBody.country , customerList[0].MailingCountry);
                    customerList[0].MailingPostalCode = checkFieldValue(jsonBody.postalCode , customerList[0].MailingPostalCode);       
                } 
                //response.addHeader('Content-Type', 'application/json');
                //response.responseBody = Blob.valueOf(JSON.serialize(customerList));
                //return response+'Successfully updated.'+ jsonBody.mongoId+ ' '+ jsonBody.city; 
            //} 
            /*if(customerList.isEmpty()) {
                response.statusCode = 204;
                response.addHeader('Content-Type', 'text/plain');
                response.responseBody  = Blob.valueOf('Contact mongo id is  found');
                return 'Contact mongo id is  found';
            } */
            System.debug('-----The List Is-----4'+customerList);
            update customerList;
            System.debug('-----The List Is-----5'+customerList);
            return 'Customer Info has been Updated Succesfully and MongoId is '+jsonBody.mongoId; 
        }
        catch(Exception e) {   
            System.debug('The following error has occurred :' + e.getMessage()); 
            //response.responseBody = Blob.valueOf(e.getMessage());
           /// response.statusCode = 204;
            return 'INVALID ID';   
        } 
         
    }
    
    @HttpPut
    global static String customerDeleted(){   
        request.addHeader('Content-Type','application/json');
        List<Contact> customerList;
        try {
            jsonBody  = (FromJSON) JSON.deserialize(request.requestBody.toString(),FromJSON.class);
            customerList = new List<Contact>();
            if(jsonBody != NULL){
                customerList = [Select id , Mongo_Reference_Id__c From Contact Where Mongo_Reference_Id__c =:jsonBody.mongoId];
            }    
            if(!customerList.isEmpty()){
                delete customerList;
            }        
            return 'Customer has been deleted.';   
        } 
        catch(Exception e) {  
            System.debug('The following error has occurred :' + e.getMessage());   
        } 
        return 'INVALID ID';  
    }
    public class FromJSON {
        public String mongoId;
        public String deviceName;
        public String name;      
        public String email;
        public String phone;  
        public String password;
        public String userType;
        public String birthdate;
        public String status;
        public String picURL;
        public Boolean tAndC;
        public Double walletBalance;
        public Double walletBlock;
        public Double walletHardLimit;
        public Double walletSoftLimit;
        public String deviceType;
        public String addressType;
        public String flatNo;
        public String landmark;
        public String addressLine1;
        public String addressLine2;
        public String city;
        public String state;
        public String country;
        public String postalCode; 
        public String countryCode; 
        
        //public Boolean guestToken;
        public String deviceId;
        public String appVersion;
        public Boolean currentlyActive;
        public String deviceOsVersion;
        public String lastLoginTime;
        public Double longitude;
        public Double latitude;
        public String createdDateAndTime;
        //public String createdBy;
        public Boolean emailVerified;
        public Boolean mobileVerified;
        public String registeredFromCity;
        public String socialMediaId; 
    }
    
    public Static String checkNull(String str){
        if(!String.isBlank(str)){
            return str;
        }
        return '';
    }
    public static String checkFieldValue(String newValue , String oldValue){
        if(newValue != oldValue && (newValue != '')){
            return newValue;
        }
        return oldValue;    
    }
    public static Integer checkCurrencyValue(Integer newValue , Integer oldValue){
        if(newValue != oldValue && (String.valueOf(newValue) != '')){
            return newValue;
        }
        return oldValue;    
    }          
}