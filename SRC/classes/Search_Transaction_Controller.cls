/**
*  Description     : This class is created to control the vf page search transaction controller class..
*
*  Created By      : Komal Kumawat
*
*  Created Date    : 20 October 2022
*  
*  Revision Log    : V+1.0 : 
*  
**/

public class Search_Transaction_Controller {
    public String selectedMain                                                              {get; set;}
    public Boolean bottomPanel                                                              {get; set;}
    public Boolean tableView                                                                {get; set;}
    public Integer selectedamountStart                                                      {get; set;}
    public Integer selectedamountEnd                                                        {get; set;}
    public Date selecteddateFrom                                                            {get; set;}
    public Date selecteddateTo                                                              {get; set;}
    public String selectedEntryName                                                         {get; set;}
    public String selectedstatus                                                            {get; set;}
    public String selectedAccountNumber                                                     {get; set;}
    public List<TransactionWrapper> transactionWrapperList                                  {get; set;}
    public Integer pageNumber                                                               {get; set;}
    public String recLimit                                                                  {get; set;}
    public Integer totalCount                                                               {get; set;}
    public String lastId                                                                    {get; set;}
    public String lastRecordId                                                              {get; set;}
    public String firstRecordId                                                             {get; set;}
    public String firstId                                                                   {get; set;}
    public String direction                                                                 {get; set;}
    private DateTime lastRecordCreatedDate;
    private DateTime firstRecordCreatedDate;

    public Search_Transaction_Controller() {
        transactionWrapperList = new List<TransactionWrapper>();
        recLimit = '10';
        bottomPanel = false;
        tableView = false;
        totalCount = 0;
        pageNumber = 1;
        selectedMain = '';
        selectedamountStart = 0;
        selectedamountEnd   = 0;
        selecteddateFrom = null;
        selecteddateTo   = null;
        selectedEntryName    = '';
        selectedstatus       = '';
        selectedAccountNumber= '';
        // first();
    }
    public void resetFilter() {
        selectedMain = '';
        selectedamountStart = 0;
        selectedamountEnd   = 0;
        selecteddateFrom = null;
        selecteddateTo   = null;
        selectedEntryName    = '';
        selectedstatus       = '';
        selectedAccountNumber= '';
        first();
    }
    public void first() {
        bottomPanel = true;
        tableView = true;
        firstId = '';
        lastId = '';
        firstRecordCreatedDate = null;
        lastRecordCreatedDate = null;
        firstRecordId = '';
        lastRecordId = '';
        retrievedefault('first');
    }
    public void next() {
        retrievedefault('next');
    }
    public void last() {
        retrievedefault('last');
    }
    public void previous() {
        retrievedefault('previous');
    }
    public void selectTheOption() {
        transactionWrapperList = new List<TransactionWrapper>();
        bottomPanel = false;
        tableView = false;
    }
    public String transactionQuery() {
        String query = 'SELECT Id,Name,CreatedDate, Amount__c, Status__c, Transaction_Date__c, Type__c, Contact__r.Name,Contact__r.Account_Number__c FROM Transaction_Entry__c WHERE Id != null  ';
        System.debug('selectedamountStart : ' + selectedamountStart);
         System.debug('query1 : ' + query);
        if (selectedamountStart != 0 && selectedamountStart != null ) {
             System.debug('selectedamountStart2 : ' + selectedamountStart);
            query += ' And Amount__c > : selectedamountStart ';
        }
        System.debug('query2 : ' + query);
        if (selectedamountEnd != 0 && selectedamountEnd != null ) {
            query += ' And Amount__c < : selectedamountEnd ';
        }
        if (selecteddateFrom != null ) {
            query += ' And Transaction_Date__c >: selecteddateFrom ';
        }
        if (selecteddateTo != null ) {
            query += ' And Transaction_Date__c <: selecteddateTo ';
        }
        if (selectedEntryName != '' &&  selectedEntryName != null) {
            selectedEntryName =  selectedEntryName.trim();
            query += ' And Name LIKE \'%' + String.escapeSingleQuotes(selectedEntryName)  + '%\''; 
        }
        if (selectedstatus != '' &&  selectedstatus != null && selectedstatus != 'All') {
            query += ' And Status__c =:selectedstatus ';
        }
        if (selectedAccountNumber != '' && selectedAccountNumber != null) {
            selectedAccountNumber =  selectedAccountNumber.trim();
            query += ' And Contact__r.Account_Number__c LIKE \'%' + String.escapeSingleQuotes(selectedAccountNumber)  + '%\''; 
        }
        System.debug('query' + query);
        return query;
    }
    public String transactionCountQuery() {
        String query = 'SELECT Count() FROM Transaction_Entry__c WHERE Id != null ';
        if (selectedamountStart != 0 && selectedamountStart != null ) {
            query += ' And Amount__c >: selectedamountStart ';
        }
        if (selectedamountEnd != 0 && selectedamountEnd != null ) {
            query += ' And Amount__c <: selectedamountEnd ';
        }
        if (selecteddateFrom != null ) {
            query += ' And Transaction_Date__c >: selecteddateFrom ';
        }
        if (selecteddateTo != null ) {
            query += ' And Transaction_Date__c <: selecteddateTo ';
        }
        if (selectedEntryName != '' &&  selectedEntryName != null) {
            selectedEntryName =  selectedEntryName.trim();
            query += ' And Name LIKE \'%' + String.escapeSingleQuotes(selectedEntryName)  + '%\''; 
        }
        if (selectedstatus != '' &&  selectedstatus != null && selectedstatus != 'All') {
            query += ' And Status__c =:selectedstatus ';
        }
        if (selectedAccountNumber != '' && selectedAccountNumber != null) {
            selectedAccountNumber =  selectedAccountNumber.trim();
            query += ' And Contact__r.Account_Number__c LIKE \'%' + String.escapeSingleQuotes(selectedAccountNumber)  + '%\''; 
        }
        return query;
    }
    public void retrievedefault(String direction) {
        transactionWrapperList = new List<TransactionWrapper>();
        Integer recordLimit = Integer.valueOf(recLimit);
        String query = transactionQuery();
        System.debug('query Check' + query);
        String countQuery = transactionCountQuery();
        totalCount = Database.countQuery(countQuery);
        if(String.isBlank(lastRecordId)) {
            List<Sobject> sobList = Database.query(query + ' ORDER BY CreatedDate ASC, Id ASC LIMIT 1');
            if(sobList.size() > 0) {
                lastRecordId = sobList[0].Id;
            }
        }
        direction = String.isBlank(direction) ? 'first' : direction;
        if(direction == 'first' || (direction == 'previous' && (pageNumber == 0 || pageNumber == 1))) {
            pageNumber = 1;
            query += ' ORDER BY CreatedDate DESC, Id DESC LIMIT ' + recordLimit;
        } else if(direction == 'previous') {
            pageNumber--;             
                query += ' AND (( Id >: firstId AND CreatedDate =: firstRecordCreatedDate) OR (CreatedDate >: firstRecordCreatedDate)) ORDER BY CreatedDate ASC, Id ASC LIMIT ' + recordLimit;
        } else if(direction == 'next') {
             pageNumber++;
                query += ' AND (( Id <: lastId AND CreatedDate =: lastRecordCreatedDate) OR (CreatedDate <: lastRecordCreatedDate)) ORDER BY CreatedDate DESC, Id DESC LIMIT ' + recordLimit;
        } else if(direction == 'last') {
            pageNumber = Integer.valueOf(Math.ceil(totalCount * 1.0/recordLimit));
            if(Math.mod(totalCount,recordLimit) == 0) {
                query += ' ORDER BY CreatedDate ASC, Id ASC LIMIT ' + recordLimit;
            } else {
                query += ' ORDER BY CreatedDate ASC, Id ASC LIMIT ' + Math.mod(totalCount,recordLimit);
            }
        }
        for(Transaction_Entry__c record : Database.query(query)) {
            transactionWrapperList.add(new TransactionWrapper(record));
        }
        System.debug('transactionWrapperList = : ' + transactionWrapperList);
        if(transactionWrapperList.size() > 0) {
            firstId = transactionWrapperList[0].Id;
            lastId = transactionWrapperList[transactionWrapperList.size() -1].Id;
            firstRecordCreatedDate = transactionWrapperList[0].transactionCreatedDate;
            lastRecordCreatedDate = transactionWrapperList[transactionWrapperList.size() -1].transactionCreatedDate;
        } else {
            firstId = '';
            lastId = '';
            firstRecordCreatedDate = null;
            lastRecordCreatedDate = null;
        }
        if(String.isBlank(firstRecordId)) {
            firstRecordId = firstId;
        }
    }
    public class TransactionWrapper {
        public String Id                                          {get; set;}
        public Decimal Amount                                     {get; set;}
        public String Contact_Name                                {get; set;}
        public String status                                      {get; set;}
        public Date transactionDate                               {get; set;}
        public String Name                                        {get; set;}    
        public String Type                                        {get; set;} 
        public DateTime transactionCreatedDate                    {get; set;}
        public String AccountNumber                              {get; set;}
        public TransactionWrapper(Transaction_Entry__c record) {
            Id = record.Id;
            Amount = record.Amount__c;
            Contact_Name = record.Contact__r.Name;
            status = record.Status__c;
            transactionDate = record.Transaction_Date__c;
            Name = record.Name;
            Type = record.Type__c;
            AccountNumber = record.Contact__r.Account_Number__c;
            transactionCreatedDate = record.CreatedDate;
       }
    }
    public List < SelectOption > getStatus() {
        List < selectOption > statusList = new List < Selectoption > ();
        Schema.DescribeFieldResult fieldResult = Transaction_Entry__c.Status__c.getDescribe();
        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();
        statusList.add(new SelectOption('All', 'All'));
        for (Schema.PicklistEntry f: ple) {
            statusList.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        return statusList;
    }
    
}