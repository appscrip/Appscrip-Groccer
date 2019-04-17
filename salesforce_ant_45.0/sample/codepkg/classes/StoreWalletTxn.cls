@RestResource(urlMapping='/WalletTxnStore/*')
global with sharing class StoreWalletTxn {

    public static RestRequest request = RestContext.request;
    public static RestResponse response = RestContext.response;  
    public static StoreJSON jsonBody; 
    public static Wallet_transaction_for_Store__c walletTxn; 

    @HttpPost
    global static String returnStoreWalletInfo() {
        response.addHeader('Content-Type','application/json');
        Account acc;
        Date dt;
       
        try {
             jsonBody  = (StoreJSON) JSON.deserialize(request.requestBody.toString(),StoreJSON.class);
             dt = Date.parse(jsonBody.txnDate);
             System.debug('The json is '+jsonBody);
             
             if(jsonBody != Null ){
                 acc =[select id,Unique_Mongo_Id__c,Name from Account where Unique_Mongo_Id__c=:jsonBody.userMongoId];
                 walletTxn = new Wallet_transaction_for_Store__c();
                 walletTxn.name = checkNull(jsonBody.txnId);
                 //System.debug('The Name is' +jsonBody.txnId);
                 walletTxn.Amount__c=jsonBody.amount;
                 walletTxn.Cash_Collected__c= jsonBody.cashCollected;
                 //customerWalletTxn.City_Id__c = checkNull(jsonBody.cityId);
                 WalletTxn.City_Name__c = checkNull(jsonBody.cityName);
                 //customerWalletTxn.Comment__c = checkNull(jsonBody.comment);
                 walletTxn.Currency_Type__c = checkNull(jsonBody.currencyType);
                 walletTxn.Store__c = checkNull(acc.Id);
                 walletTxn.Closing_Balance__c = jsonBody.closingBalance;    
                 walletTxn.Transaction_Date__c = dt;
                 walletTxn.Opening_Balance__c= jsonBody.openingBalance;
                 walletTxn.Order_Id__c= jsonBody.orderId;
                 walletTxn.Payment_Type__c = checkNull(jsonBody.paymentType);
                 walletTxn.Transaction_Type__c = checkNull(jsonBody.txnType);
             } 
             
             System.debug('The Json Is '+walletTxn);
           
           /*  Database.DMLOptions dml = new Database.DMLOptions(); 
             dml.DuplicateRuleHeader.allowSave = true;
             dml.DuplicateRuleHeader.runAsCurrentUser = true;
             //Account duplicateAccount = new Account(Name='dupe');
             Database.SaveResult sr = Database.insert(walletTxn, dml);    */
             
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
      
    public class StoreJSON {
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