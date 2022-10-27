/**
*  Description     : Test class to test the functionality of Scheduler_For_Batch_Email
*
*  Created By      : Komal Kumawat
*
*  Created Date    : 20 October 2022
*  
*  Revision Log    : V+1.0 : 
*  
**/
@isTest(seeAllData = false)
private without sharing  class Test_Of_Scheduler_Batch_Email 
{
    //Test Setup
    @testSetup 
    static void setupTestData()
    {
        //Inserting Limit 
        Transaction_Limit__c transaction_Limit_Obj = new Transaction_Limit__c();
        
        transaction_Limit_Obj.Name = 'Bank Limit';
        transaction_Limit_Obj.Maximum_Debit_Allowed_Per_Month__c = 10000;
        transaction_Limit_Obj.Maximum_Debit_Allowed_Per_Day__c = 3000;
        transaction_Limit_Obj.Maximum_Transaction_Allowed_Per_Month__c = 100;
        transaction_Limit_Obj.Maximum_Transaction_Allowed_Per_Day__c = 10;
        transaction_Limit_Obj.Maximum_Debit_Allowed_Per_Transaction__c =1000;
        
        insert transaction_Limit_Obj;
        System.debug('transaction_Limit_Obj : ' + transaction_Limit_Obj);

        //to insert Contact
        List<Contact> contactList = new List<Contact>();
        
        //to insert Transaction
        List<Transaction_Entry__c> transaction_Entry_List = new List<Transaction_Entry__c>();

        //3 Active Contact
        for(Integer i = 1; i <= 3 ; i++)
        {
            //Adding Contact
            contactList.add( new Contact(FirstName = 'Con ', LastName = i+'Test', Email = i+'komalkumawatsalesforce@gmail.com'+ i+'Test.apxc',Transaction_Limit__c = transaction_Limit_Obj.Id, Available_Balance__c = 20000, Contact_Status__c = 'Active' ));
        }
        
        //Insert ContactList
        insert contactList;
        System.debug('Contact inserted : ' + contactList);

        //adding 3 transaction per contact
        for(Contact contact_Obj : contactList)
        {
            //system.debug(contact_Obj);
            for(Integer i = 1; i <= 3 ; i++)
            {
                transaction_Entry_List.add(new Transaction_Entry__c(Amount__c = 100, type__c = 'Debit', Status__c = 'Completed', Contact__c = contact_Obj.Id, Transaction_Date__c = System.today()));
            }
        }

        //Insert Transaction
        insert transaction_Entry_List;
        System.debug('transaction_Entry_List : ' + transaction_Entry_List);
    }

    @isTest
    public static void emailTest()
    {
         
        //Cron Exp
        DateTime systemTime = dateTime.now().addSeconds(1);
        
        String cron_exp = '' + (systemTime.second()) + ' ' + systemTime.minute() + ' ' + systemTime.hour() + ' ' + systemTime.day() + ' ' + systemTime.month() + ' ? ' + systemTime.year();
        
        System.debug('cron_exp -- >' +cron_exp);
        Test.startTest();
        
        Scheduler_For_Batch_Email sch = new Scheduler_For_Batch_Email();
   
        String jobID = System.Schedule('Schedules_Email', cron_Exp, sch);
        
        Integer invocations = Limits.getEmailInvocations();
        
        //Stop Test
        Test.stopTest();

        //Assert of Mail
        //System.assertEquals(3,invocations);
    }

}