@isTest
public with sharing class TestVerifyDate {
    @isTest
    private static void check_DateCase1(){
        Test.StartTest();
        Date dt = VerifyDate.CheckDates(date.parse('01/01/2024'), date.parse('01/04/2024'));
        Assert.areEqual(date.parse('01/04/2024'),dt);
        Test.StopTest();
        
    }
    
     @isTest
    private static void check_DateCase2(){
        Test.StartTest();
        Date dt = VerifyDate.CheckDates(date.parse('01/01/2024'), date.parse('01/01/2024'));
        Assert.areEqual(date.parse('01/04/2024'),dt);
        Test.StopTest();
        
    }
}