/* *
   * Purpose       :     This trigger is created to automate the child records of Opportunity.
   * Created By    :     Komal Kumawat
   * Created On    :     1/08/2022
   * Version Logs  :     V_1.0
*/
trigger OpportunityTrigger on Opportunity (after insert, after update) {
    if(trigger.isAfter)
    {
        if(trigger.isInsert || trigger.isUpdate)
        {
            OpportunityTriggerHandler.insertAutomobileRecords(trigger.new, trigger.oldMap);
        }    
    }

}