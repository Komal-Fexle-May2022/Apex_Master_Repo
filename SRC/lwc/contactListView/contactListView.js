/* *
   * Purpose         :    This JavaScript file is created to perform Logics on html page to show contact list on record pages using flexipageRegionWidth.
   * Created By      :    Komal Kumawat
   * Created Date    :    12/09/2022
   * Current Version :    V1.0
   * Revision Log    :    V_1.0  Created - Komal Kumawat - 12/09/2022
*/
import { LightningElement, wire, api } from 'lwc';
import getContactList from '@salesforce/apex/ContactGenerator.getContactList';
export default class ContactListView extends LightningElement {
   
    small;
    medium;
    large;
    @api flexipageRegionWidth;
    @wire(getContactList) contacts;

    // calling connected method to show changes in small, medium and large region accordingly.
    connectedCallback(){
        if(this.flexipageRegionWidth=="SMALL"){
            this.small=12;
        }
        if(this.flexipageRegionWidth=="MEDIUM"){
            this.medium=12/3;
        }
        if(this.flexipageRegionWidth=="LARGE"){
            this.large=12/4;
        }
    }
}