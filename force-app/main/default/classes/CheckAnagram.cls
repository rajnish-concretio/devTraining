/**
* @description       : Checking String Values Are Anagram Or Not.
* @author            : Rajnish Kumar 
* @group             : Service
* @last modified on  : 07.02.2024
* @last modified by  : Rajnish Kumar 
* Modifications Log
* Ver   Date         Author     Modification
* 1.0   07.02.2024   Rajnish    Initial Version
**/

public class CheckAnagram {
    
    // Method to check if two strings are anagrams
    public static Boolean checkIfAnagram(String firstString, String secondString){
        
        // Initialize variable to store the result of anagram check
        boolean isAnagram = false;
        try{
            // Convert both strings to lowercase to ignore case sensitivity
        String str1AfterTrim = firstString.deleteWhitespace();
        String str2AfterTrim = secondString.deleteWhitespace();
        
        // Check if the lengths of both strings are equal
        if(str1AfterTrim.length() == str2AfterTrim.length()){
            
            // Create lists to hold characters of the two strings
            List<String> valueOne = str1AfterTrim.toLowerCase().split('');
            List<String> valueTwo = str2AfterTrim.toLowerCase().toLowerCase().split('');
            // Sort the characters in the lists
            valueOne.sort();
          	valueTwo.sort();
            
            // Check if the sorted lists are equal
            if(valueOne == valueTwo ){
                // If the sorted lists are equal, strings are anagrams
                isAnagram = true; 
            }
            
        }
            
        }catch(Exception error){
            System.debug('Error'+error.getMessage());
            return isAnagram; 
        }
        
        
        // Return the result of anagram check
        return isAnagram;
    }
    
}