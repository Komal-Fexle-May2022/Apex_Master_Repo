/* *
   * Purpose         :    This class is created to define method and call into the js file.
   * Created By      :    Komal Kumawat
   * Created Date    :    04/09/2022
   * Current Version :    V1.0
   * Revision Log    :    V_1.0  Created - Komal Kumawat - 04/09/2022
*/
public class TextController {
    @AuraEnabled(cacheable=true)
    public static String getTextMethod1(){
        return 'METHOD-1';
    }
    @AuraEnabled(cacheable=true)
    public static String getTextMethod2(){
        return 'METHOD-2';
    }
    @AuraEnabled(cacheable=true)
    public static String getTextMethod3(){
        return 'METHOD-3';
    }
}