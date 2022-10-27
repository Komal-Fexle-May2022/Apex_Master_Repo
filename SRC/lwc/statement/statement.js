import { LightningElement,api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getStatement from '@salesforce/apex/TransactionGenerator.getStatement';
import sendEmail from '@salesforce/apex/TransactionGenerator.sendEmail';
import pdflib from "@salesforce/resourceUrl/pdflib";
import { loadScript } from "lightning/platformResourceLoader";
import pdfcreator from '@salesforce/resourceUrl/pdfcreator';

const cols = [
    {label : 'Name' , fieldName: 'Name', type: 'text'},
    {label: 'Amount', fieldName: 'Amount__c', type : 'Currency'},
    {label: 'Status', fieldName : 'Status__c', type: 'text'},
    {label : 'Type', fieldName : 'Type__c', type:'text'},
    {label : 'Date', fieldName : 'TransactionDate__c', type: 'datetime'},
];

export default class Statement extends LightningElement {
    @api recordId;
    @api trans;
    @api startDate;
    @api endDate;
    
    @api transresult;
    @track error;
    @track data;
    @track columns = cols;
    diff;
    syear;
    eyear;
    smonth;
    emonth;
    
    


    handleStartChange(event){
      

        this.startDate = event.target.value;
        console.log('starting date is:' , this.startDate);
        console.log('record Id is ',this.recordId);
        
    }

    handleEndChange(event){
        this.endDate = event.target.value;
        console.log('ENding Date is : ', this.endDate);
        
    }



    
    handleShowStatement(event){
      
        this.trans = event.target.value;
        console.log('Method is getting called');
        


        getStatement({recordIdOfContact : this.recordId, statementStartDate : this.startDate, statementEndDate: this.endDate})
        .then(result => {
           /* this.transresult = result;
            console.log('result are ',this.transresult);*/
            var tempTrans = [];
            for(var i = 0;i<result.length;i++)
            {
                if(result[i].Name)
                {
                    tempTrans.push(result[i]);
                }

            }
            this.data = tempTrans;
            console.log(this.data);
            console.log(JSON.stringify(this.data));

        })
        .catch(error => {
            this.error = error;
            this.transresult = undefined;
        })


    }

    handlePdf(){
      let urlString = window.location.href;
      let urlWithParameters = urlString.substring(0, urlString.indexOf(".com/"));
      console.log(this.recordId);
      urlWithParameters = urlWithParameters.concat('.com/apex/Pdf_Generator?id='+this.recordId);
      
      
      const event = new ShowToastEvent({
          title: 'PDF Success',
          message: 'PDF Downloaded Successfully',
          variant: 'success'
      });
    
      this.dispatchEvent(event);
      
      //Opening url
      window.open(urlWithParameters);


    }



    
    transactionForCSV= [];

    handleCSV(event){
      let csvContent = "data:text/csv;charset=utf-8,";
          
      /* this.fields.forEach(function(rowArray) {
          let row = rowArray.MetadataComponentName+","+rowArray.MetadataComponentType+",";
          csvContent += row + "\r\n";
      });
      let row = 'This is csv content,This is 2test';
      csvContent += row + "\r\n";*/

      let rowEnd = '\n';
      let rowData = new Set();
      var txRecords = [];     
      for(let i =0;i<this.data.length;i++)
      {
        let tx = {};
        tx.Name = this.data[i].Name;
        tx.Amount__c = this.data[i].Amount__c;
        tx.Type__c = this.data[i].Type__c;
        tx.Status__c = this.data[i].Status__c;
        tx.TransactionDate__c = this.data[i].TransactionDate__c;
        txRecords.push(tx);
      }
      this.transactionForCSV = txRecords;

      this.transactionForCSV.forEach(function (record)
      {
        Object.keys(record).forEach(function (key)
        {
          rowData.add(key);
        });
      });
      rowData = Array.from(rowData);
      csvContent+= rowData.join(',');
      csvContent+=rowEnd;
      for(let i=0;i<this.transactionForCSV.length; i++)
      {
        let colValue = 0;
        for(let key in rowData)
        {
          if(rowData.hasOwnProperty(key))
          {
            let rowKey = rowData[key];
                  // add , after every value except the first.
                  if(colValue > 0){
                    csvContent += ',';
                  }
                  // If the column is undefined, it as blank in the CSV file.
                  let value = this.transactionForCSV[i][rowKey] === undefined ? '' : this.data[i][rowKey];
                  csvContent += '"'+ value +'"';
                  colValue++;
          }
        }
        csvContent+= rowEnd;

      }

      var encodedUri = encodeURI(csvContent);
      var link = document.createElement("a");
      link.setAttribute("href", encodedUri);
      link.setAttribute("download", "Dependent.csv");
      document.body.appendChild(link); 
      link.click();

    }



    handleEmail() {
      
      console.log('Handle');
        
        //Calling Email method from apex
        sendEmail({recordIdOfContact : this.recordId})
						.then(result => 
                        {
                            console.log(result);
						})
						.catch(error => {
							console.log(error);
						});
        
        const event = new ShowToastEvent({
            title: 'Email',
            message: 'PDF Genrated And sent to Contact Email address.',
            variant: 'success'
        });

        this.dispatchEvent(event);
    }
    
}