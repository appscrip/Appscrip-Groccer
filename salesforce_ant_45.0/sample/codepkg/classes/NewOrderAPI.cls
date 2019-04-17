@RestResource(urlMapping='/NewOrder/*')
global with sharing class NewOrderAPI {
   public Static RestRequest request = RestContext.request;
   public Static RestResponse response = RestContext.response;
   public Static FromJSON jsonBody;
        
    @HttpPost
    global static String returnOrderInfo() {   
        response.addHeader('Content-Type','application/json');
        Account a;     
        Contact c;
        Order ord;
        AddOn__c adOn;
        Ordered_Items__c orderItem;
        List<OrderedItem> s = new List<OrderedItem>();
        List<AddOns> s1 = new List<AddOns>();
        List<AddOn__c> addOnsList = new List<AddOn__c>();
        List<Ordered_Items__c> orderdList = new List<Ordered_Items__c>();
        List<Ordered_Items__c> ordItemList = new List<Ordered_Items__c>();
        List<Ordered_Item_AddOn__c> orderItemAndAddOnList = new List<Ordered_Item_AddOn__c>();
        Map<String,AddOn__c> addOnsMap = new Map<String,AddOn__c>();
        Map<String,Ordered_Items__c> existOrdItemMap = new Map<String,Ordered_Items__c>();
       
        System.debug('---'+request);
        System.debug('---'+request.requestBody);
        System.debug('----'+request.requestBody.toString());
       
        try {       
            
            jsonBody  = (FromJSON)JSON.deserialize(request.requestBody.toString(),FromJSON.class);
            System.debug('The json is out'+ jsonBody);
            if(jsonBody != NULL){
                System.debug('The json is in'+ jsonBody);
                a = [Select id,Unique_Mongo_Id__c,name from Account where Unique_Mongo_Id__c =: jsonBody.storeId];
                c = [Select id , Mongo_Reference_Id__c From Contact Where Mongo_Reference_Id__c  =: jsonBody.customerId];
                Date dt = Date.Parse(jsonBody.effectiveDate);
                ord = new Order();
                System.debug('the order id is '+ jsonBody.orderId);
                ord.Order_Id__c = jsonBody.orderId;
                ord.Store_Id__c = jsonBody.storeId;
                ord.AccountId = a.id;
                ord.CustomerAuthorizedById = c.Id;
                ord.EffectiveDate = dt;
                ord.Status = checkNull(jsonBody.status);
                ord.Cart_Total__c = checkIntValue(jsonBody.cartTotal); 
                ord.Cart_Discount__c = checkIntValue(jsonBody.cartDiscount);
                ord.Store_App_Commission__c = checkIntValue(jsonBody.storeAppCommission);
                ord.Store_Commission_Type__c = checkNull(jsonBody.storeCommissionType);
                ord.Store_Driver_Type__c = checkNull(jsonBody.storeDriverType);
                ord.Sub_Total__c = checkIntValue(jsonBody.subTotal);
                ord.Delivery_Charge__c = checkIntValue(jsonBody.deliveryCharge);
                ord.Store_Free_Delivery__c = jsonBody.storeFreeDelivery;    //<---------Boolean Type
                ord.Sub_Total_Without_Tax__c = checkIntValue(jsonBody.subTotalWithOutTax);
                ord.Tax_Amount__c = checkIntValue(jsonBody.taxAmount);
                ord.Applied_Taxes__c = checkNull(jsonBody.appliedTax);   
                ord.Order_Type_Message__c = checkNull(jsonBody.orderTypeMessage);
                ord.Promocode_Discount__c = checkIntValue(jsonBody.promoCodeDiscount);
                ord.Total_Amount__c = checkIntValue(jsonBody.totalAmount);
                ord.Coupon_Code__c = checkNull(jsonBody.couponCode);
                ord.Payment_Type__c = checkNull(jsonBody.paymentType);
                ord.Paid_By_Wallet__c = jsonBody.paidByWallet;          //<-------Boolean Type
                ord.Booking_Date_Time__c = DateTime.valueOf(jsonBody.bookingDateNTime); //<=======Date and Time Type
                ord.Due_Date_Time__c = DateTime.valueOf(jsonBody.dueDateNTime);    //<=======Date and Time Value
                ord.City__c = checkNull(jsonBody.city);
                ord.Booking_Status_Message__c = checkNull(jsonBody.bookingStatusMessage);
                ord.Booking_Type__c = checkNull(jsonBody.bookingType);
                ord.Booking_Note__c = checkNull(jsonBody.bookingNote);
                ord.Store_Dispatcher__c= checkNull(jsonBody.storeDispatcher);
                ord.Pickup_Place_Name__c = checkNull(jsonBody.pickUpPlaceName);
                ord.Pickup_Address__c = checkNull(jsonBody.pickUpAddress);
                ord.Pickup_City__c = checkNull(jsonBody.pickUpCity);
                ord.Pickup_Area__c = checkNull(jsonBody.pickUpArea);
                ord.Pickup_Postal_Code__c = checkNull(jsonBody.pickUpPostalCode);
                ord.Pickup_Country__c = checkNull(jsonBody.pickUpCountry);
                ord.Drop_Place_Name__c = checkNull(jsonBody.dropPlaceName);
                ord.Drop_Address__c = checkNull(jsonBody.dropAddress);
                ord.Drop_City__c = checkNull(jsonBody.dropCity);
                ord.Drop_Area__c = checkNull(jsonBody.dropArea);
                ord.Drop_Postal_Code__c = checkNull(jsonBody.dropPostalCode);
                ord.Drop_Country__c = checkNull(jsonBody.dropCountry);
                ord.Driver_Account_Message__c = checkNull(jsonBody.driverAccountMessage);
                ord.Taxes__c = checkIntValue(jsonBody.taxes);
                ord.Store_Commission_Percentage__c = checkIntValue(jsonBody.storeCommissionPercentage);
                ord.Store_Commission_Message__c = checkNull(jsonBody.storeCommissionMessage);
                ord.Driver_Commission_Percentage__c = checkIntValue(jsonBody.driverCommissionPercentage);
                ord.Driver_Commission_Message__c = checkNull(jsonBody.driverCommissionMessage);
                ord.App_Earning_Value__c = checkIntValue(jsonBody.appEarningValue);
                ord.Driver_Earning_Value__c = checkIntValue(jsonBody.driverEarningValue);
                ord.Driver_Commission_to_App_Value__c = checkIntValue(jsonBody.driverCommissionToAppValue);
                ord.Store_Earning_Value__c = checkIntValue(jsonBody.storeEarningValue);
                ord.Store_Commission_to_App_Value__c = checkIntValue(jsonBody.storeCommissionToAppValue);
                ord.PG_Commission_Name__c = checkNull(jsonBody.pgCommissionName);
                ord.Driver_Tip__c = checkIntValue(jsonBody.driverTip);
                ord.Driver_Total_Earning__c = checkIntValue(jsonBody.driverTotalEarning);
                ord.Store_Commission_Value__c = checkIntValue(jsonBody.storeCommissionValue);
                ord.Cart_Commission_Value__c = checkIntValue(jsonBody.cartCommissionValue);
                ord.Driver_Commission_Value__c = checkIntValue(jsonBody.DriverCommissionValue);
                ord.App_Discount_Value__c = checkIntValue(jsonBody.appDiscountValue);
                ord.Store_Discount_Value__c = checkIntValue(jsonBody.storeDiscountValue);
                ord.Store_Delivery_Fee__c = checkIntValue(jsonBody.storeDeliveryFee);
                ord.PG_Earning_Value__c = checkIntValue(jsonBody.pgEarningValue);
                
                insert ord;    
                
        // --------------------------------------------------- For Ordered Items & AddOn Object -------------------------------------------------------------        
                               
                s =(List<OrderedItem>)jsonBody.orderItems;
                
                ordItemList = [Select id , Name , Unit_Id__c , Unit_Name__c , Taxes__c , Offer_Id__c , Orders__c , Offered_Price__c ,
                              Item_Image__c, Item_Discount__c , AddOn_Price__c , Actual_Price__c From Ordered_Items__c];
                addOnsList = [Select id ,AddOn_Id__c ,  Name , Price__c From AddOn__c];
                
                for(Ordered_Items__c ordItem : ordItemList){
                    existOrdItemMap.put(ordItem.Unit_Id__c , ordItem);    
                }
                for(AddOn__c adOns : addOnsList){
                    addOnsMap.put(adOns.AddOn_Id__c , adOns);   
                }
                 
                System.debug('Order Item Json is'+ s);
              
                if(s != NULL){
                     System.debug('---'+s);   
                    for(Integer i=0;i<s.size();i++){          
           
                        if(existOrdItemMap.containsKey(s.get(i).unitId)){        
                            s1 = s.get(i).addOns;
                            orderItem =existOrdItemMap.get(s.get(i).unitId);
                            orderItem.Orders__c = ord.id;
                            System.debug('AddOns Json is'+ s1);
                            
                            if(s != NULL){
                                for(Integer j=0;j<s1.size();j++){
                                    if(addOnsMap.containsKey(s1.get(j).addOnId)){
                                        adOn = addOnsMap.get(s1.get(j).addOnId);
                                        Ordered_Item_AddOn__c ordItemAddOn = new Ordered_Item_AddOn__c();
                                        ordItemAddOn.Ordered_Items__c = orderItem.id;
                                        ordItemAddOn.AddOns__c = adOn.id;
                                        orderItemAndAddOnList.add(ordItemAddOn);
                                        System.debug('---'+orderItemAndAddOnList);   
                                    }
                                }
                            }
                            orderdList.add(orderItem);           
                        }           
                     }
                        update orderdList;    	
               }
                if(!orderItemAndAddOnList.isEmpty()){
                	insert orderItemAndAddOnList;
                }           
            }     
        }
        Catch(Exception e){
            System.debug('The following error has occurred :' + e.getMessage());
        }    
        if(ord.id != NULL ){ 
            //System.debug('The New Customer is created and name is '+ .lastname);
            return 'returnClientInfo finished.' + jsonBody.orderId + '  ' +   ' request=' + request ;  
        }
        return 'INVALID ID';
    }
    
     //<=========================================================> Update Case API <==================================================================>
    
    @HttpPatch
    global static String updateStoreInformation() { 
        response.addHeader('Content-Type','applicatin/json');
        List<Order> ordList = new List<Order>();
        
        try {
            jsonBody  = (FromJSON)JSON.deserialize(request.requestBody.toString(),FromJSON.class);
            System.debug('The json is' +jsonBody);
            if(jsonBody != Null){
                ordList = [Select id , Order_Id__c , Status From Order where Order_Id__c =:jsonBody.orderId];
                if(!ordList.isEmpty()){
                    if(jsonBody.managerAccept == 4){
                        ordList[0].Status = 'Accepted';
                    }
                }
            }
            update ordList;
            return 'Order Status has been updated and Order Id is '+jsonBody.orderId;
        }

        catch(Exception e) {   
            System.debug('The following error has occurred :' + e.getMessage()); 
            return 'Order Status Data Update Error' +e.getMessage(); 
        } 
    }    
    
    public class FromJSON {     
        public String orderId;
        public String storeId;
        public String customerId;
        public Double cartTotal;
        public Double cartDiscount; 
        public String effectiveDate;
        public String status;
        public Double managerAccept;
        public String driverStatus;
        public Double storeAppCommission;
        public String storeCommissionType;
        public String storeDriverType;
        public Double subTotal;
        public Double deliveryCharge;
        public Boolean storeFreeDelivery;
        public Double subTotalWithOutTax;
        public Double taxAmount;
        public String appliedTax;
        public String orderTypeMessage;
        public Double promoCodeDiscount;
        public Double totalAmount;
        public String couponCode;
        public String paymentType;
        public Boolean paidByWallet;
        public String bookingDateNTime;
        public String dueDateNTime;
        public String city;
        public String bookingStatusMessage;
        public String bookingType;
        public String bookingNote;
        public String storeDispatcher;
        public String pickUpPlaceName;
        public String pickUpAddress;
        public String pickUpCity;
        public String pickUpArea;
        public String pickUpPostalCode;
        public String pickUpCountry;
        public String dropPlaceName;
        public String dropAddress;
        public String dropCity;
        public String dropArea;
        public String dropPostalCode;
        public String dropCountry; 
        public String driverAccountMessage;
        public Double taxes;
        public Double storeCommissionPercentage;
        public String storeCommissionMessage;
        public Double driverCommissionPercentage;
        public String driverCommissionMessage;
        public Double appEarningValue;
        public Double driverEarningValue;
        public Double driverCommissionToAppValue;
        public Double storeEarningValue;
        public Double storeCommissionToAppValue;
        public String pgCommissionName;
        public Double driverTip;
        public Double driverTotalEarning;
        public Double storeCommissionValue;
        public Double cartCommissionValue;
        public Double driverCommissionValue;
        public Double appDiscountValue;
        public Double storeDiscountValue;
        public Double storeDeliveryFee;
        public Double pgEarningValue; 
        public List<OrderedItem> orderItems;
            
     }
     
    public class OrderedItem{
        public String orderItemId;
        public String unitId;
        public String itemName;  
        public String unitName;
        public Double actualPrice;
        public Double offeredPrice;
        public Double itemDiscount;
        public String itemImage;
        public String offerId;
        public String taxes;
        public Double addOnPrice;
        public List<AddOns> addOns;    
        
     }
    public class AddOns{
        public String addOnId;
        public String name;
        public Double price;
        
     }
      
    public Static String checkNull(String str){
        if(!String.isBlank(str)){
            return str;
        }
        return '';
    }
    public static Double checkIntValue(Double intValue ){
        if(String.isBlank(String.valueOf(intValue)) || intValue == Null){  
            return 0.0;
        }
        return intValue;             
    }                 
}