public with sharing class Transaction_Trigger_Helper {
    
    public static void transactionLimitValidation(List<Transaction_Entry__c> newTnxEntryList){
        if(newTnxEntryList.size()>0){
           Set<Id> setOfCOntactId = new Set<Id>();
            for(Transaction_Entry__c tnxEntry : newTnxEntryList){
                if(tnxEntry.Amount__c != null && tnxEntry.Contact__c != null){
                    setOfCOntactId.add(tnxEntry.Contact__c);
                }
            }
            System.debug('setOfCOntactId'+setOfCOntactId);

            Map<Id, TransactionEntryWrapper> contactAndTransactionLimitMap = new Map<Id, TransactionEntryWrapper>();
            // Map<Id, Integer>         = new Map<Id,Integer>();
            if(!setOfCOntactId.isEmpty()){
                for(Contact con : [SELECT Id, Account_Number__c,Contact_Status__c,
                                    Transaction_Limit__r.Maximum_Debit_Allowed_Per_Day__c,
                                    Transaction_Limit__r.Maximum_Debit_Allowed_Per_Month__c,
                                    Transaction_Limit__r.Maximum_Transaction_Allowed_Per_Day__c,
                                    Transaction_Limit__r.Maximum_Transaction_Allowed_Per_Month__c,
                                        (SELECT Id, Amount__c,Status__c,Transaction_Date__c,Contact__c,Type__c 
                                        FROM Transaction_Entries__r 
                                        WHERE CALENDAR_MONTH(Transaction_Date__c) =: Date.today().month()
                                        AND Status__c = 'Completed' 
                                        AND Type__c = 'Debit')
                                    FROM Contact WHERE Id IN : setOfContactId 
                                    AND Transaction_Limit__c != null]){
                    TransactionEntryWrapper tnsEtryWrap = new TransactionEntryWrapper();

                    tnsEtryWrap.maximumTransactionsToday = con.Transaction_Limit__r.Maximum_Transaction_Allowed_Per_Day__c;
                    tnsEtryWrap.maximumTransactionsThisMonth = con.Transaction_Limit__r.Maximum_Transaction_Allowed_Per_Month__c;
                    tnsEtryWrap.maximumAmountDebitedToday = con.Transaction_Limit__r.Maximum_Debit_Allowed_Per_Day__c;
                    tnsEtryWrap.maximumAmountDebitedThisMonth = con.Transaction_Limit__r.Maximum_Debit_Allowed_Per_Month__c;

                    for(Transaction_Entry__c transactionEntry: con.Transaction_Entries__r){
                        if(transactionEntry.Transaction_Date__c == Date.today()) {
                            tnsEtryWrap.totalTransactionsToday += 1;
                            tnsEtryWrap.totalAmountDebitedToday += transactionEntry.Amount__c;
                        }
                        if(transactionEntry.Transaction_Date__c.month() == Date.today().month()) {
                            tnsEtryWrap.totalTransactionsThisMonth += 1;
                            tnsEtryWrap.totalAmountDebitedThisMonth += transactionEntry.Amount__c;
                        }
                    }
                    contactAndTransactionLimitMap.put(con.Id,tnsEtryWrap);
                }
                for(Transaction_Entry__c tnxEntry : newTnxEntryList){
                    if(setOfCOntactId.contains(tnxEntry.Contact__c) && contactAndTransactionLimitMap.containsKey(tnxEntry.Contact__c)){
                        TransactionEntryWrapper tnsEtryWrap = contactAndTransactionLimitMap.get(tnxEntry.Contact__c);
                        if(tnsEtryWrap.totalTransactionsToday >= tnsEtryWrap.maximumTransactionsToday) {
                            tnxEntry.addError('You have already reached the limit for maximum number of transaction per day.');
                        }
                        if(tnsEtryWrap.totalTransactionsThisMonth >= tnsEtryWrap.maximumTransactionsThisMonth) {
                            tnxEntry.addError('You have already reached the limit for maximum number of transaction per month.');
                        }
                        if(tnsEtryWrap.totalAmountDebitedToday >= tnsEtryWrap.maximumAmountDebitedToday) {
                            tnxEntry.addError('You have already reached the limit for maximum amount of transaction per day.');
                        }
                        if(tnsEtryWrap.totalAmountDebitedThisMonth >= tnsEtryWrap.maximumAmountDebitedThisMonth) {
                            tnxEntry.addError('You have already reached the limit for maximum amount of transaction per month.');
                        }
                    }
                }
            }
        }
    }

    public class TransactionEntryWrapper {
        public Decimal totalTransactionsToday;
        public Decimal totalTransactionsThisMonth;
        public Decimal totalAmountDebitedToday;
        public Decimal totalAmountDebitedThisMonth;
        public Decimal maximumTransactionsToday;
        public Decimal maximumTransactionsThisMonth;
        public Decimal maximumAmountDebitedToday;
        public Decimal maximumAmountDebitedThisMonth;

        public TransactionEntryWrapper() {
            totalTransactionsToday = 0;
            totalTransactionsThisMonth = 0;
            totalAmountDebitedToday = 0;
            totalAmountDebitedThisMonth = 0;
        }
    }
    /**   Description :   After Trigger Method Deduct And Add Of Available Balance
    *     Created By  :   Komal Kumawat
    *     Arguments   :   List
    *     Return      :   void
    *     Revision log:   V_1.0 - Created  - KomalKumawat - 10/10/2022
    */                    
    public static void deductAndAddOfAvailableBalance(List<Transaction_Entry__c> newTnxEntryList,Map<Id,Transaction_Entry__c> oldMapOfTnxEntry){
       
        if(newTnxEntryList.size() > 0){ 
            Set<Id> setOfContactId = new Set<Id>();
            for(Transaction_Entry__c tnxEntryOfConId : newTnxEntryList) {

                if(tnxEntryOfConId.Contact__c != null && (oldMapOfTnxEntry == null || tnxEntryOfConId.Status__c != oldMapOfTnxEntry.get(tnxEntryOfConId.Id).Status__c 
                            ||tnxEntryOfConId.Type__c != oldMapOfTnxEntry.get(tnxEntryOfConId.Id).Type__c )){
                    setOfContactId.add(tnxEntryOfConId.Contact__c);
                }
            }
            System.debug('++++====>>>>'+setOfContactId);
            Map<Id,Contact> mapOfContact = new Map<Id,Contact>([SELECT Id, Name, Account_Number__c,Contact_Status__c,Email, Available_Balance__c
                                                                FROM Contact WHERE Id IN : setOfContactId]);
            System.debug(mapOfContact);                                                   

            Map<Id,Contact> updateMapOfContact = new Map<Id,Contact>();
            for(Transaction_Entry__c tnxEntry :newTnxEntryList){
                if(mapOfContact.containskey(tnxEntry.Contact__c)){
                    if(mapOfContact.get(tnxEntry.Contact__c).Contact_Status__c == 'Active'){
                        Contact objContact = new Contact();
                        // it’s a debit entry, deduct the amount from the contact level Available Balance field
                        if((tnxEntry.Type__c == 'Debit' && tnxEntry.Status__c =='Completed' ) ||
                            (tnxEntry.Type__c == 'Debit' && tnxEntry.Status__c =='Cancelled')){
                            objContact.Id = tnxEntry.Contact__c;
                            objContact.Available_Balance__c = mapOfContact.get(tnxEntry.Contact__c).Available_Balance__c - tnxEntry.Amount__c;
                            updateMapOfContact.put(objContact.Id,objContact);
                        } 
                        //it’s a credit entry, add the amount on the contact level Available Balance field
                        else if( (tnxEntry.Type__c == 'Credit' && tnxEntry.Status__c =='Completed') ||
                            (tnxEntry.Type__c == 'Credit' && tnxEntry.Status__c =='Cancelled' )) {
                            objContact.Id = tnxEntry.Contact__c;
                            objContact.Available_Balance__c = mapOfContact.get(tnxEntry.Contact__c).Available_Balance__c + tnxEntry.Amount__c;
                            updateMapOfContact.put(objContact.Id,objContact);
                        }
                    }
                }
            }  
            System.debug('+++++++====>>>'+updateMapOfContact);
            if(!updateMapOfContact.isEmpty()){
                update updateMapOfContact.values();
            }
            sendMail(newtnxEntryList,mapofContact);
        }        
    }
    /**   Description :   Method Send Mail
    *     Created By  :   Komal Kumawat
    *     Arguments   :   List,Map
    *     Return      :   void
    *     Revision log:   V_1.0 - Created  - Komal Kumawat - 11/10/2022
    *                  
    **/
    public static void sendMail(List<Transaction_Entry__c> newtnxEntryList, Map<Id,Contact> mapofContact ){
        List<Messaging.SingleEmailMessage>  email = new List<Messaging.SingleEmailMessage>();
        for(Transaction_Entry__c tnxEntry : newtnxEntryList){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> sendToContact = new List<String>();
            sendToContact.add(mapofContact.get(tnxEntry.Contact__c).Email);
            mail.setToAddresses(sendToContact);
            mail.setSubject('Notification Form Bank');
            String body = '';
            body += 'Dear ' +mapOfContact.get(tnxEntry.Contact__c).Name;
            if(tnxEntry.Type__c.equals('Debit')){
                body += '<br>Your A/c ' + mapOfContact.get(tnxEntry.Contact__c).Account_Number__c + ' is Debited by Rs.'
                        +tnxEntry.Amount__c +' on '+tnxEntry.Transaction_Date__c +' Available Balance '+ mapOfContact.get(tnxEntry.Contact__c).Available_Balance__c+'.';
                body += '<br> Thank you';
            }else if(tnxEntry.Type__c.equals('Credit')){
                body += '<br>Your A/c ' + mapOfContact.get(tnxEntry.Contact__c).Account_Number__c + ' is Credited by Rs.'
                        +tnxEntry.Amount__c +' on '+tnxEntry.Transaction_Date__c +' Available Balance '+ mapOfContact.get(tnxEntry.Contact__c).Available_Balance__c+'.';
                body += '<br> Thank you';
            }
            mail.setHtmlBody(body);
            email.add(mail);
        }
        if(!email.isEmpty()){
            Messaging.sendEmail(email);
        }
    }
}