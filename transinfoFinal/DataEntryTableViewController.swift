//
//  DataEntryTableViewController.swift
//  transinfoFinal
//
//  Created by Jessica Cotrina Revilla on 7/27/16.
//  Edited and managed by Alfredo Pomales III starting 8/15/2017 - Current.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import UIKit
import CoreData

class DataEntryTableViewController: UITableViewController{
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
   
    @IBOutlet var listaMiembros: UITableView!
    
    var vehicle = [NSManagedObject]()
    
    var person = [NSManagedObject]()
    
    var object = [NSManagedObject]()
    
    let singleton = Global.sharedGlobal
    
    let section = ["Vehiculos","Personas" ]
    
    //let  array: [Any] = []
    var items = [["vehicles"],["people"]]
    
    var item = [["":""],["":""]]
    
    var dictionary: [String:String] = [
        "tipoVehiculo" :"",
        "ocupantes" :"",
        "numDeTablilla" :"",
        "jurisdiccion": "",
        "estado" :"",
        "vin" :"",
        "year" :"",
        "marca": "",
        "model" :"",
        "marbete" :"",
        "aseguradora" :"",
        "fechaCompra": "",
        "fechaExpiracion": "",
       ]
    
    var dictionary1: [String:String] = [
        "categoriaPerson" :"",
        "genero" :"",
        "license" :"",
        "organDonor": "",
        "tipoPersona" :"",
        "ciudad" :"",
        "state" :"",
        "transportedBy": "",
        "name" :"",
        ]
    var dictionaryA: [String:String] = [
        "numDeTablilla" :"",
        "marca" :"",
        "modelo" :"",
        "year": "",
        "name" :"",
        "categoriaPersona" :"",
        "tipoPersona" :"",
        "genero": "",
        ]

    var objectNum = -1
    
    var oneOrOther = true

  
    @IBOutlet weak var listaMembers: UITableViewCell!
    override func viewDidLoad() {
       // singleton.foreignKeys[0].crashBasicInformation = 112
        
      //  print(singleton.listPeople[0].person)
        //print("estoy aqui")
        item[1] = singleton.listPeople[0].person
        // print("estoy aqui")
        super.viewDidLoad()
        listaMiembros.delegate = self
        listaMiembros.dataSource = self
       
        // Do any additional setup after loading the view, typically from a nib.
        //ADD SCROLL VIEW DIMENTIONS
        
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
          //  menuButton.action = "revealToggle:"
               menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
           
        }
        
        // print("estoy aqui")
      
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    

    
    override func tableView(tableView: UITableView,cellForRowAtIndexPath
indexPath: NSIndexPath) -> UITableViewCell {
        // print("estoy aqui table")
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        if indexPath.section == 0{
        //let vehicles = vehicle[indexPath.row]
        cell!.textLabel!.text = singleton.listVehicle[indexPath.row].vehicle["plateNumber"]//numTablilla
        }
        else{
           
            cell!.textLabel!.text = singleton.listPeople[indexPath.row+1].person["name"]

        }
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let indexPath = tableView.indexPathForSelectedRow // index path of selected cell
        
//        let cellIndex = indexPath!.row // index of selected cell
//        print(indexPath?.row)//iT'S THE NUMBER YOU WANT - 1
//       // let cellName = tableView.cellForRowAtIndexPath(indexPath!) //  instance of selected cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // print("estoy aqui section")
        return self.section [section]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // print("estoy aqui count")
        return self.item.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        // #warning Incomplete implementation, return the number of rows
//         print("estoy aqui number of rows in section")
//        print(section)
//        
//        print(singleton.listNum)
        return singleton.listNum[section]//self.item[section].count
        
    }
    
     @IBAction func unwindToVC(segue: UIStoryboardSegue) {
        self.tableView.reloadData()
        tableView.reloadData()
        viewDidLoad()
    }
}
    
    



