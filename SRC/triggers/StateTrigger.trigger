/* *
   * Purpose      :     This Trigger is Created to automate the States Under Country.
   * Created By   :     Komal Kumawat
   * Created On   :     16/08/2022
   * Version Logs :     V_1.0
*/
trigger StateTrigger on States__c(after insert, after update, after delete) {
 
    if(trigger.isAfter)
    {
        if(trigger.isInsert || trigger.isUpdate || trigger.isdelete)
        {
            StateTriggerHandler.populateTotalNumberOfStatesOnCountry(Trigger.new, Trigger.old);
        }
    }
}