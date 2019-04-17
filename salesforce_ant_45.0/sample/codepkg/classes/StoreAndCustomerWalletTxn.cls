@RestResource(urlMapping='/Store&CustomerWalletTxn/*')
global with sharing class StoreAndCustomerWalletTxn {
    public static RestRequest request = RestContext.request;
    public static RestResponse response = RestContext.response;  
    public static CustomerJSON jsonBody; 
    public static Wallet_Transactions__c walletTxn; 

    @HttpPost
    global static String returnCustomerWalletInfo() {
        response.addHeader('Content-Type','application/json');
        List<Contact> con= new List<contact>();
        Account acc;
        Date dt;
        //Id devRecordTypeId;
       
        try {
             jsonBody  = (CustomerJSON) JSON.deserialize(request.requestBody.toString(),CustomerJSON.class);
             dt = Date.parse(jsonBody.txnDate);
             System.debug('The json is '+jsonBody);
             System.debug('string is isBlank' +String.isBlank(jsonBody.storeMongoId));
             
             if(!String.isBlank(jsonBody.storeMongoId)){
             
                 System.debug('The json for Store wallet transaction is' +jsonBody.storeMongoId);
                 acc =[select id,Unique_Mongo_Id__c,Name from Account where Unique_Mongo_Id__c=:jsonBody.storeMongoId];
                 //devRecordTypeId = Schema.SObjectType.Wallet_Transactions__c.getRecordTypeInfosByName().get('Store').getRecordTypeId();
                 //walletTxn.Id = Schema.SObjectType.Wallet_Transactions__c.getRecordTypeInfosByName().get('Store').getRecordTypeId();
                 //System.debug('The json record type id is  '+ devRecordTypeId);
                 walletTxn = new Wallet_Transactions__c();
                 walletTxn.RecordTypeId = Schema.SObjectType.Wallet_Transactions__c.getRecordTypeInfosByName().get('Store').getRecordTypeId();
                 walletTxn.name = checkNull(jsonBody.txnId);  
                 walletTxn.Amount__c=jsonBody.amount;
                 walletTxn.Cash_Collected__c= jsonBody.cashCollected;
                 //customerWalletTxn.City_Id__c = checkNull(jsonBody.cityId);
                 walletTxn.City_Name__c = checkNull(jsonBody.cityName);
                 walletTxn.Comment__c = checkNull(jsonBody.comment);
                 walletTxn.Currency__c = checkNull(jsonBody.currencyType);
                 walletTxn.Store_Name__c = checkNull(acc.Id);
                 //walletTxn.Customer_Name__c = checkNull(jsonBody.customerMongoId);
                 walletTxn.Closing_Balance__c = jsonBody.closingBalance;    
                 walletTxn.Transaction_Date__c = dt;
                 walletTxn.Opening_Balance__c= jsonBody.openingBalance;
                 walletTxn.Order_Id__c= jsonBody.orderId;
                 walletTxn.Trigger__c = checkNull(jsonBody.triggerType);
                 walletTxn.Payment_Type__c = checkNull(jsonBody.paymentType);
                 walletTxn.Transaction_Type__c = checkNull(jsonBody.txnType);
                 
             } 
             
              else if(!String.isBlank(jsonBody.customerMongoId)) {
              
                 System.debug('The json for Customer wallet transaction is' +jsonBody);
                 con =[select id,Mongo_Reference_Id__c,Name from Contact where Mongo_Reference_Id__c=:jsonBody.customerMongoId];
                 System.debug('The con size is' + con.size());
                 walletTxn = new Wallet_Transactions__c();
                 walletTxn.RecordTypeId = Schema.SObjectType.Wallet_Transactions__c.getRecordTypeInfosByName().get('Customer').getRecordTypeId();
                 walletTxn.name = checkNull(jsonBody.txnId);
                 walletTxn.Amount__c=jsonBody.amount;
                 walletTxn.Cash_Collected__c= jsonBody.cashCollected;
                 //customerWalletTxn.City_Id__c = checkNull(jsonBody.cityId);
                 walletTxn.City_Name__c = checkNull(jsonBody.cityName);
                 walletTxn.Comment__c = checkNull(jsonBody.comment);
                 walletTxn.Currency__c = checkNull(jsonBody.currencyType);
                 walletTxn.Customer_Name__c = checkNull(con[0].Id);
                 //walletTxn.Store_Name__c = checkNull(jsonBody.storeMongoId);
                 walletTxn.Closing_Balance__c = jsonBody.closingBalance;
                 walletTxn.Transaction_Date__c = dt;
                 walletTxn.Opening_Balance__c= jsonBody.openingBalance;
                 walletTxn.Order_Id__c= jsonBody.orderId;
                 walletTxn.Payment_Type__c = checkNull(jsonBody.paymentType);
                 WalletTxn.Trigger__c = checkNull(jsonBody.triggerType);
                 walletTxn.Transaction_Type__c = checkNull(jsonBody.txnType);
             }    
              
             System.debug('The Json Is '+walletTxn);
             
         /*  Database.DMLOptions dml = new Database.DMLOptions(); 
             dml.DuplicateRuleHeader.allowSave = true;
             dml.DuplicateRuleHeader.runAsCurrentUser = true;
             //Account duplicateAccount = new Account(Name='dupe');
             Database.SaveResult sr = Database.insert(walletTxn, dml);  */
             
        }
        Catch(Exception e){
                System.debug('The following error has occurred :' + e.getMessage());
        }
        System.debug('The Json Is'+ walletTxn);
        insert walletTxn;
        if(walletTxn.id != NULL ){
            System.debug('The New store OR customer wallet transaction is created and name is '+ walletTxn.id);
            return 'returnClientInfo finished.' + jsonBody.storeMongoId+''+jsonBody.customerMongoId+ ' ' + jsonBody.paymentType+ ' '+ jsonBody.txnId + 'request=' + request ;
        }
        return 'INVALID ID';
    } 
      
    public class CustomerJSON {
        public String mongoId;
        public Double amount;
        public Double cashCollected;
        public String cityId; 
        public String cityName;
        public String comment;
        public String currencyType;
        public Double openingBalance;
        public String orderId;
        public String txnId;  
        public String txnType;
        public String serviceType;
        public Boolean test;
        public Double closingBalance;
        public String txnDate;
        public String triggerType;  
        public String paymentType;
        public String customerMongoId;
        public String storeMongoId;
        
     } 
     
    public Static String checkNull(String str){
        if(!String.isBlank(str)){
         return str;
        }return '';
    }  
     
    
   
}