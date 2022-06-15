// Creating Class to store Student Record data and Query that
public class StudentController {
    public static void createStudentData(){
        
        // Inserting Student Record

        Student__c studentData = new  Student__c();
        studentData.Name = 'Sourya Maheshwari';
        studentData.Address__c = 'Vaishali, Jaipur';
        //studentData.Branch__c = 'Computer Science';
        studentData.College_Joining__c = date.newInstance(2019,7,5);
        //studentData.Current_Year__c = datetime.newInstance(12,3,2022,12,09,00);
        studentData.Father_Name__c = 'Kapil Maheshwari';
        //studentData.Fees_Submitted__c = '564';
        studentData.Linkedin_ID__c  = 'https://SouryaMaheshwari987//Linkedin.com';
        studentData.Mobile_Number__c = '(876)543-2780';
        studentData.Place__Latitude__s = 32;
        studentData.Place__Longitude__s= 98;
        studentData.Roll_Number__c = 345678;
        studentData.Student_College_Url__c = 'https://www.sobhasaria.edu.in/';
        studentData.Student_Email__c = 'sourya123@gmail.com';
        studentData.No_Back__c = true;
        studentData.Student_Hobbies__c = 'Cricket;Reading';
        studentData.Student_Qualification__c = 'Diploma';
        studentData.Total_Fees__c = 1234;
        studentData.Total_Percentage__c = 89.00;
        insert studentData;
        
        // Query Student Data
                                            // Query for one  Student data
       /* Student__c studentData = [select Id, Name, Roll_Number__c,Mobile_Number__c,Father_Name__c from Student__c order by createdDate DESC limit 1  ];
        system.debug("Check my latest student" + studentData);*/
                           
                                            // Query for multiple Student data using List
        List<Student__c> studentList = [select Id, Name, Roll_Number__c,Mobile_Number__c,Father_Name__c from Student__c order by createdDate DESC limit 5];
        for(Student__c student: studentList){
            system.debug('Check my latest student' + studentList);
        }
    }
    

}