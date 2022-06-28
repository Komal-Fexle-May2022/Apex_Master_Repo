/* Method Call By Value:- means when a method is called , a second copy of the parameter variable is made in memory and this copy is passed
                          to the method as a parameter. This copy can be modified in the method , but original variable in the caller is unchanged,
                          and the changes to the copy are lost upon return.
   Method Call By Refrence:- means when a method is called, that actual variable is passed to the method. Apex is not passing anything by refrence
                              (i.e memory address) by value, which allows the developer to change fields on tne object and call methods
                              (like list.add()) on the object.
*/
public  class MethodCallingController {
    Student__c s1 = new Student__c();
    Integer methodVar = 10;

    public MethodCallingController() {
        // Calling refrence method
        manipulateRefrence(s1);
        //s1.Name = 'Vanshika Kumawat';
        System.debug('Check student name :::  ' + s1.Name);
     
        // Calling value method
        checkCallByValue(methodVar);
        System.debug('Calling Value in method inside constructor -- ' + methodVar);
    }
    Student__c stData = new Student__c();
    public void manipulateRefrence(Student__c stData){
        for(Integer methodVar=0;methodVar<10;methodVar++){
            stData.Name = 'Komal Kumawat';
            stData.Name = stData.Name + methodVar;
        }
    }

    public void checkCallByValue(Integer methodVar){
        methodVar = 50;
        System.debug('Check call by value inside method--- ' + methodVar);
    }
}