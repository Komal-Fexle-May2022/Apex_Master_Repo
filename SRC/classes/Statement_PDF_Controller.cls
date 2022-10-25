/**
*  Description     : This class is created to control the PDF statement for statement lwc component.
*
*  Created By      : Komal Kumawat
*
*  Created Date    : 20 October 2022
*  
*  Revision Log    : V+1.0 : 
*  
**/

public with sharing class Statement_PDF_Controller {
    public List<Transaction_Entry__c> transaction_Entry_List {get;set;}
    public String startDateString {set;get;}
    public String endDateString {set;get;}
    public Contact contact_Obj{set;get;}
    
    //Constructor
    public Statement_PDF_Controller()
    {
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=BankStatement.pdf');
        
    }

    public void genratePDF()
    {
        
        Id recordIdOfContact = ApexPages.currentPage().getParameters().get('id');
        
        //SOQL
        Transaction_Entry_List = [SELECT Id, Name, Amount__c, Transaction_Date__c,
                                           Type__c, Status__c FROM Transaction_Entry__c WHERE 
                                           Contact__c =: recordIdOfContact];

        //Contact information for pdf body
        contact_Obj = [SELECT Id, Title, Name, Account_Number__c, Email FROM Contact WHERE Id =: recordIdOfContact];

    }
}