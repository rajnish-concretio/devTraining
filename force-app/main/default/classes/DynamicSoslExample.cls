/**
 * Class to demonstrate dynamic SOSL search in Apex.
 */
public class DynamicSoslExample {
    
    /**
     * Method to perform a dynamic SOSL search based on user input.
     * 
     * @param userSearchInput The search term provided by the user.
     * @return A list of search results grouped by object types.
     */
    public static List<List<SObject>> performDynamicSOSLQuery(String userSearchInput) {
        // Constructing the SOSL query dynamically
        String soslQuery = 'FIND \'' + userSearchInput + '\' IN ALL FIELDS RETURNING Account, Contact, Opportunity';
        
        // Performing SOSL search
        List<List<sObject>> results = Search.query(soslQuery);
        
        return results;
    }
    
     public static List<List<SObject>> getSearchedRecords(String customObject) {
        String searchTerm='Raj';
        String soslQuery = 'FIND \'' + searchTerm + '\' IN ALL FIELDS RETURNING '+customObject;
        List<List<SObject>> results = Search.query(soslQuery);
        return results;
    }
}