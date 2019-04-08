// Task #2 of Task Object
trigger ActivityUpdation on Task (before insert , after insert) {

    String s ='';
    Set<Id> aid = new Set<Id>();
    Set<Id> cid = new Set<Id>();
    Integer a=0,b=0,c=0,d=0,e,f;
    
    if(Trigger.isBefore && Trigger.isInsert){
        for(Task t : Trigger.New){
    
            if(t.subject.Contains('Call')){  
                t.type = 'Call'; 
                     
            }
            else if(t.subject.Contains('Email')){      
                    t.type = 'Email';
                          
            }
            else if(t.subject.Contains('Other')){
                    t.type = 'Task';
                    
            }
            else if(t.subject.Contains('for all Events')){
                    t.type = 'Meeting';
                           
            }
        }    
    
    }
     
    if(Trigger.isAfter && Trigger.isInsert){
        for(Task t : Trigger.New){
        
            aid.add(t.WhatId);
            cid.add(t.WhoId);
            
            if(t.type == 'Call'){  
              
                ++a;
                s+='_Call'; 
                
            }
            else if(t.type == 'Email'){       
               
                    ++b;
                    s+='_Email'; 
            }
            else if(t.type == 'Task'){
                    
                    ++c;
                    s+='_Task';
            }
            else if(t.type == 'Meeting'){
                    
                    ++d;
                    s+='_Meeting';
            }  
        }
    
    if(!aid.isEmpty()){
        List<Account> acc = [Select id , name , Activity_Score__c from Account where id IN : aid];
        e = ((d*3)+(a*2)+(b*1));
        if(!acc.isEmpty()){
            for(Account a : acc){
                a.name+=s;
                if(a.Activity_Score__c == null){
                a.Activity_Score__c = e;
                }
                
                else{
                    a.Activity_Score__c += e;
                }
            }
        }
        
        update acc;
    }
    
    if(!cid.isEmpty()){
        List<Contact> con = [Select id , Lastname , Activity_Score__c from Contact where id IN : cid];
        e = ((d*3)+(a*2)+(b*1));
        
        if(!con.isEmpty()){
            for(Contact c : con){
                c.lastname+=s;
                if(c.Activity_Score__c == null){
                c.Activity_Score__c = e;
                }
                
                else{
                c.Activity_Score__c += e;
                }   
            }
        }
        
        update con;
    }
    }

}