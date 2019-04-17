public class AutoUploadDoc{
    
    static String imageURL;
    static String base64Data;
    public AutoUploadDoc(){
        ImageURL = 'https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260';
        base64Data = '';
    }
    public static void imageUpload(){
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://images.pexels.com/');
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(req);
        Blob image = res.getBodyAsBlob();
        System.debug('The Image is '+ image);
        base64Data =  EncodingUtil.base64Encode(image);
    
        Document doc = new Document();
        doc.Name = 'SF Dashboard Image.jpeg';
        doc.body = EncodingUtil.base64Decode(base64Data);
        doc.folderId = '00l900000027wOx'; //your folder id
        insert doc;
    }
    

}