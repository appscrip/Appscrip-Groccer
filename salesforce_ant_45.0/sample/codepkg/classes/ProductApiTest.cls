@isTest
public class ProductApiTest {
     public static product2 pr;
    @isTest public static void  productPostMethod(){
       
        ProductAPI.ProductJSON p = new ProductAPI.ProductJSON();
        p.mongoId='hgefg6t78377837u53n3';
        p.picUrl='http://rahul.jpg';
        p.productName='test1';
        p.status=true;
        p.firstCategory='A';
        p.secondCategory='B';
        p.thirdCategory='C';
        p.productCode='121';
        p.barCode='4535353';
        p.brandName='bn';
        p.manufactureName='mn';
        p.description='na';
        p.storeMongoId='653467365375gbc653645b';
        p.sku='12'; 
        p.viewCount=87678;
        p.favoriteCount=876786;
        p.addedToCartCount=876786;
        p.ingredients='nA';
        
        String instanceURL =URL.getSalesforceBaseUrl().toExternalForm();
        System.debug('The URL IS----'+instanceURL);
        
        String myJSON = JSON.serialize(p);
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();

        request.requestUri ='instanceURL/services/apexrest/Flexy_App/Pro';
        request.httpMethod = 'POST';
		request.requestBody = Blob.valueof(myJSON);
        
		RestContext.request = request;
        RestContext.response = res;
        pr = new Product2();
        
        pr.Name='test1';
        pr.Mongo_Id__c='hgefg6t78377837u53n3';
        pr.ProductCode='121';
        //pr.Store__c=a.id;
        pr.SKU__c='12';
        insert pr;
        String ac = ProductAPI.returnProductInfo();
        
    }

}