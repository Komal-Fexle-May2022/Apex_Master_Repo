trigger Trigger_Transactions on Transaction_Entry__c (before insert, before update,after insert, after update) 
{
    //Check for trigger context
    if(Trigger.isAfter)
    {
        //check for trigger event
        if(Trigger.isInsert || Trigger.isUpdate)
        {
            //Helper class method
            Transaction_Trigger_Helper.transactionLimitValidation(Trigger.new);
            
        }
    }
    
    //Check for trigger context
    if(Trigger.isAfter)
    {
        //check for trigger event
        if(Trigger.isInsert || Trigger.isUpdate)
        {
            //Helper class method
            Transaction_Trigger_Helper.deductAndAddOfAvailableBalance(Trigger.new, Trigger.oldMap);
            
        }
    }

}