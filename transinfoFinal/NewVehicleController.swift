//
//  NewVehicleController.swift
//  transinfoFinal
//
//  Created by Jessica Cotrina Revilla on 7/31/16.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class NewVehicleController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet weak var saveSubmit: UIBarButtonItem!
    @IBOutlet weak var typeVehicleField: SwiftDropDownList!
    @IBOutlet weak var jurisdictionVehicleField: SwiftDropDownList!
    
    @IBOutlet weak var ocupantesField: UITextField!
    @IBOutlet weak var numeroDeTablilla: UITextField!
    @IBOutlet weak var estadoField: UITextField!
    @IBOutlet weak var VINField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var marcaField: UITextField!
    @IBOutlet weak var modeloField: UITextField!
    @IBOutlet weak var numeroDeMarbete: UITextField!
    @IBOutlet weak var aseguradoraField: UITextField!
    
    @IBOutlet weak var fechaCompraField: UITextField!
    @IBOutlet weak var scrollVIew: UIScrollView!
    @IBOutlet weak var fechaExpiracionField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var search: UITextField!
    
    var dictionary: [String:String] = [
        "numTablilla" :"",
        "year" :"",
        "make": "",
        "model" :""
        ]
    var dictionaryQuery = [String:AnyObject] ()
    var content = String()
    var finalContent = [String:String] ()
    var vehicle: AnyObject?
    var dictionaries: Dictionary<String,AnyObject> = ["vacio":"empty"]

    var objectNum = Int()
    var isUpdating = false

    var vehiclefk = ""
    var problemField = ""
    
    var newVehicleID = Dictionary<String,AnyObject>()
    
    var myArray = Array<AnyObject> ()
    
    var values: [String:AnyObject] = [
        "accidentfk":"",
        "vehiclefk":"",
        "personfk":""
    ]

    var submission = false
    
    var condition = false
    
    let singleton = Global.sharedGlobal
    
    @IBAction func fechaCompraField(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(NewVehicleController.datePickerValueChanged1), forControlEvents: UIControlEvents.ValueChanged)

    }
    
    @IBAction func fechaExpiracionField(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(NewVehicleController.datePickerValueChanged2), forControlEvents: UIControlEvents.ValueChanged)

    }
    
    
    func datePickerValueChanged1(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        fechaCompraField.text = dateFormatter.stringFromDate(sender.date)

    }
    func datePickerValueChanged2(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        fechaExpiracionField.text = dateFormatter.stringFromDate(sender.date)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        print(singleton.foreignKeys[0])
        
        self.view.tintColor = UIColor.blueColor()
        
        let webServicesObject = WebService.init()
        webServicesObject.initiate(5)
        
        
        
        
        jurisdictionVehicleField.isKeyboardHidden = true
        jurisdictionVehicleField.isDismissWhenSelected = true
        jurisdictionVehicleField.isArrayWithObject = true
        jurisdictionVehicleField.keyPath = "DescriptionES"
        jurisdictionVehicleField.arrayList = webServicesObject.arrayOfDictionaries("vehicleJurisdictions")
        print(webServicesObject.arrayOfDictionaries("ListVehicleByPlateNumber"))
        
        // Do any additional setup after loading the view, typically from a nib.
        scrollVIew.contentSize.height = 1000
        //Cargar Automaticamente Fecha
        fechaCompraField.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle)
        fechaExpiracionField.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle)        
        
        
        
               
        //search.text = "123"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    override func viewDidAppear(animated: Bool) {
    }
    
    @IBAction func guardar(sender: AnyObject) {
        
        print("--------------------")
        
        if saveSubmit.title != "Save"{
            values["personfk"] = singleton.foreignKeys[0].newPerson
            
            let webServicesObjectPOST = WebService.init()
            
            webServicesObjectPOST.addIData("PlateNumber", value: numeroDeTablilla.text)
            
            webServicesObjectPOST.addIData("VehicleJurisdiction", value: jurisdictionVehicleField.text)
            
            webServicesObjectPOST.addIData("State", value: estadoField.text)
            
            webServicesObjectPOST.addIData("Vin", value: VINField.text)
            
            webServicesObjectPOST.addIData("Year", value: yearField.text)
            
            webServicesObjectPOST.addIData("Make", value: marcaField.text)
            
            webServicesObjectPOST.addIData("modelos", value: modeloField.text)
            
            webServicesObjectPOST.addIData("RegistrationNumber", value: numeroDeMarbete.text)
            
            webServicesObjectPOST.addIData("InsuranceCompany", value: aseguradoraField.text)
            
            webServicesObjectPOST.addIData("PurchaseDate", value: fechaCompraField.text)
            
            webServicesObjectPOST.addIData("ExpirationDate", value: fechaExpiracionField.text)
            
            webServicesObjectPOST.addIData("idPersonaFK", value: values["personfk"]?.stringValue)
            
            print(webServicesObjectPOST.PostData)
            
            newVehicleID = webServicesObjectPOST.sendPOSTs(4)
            
            let errorCode = newVehicleID["error_code"]
            
            let allClear = checkParameters()
            
            
            
            
            
            if(newVehicleID.first!.0 == "error" || errorCode?.integerValue != 200 || !allClear){
                let alertController = UIAlertController(title: "No has llenado todos los campos o has puesto un valor erroneo.", message:
                    "Campo: " + problemField , preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                
                newVehicleID.removeAll()
            }else{
                let myID = newVehicleID["success"]
                let results = myID as? Dictionary<String,AnyObject>
                
                print(results!["NewVehicleId"])
                singleton.foreignKeys[0].newVehicle = (results!["NewVehicleId"]?.integerValue)!
                
                
                values["vehiclefk"] = singleton.foreignKeys[0].newVehicle
                values["accidentfk"] = singleton.foreignKeys[0].crashBasicInformation
                
                let webServicesObjectPOST2 = WebService.init()
                webServicesObjectPOST2.clearPostData()
                webServicesObjectPOST2.addIData("Accidentfk", value: values["accidentfk"]?.stringValue)
                webServicesObjectPOST2.addIData("Vehiclefk", value: values["vehiclefk"]?.stringValue)
                webServicesObjectPOST2.sendPOSTs(11)
                
                dictionary["numTablilla"] = numeroDeTablilla.text
                dictionary["year"] = yearField.text
                dictionary["make"] = marcaField.text
                dictionary["model"] = modeloField.text
                
                let newVehicle = Vehicle(vehicle: dictionary)
                singleton.listVehicle.append(newVehicle)
                
                singleton.listNum[0] += 1
//                
//                print(singleton.listVehicle)
//                print(singleton.listNum)
                  print("submit",singleton.listVehicle)
                
                submission = true
                
                
            }
            
            if submission {
                let alertController = UIAlertController(title: "Se sometio con exito!", message:
                    "Pulsa el boton para regresar.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Regresar.", style: UIAlertActionStyle.Default,handler: segueBack))
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }}
        if saveSubmit.title == "Save" {
            singleton.foreignKeys[0].newVehicle = (dictionaries["idNewVehicle"] as? Int)!
            values["vehiclefk"] = dictionaries["idNewVehicle"]
            values["accidentfk"] = singleton.foreignKeys[0].crashBasicInformation
            
            let webServicesObjectPOST2 = WebService.init()
            webServicesObjectPOST2.clearPostData()
            webServicesObjectPOST2.addIData("Accidentfk", value: values["accidentfk"]?.stringValue)
            webServicesObjectPOST2.addIData("Vehiclefk", value: values["vehiclefk"]?.stringValue)
            webServicesObjectPOST2.sendPOSTs(11)
            
            dictionary["numTablilla"] = numeroDeTablilla.text
            dictionary["year"] = yearField.text
            dictionary["make"] = marcaField.text
            dictionary["model"] = modeloField.text
            
            //singleton.listVehicle.removeAll()
            let newVehicle = Vehicle(vehicle: dictionary)
            singleton.listVehicle.append(newVehicle)
            
            singleton.listNum[0] += 1
            print("Save",singleton.listVehicle)
            let alertController = UIAlertController(title: "Se seleccionó con éxito!", message:
                "Pulsa el boton para regresar.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Regresar.", style: UIAlertActionStyle.Default,handler: segueBack))
            self.presentViewController(alertController, animated: true, completion: nil)

        }
        
        
        
}//end of guardar
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
    
    func segueBack(action: UIAlertAction){
        performSegueWithIdentifier("unwindToVC", sender: self)
    }
    
    @IBAction func submit(sender: AnyObject) {
        
        
        
    }
    

    @IBAction func searchTablilla(sender: AnyObject) {
      
        
        let webServicesQuery = WebService.init()
        webServicesQuery.initiate(1)
        print(webServicesQuery.printQuery(search.text!))
        

        dictionaryQuery = webServicesQuery.printQuery(search.text!)
        print(dictionaryQuery)
        vehicle = dictionaryQuery.first!.1
        
        myArray = (vehicle?["VehicleList"])! as! Array<AnyObject>
        
        
        
        if myArray.count != 0 {

            
            dictionaries = myArray[0] as! Dictionary<String, AnyObject>
            
            
        
            
            
    //
            let alertController = UIAlertController(title: "Vehiculo encontrado!", message:
                "Al aceptar pasaras al reporte.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: willNotUse))
            alertController.addAction(UIAlertAction(title: "Utilizar", style: UIAlertActionStyle.Default, handler: foundVehicle))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            
        }
        else{
            let alertController = UIAlertController(title: "Vehiculo no encontrado!", message:
                "Entrar informacion para uno nuevo.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: willNotUse))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
        
        
    }
    
    
    
    
    
    
    func initializeFetchedResultsController() {
    }
    
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        //        guard let selectedObject = fetchedResultsController.objectAtIndexPath(indexPath) as? NSManagedObject else { fatalError("Unexpected Object in FetchedResultsController") }
        //        // Populate cell from the NSManagedObject instance
        //        print("Object for configuration: \(selectedObject)")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath)
        // Set up the cell
        //        configureCell(cell, indexPath: indexPath)
        //        let vehicle = object[indexPath.row + modifier]
        //        if modifier<object.count{
        //            modifier += 1
        //        }
        //
        //        cell.textLabel?.text = vehicle.valueForKey("numDeTablilla") as? String
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0//fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        guard let sections = fetchedResultsController.sections else {
        //            fatalError("No sections in fetchedResultsController")
        //        }
        //        let sectionInfo = sections[section]
        return 0//sectionInfo.numberOfObjects
    }
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Move:
            break
        case .Update:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, indexPath: indexPath!)
        case .Move:
            tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func foundVehicle(action: UIAlertAction){

        saveSubmit.title = "Save"
       
        
        print(dictionaries)
        
        numeroDeTablilla.text = dictionaries["plateNumber"] as? String
        jurisdictionVehicleField.text = dictionaries["vehicleJurisdiction"] as? String
        estadoField.text = dictionaries["state"] as? String
            
            
        VINField.text = dictionaries["vin"] as? String
        yearField.text = dictionaries["year"] as? String
        marcaField.text = dictionaries["make"]  as? String
        modeloField.text = dictionaries["modelos"] as? String
        numeroDeMarbete.text = dictionaries["registrationNumber"] as? String
        aseguradoraField.text = dictionaries["insuranceCompany"] as? String
        fechaCompraField.text = dictionaries["purchaseDate"] as? String
        fechaExpiracionField.text = dictionaries["expirationDate"] as? String
    }
    
    
    func checkParameters()->Bool{

        problemField = ""
        
        
        if Int(numeroDeMarbete.text!) != nil{
            condition = true
        }else{
            problemField = "Numero de Marbete, solo numeros"
            condition = false
            return condition
        }
        if (VINField.text!.characters.count > 50){
            problemField = "Numero de Vin: Demasiados caracteres"
            condition = false
            return condition
        }
    return condition
    }
    
    
    func willNotUse(action: UIAlertAction){
        saveSubmit.title = "Guardar"
        jurisdictionVehicleField.text = ""
        numeroDeTablilla.text = ""
        estadoField.text = ""
        VINField.text = ""
        marcaField.text = ""
        modeloField.text = ""
        numeroDeMarbete.text = ""
        aseguradoraField.text = ""
        fechaCompraField.text = ""
        fechaExpiracionField.text = ""
        yearField.text = ""

    }
}
