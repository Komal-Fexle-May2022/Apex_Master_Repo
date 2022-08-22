/* *
   * Purpose        :     This class is created to count the total number of states when insert, delete, update and populate on Country object custom field.
   * Created By     :     Komal Kumawat
   * Created On     :     16/08/2022
   * Version Logs   :     V_1.0         
*/
public with sharing class StateTriggerHandler {
    public static void populateTotalNumberOfStatesOnCountry(List<States__c> stateList, List<States__c> stateOldList){

        Set<Id> setOfCountryIds = new Set<Id>();
        for(States__c states : stateList)
            {  
                if(states.Country__c != null)
                {
                    setOfCountryIds.add(states.Country__c);
                }
            }
            // Update 
            if( stateOldList != null)
            {
                for(States__c countryOld : stateOldList)
                {
                    if(countryOld.Country__c != null)
                    {
                        setOfCountryIds.add(countryOld.Country__c);
                    }
                }
            }
        System.debug(setOfCountryIds);

        // For getting Districts Name Under Country State.
        Map<String, Object> countrystateJsonWrapMap = new Map<String, Object>();
        List<String> districtName = new List<String>();
        for(Districts__c districtData : [Select Id, Name ,State_Name__r.Country__r.Name From Districts__c Where State_Name__r.Country__r.Name In: setOfCountryIds])
        {
            districtName.add(districtData.Name);
        }
        countrystateJsonWrapMap.put('District Name:-', districtName);

        // For getting States Name Under Country
        List<String> statesName = new List<String>();
        for(States__c stateData : [Select Id, Name, Total_Districts__c, State_Code__c From States__c Where Id In : setOfCountryIds])
        {
            statesName.add(stateData.Name);   
        }
        countrystateJsonWrapMap.put('StateName-', statesName);

        // Update the Total count of States.
        List<Country__c> countries = new List<Country__c>();
        Country__c countryObj = new Country__c();
        List<Country__c> countryList = [Select Id, Name, Total_States__c, Country_Code__c,Total_Districts__c, (Select Id From States__r) From Country__c Where Id In : setOfCountryIds];
        for(Country__c countryData : countryList)
        {
            if(setOfCountryIds != null)
            {
                countryData.Total_States__c = countryData.States__r.size();
                countries.add(countryData);

                countrystateJsonWrapMap.put('Total Districts-', countryData.Total_Districts__c);
                countrystateJsonWrapMap.put('Total States-',countryData.States__r.size());
                countrystateJsonWrapMap.put('Country Code-', countryData.Country_Code__c);
                countrystateJsonWrapMap.put('Country Name-', countryData.Name);
            }
        }
        
        if(countries.size() > 0)
        {
            update countries;
        }
        // JSON Data
        countryObj.Country_JSON_Data__c = JSON.serialize(countrystateJsonWrapMap);
        System.debug('@@@ JSON Country STATE DATA WRAP ' +JSON.serialize(countrystateJsonWrapMap));
    }
}