global class MyHandler implements Messaging.InboundEmailHandler {    
     public integer j ;
     public Account acc;
     public List<Contact> conList = new List<Contact>();
     public List<Contact> updatedConList = new List<Contact>();
     public List<sObject> sObjectList=new List<sObject>();
     public List<Lead> leadList{get;set;}
     public List<Task> taskList = new List<Task>();
     public List<Attachment>attachmentList  = new  List<Attachment>();
     public List<String> ccEmail = new List<String>();
    
  
     global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          System.debug('The Email is '+ email);
          String emailAddress = ''+email.fromAddress;
          System.debug('Theb Email Address is'+ emailAddress);
          acc = new Account(name='Acc');
          insert acc;
          
          List<List<sObject>> searchList = [Find :emailAddress IN ALL FIELDS RETURNING Contact(id), Lead(id,email)];
        
         for(List<sObject>sObj : searchList){
             if(sObj.getSObjectType() == conList.getSObjectType())
                 conList = sObj;
             else
                 leadList = sObj;
         }    
                   
     string des = email.plaintextbody;
     string tasksubject = email.subject;
     string  tname=email.fromName;
     string  senderEmail = email.fromAddress;
     ccEmail = email.ccAddresses;
      List<Contact> contacts = [Select id , lastName From Contact where id IN: conList];
         for(Contact c:contacts){
             c.lastName ='Contact-'+c.lastName;
             updatedConList.add(c);   
         } 
         if(!updatedConList.isEmpty()){
             update updatedConList;
         }
      System.debug('ccEmail Size is '+ ccEmail);
      if(!ccEmail.isEmpty()){
          for(integer i=0 ; i<updatedConList.size() ; i++){
              for(Integer j=0 ; j<ccEmail.size() ; j++){
                  Task t = new Task(Description = des,  subject = 'Email' + '-' + tasksubject, Priority = 'Medium', status='open',
                  CallDisposition= tname + '-'+ senderEmail, ActivityDate = System.today(), ReminderDateTime = System.now(), whoid=conList[i].id);
                  taskList.add(t);
                  system.debug('...' + t);
              }    
          }
      }
         
      if(!taskList.isEmpty()){
          insert taskList;
      } 
         
      if(email.binaryAttachments !=null && email.binaryAttachments.size()>0){
          for(Task t : taskList){
            for(integer i=0 ; i<email.binaryAttachments.size() ; i++){
                 Attachment attachment = new Attachment();
                 attachment.Name = email.binaryAttachments[i].filename;
                 attachment.Body =email.binaryAttachments[i].body ;
                 attachment.ParentId = t.id;  
                 attachmentList.add(attachment);
                System.debug('The Attachment is ');
                 //insert attachment;   
             }
         } 
          if(!attachmentList.isEmpty()){
            insert attachmentList;
              System.debug('The Attachment id is '+ attachmentList[0].id);
          }
      } 
    result.success=true;
    return result;  
   }
}