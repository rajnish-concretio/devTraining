/**
 * @description       : Trying to perform SOQL Injection.
 * @author            : Rajnish Kumar 
 * @group             : Service
 * @last modified on  : 07.02.2024
 * @last modified by  : Rajnish Kumar 
 * Modifications Log
 * Ver   Date         Author     Modification
 * 1.0   07.02.2024   Rajnish    Initial Version
 **/
public class DynamicQueryInjection {
    public static List<Account> searchAccounts(String searchTerm) {
        String query = 'SELECT Id, Name FROM Account WHERE Name = \'' + searchTerm + '\'';
        System.debug(query);
        return Database.query(query);
    }
    
}