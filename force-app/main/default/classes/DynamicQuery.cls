/**
* @description       : Retrieves records from a custom object based on the specified object name.
* @author            : Rajnish Kumar 
* @group             : Service
* @last modified on  : 07.02.2024
* @last modified by  : Rajnish Kumar 
* Modifications Log
* Ver   Date         Author     Modification
* 1.0   07.02.2024   Rajnish    Initial Version
**/
/*public class DynamicQuery {
public static List<sObject> retrieveCustomObjectRecords(String customObjectName) {
try{
String queryString = 'SELECT Id, Name FROM ' + customObjectName;
List<sObject> records = Database.query(queryString);
return records;
}
catch(Exception error){
System.debug('No Record Found'+ error.getMessage());
return null; 
}        

}


}*/
public class DynamicQuery {
    /**
* Retrieves records from a custom object based on the specified object name.
* 
* @param customObjectName The API name of the custom object to retrieve records from.
* @return A list of sObjects containing the Id and Name fields of the specified custom object.
*         If an error occurs during the query execution or no records are found, an empty list is returned.
*/
    public static List<sObject> retrieveCustomObjectRecords(String customObjectName) {
        List<sObject> records = new List<sObject>();
        
        try {
            // Provideing The Custom Object Name
            customObjectName = String.escapeSingleQuotes(customObjectName);
            
            // SOQL query Operations
            String queryString = 'SELECT Id, Name FROM ' + customObjectName;
            
            // Executing the query
            records = Database.query(queryString);
        } catch(QueryException error) {
            // Log the error for debugging purposes
            System.debug('Error occurred while querying: ' + error.getMessage());
        }
        
        return records;
    }
}