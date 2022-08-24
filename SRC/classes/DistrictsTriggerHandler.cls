/* *
   * Purpose        :     This class is created to count the total number of districts when insert, delete, update and populate on State object custom field.
   * Created By     :     Komal Kumawat
   * Created On     :     
   * Version Logs   :     V_1.0         
*/
    public class DistrictsTriggerHandler {
        public static void populateTotalNumberOfDistrictsOnState(List<Districts__c> districtList,  List<Districts__c> districtOldList)
        {
            Set<Id> setOfStateIds = new Set<Id>();
            Set<Id> setOfCountryIds =new Set<Id>();
            // Insert
            for(Districts__c dist : districtList)
            {  
                if(dist.State_Name__c != null)
                {
                    setOfStateIds.add(dist.State_Name__c);
                    setOfCountryIds.add(dist.State_Name__r.Country__r.Name);
                }
            }
            // Update 
            if( districtOldList != null)
            {
                for(Districts__c distOld : districtOldList)
                {
                    if(distOld.State_Name__c != null)
                    {
                        setOfStateIds.add(distOld.State_Name__c);
                    }
                }
            }

            Map<String, Object> stateJsonWrapMap = new Map<String, Object>();
            List<String> districtName = new List<String>();
            for(Districts__c districtData : [Select Id, Name , State_Name__c From Districts__c Where State_Name__c In: setOfStateIds])
            {
                districtName.add(districtData.Name);
            }
            stateJsonWrapMap.put('District Name:-', districtName);
            
            List<States__c> states = new List<States__c>();
            List<States__c> stateList = [Select Id, Name, Total_Districts__c, State_Code__c, Country__r.Total_Districts__c, (Select Id, Name From Districts__r) From States__c Where Id In : setOfStateIds];
            States__c stateObj = new States__c();
            for(States__c stateData : stateList)
            {
                if(setOfStateIds != null)
                {
                    stateData.Total_Districts__c = stateData.Districts__r.size();
                    states.add(stateData);
                    System.debug('Data--'+stateData);
                    stateJsonWrapMap.put('Total Districts-',stateData.Districts__r.size());
                    stateJsonWrapMap.put('State Code-', stateData.State_Code__c);
                    stateJsonWrapMap.put('State Name-', stateData.Name);   
                }
            }

            List<Country__c> countries = new List<Country__c>();
            List<Country__c> countryList = [Select Id, Name, Total_Districts__c, (Select Id, Name From States__r) From Country__c Where Id In : setOfCountryIds];
            for(Country__c countryData : countryList)
            {
                if(setOfStateIds != null)
                {
                    countryData.Total_Districts__c = countryData.States__r.size();
                    countries.add(countryData);
                    System.debug('Data--'+countryData);
                }
            }
            if(states.size() > 0)
            {
                update states;
            }
            if(countries.size() > 0)
            {
                update countries;
            }
            System.debug('Data==='+ districtName);
            stateObj.State_JSON_Data__c = JSON.serialize(stateJsonWrapMap);
            System.debug('@@@ JSON STATE DATA WRAP ' +JSON.serialize(stateJsonWrapMap));
        }
    }