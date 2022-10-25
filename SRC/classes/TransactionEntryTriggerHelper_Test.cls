/**
*  Description     : Test class to test the functionality of TransactionTriggerHelper.
*
*  Created By      : Komal Kumawat
*
*  Created Date    : 20 October 2022
*  
*  Revision Log    : V_1.0 : 
*  
**/

@isTest(seeAllData = false)
private without sharing class TransactionEntryTriggerHelper_Test {
    @testSetup
    private static void testData() {

        List<Transaction_Limit__c> listOfTnxLimit = new List<Transaction_Limit__c>();
       
        Transaction_Limit__c limitOfHDFCBank = new Transaction_Limit__c();
        limitOfHDFCBank.name = 'HDFC';
        limitOfHDFCBank.Maximum_Debit_Allowed_Per_Month__c = 90000;
        limitOfHDFCBank.Maximum_Transaction_Allowed_Per_Month__c = 50;
        limitOfHDFCBank.Maximum_Debit_Allowed_Per_Day__c = 3000;
        limitOfHDFCBank.Maximum_Transaction_Allowed_Per_Day__c = 2;
        limitOfHDFCBank.Maximum_Debit_Allowed_Per_Transaction__c = 1000;  
        listOfTnxLimit.add(limitOfHDFCBank);
       
        Transaction_Limit__c limitOfICICIBank = new Transaction_Limit__c();
        limitOfICICIBank.name = 'ICICI';
        limitOfICICIBank.Maximum_Debit_Allowed_Per_Month__c = 1000;
        limitOfICICIBank.Maximum_Transaction_Allowed_Per_Month__c = 2;
        limitOfICICIBank.Maximum_Debit_Allowed_Per_Day__c = 10000;
        limitOfICICIBank.Maximum_Transaction_Allowed_Per_Day__c = 22;
        limitOfICICIBank.Maximum_Debit_Allowed_Per_Transaction__c = 10000;      
        listOfTnxLimit.add(limitOfICICIBank);
        insert listOfTnxLimit;
       
       
        List<Contact> listOfContact = new List<Contact>();
        Contact conForHDFC = new Contact();
        conForHDFC.LastName = 'Smith';
        conForHDFC.Contact_Status__c = 'Active';
        conForHDFC.Available_Balance__c = 30000;
        conForHDFC.Email = 'test@test.com';
        conForHDFC.Transaction_Limit__c = listOfTnxLimit[0].Id;
        listOfContact.add(conForHDFC);
       
        Contact conForICICI = new Contact();
        conForICICI.LastName = 'John';
        conForICICI.Contact_Status__c = 'Active';
        conForHDFC.Available_Balance__c = 30000;
        conForICICI.Email = 'test@test.com';
        conForICICI.Transaction_Limit__c = listOfTnxLimit[1].Id;
        listOfContact.add(conForICICI);
       
        //Test.startTest();              
        insert listOfContact;
        //Test.stopTest();
    }
   
   
   
   
    @isTest
    public static void testTransactionEntryForCreditDebitForHDFC(){

        List<Contact> listOfConId = new List<Contact>([Select Id From Contact Where LastName = 'Smith']);
        List<Transaction_Entry__c> creditEntryList =new List<Transaction_Entry__c>();

        Transaction_Entry__c creditEntry = new Transaction_Entry__c();
        creditEntry.Amount__c = 5000;
        creditEntry.Type__c = 'Debit';
        creditEntry.Status__c = 'Completed';
        creditEntry.Contact__c = listOfConId[0].id;
        creditEntry.Transaction_Date__c = System.today();
        try {
            insert creditEntry;
        } catch(Exception ex) {}

        Transaction_Entry__c creditEntry1 = new Transaction_Entry__c();
        creditEntry1.Amount__c = 250;
        creditEntry1.Type__c = 'Debit';
        creditEntry1.Status__c = 'Completed';
        creditEntry1.Contact__c = listOfConId[0].id;
        creditEntry1.Transaction_Date__c = Date.today();
        try {
            insert creditEntry;
        } catch(Exception ex) {}

        creditEntry = new Transaction_Entry__c();
        creditEntry.Amount__c = 1000;
        creditEntry.Type__c = 'Debit';
        creditEntry.Status__c = 'Completed';
        creditEntry.Contact__c = listOfConId[0].id;
        creditEntry.Transaction_Date__c = System.today(); 
        try {
            insert creditEntry;
        } catch(Exception ex) {
        }
               
    }
    
    @isTest
    public static void testTransactionEntryForCreditDebitForICICI(){

        List<Contact> listOfConId = new List<Contact>([Select Id From Contact Where LastName = 'John']);
       
        Transaction_Entry__c creditEntry2 = new Transaction_Entry__c();
        creditEntry2.Amount__c = 5000;
        creditEntry2.Type__c = 'Debit';
        creditEntry2.status__c = 'Completed';
        creditEntry2.contact__c = listOfConId[0].id;
        creditEntry2.Transaction_Date__c = System.today();
        try {
            insert creditEntry2;
        } catch(Exception ex) {}

        Transaction_Entry__c creditEntry = new Transaction_Entry__c();
        creditEntry.Amount__c = 250;
        creditEntry.Type__c = 'Debit';
        creditEntry.Status__c = 'Completed';
        creditEntry.Contact__c = listOfConId[0].id;
        creditEntry.Transaction_Date__c = System.today();
        try {
            insert creditEntry;
        } catch(Exception ex) {}

        Transaction_Entry__c creditEntry3 = new Transaction_Entry__c();
        creditEntry3.Amount__c = 1000;
        creditEntry3.Type__c = 'Debit';
        creditEntry3.Status__c = 'Completed';
        creditEntry3.Contact__c = listOfConId[0].id;
        creditEntry3.Transaction_Date__c = System.today();
        try {
            insert creditEntry;
        } catch(Exception ex) {}
       
    
        List<Contact> listOfCon = [Select Id, LastName, Available_Balance__c From Contact Where id = : listOfConId[0].id];
        System.assertEquals(null, listOfCon[0].Available_Balance__c);        
    }
}