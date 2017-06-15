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
    var myArray = Array<AnyObject> ()
    
    var transition = false
    
    var thereIsCellTapped = false
    var selectedRowIndex = -1
    
    override func viewDidLoad() {
        Reportes.delegate = self
        Reportes.dataSource = self
        super.viewDidLoad()

        
        
        let WebServiceQuery = WebService.init()
        WebServiceQuery.initiate(1)

        print(WebServiceQuery.getListOfReports("2017-09-09"))
        
        dictionary = WebServiceQuery.getListOfReports("7")
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
            cellName = "Case Number: "
            cellName += (dictionary["caseNumber"] as? String)!
            
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
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let indexPath = tableView.indexPathForSelectedRow // index path of selected cell
//       
//        print(myArray[(indexPath?.row)!])
//        dictionary2 = (myArray[(indexPath?.row)!] as? Dictionary<String,AnyObject>)!
//        
//        
//        var message = dictionary2["firstName"] as? String
//        message?.appendContentsOf((dictionary2["lastName"] as? String)!)
//        message?.appendContentsOf(" -> ")
//        message?.appendContentsOf((dictionary2["crashType"] as? String)!)
//         message?.appendContentsOf(" -> ")
//        message?.appendContentsOf((dictionary2["crashDate"] as? String)!)
//         message?.appendContentsOf(" -> ")
//        message?.appendContentsOf((dictionary2["cityDescriptionES"] as? String)!)
//         message?.appendContentsOf(" -> ")
//        message?.appendContentsOf((dictionary2["caseNumber"] as? String)!)
//         message?.appendContentsOf(" -> ")
//        message?.appendContentsOf((dictionary2["address"] as? String)!)
//        
//        print(message)
//        let alertController = UIAlertController(title: "Informacion Presente", message:
//            message, preferredStyle: UIAlertControllerStyle.Alert)
//        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//        
//        self.presentViewController(alertController, animated: true, completion: nil)
//
//
//  
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    
    
}
