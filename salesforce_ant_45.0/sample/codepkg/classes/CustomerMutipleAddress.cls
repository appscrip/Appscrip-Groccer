@RestResource(urlMapping='/UserMultipleAddress/*')
global with sharing class CustomerMutipleAddress {
  
    public static RestRequest request = RestContext.request;
    public static RestResponse response = RestContext.response;  
    public static CustomerJSON jsonBody; 
    public static Addresses__c customerAddress;
    public static List<Contact> con;
    public static List<Addresses__c> userAddress;
     

    @HttpPost
    global static String returnCustomerAddressInfo() {
        response.addHeader('Content-Type','application/json');
        
        System.debug('---con----'+con);
        
        System.debug('---con----'+con);
        try {
             jsonBody  = (CustomerJSON) JSON.deserialize(request.requestBody.toString(),CustomerJSON.class);
             con = new List<Contact>();
             con =[select id,Mongo_Reference_Id__c,Name from Contact where Mongo_Reference_Id__c=:jsonBody.customerMongoId];
             System.debug('------'+con);
             System.debug('The json is '+jsonBody);
                 if(!con.isEmpty()){
                 customerAddress = new Addresses__c();
                 customerAddress.name = checkNull(jsonBody.city);
                 customerAddress.User__c = checkNull(con[0].id);
                 customerAddress.Mongo_Id__c = checkNull(jsonBody.mongoId);
                 customerAddress.State__c = checkNull(jsonBody.state);
                 customerAddress.Country__c = checkNull(jsonBody.country);
                 customerAddress.Landmark__c = checkNull(jsonBody.landmark);
                 customerAddress.Flat_No__c = checkNull(jsonBody.flatNo);
                 customerAddress.Pin_Code__c = checkNull(jsonBody.pincode);
                 customerAddress.State__c = checkNull(jsonBody.state);
                 customerAddress.Address_Type__c = checkNull(jsonBody.addressType);
                 customerAddress.Address_Line_1__c = checkNull(jsonBody.addressLine1);
                 customerAddress.Address_Line_2__c = checkNull(jsonBody.addressLine2);
                 System.debug('The Json Is '+customerAddress);
             
                 Database.DMLOptions dml = new Database.DMLOptions(); 
                 dml.DuplicateRuleHeader.allowSave = true;
                 dml.DuplicateRuleHeader.runAsCurrentUser = true;
                 //Account duplicateAccount = new Account(Name='dupe');
                 Database.SaveResult sr = Database.insert(customerAddress, dml);
                 if (sr.isSuccess()) {
                        System.debug('Contact Addresses has been inserted in Salesforce!');
                 }
                 if(customerAddress.id != NULL ){     
                     System.debug('The New store is created and name is '+ customerAddress.Name);
                     response.addHeader('Content-Type', 'application/json');
                     response.responseBody = Blob.valueOf(JSON.serialize(con));
                     return response+'Successfully inserted.'+ jsonBody.customerMongoId+ ' ' + jsonBody.mongoId+ ' '+ jsonBody.city; 
                 }
                }
            if(con.isEmpty()) {
                response.statusCode = 204;
                System.debug('Status Code is '+ response.statusCode);
                response.addHeader('Content-Type', 'text/plain');
                response.responseBody  = Blob.valueOf('Not contact found');
                System.debug('Customer Mongo Id is not found in salesforce.');
                return 'Customer Mongo Id is not found.';
            } 
            return 'returnClientInfo finished.' + jsonBody.customerMongoId+ ' ' + jsonBody.mongoId+ ' '+ jsonBody.city; 
        }
        
         
      
        Catch(Exception e){
                System.debug('The following error has occurred :' + e.getMessage());
                response.responseBody = Blob.valueOf(e.getMessage());
                response.statusCode = 240;
                System.debug('Customer Mongo Id is not found in salesforce and Status Code is '+ response.statusCode);
                //throw e;
                return 'INVALID ID';           
        }
    } 
    
    @HttpPatch 
    global static String updateCustomerAddress(){
        response.addHeader('Content-Type','application/json');
        
        
        try{
            jsonBody = (CustomerJSON) JSON.deserialize(request.requestBody.toString() ,CustomerJSON.class);
            //con = new List<Contact>();
            System.debug('---The Json Is ----'+jsonBody);
            userAddress = new List<Addresses__c>();
            //con =[select id,Mongo_Reference_Id__c,Name from Contact where Mongo_Reference_Id__c=:jsonBody.customerMongoId];
            userAddress = [Select id , name , User__c , Mongo_Id__c , State__c , Country__c , Landmark__c , Flat_No__c , Pin_Code__c , Address_Type__c , 
                           Address_Line_1__c , Address_Line_2__c  From Addresses__c where Mongo_Id__c =:jsonBody.mongoId ];
             System.debug('---The userAddress Is ----'+userAddress);
            if(!userAddress.isEmpty()){
                userAddress[0].Name = checkFieldValue(jsonBody.city , userAddress[0].name);
                userAddress[0].State__c = checkFieldValue(jsonBody.state , userAddress[0].State__c);
                userAddress[0].Pin_Code__c = checkFieldValue(jsonBody.pinCode , userAddress[0].Pin_Code__c);
                userAddress[0].Landmark__c = checkFieldValue(jsonBody.landmark , userAddress[0].Landmark__c);
                userAddress[0].Flat_No__c = checkFieldValue(jsonBody.flatNo , userAddress[0].Flat_No__c);
                userAddress[0].Country__c = checkFieldValue(jsonBody.country , userAddress[0].Country__c);
                userAddress[0].Address_Type__c = checkFieldValue(jsonBody.addressType , userAddress[0].Address_Type__c);
                userAddress[0].Address_Line_1__c = checkFieldValue(jsonBody.addressLine1 , userAddress[0].Address_Line_1__c);
                userAddress[0].Address_Line_2__c = checkFieldValue(jsonBody.addressLine2 , userAddress[0].Address_Line_2__c);
                
                update userAddress;
                response.addHeader('Content-Type', 'application/json');
                response.responseBody = Blob.valueOf(JSON.serialize(userAddress));
                return response+'Successfully inserted.'+ jsonBody.customerMongoId+ ' ' + jsonBody.mongoId+ ' '+ jsonBody.city; 
            }
            
            if(userAddress.isEmpty()) {
                response.statusCode = 204;
                response.addHeader('Content-Type', 'text/plain');
                response.responseBody  = Blob.valueOf('Not Address found');
                System.debug('Customer Address is not found in salesforce and Status Code is '+ response.statusCode);
                return 'Customer Address is not found';
            }     
            
         return 'Successfully Address has been updated.'+ jsonBody.MongoId;
        }
        catch(Exception et){
             response.responseBody = Blob.valueOf(et.getMessage());
             response.statusCode = 204;
             System.debug('Customer Address is not found in salesforce and Status Code is '+ response.statusCode);
             return 'INVALID ID';           
        }
    }
      
    public class CustomerJSON {
        public String mongoId;
        public String city;
        public String state;
        public String pincode;
        public String landmark;
        public String flatNo;  
        public String country;
        public String addressType;
        public String addressLine1;
        public String addressLine2;
        public String customerMongoId;
        
     } 
     
    public Static String checkNull(String str){
        if(!String.isBlank(str)){
         return str;
        }
        return '';
    }
    
    public Static String checkFieldValue(String newValue , String oldvalue) {   
        if(newValue != oldValue && (newValue !='')){
            return newValue;
        }
        return oldValue;
    
    
    }  
    
   
}