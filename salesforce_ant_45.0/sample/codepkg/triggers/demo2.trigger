trigger demo2 on Account (after insert){

    Id aid;
    String accName;
    List<Account> acclist = new List<Account>();
    List<Account> aclst = new List<Account>();
    List<Contact> conList = new List<Contact>();
    for(Account a: Trigger.New){
        System.debug('The Newly Added Accont Name is'+ a.name);
        accName = a.name;
        aid = a.id;
        System.debug('The LIst is'+acclist);
    }
    acclist=[Select Id,Name,(Select Id,LastName From Contacts) From Account Where Name=:accName];
    conList = acclist[0].Contacts;
    System.debug('The Contact is ---> '+conList);
    if(acclist.size()>0){
      
        for(Contact c : conList){
            
            System.debug('The Contact is3'+c.LastName);
            c.AccountId = aid;
             
           }
        }
    update conList;    
}