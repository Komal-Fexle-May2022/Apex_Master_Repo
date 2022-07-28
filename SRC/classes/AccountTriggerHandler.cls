/**
  * Purpose         :      Class is created to handle Account Trigger to delete opportunities when Account is Updated.
  * Created By      :      Komal Kumawat
  * Created On      :      27/07/2022
  * Version Logs    :      V_1.0
*/

public class AccountTriggerHandler 
{
    // Method to delete Opportunities with parameters
    public static void deleteAccountRelatedOpportunity(List<Account> accounts, Map<Id, Account> accountOldMap)
    {
        Set<Id> setOfAccountIds = new Set<Id>();
        List<Opportunity> listOfOppToBeDeleted = new List<Opportunity>();
        
        for(Account accountList :accounts != null ? accounts : accountOldMap.values())
        {
            setOfAccountIds.add(accountList.Id);
        }

        if(setOfAccountIds.size() > 0)
        {
            listOfOppToBeDeleted = [Select Id From Opportunity Where AccountId IN : setOfAccountIds];
            if(listOfOppToBeDeleted.size() > 0)
            {
                delete listOfOppToBeDeleted;
            }
        }
    }
}