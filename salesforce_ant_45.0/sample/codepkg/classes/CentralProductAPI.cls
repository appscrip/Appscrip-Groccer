@RestResource(urlMapping='/CentralProduct/*')
    global with sharing class CentralProductAPI {
    public static RestRequest request = RestContext.request;
    public static RestResponse response = RestContext.response;  
    public static CentralProductJSON jsonBody; 
    public static Central_Product__c p;
    
    @HttpPost
    global static String returnCentralProductInfo() {
        response.addHeader('Content-Type','applicatin/json');
        Boolean s = false;
      
        try {
             jsonBody  =(CentralProductJSON)JSON.deserialize(request.requestBody.toString(),CentralProductJSON.class);
             p=new Central_Product__c();
             System.debug('The Json is'+ jsonBody);
             p.Name = checkNull(jsonBody.productName);
             p.Product_Code__c=checkNull(jsonBody.productCode);
             p.Mongo_Id__c =jsonBody.mongoId;
             p.Product_Image__c=checkNull(jsonBody.picUrl);
             p.FirstCategory__c =checkNull(jsonBody.firstCategory);
             p.SecondCategory__c =checkNull(jsonBody.secondCategory);
             p.ThirdCategory__c =checkNull(jsonBody.thirdCategory);
             p.Bar_Code__c =checkNull(jsonBody.barCode);
             p.Brand_Name__c =checkNull(jsonBody.brandName);
             p.Manufacture_Name__c =checkNull(jsonBody.manufactureName);
             p.Product_SKU__c =checkNull(jsonBody.sku);
             p.Status__c = jsonBody.status;
             p.Product_Description__c = checkNull(jsonBody.description); 
             
        }
        Catch(Exception e){
                System.debug('The following error has occurred :' + e.getMessage());
        }
       System.debug('The Json is'+ p);

        insert p;
        if(p.id != NULL ){
            System.debug('The New store is created and name is '+ p.Name);
            return 'returnClientInfo finished.' + jsonBody.productName+ 'request=' + request ;
        }
        return 'INVALID ID';
    } 
    
    @HttpPatch
    global static String updateCentralProductInformation() {
        response.addHeader('Content-Type','applicatin/json');
        Boolean s = false; 

        try {
            jsonBody  = (CentralProductJSON)JSON.deserialize(request.requestBody.toString(),CentralProductJSON.class);
            System.debug('The jason Is' +jsonBody);
            p=[select Mongo_Id__c,Name,Bar_Code__c,Views__c,Added_To_Cart__c,Product_SKU__c,Manufacture_Name__c,Brand_Name__c,Product_Code__c,Product_Image__c,FirstCategory__c,SecondCategory__c,ThirdCategory__c,Product_Description__c,
            Status__c From Central_Product__c where Mongo_Id__c=:jsonBody.mongoId ];
            
            p.Name = checkfieldValue(jsonBody.productName,p.Name);
            p.Product_Code__c= checkfieldValue(jsonBody.productCode,p.Product_Code__c);
            p.Mongo_Id__c =jsonBody.mongoId;
            p.Product_Image__c=checkfieldValue(jsonBody.picUrl,p.Product_Image__c);
            p.FirstCategory__c =checkfieldValue(jsonBody.firstCategory,p.FirstCategory__c );
            p.SecondCategory__c =checkfieldValue(jsonBody.secondCategory,p.SecondCategory__c);
            p.ThirdCategory__c =checkfieldValue(jsonBody.thirdCategory,p.ThirdCategory__c);
            p.Bar_Code__c =checkfieldValue(jsonBody.barCode,p.Bar_Code__c);
            p.Brand_Name__c =checkfieldValue(jsonBody.brandName,p.Brand_Name__c);
            p.Manufacture_Name__c =checkfieldValue(jsonBody.manufactureName,p.Manufacture_Name__c);
            p.Product_SKU__c =checkfieldValue(jsonBody.sku,p.Product_SKU__c);
            p.Status__c =jsonBody.status; 
            p.Views__c=jsonBody.viewCount;
            //p.Favorites__c =jsonBody.favoriteCount;
            p.Added_To_Cart__c =jsonBody.addedToCartCount;
            p.Product_Description__c = checkfieldValue(jsonBody.description,p.Product_Description__c);
            
            update p;
            return 'Data UPdated' +p.Name ;
        }
        Catch(Exception e){
            System.debug('The following error has occurred :' + e.getMessage());
            return 'Data UPdated Error' +e.getMessage();
        }
     }
     
    
     
    public class CentralProductJSON {
        public String mongoId;
        public String picUrl;
        public String productName; 
        public Boolean status;   
        public String firstCategory;
        public String secondCategory;
        public String thirdCategory;
        public String productCode;
        public String barCode;
        public String brandName;
        public String manufactureName;
        public String sku;
        public Double viewCount;
        public Double favoriteCount; 
        public Double addedToCartCount; 
        public String description;
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