@RestResource(urlMapping='/Account/*')
    global class StoreAccountApi{
    @HttpPost
        global static String postContact( String Name,String Phone){
            Account  a = new Account();
            a.name = name;
            a.Phone = Phone;
            insert a;
            return 'Account  Successfuly Inserted....';
         }
     }