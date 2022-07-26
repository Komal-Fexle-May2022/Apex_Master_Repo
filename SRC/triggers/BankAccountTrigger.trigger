/*
 * Purpose       :      This trigger is created to triiger the Bank Account System by generating account number and sending mail.
 * Created By    :      Komal Kumawat
 * Created On    :      26/07/2022
 * Version Logs  :      V_1.0
*/
trigger BankAccountTrigger on Bank_Account__c(before insert, after insert, before update) 
{
    if(trigger.isBefore)
    {
        if(trigger.isInsert)
        {
            BankAccountTriggerHandler.accountNumberGenerate(Trigger.new);
        }

        // To give error while updating account number after creation.
        else if(trigger.isUpdate)
        {
            for(Bank_Account__c newAcc: Trigger.new)
            {
                newAcc.Account_Number__c.addError('Account Number cannot be changed');
            }
        }
    }

    // Sending mail to Account holder using after trigger insert.
    else if(trigger.isAfter)
    {
        if(trigger.isInsert)
        {
            BankAccountTriggerHandler.emailSendMessage(Trigger.new);
        }
    }
}