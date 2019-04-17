public class Custom {
    public static List<Order> ordList{get;set;}
    public static List<Account>accList{get;set;}
    //public List<Contact>conList{get;set;}
    public static List<Contact>coList{get;set;}
    Public Id aid{get;set;}
    Public static Id cid{get;set;}
    public Custom(ApexPages.StandardController controller) {
    
    coList=new List<Contact>();
    
    //conList=[Select Id from Contact where Id=:cid];
    }
    
  
   public static List<contact> alldetail(){
   
   accList=[Select id from Account where Id=:ApexPages.currentPage().getParameters().get('id')];
   ordList=[Select id,AccountId,CustomerAuthorizedById From Order Where AccountId IN:accList];
   
   for(Integer i=0; i<ordList.size();i++){
   cid=ordList[i].CustomerAuthorizedById;
   coList=[Select Id from Contact where Id=:cid];
  }
    return coList;
  }
}