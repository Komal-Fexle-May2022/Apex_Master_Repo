/**
  * Purpose         :     This Trigger is created to automate the total number of contacts field in Account when insert, delete or update.
  * Created By      :      Komal Kumawat
  * Created On      :      27/07/2022
  * Version Logs    :      V_1.0
  * Modification    :      To handle the status of the Parent object Account and Property.
                           V_1.1   Created By Komal Kumawat on 16/08/2022.
*/

trigger ContactTrigger on Contact (after insert, after update, after delete)
{
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            ContactTriggerHelper.populateAccountStatus(Trigger.new);
        }
    }
    
    if(trigger.isAfter)
    {
        if(trigger.isInsert)
        {
            ContactTriggerHandler.populateTotalNumberOfContacts(Trigger.new);
        }
        else if(trigger.isUpdate)
        {
            ContactTriggerHandler.populateTotalNumberOfContacts(Trigger.old);
        }
        else if(trigger.isdelete)
        {
            ContactTriggerHandler.populateTotalNumberOfContacts(Trigger.old);
        }
    }
}