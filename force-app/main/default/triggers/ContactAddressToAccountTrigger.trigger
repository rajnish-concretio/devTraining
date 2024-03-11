/**
* @description       : Trigger to update Account Address with Contact Addess.
* @author            : Rajnish Kumar 
* @group             : Service
* @last modified on  : 08.02.2024
* @last modified by  : Rajnish Kumar 
* Modifications Log
* Ver   Date         Author     Modification
* 1.0   08.02.2024   Rajnish    Initial Version
**/
trigger ContactAddressToAccountTrigger on Contact (after insert, after update, after undelete) {
    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        ContactAddressToAccountHandler.updateAccountAddress(Trigger.new, Trigger.oldMap);
    }
}