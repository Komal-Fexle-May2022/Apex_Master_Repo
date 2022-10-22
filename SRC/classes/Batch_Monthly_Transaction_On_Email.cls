/** 
*  Description     :  Batch class for the Transactio_Entry__c to Send Monthly Transaction 
                      Details On Email
*
*  Created By      :  Komal Kumawat
*
*  Created Date    :  18 October 2022
*  
*  Revision Logs   :  V1.0 - Created
**/

global with sharing class Batch_Monthly_Transaction_On_Email implements Database.Batchable<sObject>
{
    //Start
    global Database.QueryLocator start(Database.BatchableContext BC)
    {   
        //Query In String 
        String query = 'SELECT Id, Name, Email, Available_Balance__c, Account_Number__c, (SELECT Id, Name, Type__c, Amount__c, Transaction_Date__c, Status__c FROM Transaction_Entries__r ) FROM Contact WHERE Contact_Status__c = \'Active\'  AND Email != NULL';
        System.debug('Inside batch : ' + query);
        return Database.getQueryLocator(query);
    }

    //Execute
    global void execute(Database.BatchableContext BC, List<Contact> contactList)
    {
        //List To hold SingleEmailMessage
        List<Messaging.SingleEmailMessage> contactEmailList = new List<Messaging.SingleEmailMessage>();
        
        //For getting Month Name
        DateTime dt = Datetime.now();
        String monthName = dt.format('MMMM');
        
        if(contactList.size()>0)
        {
            //Loop over contactList
            for(Contact contact_Obj : contactList)
            {

                //List of Entries
                List<Transaction_Entry__c> listOfSingleContactEntry = contact_Obj.Transaction_Entries__r;
                
                //Email Variables
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                
                email.setSubject('Transaction details for ' + monthName +' month');

                List<String> toAddressesList = new List<String> {contact_Obj.Email};

                //Setting  Address 
                email.setToAddresses(toAddressesList);
            

                String style = 'padding: 5px;text-align: left;border: 1px solid black;border-collapse: collapse';
                
                //Html Body
                String htmlBody = '<p>Hii '+contact_Obj.Name +'</p>'+
                        '<p> <b>Your Available balance is '+ contact_Obj.Available_Balance__c+'</b></p><br>'+
                        '<table style="width:100%;border: 1px solid black;border-collapse: collapse">'+
                        '<tr style="border: 1px solid black;border-collapse: collapse">'+
                       
                        '<th style="'+ style +'"> TXN Entry_Name</th>'+
                        '<th style="'+ style +'"> TXN Date</th>'+
                        '<th style="'+ style +'"> TXN Amount</th>'+
                        '<th style="'+ style +'"> TXN Type</th>'+
                        '<th style="'+ style +'"> TXN Status</th>'+
                        '</tr>';
                        
                //Loop over listOfSingleContactEntry to fetch data    
                for(Transaction_Entry__c transaction_Entry_Obj : listOfSingleContactEntry)
                {

                        String dateInStringFormat = transaction_Entry_Obj.Transaction_Date__c.day() +' - ' + transaction_Entry_Obj.Transaction_Date__c.month() + ' - ' +transaction_Entry_Obj.Transaction_Date__c.year() ;

                        htmlBody +='<tr style="border: 1px solid black;border-collapse: collapse">'+
                        
                        '<td style="'+ style +'">'+ transaction_Entry_Obj.Name + '</td>' +
                        '<td style="'+ style +'">'+ dateInStringFormat + '</td>' +
                        '<td style="'+ style +'">'+ transaction_Entry_Obj.Amount__c + '</td>' +
                        '<td style="'+ style +'">'+ transaction_Entry_Obj.Type__c + '</td>' +
                        '<td style="'+ style +'">'+ transaction_Entry_Obj.Status__c+ '</td>' +
                        '</tr>';
                }

                htmlBody += '</table><br>';

                //Email Body Set
                email.setHtmlBody(htmlBody);

                contactEmailList.add(email);
                System.debug('Email is : ' +htmlBody );

            
           }
        }
        
        //Email Send
        if(contactEmailList.size()>0)
        {
            Messaging.sendEmail(contactEmailList);
        }
    
    }
    
    //Finish
    global void finish(Database.BatchableContext BC) 
    {

    }
}