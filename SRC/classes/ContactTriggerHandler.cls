/**
  * Purpose         :      Class is created to handle Contact Trigger to count total number of contacts in Account related for custom field.
  * Created By      :      Komal Kumawat
  * Created On      :      27/07/2022
  * Version Logs    :      V_1.0
*/
public with sharing class ContactTriggerHandler
{
    // Method to get total number of contacts.
    public static void populateTotalNumberOfContacts(List<Contact> contactList) 
    {
        Set<Id> setOfAccountIds= new Set<Id>();
        for(Contact cont : contactList)
        {
            if(contactList != null && cont.AccountId != null)
            {
                setOfAccountIds.add(cont.AccountId);
            }
        }

        // Account Logic to update Total_Number_Of_Contacts__c field when contact is insert, delete, update.
        List<Account> accounts = new List<Account>();
        Account accountObj = new Account();
        List<Account> accountsList = [Select Id, Name, Total_Number_Of_Contacts__c, 
                                      (Select Id From Contacts) 
                                       From Account Where Id In:setOfAccountIds];
        for(Account acct : accountsList)
        {
            accountObj.Id = acct.Id;
            accountObj.Total_Number_Of_Contacts__c = acct.Contacts.size();
            accounts.add(accountObj);
            
        }
        if(setOfAccountIds.size() > 0)
        {
            update accounts;
        }  
    }
}