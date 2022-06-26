/*
 * Description   :   This class contains different type of DataTypes.
 * Created By    :   Komal Kumawat
 * Created Date  :   22-06-2022
 * Version Logs  :   V_1.0
 * Modification  : 
 */
public class DataTypesController {
    public static void createDataTypes() {
        //Boolean Datatpye
        Boolean greater = True;
        Boolean lesser = False;
        // Integer Datatype
        Integer a = 5,b=7; 
        //Example:-
        if (a>b) {
            System.debug('Printing height:- ' + greater);
        }
        else{System.debug(lesser);}
    
        /* String:- Any set of characters surrounded by single quotes. 
                A string can be null or empty and can include leading and trailing space
           Ex:- String s = 'Komal'; 
    */     
        String str = 'Fexle Services Private Limited.';
        System.debug(str);
        
        // Double Datatypes defining 
        Double d1=3.14159, d2 = 7.67880;
        System.debug('Addition of Double values ' + (d1+d2));
        
        // ID Datatype
        ID recordId= 'a0E5i000000q3LmEAI';
        System.debug('Printing Student Record ID:- ' + recordId);

        // Object Datatype:-
        Object obj = 10;
        // Cast the object to an integer.
        Integer i = (Integer)obj;
        System.assertEquals(10, i);

        // Date Datatype:-
        Date mydate= Date.newInstance(2022,6,7);
        System.debug('Printing Date' + mydate);

        // Datetime Datatype:-
        Datetime myDatetime = Datetime.newInstance(2022,7,8,18,07,12);
        System.debug('Printing date and time together' + myDatetime); 
        
        /* Long Datatype:- A 64-bit number that does not include a decimal point. Longs have a minimum value of -263 and a maximum value of 263-1. 
                           Use this data type when you need a range of values wider than the range provided by Integer.  */
        Long l = 2147483648L;
        System.debug('Printing Long value' + l);
    }
}