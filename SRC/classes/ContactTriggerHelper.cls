/* *
   * Purpose       :     This class is created to change the Status of the contact field from Parent account and Grand parent Property Object.
   * Created By    :     Komal Kumawat
   * Created On    :     16/08/2022
   * Version Logs  :     V_1.0 
*/

public with sharing class ContactTriggerHelper {
    public static void populateAccountStatus(List<Contact> contactList) {

        Set<Id> setOfAccountId = new Set<Id>();
        List<Account> acctList = new List<Account>();
        // Insert or Update case
        if(contactList != null){
            for(Contact cont : contactList){
                if(cont.Status__c == null){
                    setOfAccountId.add(cont.AccountId);     
                }      
            }
        }
        Map<Id, Account> acctMap = new Map<Id, Account> ([Select Id, Status__c, Property__r.Status__c From Account Where Id In: setOfAccountId]);    
        for(Contact contacts : contactList)
        {
            if(contacts.Status__c == Null)
            {
                Account acct = new Account();
                acct = acctMap.get(contacts.AccountId);
                if(acct.Status__c != null)
                {
                    contacts.Status__c = acct.Status__c;
                }
                if(acct.Status__c == Null)
                {
                    if(acct.Property__r.Status__c != null)
                    {
                        contacts.Status__c = acct.Property__r.Status__c;
                        acctList.add(acct);
                    }
                }
            }
        }  
        if(acctList != null)
        {
            update acctList;
        }  
    }
}