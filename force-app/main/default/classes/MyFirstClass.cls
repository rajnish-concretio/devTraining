public with sharing class MyFirstClass {
    public static void debugPrinter(List<String> accName){
        System.debug('Trying first to print something');
        List<Account> lstAcc = [Select id,Description, Name from Account where Name In : accName];
        for(Account newAcc : lstAcc){
            System.debug(newAcc);
        }
        
    }
		
}