// PaginationController.cls
public with sharing class PaginationController {
    // the wrapper class for the records and the total count
    public class PaginationResult {
        @AuraEnabled
        public List<SObject> records { get; set; }
        @AuraEnabled
        public Integer total { get; set; }
    }

    // the method to get the records from the server
    @AuraEnabled(cacheable=true)
    public static PaginationResult getRecords(String objectName, String fields, Integer pageSize, Integer offset, String sortedBy, String sortedDirection) {
        PaginationResult result = new PaginationResult();
        String query = 'SELECT ' + fields + ' FROM ' + objectName;
        if (String.isNotBlank(sortedBy)) {
            query += ' ORDER BY ' + sortedBy + ' ' + sortedDirection;
        }
        result.records = Database.query(query + ' LIMIT :pageSize OFFSET :offset');
        result.total = Database.countQuery('SELECT COUNT() FROM ' + objectName);
        return result;
    }
}
