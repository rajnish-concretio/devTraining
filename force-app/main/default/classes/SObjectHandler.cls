public with sharing class SObjectHandler {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountsByField(List<String> selectedFieldsName, String objName) {
        // Construct dynamic SOQL query with parameter binding
        String fields = String.join(selectedFieldsName, ', ');
        String query = 'SELECT ' + fields + ' FROM Account';
        System.debug(query);
        return Database.query(query);
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountsByField(List<String> selectedFieldsName, String objName) {
        // Construct dynamic SOQL query with parameter binding
        String fields = String.join(selectedFieldsName, ', ');
        String query = 'SELECT ' + fields + ' FROM ' + objName;
        System.debug(query);
        return Database.query(query);
    }
}