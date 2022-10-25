/** 
*  Description     :  Schedule class for the Transaction_Entry__c to run batch 
                      Batch_Monthly_Transaction_On_Email every Month End
*
*  Created By      :  Komal Kumawat
*
*  Created Date    :  18 October 2022
*  
*  Revision Logs   :  V1.0 - Created
**/

global with sharing class Scheduler_For_Batch_Email implements Schedulable
{
    global void execute(SchedulableContext ctx) 
    {
        //Batch
        Batch_Monthly_Transaction_On_Email batchObject = new Batch_Monthly_Transaction_On_Email();
    
        Id batchId = Database.executeBatch(batchObject);
    }
}