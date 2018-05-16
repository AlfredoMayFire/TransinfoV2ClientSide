//
//  ReportsListController.swift
//  
//
//  Created by Pedro Santiago on 3/5/17.
//
//

import Foundation
import UIKit


class ReportController: UIViewController{
    let singleton = Global.sharedGlobal
    var converterObject: Dictionary<String,AnyObject> = ["":""]
    var converterArray = Array<AnyObject>()
    
    
    @IBOutlet weak var reportText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let WebServicesQuery = WebService.init()
        let caseNumber = singleton.foreignKeys[0].crashBasicInformation
        let accidentFK = singleton.foreignKeys[0].accidentCondition
        singleton.foreignKeys[0].crashBasicInformation = 0
        singleton.foreignKeys[0].accidentCondition = 0
        
        let firstTab = WebServicesQuery.letsReport(String(caseNumber))
        let secondTab = WebServicesQuery.secondTab(String(accidentFK))
        let newPerson = WebServicesQuery.personTab(String(accidentFK))
        let newVehicle = WebServicesQuery.vehicleTab(String(accidentFK))
        let narrative = WebServicesQuery.narrativeTab(String(accidentFK))
        
        print(firstTab)
        print(secondTab)
        print(newPerson)
        print(newVehicle)
        print(narrative)
        
        converterObject = (firstTab["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
        //print(converterArray)
        firstTabFormat(String(converterArray))

        
        reportText.insertText(String(converterArray))
        
        converterObject = (secondTab["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
//        print(converterArray)
        secondTabFormat(String(converterArray))
        
        reportText.insertText(String(converterArray))
        
        converterObject = (newPerson["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
        //print(converterArray)
        
        reportText.insertText(String(converterArray))
        
        converterObject = (newVehicle["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
        //print(converterArray)
        
        reportText.insertText(String(converterArray))
        
        converterObject = (narrative["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
        print(converterArray)
        
        reportText.insertText(String(converterArray))
        
        singleton.firstTabInfo[0].sawReport = true
        
        //let json = try? NSJSONSerialization.JSONObjectWithData(firstTab, options: [])
        
//        reportText.insertText(String(firstTab.first))
//        reportText.insertText(String(secondTab.first))
//        reportText.insertText(String(newPerson.first))
//        reportText.insertText(String(newVehicle.first))
//        reportText.insertText(String(narrative.first))
     
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func firstTabFormat(firstTab: String){
        var value = ""
        var first = false
        
        print("aiiiiooo",firstTab.rangeOfString("address")!)
        
        for i in firstTab.startIndex..<firstTab.endIndex {
            if firstTab.startIndex.distanceTo(i) == 17 {
                var j = i
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                }
            }
            
        }//for
       // print(value)
        singleton.firstTabInfo[0].firstTab["address"] = value
//        print(singleton.firstTabInfo[0].firstTab["address"],"this one")
        value = ""

        for i in firstTab.rangeOfString("caseNumber")!.startIndex ..< firstTab.endIndex {
            var j = i
            //j = j.advancedBy(12, limit: firstTab.endIndex)
            
            if i == firstTab.rangeOfString("caseNumber")!.startIndex {
                j = i;
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["caseNumber"] = value
                value = ""
            }
            if i == firstTab.rangeOfString("cityDescriptionES")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["cityDescriptionES"] = value
                value = ""
                
            }
            if i == firstTab.rangeOfString("countryDescriptionES")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["countryDescriptionES"] = value
                value = ""
                
            }

            if i == firstTab.rangeOfString("crashDate")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["crashDate"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("crashType")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["crashType"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("directionDescriptionES")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["directionDescriptionES"] = value
                value = ""
                
            }
            if i == firstTab.rangeOfString("distance")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["distance"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("hour")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["hour"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("latitude")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["latitude"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("locationDescriptionES")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["locationDescriptionES"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("longitude")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["longitude"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("measurementDescriptionES")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["measurementDescriptionES"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("name")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["name"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("nearToDescriptionEs")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["nearToDescriptionEs"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("propertyDescriptionES")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["propertyDescriptionES"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("status")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["status"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("unitAutomovilistas")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["unitAutomovilistas"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("unitFatalaties")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["unitFatalaties"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("unitInjured")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["unitInjured"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("unitPedestrians")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["unitPedestrians"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("unitVehiculos")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["countryDescriptionES"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("countryDescriptionES")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["unitVehiculos"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("zoneTypeDescriptionES")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].firstTab["zoneTypeDescriptionES"] = value
                value = ""
                
            }
            
            
            
            
            
        }
   
        
        
        
        
        
    }

    func secondTabFormat(firstTab: String){
        var value = ""
        var first = false
        
        for i in firstTab.rangeOfString("collisionTypeDescriptionES")!.startIndex ..< firstTab.endIndex {
            var j = i
            //j = j.advancedBy(12, limit: firstTab.endIndex)
            
            if i == firstTab.rangeOfString("collisionTypeDescriptionES")!.startIndex {
                j = i;
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["collisionTypeDescriptionES"] = value
                value = ""
            }
            if i == firstTab.rangeOfString("crashLocation")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["crashLocation"] = value
                value = ""
                
            }
            if i == firstTab.rangeOfString("environmental")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["environmental"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("eventDescriptionES")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["eventDescriptionES"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("eventLocationDescriptionES")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["eventLocationDescriptionES"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("inserctionType")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["inserctionType"] = value
                value = ""
                
            }
            if i == firstTab.rangeOfString("mannerofColisionDescriptionES")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["mannerofColisionDescriptionES"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("nearConstruction")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["nearConstruction"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("pavementCondition")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["pavementCondition"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("policePresent")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["policePresent"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("roadDescription")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["roadDescription"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("schoolBusRelated")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["schoolBusRelated"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("specifLocation")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["specifLocation"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("visibilityCondition")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["visibilityCondition"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("weatherConditionDos")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["weatherConditionDos"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("weatherConditionUno")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["weatherConditionUno"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("withinInterchange")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["withinInterchange"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("workerPresent")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["workerPresent"] = value
                value = ""
                
            }
            
            if i == firstTab.rangeOfString("workerZoneType")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].secondTab["workerZoneType"] = value
                value = ""
                
            }
            
            
            
            
            
            
            
        }
        print(value)
        
        print(singleton.firstTabInfo[0].firstTab,"thisinfor",singleton.firstTabInfo[0].secondTab)
        
        
        
    }
    
    func thirdTabFormat(firstTab: String){
        var value = ""
        var first = false
        
        for i in firstTab.rangeOfString("details")!.startIndex ..< firstTab.endIndex {
            var j = i
            //j = j.advancedBy(12, limit: firstTab.endIndex)
            
            if i == firstTab.rangeOfString("details")!.startIndex {
                j = i;
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].thirdTab["details"] = value
                value = ""
            }
            if i == firstTab.rangeOfString("notifiedTimeEmergencie")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].thirdTab["notifiedTimeEmergencie"] = value
                value = ""
                
            }
            if i == firstTab.rangeOfString("notifiedTimePolice")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].thirdTab["notifiedTimePolice"] = value
                value = ""
                
            }
            if i == firstTab.rangeOfString("timeOfArrivalEmergencie")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].thirdTab["timeOfArrivalEmergencie"] = value
                value = ""
                
            }

            if i == firstTab.rangeOfString("timeOfArrivalPolice")!.endIndex {
                j=i;
                j = j.advancedBy(3)
                while firstTab[j] != ";" {
                    value.append(firstTab[j])
                    j = j.advancedBy(1)
                    //                    print(value)
                }
                singleton.firstTabInfo[0].thirdTab["timeOfArrivalPolice"] = value
                value = ""
                
            }

            
            
        print(value)
        
        print(singleton.firstTabInfo[0].firstTab,"thisinfor")
        
            
        
        
    }

    

    }
}