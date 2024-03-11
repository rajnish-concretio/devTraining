public class ContactAddressToAccountHandler {
    
    public static void updateAccountAddress(List<Contact> newContacts, Map<Id, Contact> oldContactsMap) {
        Set<Id> accountIdsToUpdate = new Set<Id>();
        Map<Id, String> accountCityMap = new Map<Id, String>();
        
        // Identify Account Ids that need to be updated
        for(Contact con : newContacts) {
            System.debug('CONTACT :: '+con);
            System.debug('oldContactsMap :: '+oldContactsMap);
            System.debug('con.MailingCity :: '+con.MailingCity);
            System.debug('oldContactsMap.get(con.Id).MailingCity :: '+oldContactsMap?.get(con.Id)?.MailingCity);
            if (con.AccountId != null && (oldContactsMap == null || con.MailingCity != oldContactsMap.get(con.Id).MailingCity)) {
                accountIdsToUpdate.add(con.AccountId);
                accountCityMap.put(con.AccountId, con.MailingCity);
            }
        }
        
        // Query Accounts with their related Contacts where necessary
        List<Account> accountsToUpdate = [SELECT Id, Name, Phone, BillingCity, (SELECT Id, Phone, MailingCity FROM Contacts) 
                                          FROM Account WHERE Id IN :accountIdsToUpdate];
        
        // Update Accounts based on associated Contacts
        for(Account acc : accountsToUpdate) {
            acc.BillingCity = accountCityMap.get(acc.Id);
        }
        
        // Attempt to update the modified Accounts, handling any exceptions
        try {
            update accountsToUpdate;
        } catch(Exception error) {
            // Log any errors that occur during the update process
            System.debug('Error: ' + error.getMessage());
        }
    }
}