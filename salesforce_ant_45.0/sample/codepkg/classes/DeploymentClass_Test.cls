@isTest
public class DeploymentClass_Test{

    public static testMethod void positiveScenario(){
        Test.startTest();
        DeploymentClass dc = new DeploymentClass();
        dc.myDeployMethod();
        Test.stopTest();
    
    }


}