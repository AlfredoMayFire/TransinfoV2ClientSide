//
//  VehiclesTableViewController.swift
//  transinfoFinal
//
//  Created by Jessica Cotrina Revilla on 7/27/16.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import UIKit
import CoreData

class VehiclesTableViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var object = [NSManagedObject]()
    
    let singleton = Global.sharedGlobal
    
    @IBOutlet var listaVehiculos: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaVehiculos.delegate = self
        listaVehiculos.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        //ADD SCROLL VIEW DIMENTIONS
        
        //colornavigation
        navigationController!.navigationBar.barTintColor = UIColor (red:28.0/255.0, green:69.0/255.0, blue:135.0/255.0, alpha:1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
           // menuButton.action = "revealToggle:"
               menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
        }

        
        tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
      //  print(objectNum)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.tableView.reloadData()
        viewDidLoad()
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singleton.listNum[section]
    }
    
    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        print(singleton.listVehicle)
      
        if singleton.firstTabInfo[0].sawReportOnce {
            cell!.textLabel!.text = singleton.listVehicle[indexPath.row].vehicle["plateNumber"]
        }
        else{
            cell!.textLabel!.text = singleton.listVehicle[indexPath.row+1].vehicle["numTablilla"]
        }
        
        return cell!

    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow // index path of selected cell
        
        singleton.listVehicle[0].counter = (indexPath?.row)!
        
        let cellIndex = indexPath!.row // index of selected cell
        print(indexPath?.row)//iT'S THE NUMBER YOU WANT - 1
        let cellName = tableView.cellForRowAtIndexPath(indexPath!) //  instance of selected cell
        
       
        performSegueWithIdentifier("EditVehicleSegue", sender: self)

        
        
    }
    
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "EditVehicleSegue"){
            //prepare for segue to the details view controller
            
//            if let detailsVC = segue.destinationViewController as? VehicleExtendedViewController {
//               // let indexPath = self.tableView.indexPathForSelectedRow
//
//            }
            
        }
    }

}
