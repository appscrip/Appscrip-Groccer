trigger ContactAssociation on Account (after insert) {

    ID aid;
    String accName;
    List<Account> accList = new List<Account>();
    List<Contact> conList = new List<Contact>();
    
    For(Account a : Trigger.New){
        
       aid = a.id;
       accName = a.Name;
       System.debug('The Account Id is '+ aid); 
       
    }
    
    //accList = [Select id , name ,(Select id , AccountId , LastName From Contacts) from Account where name =:accName ];
    accList = [Select id , name From Account where name =:accName ];
    conList = [Select id , AccountId , LastName From Contact where AccountId IN: accList];
    
    for(Contact c : conList) {
               
        c.AccountId = aid;
          
    }
    
    update accList;
    update conList;
               
}