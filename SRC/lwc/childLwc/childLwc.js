/* *
   * Purpose         :    This JavaScript file is created to perform Logics on html page to handle parent value through child value.
   * Created By      :    Komal Kumawat
   * Created Date    :    04/09/2022
   * Current Version :    V1.0
   * Revision Log    :    V_1.0  Created - Komal Kumawat - 04/09/2022
*/
import { LightningElement, api } from "lwc";

export default class ChildLwc extends LightningElement {
  @api progressValue;
  handleChnage(event) {
    this.progressValue = event.target.value;
    // Creates the event with the data.
    const selectedEvent = new CustomEvent("progressvaluechange", {
      detail: this.progressValue
    });

    // Dispatches the event.
    this.dispatchEvent(selectedEvent);
  }
}