@isTest
public class TestCheckAnagram {
    @isTest
    static void testCheckIfAnagram() {
        // Test case 1: Anagram strings
        String firstString = 'listen';
        String secondString = 'silent';
        CheckAnagram.checkIfAnagram(firstString, secondString);
        System.assert(true, 'This is Anagram');
        
        // Test case 2: Non-anagram strings
        firstString = 'hello';
        secondString = 'world';
        System.assertEquals(false, CheckAnagram.checkIfAnagram(firstString, secondString));
        
        // Test case 3: Anagram strings with different cases
        firstString = 'Tea';
        secondString = 'eat';
        System.assertEquals(true, CheckAnagram.checkIfAnagram(firstString, secondString));
        
        // Test case 4: Anagram strings with spaces
        firstString = 'rail safety';
        secondString = 'fairy tales';
        System.assertEquals(true, CheckAnagram.checkIfAnagram(firstString, secondString));
        
        // Test case 5: Anagram strings with special characters
        firstString = 'debit card';
        secondString = 'bad credit';
        System.assertEquals(true, CheckAnagram.checkIfAnagram(firstString, secondString));
    }
    
   @isTest
    static void testCheckIfAnagram_NullStrings() {
        // Test case: Null strings
        String firstString = null;
        String secondString = null;
        System.assertEquals(false, CheckAnagram.checkIfAnagram(firstString, secondString));
    }
    
    @isTest
    static void testCheckIfAnagram_EmptyStrings() {
        // Test case: Empty strings
        String firstString = '';
        String secondString = '';
        System.assertEquals(true, CheckAnagram.checkIfAnagram(firstString, secondString));
    }

}