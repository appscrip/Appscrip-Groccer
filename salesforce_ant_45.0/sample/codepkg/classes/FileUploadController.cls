public class FileUploadController{
	public Document document {get; set;}
	public String url {get; set;}
	public boolean hasImage {get; set;}

	public FileUploadController() {
        
        hasImage = false;
        document = new document();
        url = 'https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260';
        
    }

     public PageReference doUpload() {
    
    	if (document.body != null) {
    		System.debug('@@@@@@@@ document:' + document.name);
            if (document.name != null) {
                System.debug('@@@@@@@@ doSave');
        
                Document d = document;
                System.debug(document);
                System.debug('@@@@@@@@ document name: '+d.name);
                System.debug(d);
        
                d.folderid = UserInfo.getUserId(); //store in Personal Documents
                System.debug('@@@@@@@@ document folder id: '+d.folderid);
                d.IsPublic = true;
        
                try {
                    insert d;
                    //url = DocumentUtil.getInstance().getURL(d);
                    hasImage = true;
                } 
                
                catch (Exception e) {
        
                    ApexPages.addMessages(e);
                    url = '';
                }
        
                d.body = null;
                System.debug('@@@@@@@@ document object id: '+d.id);
                //url = DocumentUtil.getInstance(d).getURL();
                System.debug('######## document content type: '+d.type);
        
            }
        
     }
    
     PageReference page = new PageReference('/apex/Upload_Image');
     page.setRedirect(true);
     return page;
    
    }
    
}