/* 
* Description     :   This Class is created to fill map dynamically, finding combination, aggregate function, JSON method.
* Created By      :   Komal Kumawat
* Created Date    :   12/07/2022
* Version_Logs    :   V_1.0 
*/

public class CountryStateDistrictJSONController  
{
    //Map defining to fill the data 
    Map<String , Map<String, List<String>>> mapOfCountryWithStatesAndDistricts = new Map<String , Map<String, List<String>>>();
    
    public CountryStateDistrictJSONController(String startWithKeyword) 
    {
        List<Districts__c> districtsList =new List<Districts__c>();
        for(Districts__c dist : [Select Name,  State_Name__r.Name, State_Name__r.Country__r.Name 
                                 FROM Districts__c])
        {
            districtsList.add(dist);
        } 
        
        //Filling District data dynamically
        for(Districts__c listOfdata : districtsList)
        {
            Map<String, List<String>> mapOfState = mapOfCountryWithStatesAndDistricts.get(listOfdata.State_Name__r.Country__r.Name);
            if(!mapOfCountryWithStatesAndDistricts.containsKey(listOfdata.State_Name__r.Country__r.Name))
            {
                mapOfCountryWithStatesAndDistricts.put(listOfdata.State_Name__r.Country__r.Name, new Map<String, List<String>>());
            }
            
            if(!mapOfCountryWithStatesAndDistricts.get(listOfdata.State_Name__r.Country__r.Name).containsKey(listOfdata.State_Name__r.Name))
            {
                mapOfCountryWithStatesAndDistricts.get(listOfdata.State_Name__r.Country__r.Name).put(listOfdata.State_Name__r.Name, new List<String>());
            }
            if(!mapOfCountryWithStatesAndDistricts.get(listOfdata.State_Name__r.Country__r.Name).get(listOfdata.State_Name__r.Name).contains(listOfData.Name)){
                
                mapOfCountryWithStatesAndDistricts.get(listOfdata.State_Name__r.Country__r.Name).get(listOfdata.State_Name__r.Name).add(listOfData.Name);
            }
            
        }
        System.debug('Map---'+ mapOfCountryWithStatesAndDistricts);
        
        //Finding combination of Country, State, Districts start with same letter
        try
        {
            startWithKeyword +='%';
            List<String> countryData = new List<String>();
            for(Districts__c data : [Select Name ,  State_Name__r.Name, State_Name__r.Country__r.Name 
                                     FROM Districts__c 
                                     WHERE Name LIKE: startWithKeyword 
                                     AND State_Name__r.Name LIKE: startWithKeyword 
                                     AND State_Name__r.Country__r.Name LIKE: startWithKeyword])
            {
                countryData.add(data.Name);
                countryData.add(data.State_Name__r.Name);
                countryData.add(data.State_Name__r.Country__r.Name);
            }
            system.debug(countryData);  
        } 
        catch( Exception e)
        {
            System.debug(startWithKeyword + '--- letter  combination of country, state, districts is not there.' + e.getMessage());
        }  

        // Finding maximum length of districts with particular number .
        List<String> maxLenghtDistricts = new List<String>();
        for(Districts__c len :[Select Name From Districts__c])
        {
            if(len.Name.length()>=10)
            {
                maxLenghtDistricts.add(len.Name);
            }
        }
        System.debug('Maximum length Districts are -- ' + maxLenghtDistricts);
    }  
    
    //Aggregate function to count total number of states and districts.
    public static void aggregateCountMethod(String countryName){
        List<Country__c> countryList = [Select Id, Name, Total_States__c From Country__c Where Name =: countryName LIMIT 1];
        Country__c countryObj = new Country__c();
        countryObj.Name = countryName;
        countryObj.Id = countryList[0].Id;
        AggregateResult result = [Select Country__r.Name, Count(Name)totalNumberOfStates
                                  From States__c 
                                  Where Country__r.Name Like : countryName Group By Country__r.Name];
        Integer total = (Integer)result.get('totalNumberOfStates');
        System.debug('Total States--'+total);
        countryObj.Total_States__c = total;
        
        States__c stateObj = new States__c();
        List<States__c> stateList = [Select Id, Name, Total_Districts__c From States__c Where Name= 'Rajasthan' LIMIT 1];
        stateObj.Id = stateList[0].Id;
        //statecObj.Country__c = countryName;
        AggregateResult resultDist = [Select Count(Name)totalNumberOfDistricts 
                                      From Districts__c 
                                      Where State_Name__r.Country__r.Name Like : countryName Group By State_Name__r.Country__r.Name];
        Integer totalDist = (Integer)resultDist.get('totalNumberOfDistricts');
        System.debug('Total States--'+totalDist);
        stateObj.Total_Districts__c = totalDist;
        countryObj.Total_Districts__c = totalDist;
        update countryObj;
        update stateObj;
        
    }
    //Method to have generate the Countries data json
    public static void countryJSONGenerator(String countryName){
        {
            try
            {
                // Creating List for State and District List.
                List<StateDataWrapper> stateList = new List<StateDataWrapper>();
                List<DistrictDataWrapper> districtList = new List<DistrictDataWrapper>();

                // Country Data for JSON
                Country__c countryData = [Select Name, Id, Country_Code__c, Total_States__c, Total_Districts__c 
                                              From Country__c where Name =: countryName];
                CountryDataWrapper countryDataWrap = new CountryDataWrapper(countryData.Name, countryData.Country_Code__c, stateList, countryData.Total_Districts__c,countryData.Total_States__c);
                
                // State Data for JSON
                for(States__c stateData : [Select Name, State_Code__c From States__c 
                                           Where Country__r.Name =: countryName
                                           AND Name = 'Utah'])
                {
                    StateDataWrapper statecountryObj = new StateDataWrapper(districtList, stateData.State_Code__c, stateData.Name);
                    stateList.add(statecountryObj);
                }
                
                // District Data for JSON
                for(Districts__c district : [Select Name, State_Name__r.Country__r.Name, State_Name__r.Name From Districts__c
                                             Where State_Name__r.Name = 'Utah'
                                             AND Name = 'Uehi'
                                             AND State_Name__r.Country__r.Name =: countryName])
                {
                    DistrictDataWrapper districtcountryObj = new DistrictDataWrapper(district.Name);
                    districtList.add(districtcountryObj);
                }
                // Serializing and Updating JSON Data
                countryData.Country_JSON_Data__c = JSON.serialize(countryDataWrap); 
                update countryData;
                System.debug('countryDataWrap @@@@ '+JSON.serialize(countryDataWrap));
            }
            catch(Exception e){
                System.debug(countryName + '--- No such type of country is there.');
            }
        }
    }
    
    //Country Wrapper Class
    public class CountryDataWrapper
    {
        public Decimal totalDistricts{get;set;}
        public Decimal totalStates{get;set;}
        public String countryName {get;set;}
        public Decimal countryCode {get;set;}
        public List<StateDataWrapper> states{get;set;}
        
        public CountryDataWrapper(){}
        
        public CountryDataWrapper(String countryName, Decimal countryCode, List<StateDataWrapper> states, Decimal totalDistricts, Decimal totalStates)
        {
            this.countryName = countryName;
            this.countryCode = countryCode;
            this.totalStates = totalStates;
            this.totalDistricts = totalDistricts;
            this.states = states;
        }
    }
    
    //State Wrapper Class
    public class StateDataWrapper
    {
        public String stateName {get;set;}
        public Decimal stateCode {get;set;}
        public List<DistrictDataWrapper> districts {get;set;}
        
        public StateDataWrapper(List<DistrictDataWrapper> districts, Decimal stateCode,String stateName)
        {
            this.stateName = stateName;
            this.stateCode = stateCode;
            this.districts = districts;
        }
    }
    
    //District Wrapper Class
    public class DistrictDataWrapper
    {
        public String districtName {get;set;}
        public DistrictDataWrapper(String districtName)
        {
            this.districtName = districtName;
        }
        
    }
}