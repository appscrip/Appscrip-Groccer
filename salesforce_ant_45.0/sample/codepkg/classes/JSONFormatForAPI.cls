public class JSONFormatForAPI{

/*
//-----------------------------------------//Create Order JSON associate with Ordered Item & AddOns //------------------------------------------------//
{
  "orderId": "467587678564567fgh",
  "storeId": "81075",
  "customerId":"63637673567",
  "cartTotal": 7000,
  "cartDiscount": 5,
  "effectiveDate": "11/21/2018",
  "status": "Completed",
  "subTotalWithOutTax": 50,
  "storeAppCommission": 500,
  "StoreCommissionType": "Domestic",
  "storeDriverType": "Full",
  "subTotal": 1000,
  "deliveryCharge": 150,
  "storeFreeDelivery": true,
  "taxAmount": 500,
  "appliedTax": "8.9%",
  "orderTypeMessage": "Fast Order",
  "promoCodeDiscount": 100,
  "totalAmount": 2000,
  "couponCode": "NEWCUSTOMER",
  "paymentType": "Net Banking",
  "paidByWallet": true,
  "bookingDateNTime": "2018-11-22 03:15:10",
  "dueDateNTime": "2018-11-22 03:45:25",
  "city": "Jodhpur",
  "bookingStatusMessage": "Confirmed Order Booked",
  "bookingType": "Food",
  "bookingNote": "Fast Delivery and much spicy",
  "storeDispatcher": "Manager of Store",
  "pickUpPlaceName": "18 , Amart Vihar",
  "pickUpAddress": "18 , AmartVihar , Near ShastriNagar",
  "pickUpCity": "Jpdhpur",
  "pickUpArea": "Shashatri Nagar Garden",
  "pickUpPostalCode": "342005",
  "pickUpCountry": "India",
  "dropPlaceName": "18 , Amart Vihar",
  "dropAddress": "18 , AmartVihar , Near ShastriNagar",
  "dropCity": "Jpdhpur",
  "dropArea": "Shashatri Nagar Garden",
  "dropPostalCode": "342005",
  "dropCountry": "India",
  "driverAccountMessage": "Your Account Balance is 2500/-",
  "taxes": 7.9,
  "storeCommissionPercentage": 8.5,
  "storeCommissionMessage": "Store takes commission 5.5%.",
  "driverCommissionPercentage": 2.5,
  "driverCommissionMessage": "Driver takes Commission 2.5%.",
  "appEarningValue": 1000,
  "driverEarningValue": 250,
  "driverCommissionToAppValue": 200,
  "storeEarningValue": 600,
  "storeCommissionToAppValue": 500,
  "pgCommissionName": "Commissioner INcome",
  "driverTip": 100,
  "driverTotalEarning": 350,
  "storeCommissionValue": 600,
  "cartCommissionValue": 150,
  "driverCommissionValue": 250,
  "appDiscountValue": 200,
  "storeDiscountValue": 150,
  "storeDeliveryFee": 150,
  "pgEarningValue": 150,
  "orderItems": [
    {
      "itemName": "P1",
      "unitname": "ABCD112",
      "unitId": "wefsef5646",
      "actualPrice": 500,
      "offeredPrice": 500,
      "itemImage": "image2",
      "offerId": "2664564",
      "taxes": "9.5",
      "addOnPrice": 10000,
      "itemDiscount": 5.6,
      "addOns": [
        {
          "name": "AddOnP11",
          "price": 1000
        },
        {
          "name": "AddOnP12",
          "price": 1000
        },
        {
          "name": "AddOnP13",
          "price": 1000
        },
        {
          "name": "AddOnP14",
          "price": 1000
        }
      ]
    },
    {
      "itemName": "P2",
      "unitname": "AB121",
      "unitId": "5345345tsedrgfrt34",
      "actualPrice": 500,
      "offeredPrice": 500,
      "itemImage": "image1",
      "offerId": "456758",
      "taxes": "9.5",
      "addOnPrice": 10000,
      "itemDiscount": 6.7,
      "addOns": [
        {
          "name": "AddOnP21",
          "price": 1000
        },
        {
          "name": "AddOnP22",
          "price": 1000
        },
        {
          "name": "AddOnP23",
          "price": 1000
        },
        {
          "name": "AddOnP24",
          "price": 1000
        }
      ]
    },
    {
      "itemName": "P3",
      "unitname": "AB121",
      "unitId": "33463465ersgesrdtr",
      "actualPrice": 500,
      "offeredPrice": 500,
      "itemImage": "image1",
      "offerId": "456758",
      "taxes": "9.5",
      "addOnPrice": 10000,
      "itemDiscount": 6.7,
      "addOns": [
        {
          "name": "AddOnP31",
          "price": 1000
        },
        {
          "name": "AddOnP32",
          "price": 1000
        },
        {
          "name": "AddOnP33",
          "price": 1000
        },
        {
          "name": "AddOnP34",
          "price": 1000
        }
      ]
    },
    {
      "itemName": "P4",
      "unitname": "AB121",
      "unitId": "364565tregdfsg",
      "actualPrice": 500,
      "offeredPrice": 500,
      "itemImage": "image1",
      "offerId": "456758",
      "taxes": "9.5",
      "addOnPrice": 10000,
      "itemDiscount": 6.7,
      "addOns": [
        {
          "name": "AddOnP41",
          "price": 1000
        },
        {
          "name": "AddOnP42",
          "price": 1000
        },
        {
          "name": "AddOnP43",
          "price": 1000
        },
        {
          "name": "AddOnP44",
          "price": 1000
        }
      ]
    }
  ]
}

//--------------------------------------------// For Create Customer JSON //-------------------------------------------------------------//

{
"mongoId":"346456yrgadfsgse454",
"deviceName":"Android",
"name":"Shubham Gupta",
"email":"subham@gmail.com",
"Password":"8wuihfadsfb",
"Phone":"9078905656",
"userType":"Customer",
"birthdate":"11/11/1996",
"status":"New",
"picURL":"https://imgcollectinon.com/image/img1.jpg",
"tAndC":true,
"walletBalance":"0",
"walletBlock":"0",
"walletHardLimit":"0",
"walletSoftLimit":"0",
"deviceType":"Android",
"countryCode":"+91",

"deviceId":"7536324h35834",
"appVersion":"4375465", 
"currentlyActive":true,
"deviceOsVersion":"43653467443",
"lastLoginTime":"15 min ago",
"longitude":12.9716,
"latitude":77.5946,
"createdDateAndTime":"2018-11-22 03:15:10",
"createdBy":"Aakash",
"emailVerified":true,
"mobileVerified":true,
"lastLogin":"15 min ago",
"registeredFromCity":"Bangalore",
"socialMediaId":"435q3423432"           
                
}

//-------------------------------------------// for Update Customer wallet and Address JSON //---------------------------------------------//

{
"mongoId":"346456yrgadfsgse454",
"deviceOsVersion":"27487",
"picURL":"",
"lastLogin":"12 min ago",
"addressType":"HOme",
"flatNo":"147",
"landmark":"Near Power House",
"addressLine1":"178 Annamd Nagar",
"addressLine2":"Near Sisodia Garden",
"city":"Jodhpur",
"state":"Rajasthan",
"country":"India",
"postalCode":"342001"
}

{
"mongoId":"346456yrgadfsgse454",
"walletBalance":"2000",
"walletBlock":"5000",
"walletHardLimit":"10000",
"walletSoftLimit":"1000"
}
{
"mongoId":"346456yrgadfsgse454",
"password":"safjkshj",
"phone":"8107576862",
"countryCode":"+91",
"picURL":"",
"name":"Aakash",
"lastLogin":"11 min ago",
"email":"aakash@gmnail.com"
}
-----------------------------------------------//for Create Store JSON/-----------------------------------------------//
{
  "mongoId":"5345445cf3453454353d3dbjtvcdwsa",
  "parentMongoId":"",
   "Name":"New1234567890Store",
  "email":"anuragtomar@gmail.com",
  "ownerPhone":"9314299695",
  "ownerName":"Anurag Tomar",
  "averageDeliveryTime":"11/10/2018 12:46 PM",
  "commission":"7",
  "walletBalance":"100",
  "walletBlock":"1",
   "walletHardLimit":"100",
  "walletSoftLimit":"50",
  "storeLandLine":"01473262730",
  "billingCountry":"india",
  "billingCity":"jaipur",
  "billingState":"Rajasthan",
  "billingStreet":"Pratapchowk",
  "billingPostalCode":"312604",
  "Status":true,
  "commissionType":"Fixed",
  "countryCode":"91",
  "password":"12345",
  "storeaddress":"AAgra",
  "category":"A",
  "subCategory":"a",
  "appLogo":"https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg",
  "webLogo":"https://appscripdemo-dev-ed.my.salesforce.com/services/apexrest/Account.jpg",
  "storeDriver":"3",
  "companyDriver":"5",
  "franchisee":"",
  "freeDeliveryAbove":"1",
  "businessZoneName":"ra",
  "foodType":"Food",
  "averageRating":"50000",
  "storeType":"Store",
  "recordType":"Store",
  "website":"www.appscrip.com",
  "description":"New In Your Area"
  }

----------------------------------------------------------------------------------------------------------------------------------------------

------------------------_For Wallet Transaction Create Json(STORE)----------------------------------------

{
  "amount":"10000",
  "cashCollected":"00.00",
  "currencyType":"INR",
  "triggerType":"ORDER",
  "cityName":"Jodhpur",
  "txnDate":"11/20/2018",
  "closingBalance":"1000",
  "openingBalance":"6000",
  "orderId":"5438465347865789ncb5ncncnn545",
  "paymentType":"Card",
  "storeMongoId":"5c3337226723fa6189404267",
  "txnId":"askjdfasnfs9f8yhwfbnwHA8989890000",
  "txnType":"CREDIT",
  "comment":"manully created"
}

------------------------updated JSON for wallet transaction API (CUSTOMER)--------------------------------
 {
  "amount":"10000",
  "cashCollected":"00.00",
  "currencyType":"INR",
  "triggerType":"ORDER",
  "cityName":"Jodhpur",
  "txnDate":"11/20/2018",
  "closingBalance":"1000",
  "openingBalance":"6000",
  "orderId":"5438465347865789ncb5ncncnn545",
  "paymentType":"Card",
  "customerMongoId":"5c3337226723fa6189404267",
  "txnId":"askjdfasnfs9f8yhwfbnwHA8989890000",
  "txnType":"CREDIT"
  "comment":"manully created"
}
-------------------------------for Multiple Addresses of Customers-----------------------------------------------------------------------------
 { "mongoId":"",
   "city":"Gandhidham",
   "state":"Gujarat",
   "pincode":"123456",
   "landmark":"Near IFFCO colony",
   "flatNo":"G-281",
   "country":"India",
   "addressType":"Home",
   "addressLine1":"G-281 Iffco Colony , Gandhidham",
   "addressLine2":"Near Our Lady of Piller Convent School",
   "customerMongoId":""
}
----------------------------Product Json---------------------------------------------------------------------------------------------------------
 {
    "mongoId":"56763477bf4hgbhvghvbgwuyu64564h6g",
    "picUrl":"http://rahul.jpg",
    "productName":"AquaPure1",
    "productCode":"00121",
    "firstCategory":"NA11",
    "secondCategory":"NA12",
    "thirdCategory":"NA13",
    "status":true,
    "barCode":"35353523",
    "brandName":"Itc",
    "manufactureName":"HealthCare",
    "sku":"6476645",
    "storeMongoId":"653467365375gbc653645b",
    "viewCount":"7",
    "favoriteCount":"7",
    "addedToCartCount":"7",
    "ingredients":"English",
    "description":"whjfhjfsf",
    "ad":[{
    "addOnsName":"Addon01",
    "addOnsMongoId":"dxfghdgw36554",
    "price":"250",
    "storeAddOnsId":"57348bc67cb67c5672x"
    },
    {
    "addOnsName":"Addon02",
    "addOnsMongoId":"ertwrtw255453tret",
    "price":"25",
    "storeAddOnsId":"3435x34x35353bgh55"
    }],
    "un":[{
    "unitMongoId":"utyjdfgn hd5646",
    "price":"250",
    "Name":"unit001",
    "status":true,
    "size":"2"
    },
    {
    "unitMongoId":"dfgdfg5453tert",
    "price":"25",
    "Name":"unit002",
    "status":true,
    "size":"5"
    }]
  } 
-----------------------------------------------Central Product Json --------------------------------------------------------------------------------
  {
"mongoId":"7485764756nv6vnvn76",
"picUrl":"http://rahul.jpg",
"productName":"Pepsi",
"productCode":"0012",
"firstCategory":"Liqued",
"secondCategory":"Botels",
"thirdCategory":"Carates",
"status":true,
"barCode":"5646466",
"brandName":"Itc",
"manufactureName":"Pay",
"description":"whjfhjfsf"
}
--------------------------------//--------------
{
  "orderId": 1549376796274,
  "storeId": "5b85522c321ba672590c1110",
  "customerId": "5c4ee7fb6723fa6189558f39",
  "cartTotal": 464,
  "cartDiscount": "0",
  "effectiveDate": "02/05/2019",
  "status": "New Order",
  "subTotalWithOutTax": 508.95,
  "storeAppCommission": 80,
  "StoreCommissionType": "Percentage",
  "storeDriverType": "Freelance",
  "subTotal": 464,
  "deliveryCharge": 5,
  "storeFreeDelivery": false,
  "taxAmount": 44.95,
  "orderTypeMessage": "Default order",
  "promoCodeDiscount": 100,
  "totalAmount": 513.95,
  "couponCode": "",
  "paymentType": "Cash + Wallet",
  "paidByWallet": false,
  "bookingDateNTime": "2019-02-05 14:26:36",
  "dueDateNTime": "2019-02-05 19:56:34",
  "city": "",
  "bookingStatusMessage": "New Order",
  "bookingType": 1,
  "bookingNote": "",
  "storeDispatcher": "Manager of Store",
  "pickUpPlaceName": "",
  "pickUpAddress": "",
  "pickUpCity": "Bengaluru",
  "pickUpArea": "",
  "pickUpPostalCode": "560024",
  "pickUpCountry": "India",
  "dropPlaceName": "",
  "dropAddress": "19 10th Cross Road,10th Cross Road, 19 , Bengaluru, Karnataka",
  "dropCity": "Bengaluru",
  "dropArea": "RBI Colony,Hebbal",
  "dropPostalCode": "560024",
  "dropCountry": "India",
  "driverAccountMessage": "",
  "taxes": "0",
  "storeCommissionPercentage": 80,
  "storeCommissionMessage": 80,
  "driverCommissionPercentage": 0,
  "driverCommissionMessage": "",
  "appEarningValue": 0,
  "driverEarningValue": 0,
  "driverCommissionToAppValue": 0,
  "storeEarningValue": 0,
  "storeCommissionToAppValue": 0,
  "pgCommissionName": 0,
  "driverTip": 0,
  "driverTotalEarning": "0",
  "storeCommissionValue": 80,
  "cartCommissionValue": 0,
  "driverCommissionValue": 0,
  "appDiscountValue": "0",
  "storeDiscountValue": 0,
  "storeDeliveryFee": 0,
  "pgEarningValue": 0,
  "orderItems": [
    {
      "itemName": "o1",
      "unitname": "ABCD",
      "unitId": "1234567890",
      "actualPrice": 50,
      "offeredPrice": 40,
      "itemImage": "",
      "offerId": "12345",
      "taxes": "9.5",
      "itemDiscount": 12,
      "addOnPrice": 50 
    },
    {
      "itemName": "o2",
      "unitname": "ABCD",
      "unitId": "0987654321",
      "actualPrice": 50,
      "offeredPrice": 40,
      "itemImage": "",
      "offerId": "54321",
      "taxes": "10.5",
      "itemDiscount":12,
      "addOnPrice": 50
      
    }
  ]
}
---------------------------------------------------------// Case API Json----------------------------------------------
{
 "caseMongoId":"ajkssdfjd1857.",
 "customerId":"5c80fa446723fa6189aebf5d",
 "subject":"Device Problem 1",
 "category":"Order Manager",
 "description":"Device Condition not good",     
 "priority":"High",
 "origin": "Email",
 "status": "New",
 "typeValue":"Problem",
 "caseReason": "Performance"   
}
*/
}