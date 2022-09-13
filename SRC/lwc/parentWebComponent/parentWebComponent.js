/* *
   * Purpose         :    This JavaScript file is created to perform Logics on html page to firing the child method.
   * Created By      :    Komal Kumawat
   * Created Date    :    06/09/2022
   * Current Version :    V1.0
   * Revision Log    :    V_1.0  Created - Komal Kumawat - 06/09/2022
*/
import { LightningElement } from "lwc";

export default class ParentWebComponent extends LightningElement {
  handleClick() {
    //firing an child method
    this.template.querySelector("c-child-web-component").handleValueChange();
  }
}