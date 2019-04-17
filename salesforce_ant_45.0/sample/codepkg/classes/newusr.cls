public class newusr {
    List<Order> ordList;
    List<Account>accList;
    public List<Contact> contList{get;set;}
    Id aid;
    Set<Id> cid;
    public newusr(ApexPages.StandardController controller) {
    
    contList=new List<Contact>();
    cid= new Set<Id>();

    }
     public void alldetail(){
   
   accList=[Select id from Account where Id=:ApexPages.currentPage().getParameters().get('id')];
   ordList=[Select id,AccountId,CustomerAuthorizedById From Order Where AccountId IN:accList];
   for(Order ord : ordList){
     cid.add(ord.CustomerAuthorizedById);
   }
   contList=[Select Id,lastname from Contact where Id In:cid];
  }

}