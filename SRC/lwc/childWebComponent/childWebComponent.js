/* *
   * Purpose         :    This JavaScript file is created to perform Logics on html page to increase value when button is clicked.
   * Created By      :    Komal Kumawat
   * Created Date    :    06/09/2022
   * Current Version :    V1.0
   * Revision Log    :    V_1.0  Created - Komal Kumawat - 06/09/2022
*/
import { LightningElement, track,api } from "lwc";

export default class ChildWebComponent extends LightningElement {
  @track value=1; //reactive in nature 
  //public method
  @api handleValueChange() {
    this.value=this.value+1;
  }
}