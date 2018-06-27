//
//  AccidentReportTableViewController.swift
//  transinfoFinal
//
//  Created by Pedro Santiago on 2/10/17.
//  Copyright © 2017 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import UIKit

class AccidentReportTableViewController: UITableViewController {

    let singleton = Global.sharedGlobal
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var Reportes: UITableView!
    var objectNum = Int()
    
    
    var dictionary: Dictionary<String,AnyObject> = ["":""]
    var swap: Dictionary<String,AnyObject> = ["":""]
    var sorted: Dictionary<String,AnyObject> = ["":""]
    var dont = true
    var dictionary1: Dictionary<String,AnyObject> = ["":""]
    var dictionary2: Dictionary<String,AnyObject> = ["":""]
    var converterObject: Dictionary<String,AnyObject> = ["":""]
    var converterArray = Array<AnyObject>()
    var converterObject1: Dictionary<String,AnyObject> = ["":""]
    var converterArray1 = Array<AnyObject>()
    var listRemoveIndex: Array<Int> = Array()
    var myArray = Array<AnyObject> ()
    var myArrayTemp = Array<AnyObject> ()
    var foreignKeys = Array<String> ()
    
    var transition = false
    
    var thereIsCellTapped = false
    var selectedRowIndex = -1
    var caseNumber: Dictionary<String,AnyObject>=["":""]
    
    
    
    
    @IBOutlet weak var reportText: UITextView!
    
    override func viewDidDisappear(animated: Bool) {
         singleton.firstTabInfo[0].sawReport = false


    }
    
    
    override func viewDidLoad() {
        
        Reportes.delegate = self
        Reportes.dataSource = self
        super.viewDidLoad()
        
        let WebServiceQuery = WebService.init()
        WebServiceQuery.initiate(1)
        
        dictionary = WebServiceQuery.getListOfReports(singleton.foreignKeys[0].officerPlate)
        dictionary1 = (dictionary["success"] as? Dictionary<String,AnyObject>)!
        myArray = (dictionary1["ReportList"] as? Array<AnyObject>)!
        
        transition = true
        myArrayTemp = myArray
  
        myArrayTemp.removeAll()
        myArrayTemp.insert(myArray[0], atIndex: 0)
        var indices = 1
        
        for i in myArray.startIndex..<myArray.endIndex
        {
//            print(myArrayTemp[indices-1]["CaseNumber"],myArray[i]["CaseNumber"])
//            if ((myArrayTemp[indices-1]["CaseNumber"] as? String) != (myArray[i]["CaseNumber"] as? String))
//            {
//                myArrayTemp.insert(myArray[i], atIndex: indices)
//                indices += 1
//            }
            for j in myArrayTemp.startIndex..<myArrayTemp.endIndex {
                if myArray[i]["CaseNumber"] as? String == myArrayTemp[j]["CaseNumber"] as? String {
                    dont = true
                    break
                }else{
                    dont = false
                }
            }
            if !dont{
                myArrayTemp.insert(myArray[i], atIndex: indices)
                indices += 1
            }
          
        }
        print("Here is start",myArrayTemp,"here is end")
        tableView.reloadData()
   
        navigationController!.navigationBar.barTintColor = UIColor (red:28.0/255.0, green:69.0/255.0, blue:135.0/255.0, alpha:1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            //menuButton.action = "revealToggle:"
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }

        
        for x in myArrayTemp.startIndex..<myArrayTemp.endIndex {
            //            print(myArrayTemp[x])
            for y in myArrayTemp.startIndex..<myArrayTemp.endIndex {
                
                //                sorted = (myArrayTemp[x] as? Dictionary<String,AnyObject>)!
                
                
                let theDate1 = NSDateFormatter()
                theDate1.dateFormat = "MM-dd-yyyy"
                let theDate2 = NSDateFormatter()
                theDate2.dateFormat = "MM-dd-yyyy"
                if theDate1.dateFromString((myArrayTemp[x]["crashDate"] as? String)!) == nil {
                    theDate1.dateFormat = "MMM dd, yyyy"
                    theDate1.dateFromString((myArrayTemp[x]["crashDate"] as? String)!)
                    //print(theDate1)
                    
                    if theDate1.dateFromString((myArrayTemp[x]["crashDate"] as? String)!) == nil {
                        theDate1.dateFormat = "MM/dd/yyyy"
                        theDate1.dateFromString((myArrayTemp[x]["crashDate"] as? String)!)
                        if theDate1.dateFromString((myArrayTemp[x]["crashDate"] as? String)!) == nil {
                            theDate1.dateFormat = "yyyy/MM/dd"
                            theDate1.dateFromString((myArrayTemp[x]["crashDate"] as? String)!)
                            if theDate1.dateFromString((myArrayTemp[x]["crashDate"] as? String)!) == nil {
                                theDate1.dateFormat = "yyyy-MM-dd"
                                theDate1.dateFromString((myArrayTemp[x]["crashDate"] as? String)!)
                                if theDate1.dateFromString((myArrayTemp[x]["crashDate"] as? String)!) == nil {
                                    theDate1.dateFormat = "yyyy-dd-mm"
                                    theDate1.dateFromString((myArrayTemp[x]["crashDate"] as? String)!)
                                    
                                }
                            }
                        }
                        
                    }
                    
                    
                }else{
                    //print(theDate1)
                    
                }
                if theDate2.dateFromString((myArrayTemp[y]["crashDate"] as? String)!) == nil {
                    theDate2.dateFormat = "MMM dd, yyyy"
                    theDate2.dateFromString((myArrayTemp[y]["crashDate"] as? String)!)
                    //print(theDate2)
                    if theDate2.dateFromString((myArrayTemp[y]["crashDate"] as? String)!) == nil{
                        theDate2.dateFormat = "MM/dd/yyyy"
                        if theDate2.dateFromString((myArrayTemp[y]["crashDate"] as? String)!) == nil {
                            theDate2.dateFormat = "yyyy/MM/dd"
                            theDate2.dateFromString((myArrayTemp[y]["crashDate"] as? String)!)
                            if theDate2.dateFromString((myArrayTemp[y]["crashDate"] as? String)!) == nil {
                                theDate2.dateFormat = "yyyy-MM-dd"
                                theDate2.dateFromString((myArrayTemp[y]["crashDate"] as? String)!)
                                if theDate2.dateFromString((myArrayTemp[y]["crashDate"] as? String)!) == nil {
                                    theDate2.dateFormat = "yyyy-dd-mm"
                                    theDate2.dateFromString((myArrayTemp[y]["crashDate"] as? String)!)
                                    
                                }
                            }
                        }
                    }
                    
                }else{
                    //print(theDate2)
                }
                
                let firstDate = theDate1.dateFromString((myArrayTemp[x]["crashDate"] as? String)!)
                let secondDate = theDate2.dateFromString((myArrayTemp[y]["crashDate"] as? String)!)
                
                //                print((myArrayTemp[x]["crashDate"]))
                //                print((myArrayTemp[y]["crashDate"]))
                //                print("here dates")
                //                print(firstDate)
                //                print(secondDate)
                
                
                if firstDate?.compare(secondDate!) == .OrderedAscending {
                    //                    print("Older",firstDate)
                    
                }else{
                    swap = myArrayTemp[x] as! Dictionary<String, AnyObject>
                    myArrayTemp[x] = myArrayTemp[y]
                    myArrayTemp[y] = swap
                    //                    print("Older",secondDate)
                }//end of comparison
                
                
                
                
                
                
            }
        }

        
        self.tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
        Reportes.reloadData()
        self.tableView.reloadData()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }



    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int
        if transition {
            rows = myArrayTemp.count
        }else{
            rows = 0
        }
        return rows
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        var cellName: String
                dictionary = (myArrayTemp[indexPath.row] as? Dictionary<String,AnyObject>)!
        if transition {
            if cell.detailTextLabel == nil {
//                print("estecoso")
                
                cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell")
            }
            
            cellName = "Numero de Caso: "
            cellName += (dictionary["CaseNumber"] as? String)!
            
            var cellNameSub = "Fecha: "
            cellNameSub += (dictionary["crashDate"] as? String)!
            cellNameSub += " / "
            cellNameSub += "Tipo de Accidente: "
            cellNameSub += (dictionary["crashType"] as? String)!
            cell.textLabel?.text = cellName
            

            cell.detailTextLabel?.text = cellNameSub
            
        }else{
            
            cell.textLabel?.text = "null"
            
        }
        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == selectedRowIndex && thereIsCellTapped {
            return 44
        }
        
        return 44
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       
        
        self.tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor.grayColor()
        
        // avoid paint the cell is the index is outside the bounds
        if self.selectedRowIndex != -1 {
            self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: self.selectedRowIndex, inSection: 0))?.backgroundColor = UIColor.whiteColor()
        }
        if selectedRowIndex != indexPath.row {
            self.thereIsCellTapped = true
            self.selectedRowIndex = indexPath.row
        }
        else {
            // there is no cell selected anymore
            self.thereIsCellTapped = false
            self.selectedRowIndex = -1
        }
                dictionary2 = (myArrayTemp[(indexPath.row)] as? Dictionary<String,AnyObject>)!
//            print("this is myarray",myArray)
//                var message = dictionary2["firstName"] as? String
//                message?.appendContentsOf((dictionary2["lastName"] as? String)!)
                caseNumber["num"] = (dictionary2["CaseNumber"] as? String )
        
        
        
                let alertController = UIAlertController(title: "Informacion Presente", message:
                    nil, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ver reporte completo.", style: UIAlertActionStyle.Default,handler: letsReport))
                alertController.addAction(UIAlertAction(title: "Dismiss.", style: UIAlertActionStyle.Default,handler: nil))
        
                self.presentViewController(alertController, animated: true, completion: nil)

        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    func letsReport(action: UIAlertAction){
        
        
        singleton.listNum[0] = 0
        singleton.listNum[1] = 0
    
        for i in singleton.listPeople.startIndex..<singleton.listPeople.endIndex {
            singleton.listPeople[i].counter = 0
        }
        for i in singleton.listVehicle.startIndex..<singleton.listVehicle.endIndex {
            singleton.listVehicle[i].counter = 0
        }
        
        
        singleton.listPeople.removeAll()
     
        singleton.listVehicle.removeAll()
        let WebServicesQuery = WebService.init()
        let stringed = caseNumber["num"] as? String
        let stringeded = stringed
        var message = WebServicesQuery.letsReport(stringeded!)

        converterObject1 = (message["success"] as? Dictionary<String,AnyObject>!)!
        converterArray1 = converterObject1["ReportList"] as! Array<AnyObject>
        let thisNewObject = converterArray1.popLast()
        //print(thisNewObject!["address"])
        let thisNewNewObject = thisNewObject!["idCrashBasicInformation"]
        
        //print("were over here",caseNumber["num"]?.integerValue)
        singleton.foreignKeys[0].accidentCondition = thisNewNewObject!!.integerValue
        singleton.foreignKeys[0].crashBasicInformation = (caseNumber["num"]?.integerValue)!
        
        getTouchedTable(stringeded!)
        
    }
    func segueBack(){
        performSegueWithIdentifier("firstPage", sender: self)
    }

    
    func alertYou(alertMessage: String)->Void{
        let alertController = UIAlertController(title: "Informacion Presente", message:
            alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss.", style: UIAlertActionStyle.Default,handler: nil))
    }

    
    
    func getTouchedTable(caseNumberString: String){
        let WebServicesQuery = WebService.init()
        //let caseNumber = singleton.foreignKeys[0].crashBasicInformation
        let accidentFK = singleton.foreignKeys[0].accidentCondition
        singleton.foreignKeys[0].crashBasicInformation = 0
        singleton.foreignKeys[0].accidentCondition = 0
        //print(singleton.foreignKeys[0].crashBasicInformation)
        
        let firstTab = WebServicesQuery.letsReport(caseNumberString)
        let secondTab = WebServicesQuery.secondTab(String(accidentFK))
        let newPerson = WebServicesQuery.personTab(String(accidentFK))
        let newVehicle = WebServicesQuery.vehicleTab(String(accidentFK))
        let narrative = WebServicesQuery.narrativeTab(String(accidentFK))
       
        
        //print("Here we are!",firstTab)
//        print(secondTab)
//        print(newPerson)
//        print(newVehicle)
//        print(narrative)
        
        converterObject = (firstTab["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
        //print(converterArray)
        firstTabFormat(String(converterArray))
        
        converterObject = (secondTab["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
        //        print(converterArray)
        secondTabFormat(String(converterArray))
        
        converterObject = (newPerson["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
        
        //singleton.listPeople[0].arrayPerson.removeAll()
        //singleton.listVehicle[0].arrayVehicle.removeAll()
        
        for i in converterArray.startIndex..<converterArray.endIndex {
            personTabFormat(String(converterArray[i]))
        }
        
        for i in foreignKeys.startIndex..<foreignKeys.endIndex{
            let personExtended = WebServicesQuery.personExtendedTab((String(foreignKeys[i])))
            converterObject = (personExtended["success"] as? Dictionary<String,AnyObject>)!
            converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
            personExtendedTabFormat(String(converterArray))
        }
        
        foreignKeys.removeAll()
        
        converterObject = (newVehicle["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
   
        
        for i in converterArray.startIndex..<converterArray.endIndex {
            vehicleTabFormat(String(converterArray[i]))
        }
        
        for i in foreignKeys.startIndex..<foreignKeys.endIndex{
            let vehicleExtended = WebServicesQuery.vehicleExtendedTab((String(foreignKeys[i])))
            converterObject = (vehicleExtended["success"] as? Dictionary<String,AnyObject>)!
            converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
            vehicleExtendedTabFormat(String(converterArray))
            print(converterArray)
        }
        foreignKeys.removeAll()
        
        
     
        
        converterObject = (narrative["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
        //print(converterArray)
        thirdTabFormat(String(converterArray))
        
        singleton.firstTabInfo[0].sawReport = true
        singleton.firstTabInfo[0].sawReportOnce = true
        
        segueBack()
        
    }
    
    
    
    
    func firstTabFormat(firstTab: String){
        var value = ""
    
        if firstTab != "[]"{
            //        print(firstTab)
            
            for i in firstTab.startIndex..<firstTab.endIndex {
                if firstTab.startIndex.distanceTo(i) == 17 {
                    var j = i
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                    }
                }
                
            }
            singleton.firstTabInfo[0].firstTab["address"] = value
            //        print(singleton.firstTabInfo[0].firstTab["address"],"this one")
            value = ""
            
            for i in firstTab.rangeOfString("caseNumber")!.startIndex ..< firstTab.endIndex {
                var j = i
                //j = j.advancedBy(12, limit: firstTab.endIndex)
                
                if i == firstTab.rangeOfString("caseNumber")!.endIndex.advancedBy(3) {
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
                    singleton.firstTabInfo[0].firstTab["unitVehiculos"] = value
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
        
        
        
        
        
    }
    
    func secondTabFormat(firstTab: String){
        var value = ""
        
        if firstTab != "[]" {
            for i in firstTab.rangeOfString("collisionTypeDescriptionES")!.startIndex ..< firstTab.endIndex {
                var j = i
                //j = j.advancedBy(12, limit: firstTab.endIndex)
                
                if i == firstTab.rangeOfString("collisionTypeDescriptionES")!.endIndex.advancedBy(3) {
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
            //        print(value)
            //        
            //        print(singleton.firstTabInfo[0].firstTab,"thisinfor",singleton.firstTabInfo[0].secondTab)
            //        
            

        }
        
    }
    
    func thirdTabFormat(firstTab: String){
        var value = ""
        
        if firstTab != "[]"{
            for i in firstTab.rangeOfString("details")!.startIndex ..< firstTab.endIndex {
                var j = i
                //j = j.advancedBy(12, limit: firstTab.endIndex)
                
                if i == firstTab.rangeOfString("details")!.endIndex.advancedBy(3) {
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
                
                
                //            
                //            print(value)
                //            
                //            print(singleton.firstTabInfo[0].firstTab,"thisinfor")
                
            }

        }
    }
    
    func personTabFormat(firstTab: String){
        var value = ""
//        print(firstTab)
        if firstTab != "[]"{
            for i in firstTab.rangeOfString("city")!.startIndex ..< firstTab.endIndex {
                var j = i
                //j = j.advancedBy(12, limit: firstTab.endIndex)
                
                
                if i == firstTab.rangeOfString("idNewPerson")!.endIndex.advancedBy(3) {
                    j = i;
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personTab["idNewPerson"] = value
                    value = ""
                }
                
                
                
                
                if i == firstTab.rangeOfString("city")!.endIndex.advancedBy(3) {
                    j = i;
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personTab["city"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("expirationDate")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personTab["expirationDate"] = value
                    value = ""
                    
                }
                if i == firstTab.rangeOfString("gender")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personTab["gender"] = value
                    value = ""
                    
                }
                if i == firstTab.rangeOfString("licenceNumber")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personTab["licenceNumber"] = value
                    value = ""
                    
                }
                
                if i == firstTab.rangeOfString("licenseType")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personTab["licenseType"] = value
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
                    singleton.firstTabInfo[0].personTab["name"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("neighborhood")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personTab["neighborhood"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("organDonor")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personTab["organDonor"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("phoneNumber")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personTab["phoneNumber"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("stateCountry")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personTab["stateCountry"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("streetName")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personTab["streetName"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("zipCode")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personTab["zipCode"] = value
                    value = ""
                }
                
                
            }
            print(singleton.firstTabInfo[0].personTab,"thisinfor")
            singleton.listNum[1] += 1
            
            let newPerson = People(person: singleton.firstTabInfo[0].personTab)
            foreignKeys.append(singleton.firstTabInfo[0].personTab["idNewPerson"]!)
            //let thisThing =  as? Dictionary<String,AnyObject>
            singleton.listPeople.append(newPerson)
        }
       
    }

    func vehicleTabFormat(firstTab: String){
        var value = ""
       // print(firstTab)
        if firstTab != "[]"{
            for i in firstTab.rangeOfString("expirationDate")!.startIndex ..< firstTab.endIndex {
                var j = i
                //j = j.advancedBy(12, limit: firstTab.endIndex)
                
                
                
                if i == firstTab.rangeOfString("idNewVehicle")!.endIndex.advancedBy(3) {
                    j = i;
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleTab["idNewVehicle"] = value
                    value = ""
                }
                
                
                
                
                
                if i == firstTab.rangeOfString("expirationDate")!.endIndex.advancedBy(3) {
                    j = i;
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleTab["expirationDate"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("insuranceCompany")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleTab["insuranceCompany"] = value
                    value = ""
                    
                }
                if i == firstTab.rangeOfString("licenceNumber")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleTab["licenceNumber"] = value
                    value = ""
                    
                }
                if i == firstTab.rangeOfString("make")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleTab["make"] = value
                    value = ""
                    
                }
                
                if i == firstTab.rangeOfString("modelos")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleTab["modelos"] = value
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
                    singleton.firstTabInfo[0].vehicleTab["name"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("plateNumber")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleTab["plateNumber"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("purchaseDate")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleTab["purchaseDate"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("registrationNumber")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleTab["registrationNumber"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("state")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleTab["state"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("vehicleJurisdiction")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleTab["vehicleJurisdiction"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("vin")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleTab["vin"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("year")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleTab["year"] = value
                    value = ""
                }
                
                
            }
            //print(singleton.firstTabInfo[0].vehicleTab,"thisinfor")
            singleton.listNum[0] += 1
            foreignKeys.append(singleton.firstTabInfo[0].vehicleTab["idNewVehicle"]!)
            let newVehicle = Vehicle(vehicle: singleton.firstTabInfo[0].vehicleTab)
            //let thisThing =  as? Dictionary<String,AnyObject>
            singleton.listVehicle.append(newVehicle)
        }
        
    }
    
    
    func personExtendedTabFormat(firstTab: String){
        var value = ""
        print(firstTab)
        if firstTab != "[]" {
            for i in firstTab.rangeOfString("actionsAtCollisionTime")!.startIndex ..< firstTab.endIndex {
                var j = i
                //j = j.advancedBy(12, limit: firstTab.endIndex)
                
                
                if i == firstTab.rangeOfString("actionsAtCollisionTime")!.endIndex.advancedBy(3) {
                    j = i;
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["actionsAtCollisionTime"] = value
                    value = ""
                }
                
                
                
                
                if i == firstTab.rangeOfString("actionsBeforeCollision")!.endIndex.advancedBy(3) {
                    j = i;
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["actionsBeforeCollision"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("airbagsActivation")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["airbagsActivation"] = value
                    value = ""
                    
                }
                if i == firstTab.rangeOfString("ambulanceCSPNumber")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["ambulanceCSPNumber"] = value
                    value = ""
                    
                }
                if i == firstTab.rangeOfString("categoryPerson")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["categoryPerson"] = value
                    value = ""
                    
                }
                
                if i == firstTab.rangeOfString("conditionCollisionTime")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["conditionCollisionTime"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("distractedBy")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["distractedBy"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("distractedDriverBy")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["distractedDriverBy"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("driverCirncunstanceBC")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["driverCirncunstanceBC"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("expulsion")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["expulsion"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("extraction")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["extraction"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("inWayToSchool")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["inWayToSchool"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("locationWhenCollision")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["locationWhenCollision"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("medicalEmergenciesNumber")!.endIndex.advancedBy(3) {
                    j = i;
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["medicalEmergenciesNumber"] = value
                    value = ""
                }
                
                
                
                
                if i == firstTab.rangeOfString("otherLocation")!.endIndex.advancedBy(3) {
                    j = i;
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["otherLocation"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("restraintSystem")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["restraintSystem"] = value
                    value = ""
                    
                }
                if i == firstTab.rangeOfString("row")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["row"] = value
                    value = ""
                    
                }
                if i == firstTab.rangeOfString("safetyEquipmentUsed")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["safetyEquipmentUsed"] = value
                    value = ""
                    
                }
                
                if i == firstTab.rangeOfString("seat")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["seat"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("speedRelated")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["speedRelated"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("suscpectControlledSubstances")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["suscpectControlledSubstances"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("suspectAlcoholUse")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["suspectAlcoholUse"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("testResultAl")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["testResultAl"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("testResultSub")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["testResultSub"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("testResultTP")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["testResultTP"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("testStatusAl")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["testStatusAl"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("testStatusSub")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["testStatusSub"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("testTypeAl")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["testTypeAl"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("testTypeSub")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["testTypeSub"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("transportedBy")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["transportedBy"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("transportedByME")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["transportedByME"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("transportedTo")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["transportedTo"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("typePerson")!.endIndex.advancedBy(3) {
                    j = i;
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].personExtenTab["typePerson"] = value
                    value = ""
                }
                
                
                
            }
            //print(singleton.firstTabInfo[0].personExtenTab,"thisinfor")
            //        let counter  = singleton.listPeople[0].counter
            //        print(counter)
            singleton.listPeople[0].arrayPerson.append(singleton.firstTabInfo[0].personExtenTab)
            singleton.listPeople[0].counter += 1

        }
        
    }
    
    func vehicleExtendedTabFormat(firstTab: String){
        var value = ""
       // print(firstTab)
        if firstTab != "[]"{
            for i in firstTab.rangeOfString("affectedArea")!.startIndex ..< firstTab.endIndex {
                var j = i
                //j = j.advancedBy(12, limit: firstTab.endIndex)
                
                
                if i == firstTab.rangeOfString("affectedArea")!.endIndex.advancedBy(3) {
                    j = i;
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["affectedArea"] = value
                    value = ""
                }
                
                
                
                
                if i == firstTab.rangeOfString("alignment")!.endIndex.advancedBy(3) {
                    j = i;
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["alignment"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("authorizedDriver")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["authorizedDriver"] = value
                    value = ""
                    
                }
                if i == firstTab.rangeOfString("busUse")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["busUse"] = value
                    value = ""
                    
                }
                if i == firstTab.rangeOfString("commercialVehicleUse")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["commercialVehicleUse"] = value
                    value = ""
                    
                }
                
                if i == firstTab.rangeOfString("cuartaCategoria")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["cuartaCategoria"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("cuartoEvent")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["cuartoEvent"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("descriptionRoad")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["descriptionRoad"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("diamondIdNumber")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["diamondIdNumber"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("directionTripCB")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["directionTripCB"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("extendDamage")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["extendDamage"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("functionSpecialMVT")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["functionSpecialMVT"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("grossWeight")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["grossWeight"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("hazardousMaterial")!.endIndex.advancedBy(3) {
                    j = i;
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["hazardousMaterial"] = value
                    value = ""
                }
                
                
                
                
                if i == firstTab.rangeOfString("heavyVehicleType")!.endIndex.advancedBy(3) {
                    j = i;
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["heavyVehicleType"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("inOperationLost")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["inOperationLost"] = value
                    value = ""
                    
                }
                if i == firstTab.rangeOfString("initialContactPoint")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["initialContactPoint"] = value
                    value = ""
                    
                }
                if i == firstTab.rangeOfString("inspectionUpdate")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["inspectionUpdate"] = value
                    value = ""
                    
                }
                
                if i == firstTab.rangeOfString("laneCantidad")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["laneCantidad"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("laneCategoria")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["laneCategoria"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("laneTipoCarril")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["laneTipoCarril"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("lefthPlace")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["lefthPlace"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("mPH")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["mPH"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("mPHDescription")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["mPHDescription"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("maneuverVehicleMotor")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["maneuverVehicleMotor"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("motorEmergencyVU")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["motorEmergencyVU"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("occupants")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["occupants"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("primerDefectoMec")!.endIndex {
                    j=i;
                    j = j.advancedBy(13)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["primerDefectoMec"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("primerEvent")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["primerEvent"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("primeraCategoriaEvent")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["primeraCategoriaEvent"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("segundaCategoriaEvent")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["segundaCategoriaEvent"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("segundoDefectoMec")!.endIndex {
                    j=i;
                    j = j.advancedBy(13)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["segundoDefectoMec"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("segundoEvent")!.endIndex.advancedBy(3) {
                    j = i;
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["segundoEvent"] = value
                    value = ""
                }
                
                if i == firstTab.rangeOfString("slope")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["slope"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("specialPermit")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["specialPermit"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("tecerEvent")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["tecerEvent"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("terceraCategoriaEvent")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["terceraCategoriaEvent"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("thereHazardousMaterial")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["thereHazardousMaterial"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("totalAxis")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["totalAxis"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("towedDamage")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["towedDamage"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("typeControlTraffic")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["typeControlTraffic"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("vehicleConfiguration")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["vehicleConfiguration"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("vehicleMotor")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["vehicleMotor"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("vehicleMoving")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["vehicleMoving"] = value
                    value = ""
                }
                if i == firstTab.rangeOfString("vehicleType")!.endIndex {
                    j=i;
                    j = j.advancedBy(3)
                    while firstTab[j] != ";" {
                        value.append(firstTab[j])
                        j = j.advancedBy(1)
                        //                    print(value)
                    }
                    singleton.firstTabInfo[0].vehicleExtendTab["vehicleType"] = value
                    value = ""
                }
                
            }
            
            //print(singleton.firstTabInfo[0].vehicleExtendTab,"thisinfor")
            let counter  = singleton.listVehicle[0].counter
            
            singleton.listVehicle[0].arrayVehicle[counter] = singleton.firstTabInfo[0].vehicleExtendTab
            singleton.listVehicle[0].counter += 1
        }

        }
        
    
}
