/**
* @description       : Example of Wrapper class
* @author            : Rajnish Kumar 
* @group             : Service
* @last modified on  : 07.02.2024
* @last modified by  : Rajnish Kumar 
* Modifications Log
* Ver   Date         Author     Modification
* 1.0   07.02.2024   Rajnish    Initial Version
**/

public with sharing class ExampleWrapperClass {
    
    public String hospitalName;
    public String hospitalLocation;
    List<Doctor> lstDoctor = new List<Doctor>();
        
    public void addDoctor(String doctorName, Integer doctorAge, Decimal doctorSalary){
            Doctor objDoctor = new Doctor(doctorName, doctorAge, doctorSalary);
            lstDoctor.add(objDoctor);
            System.debug('A');
    }

    public void getDoctor(){
        System.debug('B');

        for(Doctor newDoctor : lstDoctor){
            System.debug('C');

            System.debug('Doctor Name : '+newDoctor.doctorName+' Age : '+newDoctor.doctorAge+' Salary is : '+
            newDoctor.doctorSalary);
        }
        System.debug('D');

    }
   
    private class Doctor{
        private String doctorName;
        private Integer doctorAge;
        private Decimal doctorSalary;
    
        Doctor(String doctorName, Integer doctorAge, Decimal doctorSalary){
            this.doctorName = doctorName;
            this.doctorAge = doctorAge;
            this.doctorSalary = doctorSalary;
        }
    }
}