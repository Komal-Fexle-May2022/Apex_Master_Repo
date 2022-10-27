public with sharing class TransactionGenerator {

    @AuraEnabled(cacheable = true)
    public static List<Transaction_Entry__c> getStatement(Id recordIdOfContact, 
                                                          String statementStartDate, 
                                                          String statementEndDate)
    {
            Date startDate = date.valueOf(statementStartDate);
            Date endDate = date.valueOf(statementEndDate);

            Integer diff = startDate.month() - endDate.month();
            System.debug('diff : ' + diff);
            System.debug('recordId' + recordIdOfContact);
            System.debug('statementStartDate :' + statementStartDate);
            System.debug('statementEndDate : ' + statementEndDate);
        	System.debug('id is ' + recordIdOfContact);
        
            //transaction_Entry_List to hold Transaction Entries
            List<Transaction_Entry__c> transaction_Entry_List = [SELECT Name, Amount__c, Transaction_Date__c, Type__c, Status__c FROM Transaction_Entry__c WHERE Transaction_Date__c >=: startDate AND Transaction_Date__c <=: endDate AND Contact__c=:recordIdOfContact]; 

            //6 Months approx 180 days

            /*if((diff <= 6) && (diff> 0))
            {
                System.debug('Inside diff one');
                transaction_Entry_List = [SELECT Name, Amount__c, Transaction_Date__c, Type__c, Status__c FROM Transaction_Entry__c WHERE Transaction_Date__c >=: startDate AND Transaction_Date__c <=: endDate AND Contact__c=:recordIdOfContact];

            }*/
            
            //Return List
            System.debug(transaction_Entry_List);
            return transaction_Entry_List;    
    }


    @AuraEnabled
    public static void sendEmail(Id recordIdOfContact)
	{
        //Setting page reference
        PageReference statementPDFRef = new PageReference('/apex/Pdf_Generator');

        //putting value to page 
        statementPDFRef.getParameters().put('id', recordIdOfContact);
        

        //To hold pdf body
        Blob bodyOfPDF;

        //For testing class
        if(Test.isRunningTest())
        {
            bodyOfPDF = blob.valueOf('Unit.Test');
        }
        else
        {
            //Content of pdf
            bodyOfPDF = statementPDFRef.getContent();
        }
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        //File attachment
        Messaging.EmailFileAttachment att = new Messaging.EmailFileAttachment();

        //Calling contact_obj for email body
        Contact contact_obj = [SELECT Id, Name, Email, Account_Number__c FROM Contact WHERE Id =: recordIdOfContact];

        //formating account number
        String accountNumberFormat = 'AccNo-XXX'+ contact_Obj.Account_Number__c.substringAfter('-').right(2);

        //set address
        email.setToAddresses(new String[] {contact_obj.Email});

        //set subject
        email.setSubject('Requested Bank Statement');
        
        //set HTML body
        email.setHtmlBody('Hello '+ contact_obj.Name + ', <br><br> As you have requested, Account statement for your account is attached below. ');
        
        //set attachment
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {att});

        //Defination of attachment
        att.setContentType('application/pdf');
        att.setFileName('Bank_Statement.pdf');
        att.setBody(bodyOfPDF);
        
        //send email
        Messaging.sendEmail(new messaging.SingleEmailMessage[] {email});
            
    }
}