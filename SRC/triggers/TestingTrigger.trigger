/*
 * Purpose        :    This trigger is created for testing trigger events and context variable example on account object.
 * Created By     :    Komal Kumawat
 * Created On     :    23/07/2022
 * Version Logs   :    V_1.0
*/

trigger TestingTrigger on Account (before insert, before update, before delete, after insert, after update, after delete) 
    {
        Account newTrigger = Trigger.new[0];
        if(trigger.isBefore)
        {
            if(trigger.isInsert)
            {
                System.debug('I am before Insert');
                newTrigger.NumberOfEmployees = 13340;
                System.debug('Check  Before Insert List ::: Trigger.New ' + Trigger.New);
                System.debug('Check  Before Insert List ::: Trigger.old ' + Trigger.old);
            }
            else if(trigger.isUpdate)
            {
                System.debug('I am before Update');
                System.debug('Check Before Update List ::: Trigger.New ' + Trigger.New);
                System.debug('Check Before Update List ::: Trigger.old ' + Trigger.old);

                if(Trigger.New[0].Type != Trigger.old[0].Type)
                { 
                    System.debug('Type Value Changed');
                    System.debug('Trigger.New Data' + Trigger.New[0].Type);
                    System.debug('Trigger.old Data' + Trigger.old[0].Type);
                }
            }
            else if(trigger.isdelete)
            {
                System.debug('I am before delete');
                System.debug('Check Before delete List ::: Trigger.New ' + Trigger.New);
                System.debug('Check Before delete List ::: Trigger.old ' + Trigger.old);
            }
        }
    
        else if (trigger.isAfter)
        {
            if(trigger.isInsert)
            {
                System.debug('I am after Insert');
                /* This statement will give runtime error because trigger.new is not allowed in after Insert  
                 newTrigger.NumberOfEmployees = 3456; */
                System.debug('Check  After Insert List ::: Trigger.New ' + Trigger.New);
                System.debug('Check  After Insert List ::: Trigger.old ' + Trigger.old);
            }
            else if(trigger.isUpdate)
            {
                System.debug('I am after Update');
                System.debug('Check After Update List ::: Trigger.New ' + Trigger.New);
                System.debug('Check After Update List ::: Trigger.old ' + Trigger.old);
            }
            else if(trigger.isdelete)
            {
                System.debug('I am after delete');
                System.debug('Check After delete List ::: Trigger.New ' + Trigger.New);
                System.debug('Check After delete List ::: Trigger.old ' + Trigger.old);
            }
            else if(trigger.isUndelete)
            {
                System.debug('I am after undelete');
                System.debug('Check After Undelete List ::: Trigger.New ' + Trigger.New);
                System.debug('Check After Undelete List ::: Trigger.old ' + Trigger.old);
            }
        }

        System.debug('Total number of Accounts old and new---' + Trigger.Size);
    }