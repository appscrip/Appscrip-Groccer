public class OrderListController {
    public List<Order> orderList{get;set;}

    public OrderListController(ApexPages.StandardController controller) {
        orderList = new List<Order>();
        orderList = [Select id,Name,OrderNumber,EffectiveDate,AccountID,CustomerAuthorizedByID,Total_Amount__c,Pickup_Area__c From Order where CustomerAuthorizedByID =: 
                     ApexPages.currentPage().getParameters().get('id') ORDER BY OrderNumber];

    }

}