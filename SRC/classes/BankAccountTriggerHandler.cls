/*
 * Description        :       This class is created as handler class for trigger sending mail and generate account number.
 * Created By         :       Komal Kumawat
 * Created On         :       26/07/22
 * Version Logs       :       V_1.0
*/

public with sharing class BankAccountTriggerHandler
{
    // This method is created to generate account number with prefix.
    public static void accountNumberGenerate( List<Bank_Account__c> accountNumList)
    {
        //Random method to create random account number.
        Integer num1 = Integer.valueOf(Math.random());
        for(Bank_Account__c numList : accountNumList)
        {
            if(numList.Bank_Account_Type__c == 'Saving')
            {
                numList.Account_Number__c = 'SA-'+num1;
            }
            else if(numList.Bank_Account_Type__c == 'Current')
            {
                numList.Account_Number__c = 'CR-'+num1;
            }
            else if(numList.Bank_Account_Type__c == 'Salary')
            {
                numList.Account_Number__c = 'SL-'+num1;
            }
            else if(numList.Bank_Account_Type__c == 'Fixed Deposit')
            {
                numList.Account_Number__c = 'FD-'+num1;
            }
            else if(numList.Bank_Account_Type__c == 'Recuring Deposit')
            {            
                numList.Account_Number__c = 'RD-'+num1;
            }
            else if(numList.Bank_Account_Type__c == 'NRI')
            {
                numList.Account_Number__c = 'NRI-'+num1;
            }
        }
    }

    // This method is created to send Email to Account holder for Account creation.
    public static void emailSendMessage(List<Bank_Account__c> bankAccEmailList)
    {
        List<Messaging.SingleEmailMessage> emailSendMsg = new List<Messaging.SingleEmailMessage>();
        for(Bank_Account__c bankAcct : bankAccEmailList)
        {
            List<String> emailAddress = new List<String>();
            Messaging.SingleEmailMessage emailObject = new Messaging.SingleEmailMessage();
            emailAddress.add(bankAcct.Email_Address__c);
            emailObject.setToAddresses(emailAddress);
            emailObject.setSubject('Congratulations your bank account has been Created!!');
            emailObject.setPlainTextBody('Dear '+bankAcct.Name+',\n\nYour'+bankAcct.Bank_Account_Type__c+' account with '
                                               + bankAcct.Bank_Name__c+' has been created. Your Account Number is '+bankAcct.Account_Number__c 
                                               + 'and your IFSC code is '+ bankAcct.IFSC_code__c+'\n\nThank You.');
            emailSendMsg.add(emailObject);                                   
        }
        Messaging.sendEmail(emailSendMsg);
    }
}