/*
 * Description     :    This class contain description of different keywords in apex.
 * Created By      :    Komal Kumawat
 * Created Date    :    31/06/2022
 * Version logs    :    V_1.0 
*/
public virtual class KeywordsController {
    //DateTime date1;
    //transient DateTime date2;
    String str;{
        this.str = 'this keyword used';
    }
    public static void instanceOfKeyword() {
        sObject s = new Account();
        Account a = (Account)s;
        Contact c = (Contact)s;

        if(s instanceOf Account){
            Account acc = (Account)s;
            system.debug('This is sObject of Account:: ');
        }
        else if(s instanceOf Contact){
            Contact con = (Contact)s;
            system.debug('This is sObject of Contact:: ');
        }
    }

    public virtual void superKeywordMethod(){
        Integer var1 = 23, var2 = 56;
        system.debug('This is used for super keyword for addition::' + var1+var2); 
    }

   /* public String dateTime1(){
        if(date1 == null){
            date1 = system.now();
            return 'this is only datetime ' + date1;
        }
    }
    public String dateTime2(){
        if(date2 == null){
            date2 = system.now();
            return 'This is transient datetime keyword' + date2;
        }
    }*/
}