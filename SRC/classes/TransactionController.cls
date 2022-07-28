/* 
 * Purpose      :    This class is created to understand the concept of transaction control.
 * Created By   :    Komal Kumawat
 * Created On   :    23/07/2022
 * Version Logs :    V_1.0
*/

public class TransactionController 
{
    public TransactionController()
    {
        // Saving the state of Database
        Savepoint sp = Database.setSavepoint();
        try
        {
            Opportunity oppObj = [Select Name, AccountId, Amount, OwnerId 
                                  From Opportunity
                                  Where Name LIKE 'Sell Pro%' LIMIT 1];
            
            // Calculating Commission of the Agent.
            Decimal agentCommission= oppObj.Amount * 0.20;
            // Updating the Amount of the Opportunity.
            oppObj.Amount = oppObj.Amount + agentCommission;
            update oppObj;
            
            // Commission Object field changes.
            Commision__c commisionObj = new Commision__c();
            commisionObj.Commission_Amount__c = agentCommission;
            commisionObj.Agent__c = oppObj.OwnerId;

            // Account Object changes.
            Account accountObj = [Select Name From Account Where Id =: oppObj.AccountId];
            accountObj.Discount_Percentage__c = 20;
            update accountObj;
        }
        catch(Exception e)
        {
            System.debug('Exception Occured');
            Database.rollback(sp);
        }
    }
}