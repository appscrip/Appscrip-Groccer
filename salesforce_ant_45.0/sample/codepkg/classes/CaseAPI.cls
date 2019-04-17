@RestResource(urlMapping='/Case/*')
global with sharing class CaseAPI {
   public Static RestRequest request = RestContext.request;
   public Static RestResponse response = RestContext.response;
   public Static FromJSON jsonBody;
   
    @HttpPost
    global static String returnCaseInfo() {   
        response.addHeader('Content-Type','application/json');
        Case cas;
        Set<Id> conId;
        //Account acc;
        List<Order> ordList = new List<Order>();
        Contact con;             
        
        try {
            jsonBody  = (FromJSON) JSON.deserialize(request.requestBody.toString(),FromJSON.class);
            System.debug('The json is'+jsonBody);
            if(jsonBody != NULL){  
                List<User> userList = [SELECT Id, Name, Profile.Name, UserRole.Name FROM User WHERE Profile.Name ='System Administrator' AND IsActive=true ];
                System.debug('============='+ userList);   
                //if(con != Null){
                    cas = new Case();
                    cas.Case_Mongo_Id__c = jsonBody.caseMongoId;     
                    //cas.AccountId = acc.id;
                   
                    if( jsonBody.orderId!= NULL && (!String.isBlank(jsonBody.orderId)) ){
                        //acc = [SELECT id,Unique_Mongo_Id__c,name FROM Account WHERE Unique_Mongo_Id__c =: jsonBody.storeId];
                        ordList = [SELECT id , Order_Id__c,CustomerAuthorizedById FROM Order WHERE Order_Id__c =: jsonBody.orderId];
                        System.debug('----------OrderList'+ordList);
                       // for(Order o : ordList){
                          //  conId.add(o.CustomerAuthorizedById);
                        //}
                        con = [Select id,Mongo_Reference_Id__c from Contact Where Id =:ordList[0].CustomerAuthorizedById];
                         System.debug('----------ContactList'+con);
                        if(con != Null)
                        cas.ContactId = con.Id;
                    }
                    else if( jsonBody.orderId== NULL || (String.isBlank(jsonBody.orderId)) )
                        cas.ContactId = NULL;                     
                     
                        
                    
                    cas.Subject= checkNull(jsonBody.subject);
                    cas.Priority = checkNull(jsonBody.priority);
                    cas.Origin = checkNull(jsonBody.origin);
                    cas.Description = checkNull(jsonBody.description);
                    cas.Status = checkNull(jsonBody.status);
                    cas.Reason = checkNull(jsonBody.caseReason);
                    cas.Type = checkNull(jsonBody.typeValue);
                    if(jsonBody.category == 'Order Manager'){
                        cas.OwnerId = userList[0].id;
                        cas.Category__c = checkNull(jsonBody.category);
                    }
                    else if(jsonBody.category == 'General Manager'){
                        cas.OwnerId = userList[1].id;
                        cas.Category__c = checkNull(jsonBody.category);
                    }
                      
                    Database.DMLOptions dml = new Database.DMLOptions(); 
                    dml.DuplicateRuleHeader.allowSave = true;
                    dml.DuplicateRuleHeader.runAsCurrentUser = true;
                    Database.SaveResult sr = Database.insert(cas,true);
                    if (sr.isSuccess()) {
                    //insert cas;
                    System.debug('Case has been successfully inserted in salesforce.');
                    } 
                //}
           /*     if(con == Null){    
                    response.statusCode = 204;
                    response.addHeader('Content-Type', 'text/plain');
                    response.responseBody  = Blob.valueOf('No Store found');
                    System.debug('Status Code is'+  response.statusCode );      
                    return 'Store Id or Contact Id is not found in salesforce and status code is'+response.statusCode;
                } */
            }
        }   
        Catch(Exception e){
            //System.debug('The following error has occurred :' + e.getMessage());
            response.statusCode = 204;
            response.addHeader('Content-Type', 'text/plain');
            response.responseBody  = Blob.valueOf('No Store found');
            System.debug('Status Code is'+  response.statusCode );      
            return 'Case is not created in salesforce and status code is'+response.statusCode;
       }
        System.debug('The Case '+ cas);
        if(cas.id != NULL ){ 
            System.debug('The New Case is created and id is '+cas.id );
            return 'returnCaseInfo finished.' + jsonBody.caseMongoId+ ' ' + jsonBody.orderId+ ' '+ jsonBody.category + 'request=' + request ;  
        }
        return 'INVALID ID';
    } 
    
    public class FromJSON {
        public String caseMongoId;
        public String orderId;
        //public String storeId;
        public String subject;
        public String category;
        public String description;      
        public String priority;
        public String origin; 
        public String status;
        public String typeValue;
        public String caseReason;
               
    }
    
    public Static String checkNull(String str){    
        if(!String.isBlank(str)){
            return str;
        }
        return '';
    }    
}