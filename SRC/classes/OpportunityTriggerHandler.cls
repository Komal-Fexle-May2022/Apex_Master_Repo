/* *
   * Purpose      :     This Opportunity Trigger Handler is created to insert , update, delete the child records while creation of Opportunity.
   * Created By   :     Komal Kumawat
   * Created On   :     1/08/2022
   * Version Logs :     V_1.0
*/
public with sharing class OpportunityTriggerHandler{
    public static void insertAutomobileRecords(List<Opportunity> oppRecords, Map<Id, Opportunity> mapOfOldOpp)
    {
        //Shortlisting of Automobile sensors data.
        Map<Id, Set<String>>  mapOfOppWithSensors = new Map<Id, Set<String>>();
        Set<String> sensorOldSet = new Set<String>();
        Set<String> sensorSet = new Set<String>();

        // List Of Auttomobile Objects:
        List<Automobile_Sensor__c> automobileSensorList = new List<Automobile_Sensor__c>();
        List<Automobile_Presence_Sensor__c> automobileSensorPresenceList = new List<Automobile_Presence_Sensor__c>();
        List<Automobile_TDU__c> automobileTDUList = new List<Automobile_TDU__c>();
        List<Automobile_Tag__c> automobileTagList = new List<Automobile_Tag__c>();

        List<sObject> automobileListToBeInserted = new List<sObject>();

        List<Automobile_Sensor__c> autoSensor = [Select Id, Name, Account__c, Opportunity__c From Automobile_Sensor__c Where Opportunity__c IN: mapOfOppWithSensors.keySet() ];
        List<Automobile_Presence_Sensor__c> automobilePresence = [Select Id, Name, Account__c, Opportunity__c From Automobile_Presence_Sensor__c Where Opportunity__c IN: mapOfOppWithSensors.keySet() ];
        List<Automobile_TDU__c> automobileTDU = [Select Id, Name, Account__c, Opportunity__c From Automobile_TDU__c Where Opportunity__c IN: mapOfOppWithSensors.keySet() ];
        List<Automobile_Tag__c> automobileTag = [Select Id, Name, Account__c, Opportunity__c From Automobile_Tag__c Where Opportunity__c IN: mapOfOppWithSensors.keySet() ];
        Map<Id, sObject> updateAutomobileSensor = new Map<Id, sObject>();
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        
        if(mapOfOppWithSensors.size() > 0)
        {
            
            for(Opportunity opp : oppRecords)
            {
                // ShortListing of the sensors Name
                if(opp.StageName =='Shipped To Customer' || opp.StageName =='Return To HQ' || opp.StageName =='Return To Customer')
                {
                    if((opp.Automobile_Tag_Details_1__c != null || opp.Automobile_Tag_Details_2__c != null || opp.Automobile_Tag_Details_3__c != null))
                    {
                        sensorSet.addAll(opp.Automobile_Tag_Details_1__c.split('\r\n'));
                        sensorSet.addAll(opp.Automobile_Tag_Details_2__c.split('\r\n'));
                        sensorSet.addAll(opp.Automobile_Tag_Details_3__c.split('\r\n'));
                        mapOfOppWithSensors.put(opp.Id , sensorSet);
                    }
                    //SensorOldSet
                    if(mapOfOldOpp != null && (mapOfOldOpp.get(opp.Id).Automobile_Tag_Details_1__c != null || mapOfOldOpp.get(opp.Id).Automobile_Tag_Details_2__c != null || mapOfOldOpp.get(opp.Id).Automobile_Tag_Details_3__c != null))
                    {
                        sensorOldSet.addAll(mapOfOldOpp.get(opp.Id).Automobile_Tag_Details_1__c.split('\r\n'));
                        sensorOldSet.addAll(mapOfOldOpp.get(opp.Id).Automobile_Tag_Details_2__c.split('\r\n'));
                        sensorOldSet.addAll(mapOfOldOpp.get(opp.Id).Automobile_Tag_Details_3__c.split('\r\n'));
                    }
                }
                // Checking for duplicates.
                if(sensorOldSet != null)
                {
                    for(String sensorOldName : sensorOldSet)
                    {
                        if(sensorSet.contains(sensorOldName))
                        {
                            sensorSet.remove(sensorOldName);
                        }
                    }
                }

                // Inserting Data
                if(opp.StageName == 'Shipped To Customer' || opp.StageName == 'Return To Customer')
                {
                    for(String sensorsName : sensorSet)
                    {
                        // Length of Automobile sensor is not greater than 18.
                        sensorsName = sensorsName.length()>18 ? sensorsName.subString(0,18) : sensorsName;
                        if(sensorsName.startsWith('00:11:CE:00'))
                        {
                            Automobile_Sensor__c automobileSensorObj = new Automobile_Sensor__c();
                            automobileSensorObj.Opportunity__c = opp.Id;
                            automobileSensorObj.Name = sensorsName;
                            automobileSensorObj.Account__c = opp.Installation_Account__c;
                            automobileSensorList.add(automobileSensorObj);
                        }          
                        else if(sensorsName.startsWith('00:11:CE:D'))
                        {
                            Automobile_Presence_Sensor__c automobileSensorPresenceObj = new Automobile_Presence_Sensor__c(); 
                            automobileSensorPresenceObj.Opportunity__c = opp.Id;
                            automobileSensorPresenceObj.Account__c = opp.Installation_Account__c;
                            automobileSensorPresenceObj.Name = sensorsName;
                            automobileSensorPresenceList.add(automobileSensorPresenceObj);
                        }
                        else if(sensorsName.startsWith('00:11:CE:E'))
                        {
                            Automobile_TDU__c automobileTDUObj = new Automobile_TDU__c();
                            automobileTDUObj.Opportunity__c = opp.Id;
                            automobileTDUObj.Name = sensorsName;
                            automobileTDUObj.Account__c = opp.Installation_Account__c;
                            automobileTDUList.add(automobileTDUObj);
                        }
                        else if(sensorsName.left(3).isNumeric())
                        {
                            Automobile_Tag__c automobileTagObj = new Automobile_Tag__c();
                            automobileTagObj.Opportunity__c = opp.Id;
                            automobileTagObj.Name = sensorsName;
                            automobileTagObj.Account__c = opp.Installation_Account__c;
                            automobileTagList.add(automobileTagObj);
                        }
                    }
                }
                // Updating Data 
                else if(opp.StageName == 'Return To HQ')
                {
                    for(Automobile_Sensor__c autoList: autoSensor)
                    {
                        if(sensorSet.contains(autoList.Name))
                        {
                            autoList.Account__c = opp.Shipment_Account__c;
                            updateAutomobileSensor.put(autoList.Id, autoList);
                        }
                    }
                    for(Automobile_Presence_Sensor__c autoPresenceList: automobilePresence)
                    {
                        if(sensorSet.contains(autoPresenceList.Name))
                        {
                            autoPresenceList.Account__c = opp.Shipment_Account__c;
                            updateAutomobileSensor.put(autoPresenceList.Id, autoPresenceList);
                        }
                    }
                    for(Automobile_TDU__c autoTDUList : automobileTDU)
                    {
                        if(sensorSet.contains(autoTDUList.Name))
                        {
                            autoTDUList.Account__c = opp.Shipment_Account__c;
                            updateAutomobileSensor.put(autoTDUList.Id, autoTDUList);
                        }                    }
                    for(Automobile_Tag__c autoTagList : automobileTag)
                    {
                        if(sensorSet.contains(autoTagList.Name))
                        {
                            autoTagList.Account__c = opp.Shipment_Account__c;
                            updateAutomobileSensor.put(autoTagList.Id, autoTagList);
                        }
                    }
                }

                // mail sending.
                List<String> emailList = new List<String>();
                Set<String> noSensorSet = new Set<String>();
                String oppOwner = opp.OwnerId;
                String oppName = opp.Name;
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                List<String> sendersList = new List<String>{'komal1725kk@gmail.com'};
                mail.setToAddresses(sendersList);
                mail.setSubject(oppName + ' ' + 'Date: '+ Date.today());
                String htmlBodyTable = '';
                htmlBodyTable = '<table border="1" cellpadding="0" style="border-collapse: collapse"><caption>Successful: Summary Data</caption><tr><th>  Automobile Type  </th><th> Name </th><th>Message</th></tr>';
                        
                for(String str : sensorSet) 
                {
                    if(opp.StageName == 'Shipped To Customer' || opp.StageName == 'Return To Customer')
                    {
                        if(str.startsWith('00:11:CE:00')) {
                                htmlBodyTable+= '<tr><td border:"1px solid black">' + ' Automobile Sensor ' +'</td><td> '+str+' </td><td>'+'Sensor inserted under installation account : '+ opp.Installation_Account__c +'</td></tr>';
                        }
                        else if(str.startsWith('00:11:CE:D')) {
                                htmlBodyTable+= '<tr><td border:"1px solid black>' + '  Automobile Presence Sensor ' +'</td><td> '+str+' </td><td>'+'Sensor inserted under installation account id: '+ opp.Installation_Account__c +'</td></tr>';
                        }
                        else if(str.startsWith('00:11:CE:E')) {
                                htmlBodyTable+= '<tr><td border:"1px solid black>' + '  Automobile Tag Sensor  ' +'</td><td> '+str+' </td><td>'+'Sensor inserted under installation account id: '+ opp.Installation_Account__c +'</td></tr>';
                        }
                        else if(str.substring(0,3).isNumeric()) {
                                htmlBodyTable+= '<tr><td border:"1px solid black>' + ' Automobile TDU Sensor ' +'</td><td> '+str+' </td><td>'+'Sensor inserted under installation account id: '+ opp.Installation_Account__c +'</td></tr>';
                        }
                        else{
                                noSensorSet.add(str);
                        }
                    }
                    else if(opp.StageName == 'Return To HQ')
                    {
                        if(str.startsWith('00:11:CE:00')) {
                                htmlBodyTable+= '<tr><td border:"1px solid black">' + ' Automobile Sensor ' +'</td><td> '+str+' </td><td>'+'Automobile Sensor is moved from Installation account : '+ opp.Installation_Account__c +'to Shipment Account :'+ opp.Shipment_Account__c +'</td></tr>';
                        }
                        else if(str.startsWith('00:11:CE:D')) {
                                htmlBodyTable+= '<tr><td border:"1px solid black>' + '  Automobile Presence Sensor ' +'</td><td> '+str+' </td><td>'+'Automobile Presence Sensor is moved from Installation account : '+ opp.Installation_Account__c +'to Shipment Account :'+ opp.Shipment_Account__c +'</td></tr>';
                        }
                        else if(str.startsWith('00:11:CE:E')) {
                                htmlBodyTable+= '<tr><td border:"1px solid black>' + '  Automobile Tag Sensor  ' +'</td><td> '+str+' </td><td>'+'Automobile Tag Sensor is moved from Installation account : '+ opp.Installation_Account__c +'to Shipment Account :'+ opp.Shipment_Account__c +'</td></tr>';
                        }
                        else if(str.substring(0,3).isNumeric()) {
                                htmlBodyTable+= '<tr><td border:"1px solid black>' + ' Automobile TDU Sensor ' +'</td><td> '+str+' </td><td>'+'Automobile TDU Sensor is moved from Installation account : '+ opp.Installation_Account__c +'to Shipment Account :'+ opp.Shipment_Account__c +'</td></tr>';
                        }
                    }      
                }
                htmlBodyTable += '</table>';
                system.debug('Email Body: ' + htmlBodyTable);
                        
                String htmlBodyTable2 = '';
                htmlBodyTable2 = '<table border="1" cellpadding="1" cellspacing="1" style="border-collapse: collapse"><caption>Unsuccessful: Summary Data</caption><tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';
                        
                for(String str : noSensorSet) 
                {
                    htmlBodyTable2+= '<tr><td>' + 'Sensor ' +'</td><td> '+str+' </td><td> Invalid sensor </td></tr>';
                }

                htmlBodyTable2 += '</table>';
                mail.setHTMLbody(htmlBodyTable + htmlBodyTable2);
                String emailAddress = 'komal1725kk@gmail.com';
                System.debug('Email Send Successfully at: ' + emailAddress);
                messages.add(mail);
            }    
        } 
        System.debug('Sensors New List---'+sensorSet);
        System.debug('Sensors Old List---'+sensorOldSet);
        System.debug('List to be Inserted--'+automobileListToBeInserted);
        automobileListToBeInserted.addAll(automobileSensorList);
        automobileListToBeInserted.addAll(automobileSensorPresenceList);
        automobileListToBeInserted.addAll(automobileTDUList);
        automobileListToBeInserted.addAll(automobileTagList);
        if(automobileListToBeInserted != null)
        {
            insert automobileListToBeInserted;
        }
        if(updateAutomobileSensor != null)
        {
            update updateAutomobileSensor.values();
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(  messages );
    }           
}