// AccountController.cls
public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<String> getSObjects() {
        List<String> sObjects = new List<String>();
        for (Schema.SObjectType sObjectType : Schema.getGlobalDescribe().Values()) {
            sObjects.add(sObjectType.getDescribe().getName());
        }
        return sObjects;
    }

    @AuraEnabled(cacheable=true)
    public static List<String> getObjectFields(String objectName) {
        List<String> fields = new List<String>();
        Schema.DescribeSObjectResult describeResult = Schema.getGlobalDescribe().get(objectName).getDescribe();
        for (Schema.SObjectField field : describeResult.fields.getMap().Values()) {
            if (field.getDescribe().isAccessible()) {
                fields.add(field.getDescribe().getName());
            }
        }
        return fields;
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getRecordsByFields(String objectName, List<String> selectedFieldsName) {
        // Construct dynamic SOQL query with parameter binding
        String fields = String.join(selectedFieldsName, ', ');
        String query = 'SELECT ' + fields + ' FROM ' + objectName;
        System.debug(query);
        return Database.query(query);
    }
}
