@RestResource(urlMapping='/upsertaccount')
global with sharing class WSCustomerEdit {
   
   @HttpPost
    global static Account doPost(){
        String accountJSON = RestContext.request.requestBody.toString();
        JsonAccount serializedAcc = (JsonAccount)(JSON.deserialize(accountJSON, JsonAccount.class));
    
        Account acc = [SELECT Id FROM Account WHERE id =: serializedAcc.Id];
        acc.Name = serializedAcc.name;
        acc.Phone = serializedAcc.phone;
        upsert acc;
        return acc;
        
    }

    global class JsonAccount{
        public String id      {get;set;}
        public String name    {get;set;}
        public String phone   {get;set;}
        public String address {get;set;}
    }
}