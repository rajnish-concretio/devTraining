@isTest
public with sharing class TestExampleWrapperClass {
    
    @isTest
    public static void testExampleWrapperClass(){

        String doctorName = 'hello';
        Integer doctorAge = 25;
        Decimal salary = 25000;
        System.assertEquals(, ExampleWrapperClass.addDoctor(doctorName, doctorAge, salary));
        
    }
}