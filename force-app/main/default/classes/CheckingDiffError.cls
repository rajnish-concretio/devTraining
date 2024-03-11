public class CheckingDiffError {
    public static void getErrorMsg(){
        for(Integer index = 1; index<=153; index++ ){
            Account objAcc = new Account();
            objAcc.Name = 'Test' +index;
            insert objAcc;
        }
    }

}