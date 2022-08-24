public class AccountTriggerHelper {
    /*public static Boolean ALLOW_ACCOUNT_CYCLIC_UPDATE = true;
    public static void processAccountData() {
        
        List<Account> accNewList = Trigger.New;
        List<Account> accList = new List<Account>();
        for(Account acc: accNewList)
        {
            //acc.Name = 'Rajeev Jain';
            accList.add(new Account(Id = acc.Id, Name = 'United Oil & Gas Corp.'));
        }
        // This is Wrong beacuse you cannot perform DML operation on Trigger.New and Trigger.Old because they are read only.
        ALLOW_ACCOUNT_CYCLIC_UPDATE = false;
        update accList;
    }*/
    public static void processUpdateAccountData(){
        List<Account> newList = Trigger.New;
        List<Account> oldList = Trigger.Old;
        List<Opportunity> opportunities = [Select Id, Name, Amount From Opportunity Where AccountId IN: newList];
        Set<Id> accountIds = new Set<Id>();
        
        for(Opportunity opp: opportunities)
        {
            if(opp.Amount>100)
            {
                accountIds.add(opp.AccountId);
            }
        }
        
        //Required Field Validations
        Integer count = 0;
        for(Account accts :newList)
        {
            if(accts.Phone == '' && oldList[count].Phone != '')
            {
                accts.addError('You cannot blank Phone Number');
            }
            if(accts.AnnualRevenue != oldList[count].AnnualRevenue && accts.AnnualRevenue > 100)
            {
                accts.Discount_Percentage__c = 50;
            }
            if(accountIds.contains(accts.Id))
            {
                accts.Type = 'Installation Partner';
            }
        }
    }
}