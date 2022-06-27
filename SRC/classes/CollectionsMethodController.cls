/*
 * Description     :   This class contain different methods of list ,Map,Set collections datatype.
 * Created By      :   Komal Kumawat
 * Created Date    :   23/06/2022
 * Version Logs    :   V_1.0
*/

public with sharing class CollectionsMethodController {
    public static void listMethodDescription(){
        /* List:- A list is an ordered collection of elements that are distinguished by their indices.
                  List elements can be of any data type—primitive types, collections, sObjects, user-defined types, and built-in Apex types.
           Syntax:- List<Datatypes> NameOfList = new List<Datatypes>();   
           Nested List:-  List<List<Datatype>> nameoflist = new List<List<Datatype>>();    
        */
        
        // Adding elements with declaration of list 
        List<String> streamName = new List<String>{'Computer Science','Mechanical'};
        
        /*Adding elements in the list using add() method
        Syntax;- listname.add(index,values)
         It adds an element to the list. If we are not giving any index then it add the element at last.
          */
        streamName.add('Electronics');
        streamName.add('Electrical'); 
        System.debug(streamName);

        //  size();- returns the number of elements in tne list 
        System.debug('Size of the list  ' + streamName.size());

        //  get(index);- Returns the element on the ith index
        System.debug('Element on the index--' + streamName.get(3));

        // remove(index);- Remove the element on the ith index.
        System.debug('Remove the element ---'+ streamName.remove(2));

        // clone();- Makes the duplicate of list
        List<String> streamNameCopy= streamName.clone();
        System.debug('Making duplicate of list-- ' + streamNameCopy);

        // set(index,value);- Sets the element on the ith position of the list. If there is already a value then value gets overriden.
        streamName.set(1,'Biology');
        System.debug('setting element --' + streamName);

        // sort();- Sorts the elements in ascending order but works with primitive datatypes only.
        streamName.sort();
        System.debug('Sorting list --' + streamName);

        // isEmpty();- Returns true if the list is empty.
        streamName.isEmpty();
        

        // clear();- Clear the list 
        streamNameCopy.clear();
        System.debug('List is clear or not -- '+ streamNameCopy);

        // equals(listname);- Compares the list with specified list and returns true if both list are equals.
        List<String> list1 = new List<String>{'Komal','Vibha','Krishna','Ruhi','Vibha'};
        System.debug('Comparing list--- ' + streamName.equals(list1));

        //hashCode();- Returns the hashcode corresponding to this list and its contents.
        System.debug('HashCode of list-- ' + streamName.hashCode());

        /*indexOf(listElement);- Returns the index of the first occurence of the specified element in this list.
                                 if this element does not contain the element, returns -1 */
        System.debug('Returning index---  '+ list1.indexOf('Vibha'));

        // toString();- Returns the String representation of the list
        System.debug('String representation of list-- ' + streamName.toString());

        // iterator();- Returns the instance of an iterator for this list.
        System.debug('Iterator of list-- ' + streamName.iterator());

        /* Array notations of List:- 
            Syntax:- Datatype[] nameoflist = new datatype[elements u want];
                     datatype[] nameoflist = new List<datatype>();
                     List<String> nameoflist = new datatype[no. of elements u want]; 
        */
        Integer[] numList = new Integer[4];
        // Sets values for list
        numList[0] = 1;
        numList[1] = 2;
        numList[2] = 4;
        numList[3] = 3;
        System.debug('Array notation list -- ' + numlist);
        System.debug('Accessing the elements -- ' + numList[2]);
    }
    
    public static void mapMethodDescription(){
        /* Map:- A map is a collection of key-value pairs where each unique key maps to a single value. 
                 Keys and values can be any data type—primitive types, collections, sObjects, user-defined types, and built-in Apex types.
           Syntax:= Map<Datatype, Datatype> mapName = new Map<Datatype, Datatype>();
           Nested Map :- Map< Datatype, collections< Datatype>> nameofmap = new Map< Datatype, collections< Datatype>>();
        */
        // Creation of map and initilization the value together.
        Map<Integer , String> studentWithRollNumber = new Map<Integer, String>{ 121=> 'Komal', 122=> 'Krishna'};

        //Methods of map:-
        // put():- To add the elements in the map
        studentWithRollNumber.put(123 , 'Vibha');
        studentWithRollNumber.put(124, 'Soumi');
        System.debug('Adding the elements in map---'+studentWithRollNumber);
        
        //containsKey(key):-  Returns true if the map contains a mapping for the specified key.
        Boolean contains = studentWithRollNumber.containsKey(123);
        System.assert(true, contains);

        //deepClone():- Makes a duplicate copy of a map, including sObject records if this is a map with sObject record values.
        Account a = new Account( Name='Acme',  BillingCity='New York');
        Map<Integer, Account> map1 = new Map<Integer, Account> {};
        map1.put(1, a);
        Map<Integer, Account> map2 = map1.deepClone();
        System.debug('Copy of the map -- '+ map2);

        //equals(map2):- Compares this map with the specified map and returns true if both maps are equal; otherwise, returns false.
        System.debug('Compairing two map values--- ' + studentWithRollNumber.equals(map1));

        //get(key):- Returns the value to which the specified key is mapped, or null if the map contains no value for this key.
        String code = studentWithRollNumber.get(122);
        System.debug('This key containing value or not-- ' + code);

        //hashCode():- Returns the hashcode corresponding to this map.
        System.debug('Returning hashcode of map--- '+ studentWithRollNumber.hashCode());
     
        // isEmpty():- Returns true if the map has zero key-value pairs.
        System.debug('Checking map is empty or not--- ' + studentWithRollNumber.isEmpty());

        //keySet():- Returns a set that contains all of the keys in the map.
        Map<String, String> colorCodes = new Map<String, String>();
        colorCodes.put('Red', 'FF0000');
        colorCodes.put('Blue', '0000A0');
        Set <String> colorSet = new Set<String>();
        colorSet = colorCodes.keySet();
        System.debug('Set of key in map-- '+ colorset);

        //putAll(sobjectArray):- Adds the list of sObject records to a map declared as Map<ID, sObject> or Map<String, sObject>.
        List<Account> accts = new List<Account>();
        accts.add(new Account(Name='Account1'));
        accts.add(new Account(Name='Account2'));
        // Insert accounts so their IDs are populated.
        insert accts;
        Map<Id, Account> m = new Map<Id, Account>();
        // Add all the records to the map.
        m.putAll(accts);
        System.debug('Putting all Account details in Map ---' + m);

        // remove(key):- Removes the mapping for the specified key from the map, if present, and returns the corresponding value.
        System.debug('Removing key --' + studentWithRollNumber.remove(124));

        // size():- Returns the number of key-value pairs in the map.
        System.debug('Size of the map-- ' + studentWithRollNumber.size());

        //toString():-  Returns the string representation of the map.
        String strOfMap = studentWithRollNumber.toString();
        System.debug('String representation of map-- ' + strOfMap);

        //values():- Returns a list that contains all the values in the map.
        List<String> colors = new List<String>();
        colors = colorCodes.values();
        System.debug('Returns the list of values of map-- ' + colors);     
    }

    public static void setMethodDescription(){
        /* Sets:- A set is an unordered collection of elements that do not contain any duplicates. 
                Set elements can be of any data type—primitive types, collections, sObjects, user-defined types, and built-in Apex types.
            Syntax:- Set<Datatype> setName = new Set<Datatype>();    
        */

        Set<String> fruitSet = new Set<String>{'Apple','Mango','Banana'};
        System.debug('Set--- '+ fruitSet);

        // Create a set from elements of another set.
        Set<String> copyFruitSet = new Set<String>(fruitset);
        System.debug('Copy of fruitset---  '+ copyFruitSet);
        
        //add(setElement):- Adds an element to the set if it is not already present.
        fruitSet.add('Grapes');
        fruitSet.add('pineapple');

        //addAll(fromList):- Adds all of the elements in the specified list to the set if they are not already present.
        List<String> myList = new List<String>{'Orange','Strawberry'};
        Boolean listSet = fruitSet.addAll(myList);
        System.debug('Adding list to the set-- ' + listSet);

        //clone():- Makes a duplicate copy of the set.
        Set<String> copyOfSet = fruitset.clone();
        System.debug('Copy of set through clone method--- '+ copyOfSet);

        //contains(setElement):- Returns true if the set contains the specified element.
        System.debug('Contains the specified element or not--  '+ fruitSet.contains('Grapes'));

        //equals(set2):- Compares this set with the specified set and returns true if both sets are equal; otherwise, returns false.
        System.debug('Compare the set---  '+ fruitSet.equals(copyFruitSet));

        //hashCode():- Returns the hashcode corresponding to this set and its contents.
        System.debug('Hashcode of the set--- ' + fruitSet.hashCode());

        //removeAll(listOfElementsToRemove/setOfElementsToRemove):-Removes the elements in the specified list/set from the set if they are present.
        System.debug('Removing all elements of list in set--' + fruitSet.removeAll(myList));

        //retainAll(list/setOfElementsToRetain):- Retains only the elements in this set that are contained in the specified list/set.
        System.debug('Retains the list of set-- '+ fruitset.retainAll(myList));

        //size():- Returns the number of elements in the set (its cardinality).
        System.debug('Size of the set--- '+ fruitSet.size());

        //toString():- Returns the string representation of the set.
        System.debug('String representation of set--- ' + fruitSet.toString());
    }
}