trigger TestDemo on Contact (before insert) {

    Set<id> cid = new Set<id>();
    List<Contact> conlist = new List<Contact>();
    
    for(Contact c : Trigger.New){
        Account Name  = c.Account;
        cid.add(c.AccountId);
    }
   conlist=[select id,lastname from contact where accountid IN:cid];
   
}