@RestResource(urlMapping='/Pro/*')
    global with sharing class ProductAPI {
    public static RestRequest request = RestContext.request;
    public static RestResponse response = RestContext.response;  
    public static ProductJSON jsonBody; 
    public static Product2 p;
    public static Product_AddOns__c adOns;
    public static Product_Unit__c u;
    Public static Product_Unit__c un;
    public static List<ProductAddOns> pa = new List<ProductAddOns>();
    public static List<Product_AddOns__c> addOnslst = new List<Product_AddOns__c>();
    public static List<ProductUnits> pul = new List<ProductUnits>();
    public static List<Product_Unit__c > unitlist = new List<Product_Unit__c>();
    public static List<Product_Unit__c > unitlist1 = new List<Product_Unit__c>();
    public static Map<String , Product_Unit__c> unitMap = new Map<String , Product_Unit__c>();

    @HttpPost
    global static String returnProductInfo() {
        response.addHeader('Content-Type','applicatin/json');
        Boolean s = false;
        Account a;
        System.debug('---'+request);
        System.debug('---'+request.requestBody);
        System.debug('----'+request.requestBody.toString());
        try {
            jsonBody  =(ProductJSON)JSON.deserialize(request.requestBody.toString(),ProductJSON.class);
            system.debug('The Json is'+ jsonBody);
             //a=[select id,Unique_Mongo_Id__c,Name from Account where Unique_Mongo_Id__c=:jsonBody.storeMongoId];
             system.debug('the account is'+a);
            //if(a!=Null){
             p=new Product2();
             System.debug('The Json is'+ jsonBody);
             p.Name = checkNull(jsonBody.productName);
             p.ProductCode=checkNull(jsonBody.productCode);
             p.Mongo_Id__c =jsonBody.mongoId;
             p.Product_Image__c=checkNull(jsonBody.picUrl);
             p.FirstCategory__c =checkNull(jsonBody.firstCategory);
             p.SecondCategory__c =checkNull(jsonBody.secondCategory);
             p.ThirdCategory__c =checkNull(jsonBody.thirdCategory);
             p.Bar_Code__c =checkNull(jsonBody.barCode);
             p.Brand_Name__c =checkNull(jsonBody.brandName);
             p.Manufacture_Name__c =checkNull(jsonBody.manufactureName);
             p.Ingredients__c = checkNull(jsonBody.ingredients);
             p.Store__c =checkNull(a.Id);
             p.IsActive = jsonBody.status;
             p.Product_Type__c='Own';
             p.Description = checkNull(jsonBody.description);
             p.SKU__c= checkNull(jsonBody.sku);
             //Database.insert(p,true);
             insert p;
             System.debug('The Product is'+ p);
             
             pul =(List<ProductUnits>)jsonBody.un;
             if(pul != Null){
                 System.debug('The UNIT Json is============' +pul);
                 for(Integer i=0;i<pul.size();i++ ){
                     u = new Product_Unit__c();
                     u.Name = pul.get(i).Name;
                     System.debug('============='+pul.get(i).Name);
                     u.Mongo_Id__c = pul.get(i).unitMongoId;
                     u.Product__c = p.id;
                     u.Price__c = pul.get(i).price;
                     u.Status__c = pul.get(i).status;
                    // u.Sizes__c=pul.get(i).size;
                     unitlist.add(u);
                 }
              }
               if(!unitlist.isEmpty()){
                    insert unitlist;
                }   
             pa =(List<ProductAddOns>)jsonBody.ad;
             if(pa != Null){
                System.debug('The Addons Json is============' +pa);
                 for(Integer i=0;i<pa.size();i++ ){
                     adOns = new Product_AddOns__c();
                     adOns.Name = pa.get(i).addOnsName;
                     System.debug('============='+pa.get(i).addOnsName);
                     adOns.Product__c = p.id;
                     adOns.AddOns_Mongo_Id__c = pa.get(i).addOnsMongoId;
                     adOns.Price__c = pa.get(i).price;
                     adOns.Store_AddOns_Id__c = pa.get(i).storeAddOnsId;
                     addOnslst.add(adOns);
                 }
             }
             System.debug('The AddOn List size is====='+addOnslst.size());
             if(!addOnslst.isEmpty()){
                    insert addOnslst;
              }  
           //}
            /*if(a==Null) {
                response.statusCode = 204;
                response.addHeader('Content-Type', 'text/plain');
                response.responseBody  = Blob.valueOf('No Store found');
                 System.debug('Store not found:' + response.responseBody + 'and Status Code is'+  response.statusCode );      
                return 'Store Not Found In Salesforce';
            }*/
          } 
          Catch(Exception e){
            System.debug('The following error has occurred :' + e.getMessage());
            //response.responseBody = Blob.valueOf('Store is not found');
            //response.statusCode = 204;
            //System.debug('Status Code is'+  response.statusCode );      
            //return 'This Store Is Not Available In Salesforce'+ response.statusCode;
             
        }
        System.debug('The Product is'+ p);
        if(p.id != NULL ){
            System.debug('The New store is created and name is '+ p.Name);
           return 'returnClientInfo finished.' + jsonBody.productName+ 'request=' + request ;
           }
        return 'INVALID ID';
    } 
    
   /* @HttpPut   
    global static String updateProductInformation() {
        response.addHeader('Content-Type','applicatin/json');
        Boolean s = false; 
        Product_Unit__c productUnitt;     
        List<Account> storeList = new List<Account>();
        Product2 p;
        List<Product2> productList = new List<Product2>();
        List<Product_Unit__c>productUnits = new List<Product_Unit__c>();
        List<Product_AddOns__c>addOnsLists = new List<Product_AddOns__c>();
        Map<String,Product_Unit__c> productUnitMap = new Map<String,Product_Unit__c>();
        Map<String,Product_AddOns__c> addOnMap = new Map<String,Product_AddOns__c>();
        System.debug('---'+request);
        System.debug('---'+request.requestBody);
        System.debug('----'+request.requestBody.toString());
        try {
            jsonBody = (ProductJSON)JSON.deserialize(request.requestBody.toString(),ProductJSON.class);
            System.debug('The jason Is' +jsonBody);
            p=[select Mongo_Id__c,Name,Bar_Code__c,Views__c,Favorites__c,Added_To_Cart__c,SKU__c,Description,Manufacture_Name__c,
            Store__c,Brand_Name__c,ProductCode,Product_Image__c,FirstCategory__c,SecondCategory__c,ThirdCategory__c,Ingredients__c,
            IsActive From Product2 where Mongo_Id__c=:jsonBody.mongoId ];
            System.debug('Product List'+ p);
            storeList=[select id,Unique_Mongo_Id__c,Name from Account where Unique_Mongo_Id__c=:jsonBody.storeMongoId];
            System.debug('Store List'+ storeList);
            if(p!=NULL && !storeList.isEmpty()){
                p.Name = checkfieldValue(jsonBody.productName,p.Name);   
                p.ProductCode= checkfieldValue(jsonBody.productCode,p.ProductCode);    
                p.Mongo_Id__c =jsonBody.mongoId;
                p.Product_Image__c=checkfieldValue(jsonBody.picUrl,p.Product_Image__c);
                p.FirstCategory__c =checkfieldValue(jsonBody.firstCategory,p.FirstCategory__c );
                p.SecondCategory__c =checkfieldValue(jsonBody.secondCategory,p.SecondCategory__c);
                p.ThirdCategory__c =checkfieldValue(jsonBody.thirdCategory,p.ThirdCategory__c);
                p.Bar_Code__c =checkfieldValue(jsonBody.barCode,p.Bar_Code__c);
                p.Brand_Name__c =checkfieldValue(jsonBody.brandName,p.Brand_Name__c);
                p.Manufacture_Name__c =checkfieldValue(jsonBody.manufactureName,p.Manufacture_Name__c);
                p.Ingredients__c = checkfieldValue(jsonBody.ingredients,p.Ingredients__c);
                p.IsActive =jsonBody.status; 
                p.Mongo_Id__c =jsonBody.mongoId;
                p.Views__c=jsonBody.viewCount;
                p.Favorites__c =jsonBody.favoriteCount;
                p.Added_To_Cart__c =jsonBody.addedToCartCount;
                p.Store__c=storeList[0].Id;
                p.Product_Type__c='Own';
                p.Description = checkfieldValue(jsonBody.description,p.Description);
                p.SKU__c= checkfieldValue(jsonBody.sku,p.SKU__c); 
             
                pul =(List<ProductUnits>)jsonBody.un;        
                pa = (List<ProductAddOns>)jsonBody.ad;   
                productUnits = [Select id ,Name, Mongo_Id__c ,Price__c,Product__c,Sizes__c,Status__c From Product_Unit__c];
                addOnsLists = [Select id ,Name, AddOns_Mongo_Id__c ,Price__c,Product__c,Store_AddOns_Id__c From Product_AddOns__c];
                for(Product_Unit__c proUnit : productUnits){
                    productUnitMap.put(proUnit.Mongo_Id__c,proUnit);        
                } 
                for(Product_AddOns__c proAddOn : addOnsLists){
                    addOnMap.put(proAddOn.AddOns_Mongo_Id__c,proAddOn);          
                }       
                if(!pul.isEmpty()){
                    System.debug('The UNIT Json is============' +pul);
                    for(Integer i=0;i<pul.size();i++ ){
                         if(productUnitMap.containsKey(pul.get(i).unitMongoId)){ 
                             productUnitt = productUnitMap.get(pul.get(i).unitMongoId);
                             productUnitt.Name = pul.get(i).Name;
                             productUnitt.Product__c = p.id;     
                             System.debug('============='+pul.get(i).Name);
                             //productUnitt.Mongo_Id__c = pul.get(i).unitMongoId;
                             productUnitt.Price__c = pul.get(i).price;
                             productUnitt.Status__c = pul.get(i).status;
                             unitlist.add(productUnitt);    
                           }
                           else{
                               u = new Product_Unit__c();
                               u.Name = pul.get(i).Name;
                               u.Product__c = p.id;
                               System.debug('============='+pul.get(i).Name);
                               u.Mongo_Id__c = pul.get(i).unitMongoId;
                               u.Price__c = pul.get(i).price;
                               u.Status__c = pul.get(i).status;
                               unitlist.add(u);
                           }
                    }
                    if(!unitlist.isEmpty()){       
                        upsert unitlist;         
                    }
               }
               if(!pa.isEmpty()) {
                    System.debug('The AddONs Json is============' +pa);
                    for(Integer i=0;i<pa.size();i++ ){
                        if(addOnMap.containsKey(pa.get(i).addOnsMongoId)){
                             adOns = addOnMap.get(pa.get(i).addOnsMongoId); 
                             adOns.Name = pa.get(i).addOnsName;
                             System.debug('============='+pa.get(i).addOnsName);
                             adOns.AddOns_Mongo_Id__c = pa.get(i).addOnsMongoId;
                             adOns.Price__c = pa.get(i).price;
                             adOns.Product__c = p.id;
                             adOns.Store_AddOns_Id__c = pa.get(i).storeAddOnsId;
                             addOnslst.add(adOns);
                          }
                          else{
                              adOns = new Product_AddOns__c();
                              adOns.Name = pa.get(i).addOnsName;
                              System.debug('============='+pa.get(i).addOnsName);
                              adOns.AddOns_Mongo_Id__c = pa.get(i).addOnsMongoId;
                              adOns.Price__c = pa.get(i).price;
                              adOns.Product__c = p.id;
                              adOns.Store_AddOns_Id__c = pa.get(i).storeAddOnsId;
                              addOnslst.add(adOns);
                          }
                     }
                     if(!addOnslst.isEmpty()){
                        upsert addOnslst;
                     } 
               }   
               update p;
               response.addHeader('Content-Type', 'application/json');
               response.responseBody = Blob.valueOf(JSON.serialize(productList));
               return response+'Successfully Inserted In Salesforce.'+ jsonBody.productCode+ ' ' + jsonBody.productName+ ' '+ jsonBody.mongoId;
            }
            if(p==Null || storeList.isEmpty() ) {
                response.responseBody = Blob.valueOf('Store is not found');
                response.statusCode = 204;
                System.debug('Status Code is'+  response.statusCode );      
                return 'Product Not Found In Salesforce'+ response.statusCode;
            } 
        }    
        Catch(Exception e){
            response.responseBody = Blob.valueOf('Store is not found');
            response.statusCode = 204;
            System.debug('Status Code is'+  response.statusCode );           
            return 'Product Not Found In Salesforce'+ response.statusCode;   
        }     
       return 'INVALID ID';
     }   */
    /* @HttpPut
     global static String deleteProductInformation() {
        response.addHeader('Content-Type','applicatin/json');
        List<Product2> prl=new List<Product2>();
        try {
            jsonBody  = (ProductJSON)JSON.deserialize(request.requestBody.toString(),ProductJSON.class);
            prl=[select id,Mongo_Id__c,ProductCode From Product2 where Mongo_Id__c=:jsonBody.mongoId ];
            delete prl;
        }
        Catch(Exception e){
             System.debug('The following error has occurred :' + e.getMessage());
        }
        return 'Data Deleted Successfuly' +prl[0].Mongo_Id__c +' jsonNameis'+jsonBody.mongoId;
    }*/
     
    public class ProductJSON {
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
        public String description;
        public String storeMongoId;
        public String sku;
        public Double viewCount;
        public Double favoriteCount; 
        public Double addedToCartCount; 
        public String ingredients;
        public List<ProductAddOns> ad;
        public List<ProductUnits> un;
    } 
    
    public class ProductAddOns{
        public String addOnsName;
        public String addOnsMongoId;
        public Double price;
        public String storeAddOnsId;    
    }
    
    public class ProductUnits{
        public String unitMongoId;
        public Double price;
        public Boolean status;   
        public String Name;
        public string ProductMongoId;
        public string size;
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
    public static Integer checkCurrencyFieldValue(Integer newValue , Integer oldValue){
        if(newValue != oldValue && (String.valueOf(newValue) != '')){
            return newValue;
        }
        return oldValue;    
    }
    public static Integer checkNullCurrencyFieldValue(Integer intValue){
      if(String.isBlank(String.valueOf(intValue)) || intValue == Null){  
            return 0;
        }
        return intValue;             
    }                 
}