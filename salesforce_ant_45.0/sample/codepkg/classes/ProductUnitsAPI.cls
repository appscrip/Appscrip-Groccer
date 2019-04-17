@RestResource(urlMapping='/ProductUnits/*')
global with sharing class ProductUnitsAPI {
public static RestRequest request = RestContext.request;
public static RestResponse response = RestContext.response;  
public static UnitsJSON jsonBody; 
    
    @HttpPost
    global static String returnUnitsInfo() {
        response.addHeader('Content-Type','applicatin/json');
        Boolean s = false;
        Product2 p;
        Product_Unit__c u;
        try {
             jsonBody  =(UnitsJSON)JSON.deserialize(request.requestBody.toString(),UnitsJSON.class);
             p=[select id,Mongo_Id__c,Name from Product2 where Mongo_Id__c=:jsonBody.productMongoId];
             u= new Product_Unit__c();
             u.Name = checkNull(jsonBody.Name);
             u.Mongo_Id__c=jsonBody.unitMongoId;
             u.Price__c=jsonBody.price;
             u.Sizes__c =checkNull(jsonBody.size);
             u.Product__c =checkNull(p.Id);
             u.Status__c = jsonBody.status;
        }
        Catch(Exception e){
            System.debug('The following error has occurred :' + e.getMessage());
        }
        insert u;
        if(u.id != NULL ){
            System.debug('The New store is created and name is :='+ u.Name);
            return 'returnClientInfo finished.' + jsonBody.Name+ 'request=' + request ;
        }
        return 'INVALID ID';
    } 
    
    @HttpPatch
    global static String updateUnitsInformation() {
        response.addHeader('Content-Type','applicatin/json');
        Boolean s = false; 
        List<Product2> prol = new List<Product2>();
        Product_Unit__c u;
        try{
            jsonBody = (UnitsJSON)JSON.deserialize(request.requestBody.toString(),UnitsJSON.class);
            u=[select id,Mongo_Id__c,Name,Status__c,Product__c,Sizes__c,Price__c From Product_Unit__c where Mongo_Id__c=:jsonBody.unitMongoId];
            prol =[select id,Mongo_Id__c,Name from Product2 where Mongo_Id__c=:jsonBody.productMongoId];
            u.Name = checkfieldValue(jsonBody.Name,u.Name);
            u.Mongo_Id__c = checkfieldValue(jsonBody.unitMongoId,u.Mongo_Id__c);
            u.Price__c = jsonBody.price;
            u.Sizes__c = checkfieldValue(jsonBody.size,u.Sizes__c);
            u.Product__c =prol[0].Id;
            u.Status__c =jsonBody.status;
            update u;
            return 'Data Updated:=' +u.Name ;
        }
        Catch(Exception e){
            System.debug('The following error has occurred :' + e.getMessage());
            return 'Data UPdated Error' +e.getMessage();
        }
    }
     
    
    
    public class UnitsJSON {
        public String unitMongoId;
        public Double price;
        public String productMongoId; 
        public Boolean status;   
        public String size;
        public String Name;
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