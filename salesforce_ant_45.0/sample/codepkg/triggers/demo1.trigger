trigger demo1 on Contact  (after Insert) {
      Double x,y;
       List<Account> acclist = new List<Account>();
       Set<Id> aid = new Set<Id>();
      for (Contact c : Trigger.new){
         x= c.Amount_X__c ;
         y= c.Amount_Y__c ;
       
        aid.add(c.accountid);
        }
        
        
        acclist = [Select id , Name , Total_Amount__c From Account Where Id IN :aid];
        for(Account a: acclist){
            a.Total_Amount__c = x+y;
        }
        update acclist; 
}