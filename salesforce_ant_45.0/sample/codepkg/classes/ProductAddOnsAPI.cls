@RestResource(urlMapping='/ProductAddoOns/*')
global with sharing class ProductAddOnsAPI {/*
public static RestRequest request = RestContext.request;
public static RestResponse response = RestContext.response;  
public static AddOnsJSON jsonBody; 
    
    @HttpPost
    global static String returnUnitsInfo() {
        response.addHeader('Content-Type','applicatin/json');
        Boolean s = false;
        Product2 p;
        Product_AddOns__c ad;
        try {
             jsonBody  =(AddOnsJSON)JSON.deserialize(request.requestBody.toString(),AddOnsJSON.class);
             p=[select id,Mongo_Id__c,Name from Product2 where Mongo_Id__c=:jsonBody.productMongoId];
             ad= new Product_AddOns__c();
             ad.Name = jsonBody.addOnsName;
             ad.AddOns_Mongo_Id__c=jsonBody.addOnsMongoId;
             ad.Price__c=jsonBody.price;
             ad.Product__c =checkNull(p.Id);
             
        }
        Catch(Exception e){
            System.debug('The following error has occurred :' + e.getMessage());
        }
        insert ad;
        if(ad.id != NULL ){
            System.debug('The New store is created and name is :='+ ad.Name);
            return 'returnClientInfo finished.' + jsonBody.addOnsName+ 'request=' + request ;
        }
        return 'INVALID ID';
    } 
    
    @HttpPatch
    global static String updateUnitsInformation() {
        response.addHeader('Content-Type','applicatin/json');
        Boolean s = false; 
        List<Product2> prol = new List<Product2>();
        Product_AddOns__c ad;
        try{
            jsonBody = (AddOnsJSON)JSON.deserialize(request.requestBody.toString(),AddOnsJSON.class);
            ad=[select id,AddOns_Mongo_Id__c,Name,Product__c,Price__c From Product_AddOns__c where AddOns_Mongo_Id__c=:jsonBody.addOnsMongoId];
            prol =[select id,Mongo_Id__c,Name from Product2 where Mongo_Id__c=:jsonBody.productMongoId];
            ad.Name = checkfieldValue(jsonBody.addOnsName,ad.Name);
            ad.AddOns_Mongo_Id__c = checkfieldValue(jsonBody.addOnsMongoId,ad.AddOns_Mongo_Id__c);
            ad.Price__c = jsonBody.price;
            ad.Product__c =prol[0].Id;
            
            update ad;
            return 'Data Updated:=' +ad.Name ;
        }
        Catch(Exception e){
            System.debug('The following error has occurred :' + e.getMessage());
            return 'Data UPdated Error' +e.getMessage();
        }
    }
     
    
    
    public class AddOnsJSON {
        public String addOnsMongoId;
        public Double price;
        public String productMongoId;    
        public String addOnsName;
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
    }*/
}