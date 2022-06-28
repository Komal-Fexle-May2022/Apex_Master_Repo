/* Constructors:- A constructor is code that is invoked when an object is created from the class blueprint. You do not need to write a constructor for every class. 
                  If a class does not have a user-defined constructor, a default, no-argument, public constructor is used.
    two types:- 
              -> Constructor with argument
              -> Constructor with no argument
    Static Constructor:- It is used to initialize any static data or to perform a particular action that needs performed once only.
                         it is called automatically before the first instance is created or any static members are refrenced.  
    Calling Constructor:-
                        new ConstructorName();
                        ClassName refrencename = new ContructorName();
                        refrencename.methodName();   ----- calling method                              
*/

public class ConstructorController{
    public Integer a=10, b=5;
    // Constructor with No Parameter
    public ConstructorController(){    
        System.debug('Multiplication of two values--- '+ (a*b));
    }

    // Constructor with Parameter
    public ConstructorController(Integer c){
        System.debug('Multiplication of two values--- '+ (a*b*c));
    }

    // Default Constructor (2)
    {
        System.debug('This statement is from default constructor');
    }

    //Static Constructor  (1)
    static{
        System.debug('This statement is from static constructor');
    }
    // Method calling through constructor instance
    public void methodConstructor(){
        System.debug('This statement from method calling constructor');
    }

    // Constructor Overloaded:- Same name of constructor with different types of arguments.
    public ConstructorController(Integer x, Integer y){
        System.debug('Overloaded Constructor1 ---' + (x+y));
    }
    public ConstructorController(String s1, String s2){
        System.debug('Overloaded Constructor2--- '+ s1 + s2);
    }

}