/* *
   * Purpose         :    This JavaScript file is created to perform Logics on html page of ADD, SUB, MULT, DIV by clicking button.
   * Created By      :    Komal Kumawat
   * Created Date    :    01/09/2022
   * Current Version :    V1.0
   * Revision Log    :    V_1.0  Created - Komal Kumawat - 01/09/2022
*/
import { LightningElement, track } from 'lwc';

export default class SimpleCalculator extends LightningElement {
    @track num1;
    @track num2;
    @track result;

    addOper(){
        this.result = Number(this.num1) + Number(this.num2);
    }
    subOper(){
        this.result = Number(this.num1) - Number(this.num2);
    }
    multOper(){
        this.result = Number(this.num1) * Number(this.num2);
    }
    divOper(){
        this.result = Number(this.num1) / Number(this.num2);
    }

    handleChangeNum1(evt){
        this.num1 = evt.target.value;
    }
    handleChangeNum2(evt){
        this.num2 = evt.target.value;
    }
}