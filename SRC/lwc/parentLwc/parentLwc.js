/* *
   * Purpose         :    This JavaScript file is created to perform Logics on html page handle the progressbar through child value.
   * Created By      :    Komal Kumawat
   * Created Date    :    06/09/2022
   * Current Version :    V1.0
   * Revision Log    :    V_1.0  Created - Komal Kumawat - 06/09/2022
*/
import { LightningElement, track } from "lwc";

export default class ParentLwc extends LightningElement {
  @track progressValue = 0;
  hanldeProgressValueChange(event) {
    this.progressValue = event.detail;
  }
}