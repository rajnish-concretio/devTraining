/**
* @description       : Trigger to update Account Address with Contact Addess.
* @author            : Rajnish Kumar 
* @group             : Service
* @last modified on  : 08.02.2024
* @last modified by  : Rajnish Kumar 
* Modifications Log
* Ver   Date         Author     Modification
* 1.0   08.02.2024   Rajnish    Initial Version
**/
trigger ContactAddressToAccount on Contact (after insert, after update, after undelete) {
    
    // Set to store unique Account Ids that need to be updated
    Set<Id> accId = new Set<Id>();
    if(trigger.isUndelete || trigger.isInsert){
        for(Contact con : trigger.new){
            if(con.AccountId != null){
                accId.add(con.AccountId);
            }
        }
    }
    
    // Iterate through the new Contacts to identify those with a changed MailingCity and associate them with their respective Account Ids
    if(trigger.isUpdate){
        for(Contact con : Trigger.new){
            if(con.AccountId != null && con.MailingCity != Trigger.oldMap.get(con.Id).MailingCity){
                accId.add(con.AccountId);
            }
        }
    }
    // Map to store Contacts by their associated Account Ids
    Map<Id, Contact> conMapItem = new Map<Id, Contact>();
    for(Contact con : Trigger.new){
        conMapItem.put(con.AccountId, con);        
    }
    
    // Query Accounts with their related Contacts where necessary
    List<Account> extLstAcc = [SELECT Id, Name, Phone, BillingCity, (SELECT Id, Phone,MailingCity FROM Contacts) FROM Account WHERE Id IN :accId];
    
    // List to store Accounts that need to be updated
    List<Account> lstToUpdateAcc = new List<Account>();
    
    // Iterate through queried Accounts to update their BillingCity based on associated Contacts
    for(Account acc : extLstAcc){
        acc.BillingCity = conMapItem.get(acc.Id).MailingCity; 
        lstToUpdateAcc.add(acc);
    }
    
    // Attempt to update the modified Accounts, handling any exceptions
    try{
        update lstToUpdateAcc;
    } catch(Exception error){
        // Log any errors that occur during the update process
        System.debug('Error in line number 54: ' + error.getMessage());
    }
}