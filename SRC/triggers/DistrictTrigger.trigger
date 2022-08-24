/* *
   * Purpose      :     This Trigger is Created to automate the Districts Under States.
   * Created By   :     Komal Kumawat
   * Created On   :     16/08/2022
   * Version Logs :     V_1.0
*/
trigger DistrictTrigger on Districts__c (after insert, after update, after delete) {

    if(trigger.isAfter)
    {
        if(trigger.isInsert || trigger.isUpdate || trigger.isdelete)
        {
            DistrictsTriggerHandler.populateTotalNumberOfDistrictsOnState(Trigger.new, Trigger.old);
        }
    }
}