/* *
   * Purpose         :    This JavaScript file is created to perform Logics on html page of ADD, SUB, MULT, DIV by clicking button.
   * Created By      :    Komal Kumawat
   * Created Date    :    01/09/2022
   * Current Version :    V1.0
   * Revision Log    :    V_1.0  Created - Komal Kumawat - 01/09/2022
*/
import { LightningElement, track } from 'lwc';

export default class SimpleCalculator extends LightningElement {
    num1;
    num2;
    result;

    onButtonCLick(event) {
        var operation = event.target.label;

        // Null Validation
        if(this.num1==null || this.num2==null){
            this.result ='Enter the inputs.'
        }
        // If input is not a number validation
        else if(isNaN(this.num1) || isNaN(this.num2)){
            this.result='Enter a valid input number.'
        }
        else{
            this.template.querySelectorAll('lightning-input');
            var tempResult;
            if (operation === 'Add') {
                tempResult = this.num1 + this.num2;
                this.template.querySelectorAll('lightning-input[data-id="reset"]').forEach(element=>{element.value=null;});
            } else if (operation === 'Subtract') {
                tempResult = this.num1 - this.num2
                this.template.querySelectorAll('lightning-input[data-id="reset"]').forEach(element=>{element.value=null;});
            } else if (operation === 'Multiply') {
                tempResult = this.num1 * this.num2;
                this.template.querySelectorAll('lightning-input[data-id="reset"]').forEach(element=>{element.value=null;});
            } else if (operation === 'Divide') {
                tempResult = this.num1 / this.num2;
                this.template.querySelectorAll('lightning-input[data-id="reset"]').forEach(element=>{element.value=null;});
            }
            if (tempResult !== null && tempResult !== '' && tempResult !== undefined && !isNaN(tempResult)) {
                this.result = tempResult;
            }
            this.num1=null;
            this.num2=null;
        }
    }    

    handleChangeNum1(event){
        this.num1 = event.target.value;
    }
    handleChangeNum2(event){
        this.num2 = event.target.value;
    }
}