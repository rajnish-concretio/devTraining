@isTest
public class TestContactAddressToAccountTrigger {   
    @isTest
    public static void check_afterInsert(){
        Test.StartTest();
        Account objAcc = new Account(Name = 'Rajnish');
        insert objAcc;
               
        Contact objCon = new Contact();
        objCon.AccountId = objAcc.id;
        objCon.LastName = 'Rajnish Contact';
        objCon.MailingCity = 'Delhi';
        insert objCon;
        
        objCon.LastName = 'Updated Rajnish Contact';
        update objCon;
        delete objCon;
        undelete objCon;        
        Account lstAcc = [Select id, Name, BillingCity from Account where Id = : objAcc.id limit 1];
        System.assertEquals(objCon.MailingCity, lstAcc.BillingCity);
        Test.StopTest();
        
    }
    
}