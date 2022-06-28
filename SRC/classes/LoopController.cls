/*
 * Description     :    This class contain different types of loop description.
 * Created By      :     Komal Kumawat
 * Created Date    :     26/06/2022
 * Version Logs    :     V_1.0
*/ 

public class LoopController {
    public static void doWhileLoop(){
        /* Do-while() loop:- The Apex do-while loop repeatedly executes a block of code as long as a particular Boolean condition remains true. 
           Syntax:- do{
                     statements
                     }while(condition)
           Apex do-while loop does not check the Boolean condition statement until after the first loop is executed. 
           Consequently, the code block always runs at least once.          
        */
        Integer count=1;
        do{
           System.debug(count);
           count++;
        }while(count<=10);   
      }
  
     public static void whileLoop(){
        /*While() Loop:- The Apex while loop repeatedly executes a block of code as long as a particular Boolean condition remains true.
        Syntax:- while(condition){
                    statements;
                    increament/decreament expression
                  } 
        */
        // Addition of ten digit number 
        Integer a=1,sum=0;
        while(a<=10){
           sum += a;
           a++;
        }
        System.debug('Addition of ten digit number-- ' + sum);
      }
  
     public static void forLoop(){
        /* For Loop:- The traditional for loop in Apex corresponds to the traditional syntax used in Java and other languages.
           Syntax:- for (init_stmt; exit_condition; increment_stmt) {
                        code_block
                    }
        */
        Integer mult=1, a;
        for(a=1;a<=10;a++){
           mult *= a; 
        }            
        System.debug('Multiplication of ten digit - ' + mult);
      }
  
     public static void listOrSetIterationLoop(){
        /* List or Set Iteration for Loops:- The list or set iteration for loop iterates over all the elements in a list or set.
           Syntax:- for (variable : list_or_set) {
                    code_block
                    }
           where variable must be of the same primitive or sObject type as list_or_set.
        */
        Integer[] myInts = new Integer[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  
        for (Integer i : myInts) {
           System.debug(i);
        }            
      }
}