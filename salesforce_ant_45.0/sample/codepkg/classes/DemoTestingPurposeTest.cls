@isTest
public class DemoTestingPurposeTest {

    public static testmethod void failingTest() {
        
       Test.startTest();
       DemoTestingPurpose dt = new DemoTestingPurpose();
       dt.myMethod();
       Test.stopTest();
        
    }
}