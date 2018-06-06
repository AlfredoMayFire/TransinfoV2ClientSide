//
//  PersonsTableViewController.swift
//  transinfoFinal
//
//  Created by Jessica Cotrina Revilla on 7/27/16.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import UIKit
import CoreData

class PersonsTableViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet var listaPersonas: UITableView!
    
    let singleton = Global.sharedGlobal
    
    var object = [NSManagedObject]()
    var dictionary: [String:String] = [
        "name" :"",
        "gender" :"",
        "typeLicense" :"",
        "numLicense": "",
        
     ]

    
    
    
    
    
    override func viewDidLoad() {
        listaPersonas.delegate = self
        listaPersonas.dataSource = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        //colornavigation
        navigationController!.navigationBar.barTintColor = UIColor (red:28.0/255.0, green:69.0/255.0, blue:135.0/255.0, alpha:1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            //menuButton.action = "revealToggle:"
            
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
        
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.tableView.reloadData()
        viewDidLoad()
        
        
        
        
    
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singleton.listNum[section+1]
    }
    
    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(singleton.listPeople)
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        print(singleton.listVehicle.count,"this is count")
        
        if singleton.firstTabInfo[0].sawReportOnce {
            cell!.textLabel!.text = singleton.listPeople[indexPath.row].person["name"]
        }
        else{
            cell!.textLabel!.text = singleton.listPeople[indexPath.row+1].person["name"]
        }
        cell?.textLabel?.text = cell?.textLabel?.text!.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        return cell!
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow // index path of selected cell
        singleton.listPeople[0].counter = (indexPath?.row)!
        _ = indexPath!.row // index of selected cell
        
        singleton.selectedKey = indexPath!.row
      
        if singleton.firstTabInfo[0].sawReportOnce{
            
            dictionary["name"] = singleton.listPeople[indexPath!.row].person["name"]
            dictionary["gender"] = singleton.listPeople[indexPath!.row].person["gender"]
            dictionary["typeLicense"] = singleton.listPeople[indexPath!.row].person["licenseType"]
            dictionary["numLicense"] = singleton.listPeople[indexPath!.row].person["licenceNumber"]
        }
        else{
            //print(singleton.listPeople[indexPath!.row])
            dictionary["name"] = singleton.listPeople[indexPath!.row+1].person["name"]
            dictionary["gender"] = singleton.listPeople[indexPath!.row+1].person["gender"]
            dictionary["typeLicense"] = singleton.listPeople[indexPath!.row+1].person["typeLicense"]
            dictionary["numLicense"] = singleton.listPeople[indexPath!.row+1].person["numLicense"]
        }
        
//        let cellName = tableView.cellForRowAtIndexPath(indexPath!) //  instance of selected cell
      
         performSegueWithIdentifier("EditPersonSegue", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if( segue.identifier == "EditPersonSegue"){
            if let infoVC = segue.destinationViewController as? PersonExtendedViewController{
                infoVC.dictionary = self.dictionary
            }
        }
    }

    @IBAction func unwindToVC2(segue: UIStoryboardSegue) {
    }


}
