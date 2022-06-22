/*
 * Description  :  This class contain different - different Star pattern programs.
 * Created By   :  Komal Kumawat
 * Created Date :  21/06/2022
 * Version Logs :  V_1.0  Created By - Komal Kumawat - 21/06/2022
 * Modification : 
 */
public class StarPatternController {
    public static void printLeftTriangleStarPattern(){
     /*        *
             * *
           * * *
         * * * *
      */   
        System.debug('Printing Left Triangle Star Pattern--');
        for(Integer i=1;i<=5;i++)
        {
            String s = ' ';
            for(Integer j=1;j<=5;j++)
            {
                if(j>=6-i )
                {
                    s = s + ' * ';
                }
                else{s = s + '_';}
            }
            
            system.debug(s);
            
        }
    }
    public static void rightTrianglePascalPattern(){
      /*
         *
         * *
         * * *
         * *
         *
      */   
        System.debug('Printing Right Triangle Pascal Star Pattern--');
        Integer k=0;
        for(Integer i=1;i<=10;i++)
        {
            if(i<=5){k++;} else{k--;}
            string s='  ';
            for(Integer j=1;j<=5;j++)
            {
                if(j<=k)
                {
                    s = s + ' * ';
                }
                else{s = s + ' ';}
            }
            
            system.debug(s);
        }
    }   
    public static void downwardTriangleStarPattern(){
      /* *****
         ****
         ***
         **
         *
      */
        System.debug('Printing Downward Triangle Star Pattern--');
        for(Integer i=1;i<=5;i++){
            String s = '  ';
            for(Integer j=1;j<=5;j++){
                if(j<=6-i){s=s+' * ';}
                else{s=s+' ';}
            }
            System.debug(s);
        }
    }
    public static void pyramidStarPattern(){
      /*        *
               ***
              *****
       */
        System.debug('Printing Pyramid Star Pattern--');
        for(Integer i=0;i<=4;i++)
        {
            String s = '  ';
            for(Integer j=0;j<=8;j++)
            {
                if(j>=4-i && j<=4+i)
                {
                    s = s + ' * ';  
                }
                else{s=s+'_';}
            }        
            system.debug(s);       
        }
    }
    public static void leftTrianglePascalPattern(){
      /*       *
              **
             ***
              **
               *
        */
        System.debug('Printing Left Triangle Pascal Star Pattern--- ');
        Integer k=6;
        for(Integer i=1;i<=9;i++)
        {
            if(i<=5){k--;} else{k++;}
            String s='  ';
            for(Integer j=1;j<=5;j++)
            {
                if(j>=k)
                {
                    s = s + ' * ';
                }
                else{s = s + '_';}
            }
            system.debug(s);      
        }
    }
    public static void hollowDownTrianglePattern(){
       /* ********
           *    *
            *  *
             *  
        */ 
        System.debug('Printing Hollow Down Triangle Star Pattern---');
        boolean b=true;
        for(integer i=1;i<=5;i++)
        {
            string s='  ';
            for(integer j=1;j<=9;j++)
            {
                if(i>=2 && i<=4){if(j>=1+i && j<=9-i){b=false;}else{b=true;}}else{b=true;}
                
                if(j>=i && j<=10-i && b)
                {
                    s = s + ' * ';
                    
                }
                else{s = s + '_';}
            }
            system.debug(s);
        }
    }
}