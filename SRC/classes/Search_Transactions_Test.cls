/**
*  Description     : This test class is created to test fuctionality of Search Transactions Controller on vf page . 
*
*  Created By      : Komal Kumawat
*
*  Created Date    : 20 October 2022
*  
*  Revision Log    : V+1.0 : 
*  
**/

@isTest(seeAllData = false)
private class Search_Transactions_Test {
    @testSetup
    private static void testData() {
        List<Contact> listOfContact = new List<Contact>();
        Contact con = new Contact();
        con.LastName = 'Vijay Kumar';
        con.Contact_Status__c = 'Active';
        con.Email = 'vijaykumar@gmail.com';
        listOfContact.add(con); 
        insert listOfContact;
    }
    @isTest
    public static void testContact(){
        List<Contact> listOfConId = new List<Contact>([SELECT Id,LastName FROM Contact WHERE  LastName = 'Vijay Kumar']);
        List<Transaction_Entry__c> listOfCreditEntry = new List<Transaction_Entry__c>();
        Transaction_Entry__c tran  =  new Transaction_Entry__c();
        tran.Contact__c = listOfConId[0].id;
        tran.Amount__c = 500;
        tran.Transaction_Date__c = system.today();
        tran.Type__c = 'Debit';
        tran.Status__c = 'Pending';
        insert tran;

        Search_Transaction_Controller searchVFTnx = new Search_Transaction_Controller();
        searchVFTnx.resetFilter();
        searchVFTnx.next();
        searchVFTnx.last();
        searchVFTnx.previous();
        searchVFTnx.selectTheOption();
        searchVFTnx.getStatus();

    }
}