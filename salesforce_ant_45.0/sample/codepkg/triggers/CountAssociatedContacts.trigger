trigger CountAssociatedContacts on Contact (after insert) {
    
    Set<Id> aid = new Set<Id>();
    List<Account> accList = new List<Account>();
    
    for(Contact c : Trigger.New){
    
        aid.add(c.AccountId);
    
    }
    
    accList = [Select id , name , Associated_Contacts__c from Account where id IN :aid];
    List<Contact> conList = [Select id from Contact where AccountId IN :aid];
    
    for(Account a :accList){
    
        a.Associated_Contacts__c = conList.size();
    
    }
    update accList;

}