@isTest
public class CustomerEditTest {

  @isTest
    static void teste(){
        
        Account acc1= new Account();
        acc1.Name ='Test';
        insert acc1;
        
        WSCustomerEdit.JsonAccount acc = new WSCustomerEdit.JsonAccount();
        acc.id      = acc1.id;
        acc.name    = 'NameTest';
        acc.phone   = '1198785496';
        acc.address = 'Rua x';
        String myJSON = JSON.serialize(acc);
        

        RestRequest request = new RestRequest();
        request.requestUri ='https://cs13.salesforce.com/services/apexrest/upsertaccount';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueof(myJSON);
        
        RestContext.request = request;
        Account accObj = WSCustomerEdit.doPost();
        
        
    }
}