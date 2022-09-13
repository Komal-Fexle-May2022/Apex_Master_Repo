/* *
   * Purpose         :    This JavaScript file is created to perform Logics on html page to load data by clicking button and importing class method.
   * Created By      :    Komal Kumawat
   * Created Date    :    04/09/2022
   * Current Version :    V1.0
   * Revision Log    :    V_1.0  Created - Komal Kumawat - 04/09/2022
*/
import { LightningElement } from 'lwc';
import getTextMethod1 from '@salesforce/apex/TextController.getTextMethod1';
import getTextMethod2 from '@salesforce/apex/TextController.getTextMethod2';
import getTextMethod3 from '@salesforce/apex/TextController.getTextMethod3';
export default class LoadClassMethod extends LightningElement {

    async handleClick() {
        try {
            const result1 = await getTextMethod1();
            console.log('Method1 result: ' + result1);
            const result2 = await getTextMethod2({
                message1: result1
            });
            console.log('Method2 result: ' + result1 + ' ' + result2);
            const result3 = await getTextMethod3({
                message2: result2
            });
            console.log('Method3 result: ' + result1 + ' ' + result2 + ' ' + result3);
        } catch(error) {
            console.log(error);
        } finally {
            setTimeout(() => {
            console.log('Finally Completed');
            }, 2000);
        }
    }
}