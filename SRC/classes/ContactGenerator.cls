/* *
   * Purpose         :    This class is created to define method and return contacts list in js file.
   * Created By      :    Komal Kumawat
   * Created Date    :    12/09/2022
   * Current Version :    V1.0
   * Revision Log    :    V_1.0  Created - Komal Kumawat - 12/09/2022
*/
public with sharing class ContactGenerator {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [
            SELECT
                Id,
                Name,
                FirstName,
                LastName,
                Title,
                Phone,
                Email,
                Picture__c
            FROM Contact
        ];
    }
}