public class CustomerAuthorizedByOrder{

    List<Account>accList;
    Set<Id> conId;
    public List<Contact> conList{get;set;}
    List<Order> ordList;

    public CustomerAuthorizedByOrder(ApexPages.StandardController controller) {
        accList = new List<Account>();
        conList = new List<Contact>();
        ordList = new List<Order>();
        conId = new Set<Id>();
       
        accList = [Select id , name From Account Where id=: ApexPages.currentPage().getParameters().get('id')];
        //accList = [Select id , name From Account Where id='0016F000036TIAv'];
        ordList = [Select id , AccountId , CustomerAuthorizedById From Order Where AccountId IN : accList ];
        for(Order o : ordList){  
        
            conId.add(o.CustomerAuthorizedById);
        } 
        
        conList = [Select id , FirstName ,lastname , Email ,Phone ,Device_Name__c , Device_Id__c , User_Type__c ,Currently_Active__c , Customer_Status__c From Contact Where id IN:conId];
        System.debug('-----'+conList); 
   }
   
}