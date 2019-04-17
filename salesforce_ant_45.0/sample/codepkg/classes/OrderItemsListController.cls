public class OrderItemsListController {
    public Set<Id> addOnId;
    public List<Ordered_Items__c> orderedItemList{get;set;}
    public List<AddOn__c> addOnList{get;set;}
    public List<Ordered_Item_AddOn__c> orderItemAddOn;
    
    public OrderItemsListController(ApexPages.StandardController controller) {
        addOnId = new Set<Id>();
        orderedItemList = new List<Ordered_Items__c>();
        addOnList = new List<AddOn__c>();
        orderItemAddOn = new List<Ordered_Item_AddOn__c>();
        
        orderedItemList = [SELECT Name,Unit_Id__c,Unit_Name__c,Orders__c,Taxes__c,Offer_Id__c,Offered_Price__c,Item_Image__c,Item_Discount__c,AddOn_Price__c,Actual_Price__c FROM Ordered_Items__c 
                           WHERE Orders__c =: ApexPages.currentPage().getParameters().get('id') ORDER BY Unit_Id__c];
        
        orderItemAddOn = [Select id , AddOns__c , Ordered_Items__c From Ordered_Item_AddOn__c where Ordered_Items__c IN: orderedItemList];
        
        for(Ordered_Item_AddOn__c ordItemAddOn : orderItemAddOn){
            addOnId.add(ordItemAddOn.AddOns__c);   
        }
        
        addOnList = [SELECT Id , AddOn_Id__c , Name , Price__c FROM Addon__c WHERE id IN: addOnId ORDER BY AddOn_Id__c  ];
       
    }
  
}