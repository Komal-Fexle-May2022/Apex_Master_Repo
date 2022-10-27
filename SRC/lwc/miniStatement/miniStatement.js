import { LightningElement, track, api } from 'lwc';
import getTransactionData from '@salesforce/apex/TransactionController.getTransactionData';

export default class MiniStatement extends LightningElement {
    @api recordId;
    @api transactionLimit = '0';
    @track dataList;

    get options(){
        return [
            {label: '5', value: '5'},
            {label: '10', value: '10'},
            {label: '15', value: '20'},
            {label: '20', value: '20'},
            {label: '25', value: '25'}
        ];
    }

    @track columns = [
        {label: 'Name', fieldName: 'redurl', type: 'url', typeAttributes: { label: { fieldName: 'Name' }, target: '_blank'} },
        // {label: 'Id', fieldName: 'Id'},
        {label: 'Amount', fieldName: 'Amount__c'},
        // {label: 'Contact', fieldName: 'Contact__c'},
        {label: 'Status', fieldName: 'Status__c'},
        {label: 'Type', fieldName: 'Type__c'},
        {label: 'Date', fieldName: 'Transaction_Date__c'},
        //{label: 'Available Balance', fieldName: 'Contact_r.Available_Balance_c'}
    ];

    handlevalue(event){
        this.transactionLimit = event.target.value;
        getTransactionData({transLimit : this.transactionLimit, recordId : this.recordId})
        .then(result => {
            // this.dataList = result;
            let tempRecs = [];
            result.forEach( ( record ) => {
                let tempRec = Object.assign( {}, record );  
                tempRec.redurl = '/' + tempRec.Id;
                tempRecs.push( tempRec );
                
            });
            this.dataList = tempRecs;

            // console.log(result);
        })
        .catch(error => {
            console.log(error);
        })
    }

    actionClose(){
        this.dispatchEvent(new actionOfClose());
    }

    actionClose(event){
        var url = window.location.href;
        var value = url.substr(0,url.lastIndexOf('/')+1);
        window.history.back();
        return false;
    }
}