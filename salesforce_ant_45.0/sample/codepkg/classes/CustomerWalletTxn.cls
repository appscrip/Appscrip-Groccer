@RestResource(urlMapping='/WalletTxnContact/*')
global with sharing class CustomerWalletTxn {
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
       
        try {
             jsonBody  = (CustomerJSON) JSON.deserialize(request.requestBody.toString(),CustomerJSON.class);
             dt = Date.parse(jsonBody.txnDate);
             System.debug('The json is '+jsonBody);
             
           /*  if(jsonBody.storeMongoId != Null && jsonBody.customerMongoId ==Null){
                 acc =[select id,Unique_Mongo_Id__c,Name from Account where Unique_Mongo_Id__c=:jsonBody.storeMongoId];
                 walletTxn = new Wallet_Transactions__c();
                 walletTxn.name = checkNull(jsonBody.txnId);
                 //System.debug('The Name is' +jsonBody.txnId);
                 walletTxn.Amount__c=jsonBody.amount;
                 walletTxn.Cash_Collected__c= jsonBody.cashCollected;
                 //customerWalletTxn.City_Id__c = checkNull(jsonBody.cityId);
                 WalletTxn.City_Name__c = checkNull(jsonBody.cityName);
                 //customerWalletTxn.Comment__c = checkNull(jsonBody.comment);
                 walletTxn.Currency__c = checkNull(jsonBody.currencyType);
                 walletTxn.Store_Name__c = acc.Id;
                 walletTxn.Closing_Balance__c = jsonBody.closingBalance;    
                 walletTxn.Transaction_Date_and_Time__c=DateTime.parse(jsonBody.txnDateAndTime);
                 walletTxn.Opening_Balance__c= jsonBody.openingBalance;
                 walletTxn.Order_Id__c= jsonBody.orderId;
                 walletTxn.Payment_Type_Text__c = checkNull(jsonBody.paymentType);
                 //customerWalletTxn.Mongo_Id__c = jsonBody.mongoId;
                 walletTxn.Transaction_Type__c = checkNull(jsonBody.txnType);
             } */
             
              if(jsonBody != Null ) {
                 con =[select id,Mongo_Reference_Id__c,Name from Contact where Mongo_Reference_Id__c=:jsonBody.userMongoId];
                 System.debug('The con size is' + con.size());
                 walletTxn = new Wallet_Transactions__c();
                 walletTxn.name = checkNull(jsonBody.txnId);
                 
                 walletTxn.Amount__c=jsonBody.amount;
                 walletTxn.Cash_Collected__c= jsonBody.cashCollected;
                 //customerWalletTxn.City_Id__c = checkNull(jsonBody.cityId);
                 WalletTxn.City_Name__c = checkNull(jsonBody.cityName);
                 //customerWalletTxn.Comment__c = checkNull(jsonBody.comment);
                 walletTxn.Currency__c = checkNull(jsonBody.currencyType);
                 walletTxn.Customer_Name__c = con[0].Id;
                 walletTxn.Closing_Balance__c = jsonBody.closingBalance;    
                 walletTxn.Transaction_Date__c = dt;
                 walletTxn.Opening_Balance__c= jsonBody.openingBalance;
                 walletTxn.Order_Id__c= jsonBody.orderId;
                 walletTxn.Payment_Type__c = checkNull(jsonBody.paymentType);
                 //customerWalletTxn.Mongo_Id__c = jsonBody.mongoId;
                 walletTxn.Transaction_Type__c = checkNull(jsonBody.txnType);
             }  
             
             
             System.debug('The Json Is '+walletTxn);
             
          /*   Database.DMLOptions dml = new Database.DMLOptions(); 
             dml.DuplicateRuleHeader.allowSave = true;
             dml.DuplicateRuleHeader.runAsCurrentUser = true;
             //Account duplicateAccount = new Account(Name='dupe');
             Database.SaveResult sr = Database.insert(walletTxn, dml);   */ 
        }
        Catch(Exception e){
                System.debug('The following error has occurred :' + e.getMessage());
        }
        System.debug('The Json Is'+ walletTxn);
        insert walletTxn;
        if(walletTxn.id != NULL ){
            System.debug('The New store is created and name is '+ walletTxn.Name);
            return 'returnClientInfo finished.' + jsonBody.userMongoId+ ' ' + jsonBody.paymentType+ ' '+ jsonBody.txnId + 'request=' + request ;
        }
        return 'INVALID ID';
    } 
      
    public class CustomerJSON {
        //public String mongoId;
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
        public String userMongoId;
        //public String storeMongoId;
        
     } 
     
    public Static String checkNull(String str){
        if(!String.isBlank(str)){
         return str;
        }return '';
    }   
    
   
}