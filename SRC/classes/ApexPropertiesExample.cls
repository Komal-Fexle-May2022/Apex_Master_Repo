/* Apex Properties:- Property definitions include one or two code blocks, representing a get accessor and a set accessor:
                       The code in a get accessor executes when the property is read.
                       The code in a set accessor executes when the property is assigned a new value.
*/
// Example :- Creating New class for that
public class ApexPropertiesExample{
    // Way of caching the data
    public static Student__c stData{
        get{
            if(stData==null){
                //OneTime Run
                stData = [select Id, Name from  Student__c where Name != Null];
            }
            return stData;
        }
        set{
            stData.Name = stData.Name + DateTime.now();
            system.debug('Check stdata.Name ' + stData.Name);
        }
    }
   //public static Student__c stData(get;set);

    // Direct method based property declaration,calling and initialization.
    @AuraEnabled
    public static Student__c getStData(){
       Student__c stLocal;
       if(stLocal == null){
        stLocal = [select Id, Name from  Student__c where Name != Null];
       }
       return stLocal;
    }
    
}