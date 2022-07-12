/*
 * Description       :    This class contain country map example through Map collections.
 * Created By        :    Komal Kumawat
 * Created Date      :    5/072022
 * Version Logs      :    V_1.0 
*/

public  class CountryMapController {
    public CountryMapController() {
        
        //This is the list of districts of state.
        List<String> rajasthanDistricts = new List<String>{'Ajmer','Udaipur','Jodhpur'};
        List<String> californiaDistricts = new List<String>{'Butte','Alpine','Solano', 'Calaveras'};
        List<String> jakartaDistricts = new List<String>{'Kaliders', 'Gambir','Sawah','Senen','Tebet'};
        List<String> espiritoDistricts = new List<String>{'Serra','Vila Vehla','Linhares','Colatina','Alergre'};
        List<String> berlinDistricts = new List<String>{'Mitte','Neukolln','Litchenberg','Pankow'};
        List<String> asyutDistricts = new List<String>{'Abnub','Abu Tig','Dairut','El Badari'};
        
        // This is the map of state with districts.
        Map<String, List<String>> mapOfStateRajasthanDistricts = new Map<String , List<String>>{'Rajasthan'=> rajasthanDistricts};
        Map<String, List<String>> mapOfStateCaliforniaDistricts = new Map<String , List<String>>{'California'=> californiaDistricts};
        Map<String, List<String>> mapOfStateJakartaDistricts = new Map<String , List<String>>{'Jakarta'=> jakartaDistricts};
        Map<String, List<String>> mapOfStateEspiritoDistricts = new Map<String , List<String>>{'Spirito Santo'=> espiritoDistricts};
        Map<String, List<String>> mapOfStateBerlinDistricts = new Map<String , List<String>>{'Berlin'=> berlinDistricts};
        Map<String, List<String>> mapOfStateAsyutDistricts = new Map<String , List<String>>{'Asyut'=> asyutDistricts};

        // This is the map of country with state.
        Map<String, Map<String, List<String>>> mapOfCountryIndiaState = new Map<String, Map<String, List<String>>>{'India'=>mapOfStateRajasthanDistricts};
        Map<String, Map<String, List<String>>> mapOfCountryUsState = new Map<String, Map<String, List<String>>>{'US'=> mapOfStateCaliforniaDistricts};
        Map<String, Map<String, List<String>>> mapOfCountryIndonesiaState = new Map<String, Map<String, List<String>>>{'Indonesia'=> mapOfStateJakartaDistricts};
        Map<String, Map<String, List<String>>> mapOfCountryBrazilState = new Map<String, Map<String, List<String>>>{'Spain'=> mapOfStateEspiritoDistricts};
        Map<String, Map<String, List<String>>> mapOfCountryGermanyState = new Map<String, Map<String, List<String>>>{'Germany'=> mapOfStateBerlinDistricts};
        Map<String, Map<String, List<String>>> mapOfCountryEgyptState = new Map<String, Map<String, List<String>>>{'Egypt'=> mapOfStateAsyutDistricts};

        Map<Integer , Map<String, Map<String, List<String>>>> mapOfCountryCode = new Map<Integer , Map<String, Map<String, List<String>>>>();

        // Putting country code with country.
        mapOfCountryCode.put(91 , mapOfCountryIndiaState);
        mapOfCountryCode.put(1 , mapOfCountryUsState);
        mapOfCountryCode.put(62, mapOfCountryIndonesiaState);
        mapOfCountryCode.put(55, mapOfCountryBrazilState);
        mapOfCountryCode.put(49, mapOfCountryGermanyState);
        mapOfCountryCode.put(20, mapOfCountryEgyptState);

        System.debug(mapOfCountryCode);

        Integer districtLen = 5;

        Map<String, List<String>> countryNamesStartingWithS = new Map<String, List<String>>();
        Map<String, List<String>> mapOfStateWithDistrict = new Map<String, List<String>>();
        Map<String, String> mapOfStateWithCountry = new Map<String, String>();
        List<List<String>> listOfCombinations = new List<List<String>>();


        //Finding all the Country Names that start with 's'
        for(Map<String, Map<String, List<String>>> tempMap : mapOfCountryCode.values()){
        
            for(String countryName : tempMap.keySet()){

                
                if(countryName.startsWith('s'.toUpperCase())){
                    mapOfStateWithDistrict.putAll(tempMap.get(countryName));
                    countryNamesStartingWithS.put(countryName, new List<String>(tempMap.get(countryName).keySet()));
                }
            }
        }

        for(String countryName : countryNamesStartingWithS.keySet()){
            for(String state : countryNamesStartingWithS.get(countryName)){
                mapOfStateWithCountry.put(state, countryName);
            }
        }

        System.debug(mapOfStateWithDistrict);

        for(String State : mapOfStateWithDistrict.keySet()){
            if(state.startsWith('s'.toUpperCase())){
                for(String dist : mapOfStateWithDistrict.get(state)){
                    if(dist.startsWith('s'.toUpperCase())){
                        listOfCombinations.add(new List<String>{mapOfStateWithCountry.get(state), state, dist});
                    }
                }
            }
        }

        System.debug(listOfCombinations);

    }
}