public class MyNewController {

   public  List<Account> acList{get;set;}
   public  List<Contact> coList{get;set;}
   public  List<Opportunity> opList{get;set;}
   
   public MyNewController (){
      
        acList= new List<Account>();
        coList= new List<Contact>();
        opList= new List<Opportunity>();
        acList=[Select Id,Name,Phone From Account limit 20];
        coList=[Select Id,LastName,Phone From Contact limit 20];
        opList=[Select Id,Name,StageName from Opportunity limit 20];
        
    }
    public void showrec(){
       
    }
}