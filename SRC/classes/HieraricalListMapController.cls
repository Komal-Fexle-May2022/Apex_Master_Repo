/*
 * Description    :    This class contain hierarical example of map & list.
 * Created By     :    Komal Kumawat
 * Created Date   :    24/06/2022
 * Version Logs   :    V_1.0    Created By - Komal Kumawat on 24/06/22.   
*/


public class HieraricalListMapController {
    public static void classStreamData(){
        Map<String,Map<String,List<Student__c>>> classMap = new Map<String,Map<String,List<Student__c>>>();
        
        // 1stYear List of Student
        List<Student__c> firstYearListComputer = new List<Student__c>();
        firstYearListComputer = [select Id,Name,Roll_Number__c,Class__c,Stream__c from Student__c where Class__c = 'First Year' and Stream__c = 'Computer Science'];
        Map<String, List<Student__c>> mapOfStudentWithStream1stYear = new Map<String, List<Student__c>>();
        mapOfStudentWithStream1stYear.put('Computer Science', firstYearListComputer);

        // 1styear list of Electronics Student
        List<Student__c> firstYearListElectronics = new List<Student__c>();
        firstYearListElectronics = [select Id,Name,Roll_Number__c,Class__c,Stream__c from Student__c where Class__c = 'First Year' and Stream__c = 'Electronics'];
        mapOfStudentWithStream1stYear.put('Electronics', firstYearListElectronics);

        // 2ndYear List of Electronics Student
        List<Student__c> secondYearListElectronics = new List<Student__c>();
        secondYearListElectronics = [select Id,Name,Roll_Number__c,Class__c,Stream__c from Student__c where Class__c = 'Second Year' and Stream__c = 'Electronics'];
        Map<String, List<Student__c>> mapOfStudentWithStream2ndYear = new Map<String, List<Student__c>>();
        mapOfStudentWithStream2ndYear.put('Electronics', secondYearListElectronics);
         
        classMap.put('1stYear' , mapOfStudentWithStream1stYear);
        classMap.put('2ndYear',mapOfStudentWithStream2ndYear);
        System.debug(classMap);
    }


}