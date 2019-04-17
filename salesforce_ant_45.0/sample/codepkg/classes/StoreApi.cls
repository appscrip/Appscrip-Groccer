@RestResource(urlMapping='/Store/*')
global with sharing class StoreApi { 
        public static RestRequest request = RestContext.request;
        public static RestResponse response = RestContext.response;  
        public static StoreJSON jsonBody; 
        public static Account a;
        public static List<Account> accList; 
        public static String franchisesMongoId;
    
	 @HttpPost
    global static Account returnStoreInfo() {
        response.addHeader('Content-Type','application/json');
        Boolean s = false;
        try {
             jsonBody  = (StoreJSON) JSON.deserialize(request.requestBody.toString(),StoreJSON.class);
             System.debug('The json is '+jsonBody);
             a = new Account();
             accList = new List<Account>();
             if(jsonBody.recordType == 'Franchises'){
                 a.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Franchises').getRecordTypeId();
             }
             else if(jsonBody.recordType == 'Store' && jsonBody.parentMongoId != Null && jsonBody.parentMongoId !='' ){
                     a.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Store').getRecordTypeId();
                     accList=[select id,Name from Account where Unique_Mongo_Id__c =:jsonBody.parentMongoId];
                     a.ParentId = accList[0].id;
                     a.Related_Store__c= accList[0].id;
              
              }
             else if(jsonBody.recordType == 'Store'){
                  a.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Store').getRecordTypeId();
             }
             a.name = jsonBody.Name;
             System.debug('The Name is' +jsonBody.averageDeliveryTime);
             a.Unique_Mongo_Id__c =jsonBody.mongoId;
             a.App_Logo__c= checkNull(jsonBody.appLogo);
             a.Web_Logo__c = checkNull(jsonBody.webLogo);
             a.Average_Delivery_Time__c = checkNull(jsonBody.averageDeliveryTime);      //dt;
             a.Commission__c=jsonBody.commission;
             a.Commission_Type__c= jsonBody.commissionType;
             a.Country_Code__c= checkNull(jsonBody.countryCode);
             a.Email__c = checkNull(jsonBody.email);
             a.Owner_Name__c = checkNull(jsonBody.ownerName);
             a.Owner_Phone__c = checkNull(jsonBody.ownerPhone);
             a.Store_Address__c = checkNull(jsonBody.storeaddress);
             a.Store_Category__c = checkNull(jsonBody.category);
             a.Store_Sub_Category__c = checkNull(jsonBody.subCategory);
             a.Store_Landline_Number__c = checkNull(jsonBody.storeLandLine);
             a.Store_Password__c = checkNull(jsonBody.password);
             a.Status__c = jsonBody.status;
             a.Wallet_Balance__c = jsonBody.walletBalance;
             a.Wallet_Block__c = jsonBody.walletBlock;
             a.Wallet_Hard_Limit__c = jsonBody.walletHardLimit;
             a.Wallet_Soft_Limit__c = jsonBody.walletSoftLimit;
             a.BillingCountry = checkNull(jsonBody.billingCountry);
             a.BillingCity = checkNull(jsonBody.billingCity);
             a.BillingState = checkNull(jsonBody.billingState);
             a.BillingStreet = checkNull(jsonBody.billingStreet);
             a.BillingPostalCode = checkNull(jsonBody.billingPostalCode); 
             a.Website  = checkNull(jsonBody.website);
             a.Store_Type__c = checkNull(jsonBody.storeType);
             a.Business_Zone_Name__c = checkNull(jsonBody.businessZoneName); 
             a.Company_Driver__c = checkNull(jsonBody.companyDriver);
             a.Food_Type__c= checkNull(jsonBody.foodType);
             a.Franchisee__c = checkNull(jsonBody.franchisee);
             a.Free_Delivery_Above__c = jsonBody.freeDeliveryAbove;
             a.Store_Average_Rating__c= jsonBody.averageRating;
             a.Store_Driver__c = checkNull(jsonBody.storeDriver);
             a.Description = checkNull(jsonBody.description);
             System.debug('The Json Is '+a);
             
             Database.DMLOptions dml = new Database.DMLOptions(); 
             dml.DuplicateRuleHeader.allowSave = true;
             dml.DuplicateRuleHeader.runAsCurrentUser = true;
             Account duplicateAccount = new Account(Name='dupe');
             Database.SaveResult sr = Database.insert(a, dml); 
        }
        catch(Exception e){
                System.debug('The following error has occurred :' + e.getMessage());
        }
        System.debug('The Json Is'+a);
        if(a.id != NULL ){
            System.debug('The New store is created and name is '+ a.Name);
            //return 'returnClientInfo finished.' + jsonBody.Name+ ' ' + jsonBody.ownerPhone+ ' '+ jsonBody.email + 'request=' + request ;
        }
        //return 'INVALID ID';
        return a;
    } 
      
  /*  @HttpPatch
    global static String updateStoreInformation() { 
        response.addHeader('Content-Type','applicatin/json');
        Boolean s = false; 
        Account a;
        try {
            jsonBody  = (StoreJSON)JSON.deserialize(request.requestBody.toString(),StoreJSON.class);
            System.debug('The jason Is' +jsonBody);
            a=[select Unique_Mongo_Id__c,Website,Description,Store_Driver__c,Store_Type__c,Food_Type__c,Franchisee__c,Free_Delivery_Above__c,Company_Driver__c,
               Business_Zone_Name__c,Store_Average_Rating__c,App_Logo__c,Web_Logo__c,Name,Email__c,Status__c,Country_Code__c,Store_Password__c,Commission__c,
               Commission_Type__c,BillingStreet,BillingCountry,BillingCity,BillingState,BillingPostalCode,Wallet_Balance__c,Wallet_Block__c,Wallet_Hard_Limit__c,
               Wallet_Soft_Limit__c,Owner_Name__c,Store_Landline_Number__c,Owner_Phone__c,Store_Address__c,Store_Category__c,Store_Sub_Category__c,
               Average_Delivery_Time__c From Account where Unique_Mongo_Id__c=:jsonBody.mongoId ];
               
            if(jsonBody.walletBalance != Null && jsonBody.walletBlock != Null && jsonBody.walletHardLimit != Null && jsonBody.walletSoftLimit != Null){
             a.Wallet_Balance__c = jsonBody.walletBalance;
             a.Wallet_Block__c = jsonBody.walletBlock;
             a.Wallet_Hard_Limit__c = jsonBody.walletHardLimit;
             a.Wallet_Soft_Limit__c = jsonBody.walletSoftLimit;
            }
            
            else{
                a.Name= checkfieldValue(jsonBody.Name,a.Name); 
                a.App_Logo__c= checkfieldValue(jsonBody.appLogo,a.App_Logo__c); 
                a.Web_Logo__c =checkfieldValue(jsonBody.webLogo,a.Web_Logo__c); 
                a.Average_Delivery_Time__c = checkFieldValue(jsonBody.averageDeliveryTime,a.Average_Delivery_Time__c);    //dt;
                a.Commission_Type__c= checkfieldValue(jsonBody.commissionType,a.Commission_Type__c); 
                a.Country_Code__c = checkfieldValue(jsonBody.countryCode,a.Country_Code__c);
                a.Email__c = checkfieldValue(jsonBody.email,a.Email__c); 
                a.Owner_Name__c = checkfieldValue(jsonBody.ownerName,a.Owner_Name__c); 
                a.Owner_Phone__c = checkfieldValue(jsonBody.ownerPhone,a.Owner_Phone__c ); 
                a.Store_Address__c = checkfieldValue(jsonBody.storeaddress,a.Store_Address__c); 
                a.Store_Category__c = checkfieldValue(jsonBody.category,a.Store_Category__c); 
                a.Store_Sub_Category__c = checkfieldValue(jsonBody.subCategory,a.Store_Sub_Category__c); 
                a.Store_Landline_Number__c = checkfieldValue(jsonBody.storeLandLine,a.Store_Landline_Number__c); 
                a.Store_Password__c = checkfieldValue(jsonBody.password,a.Store_Password__c);
                a.Commission__c=jsonBody.commission;
                a.Website  = checkfieldValue(jsonBody.website,a.Website);
                a.BillingCountry = checkfieldValue(jsonBody.billingCountry,a.BillingCountry); 
                a.BillingCity = checkfieldValue(jsonBody.billingCity,a.BillingCity);
                a.BillingState= checkfieldValue(jsonBody.billingState,a.BillingState);
                a.BillingStreet = checkfieldValue(jsonBody.billingStreet,a.BillingStreet);
                a.BillingPostalCode = checkfieldValue(jsonBody.billingPostalCode,a.BillingPostalCode); 
                a.Description = checkfieldValue(jsonBody.description,a.Description);
                a.Business_Zone_Name__c = checkfieldValue(jsonBody.businessZoneName,a.Business_Zone_Name__c); 
                a.Company_Driver__c = checkfieldValue(jsonBody.companyDriver,a.Company_Driver__c);           
                a.Food_Type__c= checkfieldValue(jsonBody.foodType,a.Food_Type__c);
                a.Franchisee__c = checkfieldValue(jsonBody.franchisee,a.Franchisee__c);
                a.Free_Delivery_Above__c = jsonBody.freeDeliveryAbove;
                a.Store_Type__c = checkfieldValue(jsonBody.storeType,a.Store_Type__c);
                a.Store_Average_Rating__c=jsonBody.averageRating;
                a.Store_Driver__c = checkfieldValue(jsonBody.storeDriver,a.Store_Driver__c);
           }
            update a;
            return 'Data UPdated' +a.name ;
        }
        Catch(Exception e){
            System.debug('The following error has occurred :' + e.getMessage());
            return 'Data UPdated Error' +e.getMessage();
        }
    }
    */
   
     @HttpPut
     global static String deleteStoreInformation() {
      response.addHeader('Content-Type','applicatin/json');
      List<Account> accList=new List<Account>();
      Boolean s = false; 
        try {
            jsonBody  = (StoreJSON)JSON.deserialize(request.requestBody.toString(),StoreJSON.class);
            accList=[select Unique_Mongo_Id__c,Website,Description,Store_Driver__c,Store_Type__c,Food_Type__c,Franchisee__c,Free_Delivery_Above__c,Company_Driver__c,
               Business_Zone_Name__c,Store_Average_Rating__c,App_Logo__c,Web_Logo__c,Name,Email__c,Status__c,Country_Code__c,Store_Password__c,Commission__c,
               Commission_Type__c,BillingStreet,BillingCountry,BillingCity,BillingState,BillingPostalCode,Wallet_Balance__c,Wallet_Block__c,Wallet_Hard_Limit__c,
               Wallet_Soft_Limit__c,Owner_Name__c,Store_Landline_Number__c,Owner_Phone__c,Store_Address__c,Store_Category__c,Store_Sub_Category__c,
               Average_Delivery_Time__c From Account where Unique_Mongo_Id__c=:jsonBody.mongoId ];
           
            
            if(accList.isEmpty()){
                a = new Account();
                if(jsonBody.recordType == 'Franchises'){
                     a.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Franchises').getRecordTypeId();
                 }
                 
                else if(jsonBody.recordType == 'Store' && jsonBody.parentMongoId != Null && jsonBody.parentMongoId !='' ){
                    a.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Store').getRecordTypeId();
                    accList=[select id,Name from Account where Unique_Mongo_Id__c =:jsonBody.parentMongoId];
                    a.ParentId = accList[0].id;
                    a.Related_Store__c= accList[0].id;  
                }
                else if(jsonBody.recordType == 'Store'){
                    a.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Store').getRecordTypeId();      
                }
                      
                 a.name = jsonBody.Name;
                 System.debug('The Name is' +jsonBody.averageDeliveryTime);
                 a.Unique_Mongo_Id__c =jsonBody.mongoId;
                 a.App_Logo__c= checkNull(jsonBody.appLogo);
                 a.Web_Logo__c = checkNull(jsonBody.webLogo);
                 a.Average_Delivery_Time__c = checkNull(jsonBody.averageDeliveryTime);      //dt;
                 a.Commission__c=jsonBody.commission;
                 a.Commission_Type__c= jsonBody.commissionType;
                 a.Country_Code__c= checkNull(jsonBody.countryCode);
                 a.Email__c = checkNull(jsonBody.email);
                 a.Owner_Name__c = checkNull(jsonBody.ownerName);
                 a.Owner_Phone__c = checkNull(jsonBody.ownerPhone);
                 a.Store_Address__c = checkNull(jsonBody.storeaddress);
                 a.Store_Category__c = checkNull(jsonBody.category);
                 a.Store_Sub_Category__c = checkNull(jsonBody.subCategory);
                 a.Store_Landline_Number__c = checkNull(jsonBody.storeLandLine);
                 a.Store_Password__c = checkNull(jsonBody.password);
                 a.Status__c = jsonBody.status;
                 a.Wallet_Balance__c = jsonBody.walletBalance;
                 a.Wallet_Block__c = jsonBody.walletBlock;
                 a.Wallet_Hard_Limit__c = jsonBody.walletHardLimit;
                 a.Wallet_Soft_Limit__c = jsonBody.walletSoftLimit;
                 a.BillingCountry = checkNull(jsonBody.billingCountry);
                 a.BillingCity = checkNull(jsonBody.billingCity);
                 a.BillingState = checkNull(jsonBody.billingState);
                 a.BillingStreet = checkNull(jsonBody.billingStreet);
                 a.BillingPostalCode = checkNull(jsonBody.billingPostalCode); 
                 a.Website  = checkNull(jsonBody.website);
                 a.Store_Type__c = checkNull(jsonBody.storeType);
                 a.Business_Zone_Name__c = checkNull(jsonBody.businessZoneName); 
                 a.Company_Driver__c = checkNull(jsonBody.companyDriver);
                 a.Food_Type__c= checkNull(jsonBody.foodType);
                 a.Franchisee__c = checkNull(jsonBody.franchisee);
                 a.Free_Delivery_Above__c = jsonBody.freeDeliveryAbove;
                 a.Store_Average_Rating__c= jsonBody.averageRating;
                 a.Store_Driver__c = checkNull(jsonBody.storeDriver);
                 a.Description = checkNull(jsonBody.description);
                 System.debug('The Json Is '+a);
                 accList.add(a);
             }
             
             if(!accList.isEmpty()){
             
                 if(jsonBody.walletBalance != Null && jsonBody.walletBlock != Null && jsonBody.walletHardLimit != Null && jsonBody.walletSoftLimit != Null){
                     accList[0].Wallet_Balance__c = jsonBody.walletBalance;
                     accList[0].Wallet_Block__c = jsonBody.walletBlock;
                     accList[0].Wallet_Hard_Limit__c = jsonBody.walletHardLimit;
                     accList[0].Wallet_Soft_Limit__c = jsonBody.walletSoftLimit;
                }
                
                else{
                    accList[0].Name= checkfieldValue(jsonBody.Name,accList[0].Name); 
                    accList[0].App_Logo__c= checkfieldValue(jsonBody.appLogo,accList[0].App_Logo__c); 
                    accList[0].Web_Logo__c =checkfieldValue(jsonBody.webLogo,accList[0].Web_Logo__c); 
                    accList[0].Average_Delivery_Time__c = checkFieldValue(jsonBody.averageDeliveryTime,accList[0].Average_Delivery_Time__c);    //dt;
                    accList[0].Commission_Type__c= checkfieldValue(jsonBody.commissionType,accList[0].Commission_Type__c); 
                    accList[0].Country_Code__c = checkfieldValue(jsonBody.countryCode,accList[0].Country_Code__c);
                    accList[0].Email__c = checkfieldValue(jsonBody.email,accList[0].Email__c); 
                    accList[0].Owner_Name__c = checkfieldValue(jsonBody.ownerName,accList[0].Owner_Name__c); 
                    accList[0].Owner_Phone__c = checkfieldValue(jsonBody.ownerPhone,accList[0].Owner_Phone__c ); 
                    accList[0].Store_Address__c = checkfieldValue(jsonBody.storeaddress,accList[0].Store_Address__c); 
                    accList[0].Store_Category__c = checkfieldValue(jsonBody.category,accList[0].Store_Category__c); 
                    accList[0].Store_Sub_Category__c = checkfieldValue(jsonBody.subCategory,accList[0].Store_Sub_Category__c); 
                    accList[0].Store_Landline_Number__c = checkfieldValue(jsonBody.storeLandLine,accList[0].Store_Landline_Number__c); 
                    accList[0].Store_Password__c = checkfieldValue(jsonBody.password,accList[0].Store_Password__c);
                    accList[0].Commission__c=jsonBody.commission;
                    accList[0].Website  = checkfieldValue(jsonBody.website,accList[0].Website);
                    accList[0].BillingCountry = checkfieldValue(jsonBody.billingCountry,accList[0].BillingCountry); 
                    accList[0].BillingCity = checkfieldValue(jsonBody.billingCity,accList[0].BillingCity);
                    accList[0].BillingState= checkfieldValue(jsonBody.billingState,accList[0].BillingState);
                    accList[0].BillingStreet = checkfieldValue(jsonBody.billingStreet,accList[0].BillingStreet);
                    accList[0].BillingPostalCode = checkfieldValue(jsonBody.billingPostalCode,accList[0].BillingPostalCode); 
                    accList[0].Description = checkfieldValue(jsonBody.description,accList[0].Description);
                    accList[0].Business_Zone_Name__c = checkfieldValue(jsonBody.businessZoneName,accList[0].Business_Zone_Name__c); 
                    accList[0].Company_Driver__c = checkfieldValue(jsonBody.companyDriver,accList[0].Company_Driver__c);           
                    accList[0].Food_Type__c= checkfieldValue(jsonBody.foodType,accList[0].Food_Type__c);
                    accList[0].Franchisee__c = checkfieldValue(jsonBody.franchisee,accList[0].Franchisee__c);
                    accList[0].Free_Delivery_Above__c = jsonBody.freeDeliveryAbove;
                    accList[0].Store_Type__c = checkfieldValue(jsonBody.storeType,accList[0].Store_Type__c);
                    accList[0].Store_Average_Rating__c=jsonBody.averageRating;
                    accList[0].Store_Driver__c = checkfieldValue(jsonBody.storeDriver,accList[0].Store_Driver__c);
               }
           }
            upsert accList;
            return 'Data has been Successfully Inserted or Updated' +accList[0].name +' jsonNameis'+jsonBody.Name;
             
             //Database.DMLOptions dml = new Database.DMLOptions(); 
             //dml.DuplicateRuleHeader.allowSave = true;
             //dml.DuplicateRuleHeader.runAsCurrentUser = true;
             //Account duplicateAccount = new Account(Name='dupe');
             //Database.SaveResult sr = Database.insert(a, dml); 
        }
        Catch(Exception e){
             System.debug('The following error has occurred :' + e.getMessage());
             return 'Data UPdated Error' +e.getMessage();
        }
        
    } 
    public class StoreJSON {
        public String mongoId {get;set;}
        public String parentMongoId {get;set;}
        public String appLogo {get;set;}
        public String Name {get;set;}
        public String averageDeliveryTime {get;set;} 
        public Double commission {get;set;}
        public String commissionType {get;set;}
        public String countryCode {get;set;}
        public Boolean status {get;set;}
        public String email {get;set;}
        public String ownerName {get;set;}
        public String ownerPhone {get;set;}
        public String password {get;set;} 
        public String storeaddress {get;set;}
        public String category {get;set;}
        public String subCategory {get;set;}
        public Double walletBalance {get;set;} 
        public Double walletBlock {get;set;}
        public Double walletHardLimit {get;set;}
        public Double walletSoftLimit {get;set;}
        public String storeLandLine {get;set;}
        public String webLogo {get;set;}
        public String billingCountry {get;set;}
        public String billingCity {get;set;}
        public String billingState {get;set;}
        public String billingStreet {get;set;} 
        public String billingPostalCode {get;set;} 
        public String storeDriver {get;set;}
        public String companyDriver {get;set;}
        public String franchisee {get;set;}
        public Double freeDeliveryAbove {get;set;}
        public String businessZoneName {get;set;}
        public String foodType {get;set;}
        public Double averageRating {get;set;}
        public String storeType {get;set;}
        public String recordType {get;set;}
        public String description {get;set;}
        public String website {get;set;} 
       
        
    } 
    public Static String checkNull(String str){
        if(!String.isBlank(str)){
         return str;
        }return '';
    } 
    public Static String checkfieldValue(String newVal ,String oldVal){
        if(oldVal !=newVal && (newVal != '')){
            System.debug('New Value is'+newVal);
            return newVal;
        }
        return oldVal;
    }
    
}