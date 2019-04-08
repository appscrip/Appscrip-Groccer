@isTest
//Task#2 Test Class of Task Object
    public class ActivityUpdation_TestClass{
        
        public Static testMethod void myTest(){
       
        Account a = new Account();
        a.name = 'Manish';
       // a.Activity_Score__c = 10;
        insert a ;
       // a.Activity_Score__c = 10 ;
       // update a;
        
        
        Contact c = new Contact();
        c.AccountId = a.id;
        c.lastname = 'Mourya';
        //c.Activity_Score__c = 10;
        insert c ;
        //c.Activity_Score__c = 10;
        //update c;
           
        for(Integer i=1 ; i<=4 ; i++){
                
            Task t = new Task();
            t.WhatId = a.id;
            t.WhoId = c.id;
            t.Priority = 'Normal';
            t.Status = 'Completed';
            if(i==1){
            t.Subject = 'Call';
            t.type = 'Call'; 
            }
            if(i==2){
            t.Subject = 'Email';
            t.type = 'Email'; 
            }
            if(i==3){
            t.Subject = 'Other';
            t.type = 'Other'; 
            }
            if(i==4){
            t.Subject = 'for all Events';
            t.type = 'Meeting'; 
            }
            insert t;                 
        }
         
        }
    }        
        
       /* public Static testMethod void myTest1(){
       
        Account a = new Account();
        a.name = 'Manish';
        insert a ;
       // a.Activity_Score__c = 10 ;
       // update a;
        
        
        Contact c = new Contact();
        c.AccountId = a.id;
        c.lastname = 'Mourya';
        insert c ;
       // c.Activity_Score__c = 10;
        //update c;
        for(Integer i=1 ; i<=4 ; i++){
                
            Task t = new Task();
            t.WhatId = a.id;
            t.whoId = c.id;
            t.Priority = 'Normal';
            t.Status = 'Completed';
            if(i==1){
            t.Subject = 'Call';
            t.type = 'Call'; 
            }
            if(i==2){
            t.Subject = 'Email';
            t.type = 'Email'; 
            }
            if(i==3){
            t.Subject = 'Other';
            t.type = 'Other'; 
            }
            if(i==4){
            t.Subject = 'for all Events';
            t.type = 'Meeting'; 
            }
            insert t;                 
        } 
        } */