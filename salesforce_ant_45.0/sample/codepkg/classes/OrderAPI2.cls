//<=========================================================> Using PUT METHOD Update Case API <==================================================================>
@RestResource(urlMapping='/Ord/*')
global with sharing class OrderAPI2{
   public Static RestRequest request = RestContext.request;
   public Static RestResponse response = RestContext.response;
   public Static FromJSON jsonBody;
   public Static FromJSON jsonBody1;
     
    @HttpPut
    global static String updateOrderInfo(){
      request.addHeader('Content-Type','application/json');
      Account a;     
      Contact c;
      Order ord;
      List<OrderedItem> s = new List<OrderedItem>();
      List<AddOns> s1 = new List<AddOns>();
      List<Ordered_Items__c>orderedItems = new List<Ordered_Items__c>();
      List<AddOn__c> addOn = new List<AddOn__c>();
      Map<String,List<AddOn__c>> mapAddOns = new Map<String,List<AddOn__c>>();
      Map<String,Ordered_Items__c> checkUnitId =new Map<String,Ordered_Items__c>();
      List<Order>orderList = new List<Order>();
        
        try{
            jsonBody  = (FromJSON)JSON.deserialize(request.requestBody.toString(),FromJSON.class);
            orderList = new List<Order>();
             if(jsonBody != NULL){
                 orderList = [Select Order_Id__c, Status From Order Where Order_Id__c =:jsonBody.orderId ];
            
                 if(orderList.isEmpty()){
                    System.debug('The json is '+ jsonBody);
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
                    orderList.add(ord);
                 }
                                  
                if(!orderList.isEmpty()){
                    if(jsonBody.status!= NULL ){ 
                        orderList[0].Status = jsonBody.status;
                               
                    }
                }
           
            upsert orderList;
            
            //<============================================== For Ordered Items & AddONs ========================================================>
             s =(List<OrderedItem>)jsonBody.orderItems;
                System.debug('The Main Json is'+ jsonBody);
                System.debug('The ordered Items is '+ s.get(0));
                if(s != NULL){
                    for(Integer i=0;i<s.size();i++){ 
                        Ordered_Items__c ordItems = new Ordered_Items__c(); 
                        ordItems.Orders__c = ord.id;
                        ordItems.Unit_Id__c = s.get(i).unitId;
                        ordItems.Name = s.get(i).itemName;
                        ordItems.Unit_Name__c = checkNull(s.get(i).unitName);
                        ordItems.Actual_Price__c = checkIntValue(s.get(i).actualPrice);
                        ordItems.Offered_Price__c = checkIntValue(s.get(i).offeredPrice);
                        ordItems.Item_Discount__c = checkIntValue(s.get(i).itemDiscount);
                        ordItems.Item_Image__c = checkNull(s.get(i).itemImage);
                        ordItems.Offer_Id__c = checkNull(s.get(i).offerId);
                        ordItems.Taxes__c = checkNull(s.get(i).taxes);
                        ordItems.AddOn_Price__c = checkIntValue(s.get(i).addOnPrice);
                         
                        s1 = s.get(i).addOns;
                        if(s1 != NULL){
                        List<AddOn__c> listAddon =new List<AddOn__c>();
                        for(AddOns str :s1){
                            AddOn__c ad = new AddOn__c(); 
                            ad.Name = checkNull(str.name);
                            ad.Price__c = checkIntValue(str.price);
                            listAddon.add(ad);  
                         }
                            mapAddOns.put(ordItems.Unit_Id__c,listAddOn);
                        }
                        orderedItems.add(ordItems);
                    }
                }
                System.debug('The orderedItems List size is '+orderedItems.size());
                if(!orderedItems.isEmpty()){
                    insert orderedItems;    
                }
                
                for(Ordered_Items__c orderI :orderedItems){
                    checkUnitId.put(orderI.Unit_Id__c,orderI);
                }
                
                 for(String st :mapAddOns.keySet()){
                    for(AddOn__c adon :mapAddOns.get(st)){
                        if(checkUnitId.containskey(st)){
                            Ordered_Items__c orderItems = checkUnitId.get(st);
                            adon.Ordered_Items__c =orderItems.id;
                            addOn.add(adon);
                        }
                    }
                }
                
                System.debug('The AddOn List size is '+addOn.size());
                if(!addOn.isEmpty()){
                    insert addOn;
                }              
            } 
        }

        catch(Exception e) {   
            System.debug('The following error has occurred :' + e.getMessage());  
        } 
        return 'Order Info has been Updated OR Inserted Succesfully and OrderId is '+jsonBody.orderId;  
    }    
                
    public class FromJSON {
        public String orderId;
        public String storeId;
        public String customerId;
        public Double cartTotal;
        public Double cartDiscount; 
        public String effectiveDate;
        public String status;
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