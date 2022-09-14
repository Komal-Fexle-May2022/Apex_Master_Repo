/* *
   * Purpose         :    This JavaScript file is created to perform Logics on html page for initializing image, js file, css file and use of it.
   * Created By      :    Komal Kumawat
   * Created Date    :    09/09/2022
   * Current Version :    V1.0
   * Revision Log    :    V_1.0  Created - Komal Kumawat - 09/09/2022
*/
import { LightningElement } from 'lwc';
import SALESFORCE_LOGO from '@salesforce/resourceUrl/salesforce_logo'
import MOMENT from '@salesforce/resourceUrl/moment'
import ANIMATE from '@salesforce/resourceUrl/animate'
import {loadScript, loadStyle} from 'lightning/platformResourceLoader'
export default class ThirdPartyJsComponent extends LightningElement {
    
    logo = SALESFORCE_LOGO
    currentDate = ''
    isLoad = false
    renderedCallback(){
        if(this.isLoad){
            return
        }
        else{
            Promise.all([
                loadStyle(this, ANIMATE+'/animate/animate.min.css'),
                loadScript(this, MOMENT+'/moment/moment.min.js')
            ]).then(()=>{
                this.setDateOnScreen()
            })
            this.isLoad = true
        }
       
    }
    setDateOnScreen(){
        this.currentDate = moment().format('MMMM Do YYYY, h:mm:ss a');
    }
}