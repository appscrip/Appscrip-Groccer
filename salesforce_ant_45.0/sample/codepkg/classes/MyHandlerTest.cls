@isTest
public class MyHandlerTest{
    
    public static testMethod void postiveScenario(){
      Id[] fixedSearchResults = new Id[5];
      
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       
      email.subject = 'New Email Service';
      email.fromAddress = 'mouryamanish7@email.com';
      email.plainTextBody = 'For Checking Purpose';
      
      List<String> ccEmailList = new List<String>{'mouryamanish7@gmail.com','manish@mobifyi.com.cm'};
      email.ccAddresses = ccEmailList;
      List<Task> taskList = new List<Task>();
      List<Attachment> attachmentList = new List<Attachment>();
     
      Contact c = new Contact(lastName = 'New Contact', Email='mouryamanish7@gmail.com');
      insert c;
      for(Integer i=0; i<ccEmailList.size();i++){
          Task t = new Task(whoId = c.id , subject='Email',Priority = 'Medium' , Status = 'Open');
          taskList.add(t); 
        }
        insert taskList;
     
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
           
      attachment.body = blob.valueOf('My File');
      attachment.fileName = 'MyFile.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment};
      
      for(Task t : taskList){
          Attachment attachment1 = new Attachment();
          attachment1.Name = 'MyFile.txt';
          attachment1.Body =blob.valueOf('My File');
          attachment1.ParentId =t.id;
          attachmentList.add(attachment1);
      }    
      insert attachmentList;
      
      fixedSearchResults[0] = c.id;
      Test.setFixedSearchResults(fixedSearchResults); 
         
      MyHandler myHand =new MyHandler();
      myHand.handleInboundEmail(email , envelope );
     
    }
}