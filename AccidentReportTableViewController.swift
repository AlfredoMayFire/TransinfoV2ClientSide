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
    var myArray = Array<AnyObject> ()
    
    var transition = false
    
    var thereIsCellTapped = false
    var selectedRowIndex = -1
    var caseNumber: Dictionary<String,AnyObject>=["":""]
    
    override func viewDidLoad() {
        Reportes.delegate = self
        Reportes.dataSource = self
        super.viewDidLoad()

        
        
        let WebServiceQuery = WebService.init()
        WebServiceQuery.initiate(1)

        print(singleton.foreignKeys[0].officerPlate)
       // singleton.foreignKeys[0].accidentCondition =
        
        dictionary = WebServiceQuery.getListOfReports(singleton.foreignKeys[0].officerPlate)
        dictionary1 = (dictionary["success"] as? Dictionary<String,AnyObject>)!
        myArray = (dictionary1["ReportList"] as? Array<AnyObject>)!
        
        transition = true
        
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
            rows = myArray.count
        }else{
            rows = 0
        }
        return rows
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        var cellName: String
        dictionary = (myArray[indexPath.row] as? Dictionary<String,AnyObject>)!
        if transition {
            cellName = "Plate Number: "
            cellName += (dictionary["plateNumber"] as? String)!
            
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
        
        print(myArray[(indexPath.row)])
                dictionary2 = (myArray[(indexPath.row)] as? Dictionary<String,AnyObject>)!
        
        
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
                caseNumber["num"] = (dictionary2["CaseNumber"] )
        
        
        
                let alertController = UIAlertController(title: "Informacion Presente", message:
                    message, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss.", style: UIAlertActionStyle.Default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Ver reporte completo.", style: UIAlertActionStyle.Default,handler: letsReport))
                
                self.presentViewController(alertController, animated: true, completion: nil)

        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    func letsReport(action: UIAlertAction){
        let WebServicesQuery = WebService.init()
        
        var message = WebServicesQuery.letsReport((caseNumber["num"]as? String )!)
        
        print(message)
        converterObject = (message["success"] as? Dictionary<String,AnyObject>!)!
        converterArray = converterObject["ReportList"] as! Array<AnyObject>
        let thisNewObject = converterArray.popLast()
        print(thisNewObject!["address"])
        let thisNewNewObject = thisNewObject!["idCrashBasicInformation"]
        
        
        singleton.foreignKeys[0].accidentCondition = thisNewNewObject!!.integerValue
        singleton.foreignKeys[0].crashBasicInformation = (caseNumber["num"]?.integerValue)!
        
        
        let message2 = WebServicesQuery.secondTab(thisNewNewObject!!.stringValue)
        
        let message3 = WebServicesQuery.personTab(thisNewNewObject!!.stringValue)
        let message4 = WebServicesQuery.vehicleTab(thisNewNewObject!!.stringValue)
        let message5 = WebServicesQuery.narrativeTab(thisNewNewObject!!.stringValue)
        //let message6 = WebServicesQuery.personExtendedTab(<#T##idPersonFK: String##String#>)
        print(message3,message4,message5)
        segueBack()
        //        _ = UIAlertView(title: "AccidentCondition", message: converterObject["address"] as? String, delegate: self, cancelButtonTitle: "OK")
        
    }
    func segueBack(){
        performSegueWithIdentifier("displayReport", sender: self)
    }

    
    func alertYou(alertMessage: String)->Void{
        let alertController = UIAlertController(title: "Informacion Presente", message:
            alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss.", style: UIAlertActionStyle.Default,handler: nil))
    }

    
    
}
