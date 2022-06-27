/*
 * Description   :    This class contain different types of operators description and example.
 * Created By    :    Komal Kumawat
 * Created Date  :    25/06/2022
 * Version Logs  :    V_1.0   
*/

public class ExpressionsAndOperatorsController {
   /* Expressions:- An expression is a construct made up of variables, operators, and method invocations that evaluates to a single value.
      Operators:- which tells the compiler that which type of logical manipulation has to be performed.
      Example:- a+b   ( a & b are variables , + is an operator and this statement is called expression)  
   */
    
   // Different types of Operators:- 
    public static void airthmeticOperator() {
        /*Airthmetic Operator:- * /    { precedance:- 3 }
                                + -    { precedance:- 4 } 
        */
        Integer a = 7;
        Integer b = 17;
        System.debug('Addition of two number-- ' + (a+b));
        System.debug('Subtraction of two number-- '+ (b-a));
        System.debug('Multiplication of two numbers-- '+ (a*b));
        System.debug('Division of two numbers-- '+ (b/a));
    }

    public static void logicalOperator(){
        /*Logical Operator:- These are used to test morethan one condition & decision making.
          Logical AND( && ):- (Left associative). If x, a Boolean, and y, a Boolean, are both true, 
                              then the expression evaluates to true. Otherwise the expression evaluates to false.
                              Precedance:- 12
          Logical Or( || ):-  (Left associative). If x, a Boolean, and y, a Boolean, are both false, 
                               then the expression evaluates to false. Otherwise the expression evaluates to true.
                               Precedance:- 13
        */
        Integer a = 7, b=10, c=8;
        // Logical AND Example:- 
        if(a>b && a>c){ System.debug('A is greater'); }
        else if(b>c){ System.debug('B is greater'); }
        else{ System.debug('C is greater'); }

        // Logical OR Example;-
        if(a<b || b==10){ System.debug('A is less than B-- '); }
        else{ System.debug('Ais greater than B-- '); }
    }

    public static void comparisionOperator(){
        /* Comparision Operator:- Compare two values & condition.
            < <= > >= :- Precedance 6
            == != :- Precedance 7
            Exact equality operator( === ):- If x and y reference the exact same location in memory the expression evaluates to true. 
                                             Otherwise the expression evaluates to false.
            Exact inequality operator( !== ):-  If x and y don’t reference the exact same location in memory, the expression evaluates to true.
                                        Otherwise the expression evaluates to false. 
        */
        Integer x = 11, y = 18;
        System.debug('x is less than y--' + (x<y)); 
        System.debug('x isgreater then y-- ' + (x>y));
        System.debug('x is equal to y--' + (x==y)); 
        System.debug('x is not equal to y--' + (x!=y));                                                                
    }

    public static void bitwiseOperator(){
        /* Bitwise Operator:- These operators are used to perform operation at bit level.
           Bitwise AND operator( & ):- ANDs each bit in x with the corresponding bit in y so that the result
                                     bit is set to 1 if both of the bits are set to 1.
                                     Precedance:-  8

            Bitwise exclusive OR operator( ^ ) Exclusive ORs each bit in x with the corresponding bit in y so that the result bit is set to 1
                                           if exactly one of the bits is set to 1 and the other bit is set to 0.
                                           Precedance:- 9
                                           
            Bitwise OR operator( | ):- ORs each bit in x with the corresponding bit in y so that the result bit is set to 1
                                 if at least one of the bits is set to 1.  
                                 Precedance:- 10    

            Bitwise exclusive OR operator(^=):- Exclusive ORs each bit in x with the corresponding bit in y so that the result bit is set to 1
                             if exactly one of the bits is set to 1 and the other bit is set to 0. Assigns the result of the exclusive OR operation to x.
                             
            Bitwise shift left operator( << ):- Shifts each bit in x to the left by y bits so that the high-order bits are lost and the new right bits are set to 0.                 
                                                 Precedance:- 5

            Bitwise shift right signed operator(>>):- Shifts each bit in x to the right by y bits so that the low-order bits are lost and the new left bits are set 
                                                  to 0 for positive values of y and 1 for negative values of y.      
                                                  Precedance:- 5
                                                  
            Bitwise shift right unsigned operator(<<<):- Shifts each bit in x to the right by y bits so that the low-order bits are lost and the new left bits are set 
                                                          to  0 for all values of y.
                                                          Precedance:- 5

            Bitwise Not or Complement operator( ~ ):- Toggles each binary digit of x, converting 0 to 1 and 1 to 0.
                                                  Boolean values are converted from True to False and vice versa.                                              
        */
        
        Integer x = 4, y=5 ;
        Integer a,b,c,d,e,f,g;
        a = x & y;
        b = x ^ y;
        c = x | y;
        d = x << y;
        e = x >> y;
        f = x >>> y;
        g = ~x; 
        System.debug('Bitwise AND of x & y--  '+ a);
        System.debug('Bitwise XOR of x & y--  '+ b);
        System.debug('Bitwise OR of x & y--  '+ c);
        System.debug('Bitwise left shift of x & y--  '+ d);
        System.debug('Bitwise right shift of x & y--  '+ e);
        System.debug('Bitwise shift right unsigned of x & y--  '+ f);
        System.debug('Bitwise NOT of x --  '+ g);
    }

    public static void assignmentOperators(){
        /* = , += , -= , *= , /= , &=  , <<= , >>= , >>>=     Precedance:- 13
          x=y   ( Assignment Operator:- It assigns the value of x to y. )
          x = x+y -----  x += y;
        */
        Integer x= 8,y=5;
        System.debug('Addition of x & y and stores in x variable--  ' + (x += y));
        System.debug('AND Operation of x & y and stores in x variable--  ' + (x &= y));
        System.debug('Bitwise Left shift of x & y and stores in x variable--  ' + (x <<= y));
    }

    public static void ternaryOperator(){
        /* Ternary Operator( ? : ):- (Right associative). This operator acts as a short-hand for if-then-else statements. 
                                 If x, a Boolean, is true, y is the result. Otherwise z is the result.*/
                      
         Integer x=6, y=7,z;
         z = x<y?x:y;
         System.debug('Checking ternary operator value-- X is less than y'+ z );                        
    }

    public static void safeNavigatorOperator(){
        /* Safe Navigator Operator:- Use the safe navigation operator (?.) to replace explicit, sequential checks for null references. This operator short-circuits expressions that attempt 
                                     to operate on a null value and returns null instead of throwing a NullPointerException.
        */
        Map<Id,Account> accountMap = new Map<Id,Account>([select Id, Name FROM Account]);
        System.debug('Safe navigator operator value---  ' +accountMap.get('0015i000009adNUAAY').Name);                    
    }
}