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
    var dictionary1: Dictionary<String,AnyObject> = ["":""]
    var dictionary2: Dictionary<String,AnyObject> = ["":""]
    var converterObject: Dictionary<String,AnyObject> = ["":""]
    var converterArray = Array<AnyObject>()
    var converterObject1: Dictionary<String,AnyObject> = ["":""]
    var converterArray1 = Array<AnyObject>()
    var listRemoveIndex: Array<Int> = Array()
    var myArray = Array<AnyObject> ()
    var myArrayTemp = Array<AnyObject> ()
    
    var transition = false
    
    var thereIsCellTapped = false
    var selectedRowIndex = -1
    var caseNumber: Dictionary<String,AnyObject>=["":""]
    
    
    
    
    @IBOutlet weak var reportText: UITextView!
    
    override func viewDidLoad() {
        Reportes.delegate = self
        Reportes.dataSource = self
        super.viewDidLoad()

        
        
        let WebServiceQuery = WebService.init()
        WebServiceQuery.initiate(1)

//        print(singleton.foreignKeys[0].officerPlate)
       // singleton.foreignKeys[0].accidentCondition =
        
        dictionary = WebServiceQuery.getListOfReports(singleton.foreignKeys[0].officerPlate)
        dictionary1 = (dictionary["success"] as? Dictionary<String,AnyObject>)!
        myArray = (dictionary1["ReportList"] as? Array<AnyObject>)!
        
        print(myArray.count)
        var indices = 0
        transition = true
        myArrayTemp = myArray
        for i in myArray.startIndex..<myArray.endIndex {
            for j in i..<myArray.endIndex {
                if (myArray[i]["CaseNumber"] as? String) == (myArray[j]["CaseNumber"] as? String){
                   print(i,j)
                    listRemoveIndex.insert(j, atIndex: indices)
                    //listRemoveIndex[indices] = i
                    indices += 1
                    //myArrayTemp.removeAtIndex(i)
                }
            }
            
        }
        myArrayTemp.removeAll()
        myArrayTemp.insert(myArray[0], atIndex: 0)
        indices = 1
        for i in myArray.startIndex..<myArray.endIndex {
            print(myArrayTemp[indices-1]["CaseNumber"],myArray[i]["CaseNumber"])
            if ((myArrayTemp[indices-1]["CaseNumber"] as? String) != (myArray[i]["CaseNumber"] as? String)){
                myArrayTemp.insert(myArray[i], atIndex: indices)
                indices += 1
            }
          
        }
//        print(listRemoveIndex)
////        indices = 0
////        for var i in listRemoveIndex.startIndex..<listRemoveIndex.endIndex {
////            for j in i.advancedBy(1)..<listRemoveIndex.endIndex {
////                if listRemoveIndex[i] == listRemoveIndex[j] {
////                    print("indices",indices)
////                    print("i",i)
////                    print("j",j)
////                    print("subtraction",i-indices)
////                    //print(myArray)
////                    myArray.removeAtIndex(listRemoveIndex[i-indices])
////                    indices += 1
////                    break
////                }
////                
////                
////            }
////            
////        }
        
        self.tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
        Reportes.reloadData()
        self.tableView.reloadData()
        
        tableView.reloadData()
        //print(WebServiceQuery.getListOfReports("Apr 1, 2017"))
        
        
        
        
        
        
        
        navigationController!.navigationBar.barTintColor = UIColor (red:28.0/255.0, green:69.0/255.0, blue:135.0/255.0, alpha:1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            //menuButton.action = "revealToggle:"
            
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }

        
        self.tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
        Reportes.reloadData()
        self.tableView.reloadData()
        
        
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        var cellName: String
        dictionary = (myArrayTemp[indexPath.row] as? Dictionary<String,AnyObject>)!
//        for i in dictionary {
//            if dictionary[i]
//        }
        if transition {
            cellName = "Numero de Caso: "
            cellName += (dictionary["CaseNumber"] as? String)!
            cellName += " / "
            cellName += "Fecha: "
            cellName += (dictionary["crashDate"] as? String)!
            cellName += " / "
            cellName += "Tipo de Accidente: "
            cellName += (dictionary["crashType"] as? String)!


            
            cell.textLabel?.text = cellName
            
        }else{
            
            cell.textLabel?.text = "null"
            
        }
        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == selectedRowIndex && thereIsCellTapped {
            return 140
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
//        print(dictionary)
//        print(myArray[(indexPath.row)])
                dictionary2 = (myArrayTemp[(indexPath.row)] as? Dictionary<String,AnyObject>)!
        
        

        
            print("this is myarray",myArray)
                var message = dictionary2["firstName"] as? String
                message?.appendContentsOf((dictionary2["lastName"] as? String)!)
                message?.appendContentsOf(" -> ")
                message?.appendContentsOf((dictionary2["crashType"] as? String)!)
                 message?.appendContentsOf(" -> ")
                message?.appendContentsOf((dictionary2["crashDate"] as? String)!)
                 message?.appendContentsOf(" -> ")
                message?.appendContentsOf((dictionary2["countryDescriptionES"] as? String)!)
                 message?.appendContentsOf(" -> ")
                message?.appendContentsOf((dictionary2["address"] as? String)!)
                caseNumber["num"] = (dictionary2["CaseNumber"] as? String )
        
        
        
                let alertController = UIAlertController(title: "Informacion Presente", message:
                    nil, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ver reporte completo.", style: UIAlertActionStyle.Default,handler: letsReport))
                alertController.addAction(UIAlertAction(title: "Dismiss.", style: UIAlertActionStyle.Default,handler: nil))
        
                self.presentViewController(alertController, animated: true, completion: nil)

        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    func letsReport(action: UIAlertAction){
        let WebServicesQuery = WebService.init()
        let stringed = caseNumber["num"] as? String
        let stringeded = stringed
        print(stringeded)
        var message = WebServicesQuery.letsReport(stringeded!)
        
        
        
        print(message)
        converterObject1 = (message["success"] as? Dictionary<String,AnyObject>!)!
        converterArray1 = converterObject1["ReportList"] as! Array<AnyObject>
        let thisNewObject = converterArray1.popLast()
        print(thisNewObject!["address"])
        let thisNewNewObject = thisNewObject!["idCrashBasicInformation"]
        
        print("were over here",caseNumber["num"]?.integerValue)
        singleton.foreignKeys[0].accidentCondition = thisNewNewObject!!.integerValue
        singleton.foreignKeys[0].crashBasicInformation = (caseNumber["num"]?.integerValue)!
        
        getTouchedTable(stringeded!)
        
    }
    func segueBack(){
        //performSegueWithIdentifier("displayReport", sender: self)
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
        print(singleton.foreignKeys[0].crashBasicInformation)
        
        let firstTab = WebServicesQuery.letsReport(caseNumberString)
        let secondTab = WebServicesQuery.secondTab(String(accidentFK))
        let newPerson = WebServicesQuery.personTab(String(accidentFK))
        let newVehicle = WebServicesQuery.vehicleTab(String(accidentFK))
        let narrative = WebServicesQuery.narrativeTab(String(accidentFK))
        
        print("Here we are!",firstTab)
//        print(secondTab)
//        print(newPerson)
//        print(newVehicle)
//        print(narrative)
        
        converterObject = (firstTab["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
        //print(converterArray)
        firstTabFormat(String(converterArray))
        
        
//        reportText.insertText(String(converterArray))
        
        converterObject = (secondTab["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
        //        print(converterArray)
        secondTabFormat(String(converterArray))
        
//        reportText.insertText(String(converterArray))
        
        converterObject = (newPerson["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
        print(converterArray)
        //personTabFormat(String(converterArray))
        
//        reportText.insertText(String(converterArray))
        
        converterObject = (newVehicle["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
        //print(converterArray)
        
//        reportText.insertText(String(converterArray))
        
        converterObject = (narrative["success"] as? Dictionary<String,AnyObject>)!
        converterArray = (converterObject["ReportList"] as? Array<AnyObject>)!
        //print(converterArray)
        thirdTabFormat(String(converterArray))
//        reportText.insertText(String(converterArray))
        
        singleton.firstTabInfo[0].sawReport = true
        
        segueBack()
    }
    
    
    
    
    func firstTabFormat(firstTab: String){
        var value = ""
        var first = false
        
        print(firstTab)
        
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
    
    func secondTabFormat(firstTab: String){
        var value = ""
        var first = false
        
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
    
    func thirdTabFormat(firstTab: String){
        var value = ""
        var first = false
        
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
    
//    func personTabFormat(firstTab: String){
//        var value = ""
//        var first = false
//        
//        for i in firstTab.rangeOfString("details")!.startIndex ..< firstTab.endIndex {
//            var j = i
//            //j = j.advancedBy(12, limit: firstTab.endIndex)
//            
//            if i == firstTab.rangeOfString("details")!.endIndex.advancedBy(3) {
//                j = i;
//                while firstTab[j] != ";" {
//                    value.append(firstTab[j])
//                    j = j.advancedBy(1)
//                    //                    print(value)
//                }
//                singleton.firstTabInfo[0].thirdTab["details"] = value
//                value = ""
//            }
//            if i == firstTab.rangeOfString("notifiedTimeEmergencie")!.endIndex {
//                j=i;
//                j = j.advancedBy(3)
//                while firstTab[j] != ";" {
//                    value.append(firstTab[j])
//                    j = j.advancedBy(1)
//                    //                    print(value)
//                }
//                singleton.firstTabInfo[0].thirdTab["notifiedTimeEmergencie"] = value
//                value = ""
//                
//            }
//            if i == firstTab.rangeOfString("notifiedTimePolice")!.endIndex {
//                j=i;
//                j = j.advancedBy(3)
//                while firstTab[j] != ";" {
//                    value.append(firstTab[j])
//                    j = j.advancedBy(1)
//                    //                    print(value)
//                }
//                singleton.firstTabInfo[0].thirdTab["notifiedTimePolice"] = value
//                value = ""
//                
//            }
//            if i == firstTab.rangeOfString("timeOfArrivalEmergencie")!.endIndex {
//                j=i;
//                j = j.advancedBy(3)
//                while firstTab[j] != ";" {
//                    value.append(firstTab[j])
//                    j = j.advancedBy(1)
//                    //                    print(value)
//                }
//                singleton.firstTabInfo[0].thirdTab["timeOfArrivalEmergencie"] = value
//                value = ""
//                
//            }
//            
//            if i == firstTab.rangeOfString("timeOfArrivalPolice")!.endIndex {
//                j=i;
//                j = j.advancedBy(3)
//                while firstTab[j] != ";" {
//                    value.append(firstTab[j])
//                    j = j.advancedBy(1)
//                    //                    print(value)
//                }
//                singleton.firstTabInfo[0].thirdTab["timeOfArrivalPolice"] = value
//                value = ""
//                
//            }
//            
//            
//            
//            print(value)
//            
//            print(singleton.firstTabInfo[0].firstTab,"thisinfor")
//            
//            
//            
//            
//        }
//        
//        
//        
//    }

    
    
    
}
