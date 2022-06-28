/* Overloading Method:- It occurs when two or more methods in one class have 
               the same method name but different parameters.
*/

public class OverloadingController{
    public static void logicalMethod(Integer value1, Integer value2){
        value1 = 10;
        value2 = 20;
        System.debug('Addition of two variable-- '+ (value1+value2));
        System.debug('Multiplication of two variable-- '+ (value1*value2));
        System.debug('Subtraction of two variable-- '+ (value1-value2));
        System.debug('Division of two variable-- '+ (value1/value2));
    }

    public static void logicalMethod(Integer value3, Integer value4, Integer value5){
        value3 = 30;
        value4 = 40;
        value5 = 50;
        System.debug('Addition of three variable-- '+ (value3+value4+value5));
        System.debug('Multiplication of three variable-- '+ (value3*value4*value5));
        System.debug('Subtraction of three variable-- '+ (value3-value4-value5));
    }
    public static void logicalMethod(Integer var1){
        for(var1 = 1;var1<=10;var1++){
            var1 = var1*2;
            System.debug('multiplication of 2-- \n' + var1);
        }
    }
}