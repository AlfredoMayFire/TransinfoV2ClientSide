//
//  NewPersonController.swift
//  transinfoFinal
//
//  Created by Jessica Cotrina Revilla on 7/31/16.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class NewPersonController: UIViewController/*, PPScanningDelegate*/, UITableViewDelegate, UITableViewDataSource {
    //Faltan cosa por hacer on los fields!
    //Faltan cosa por hacer on los fields!//Faltan cosa por hacer on los fields!//Faltan cosa por hacer on los fields!//Faltan cosa por hacer on los fields!//Faltan cosa por hacer on los fields!//Faltan cosa por hacer on los fields!//Faltan cosa por hacer on los fields!//Faltan cosa por hacer on los fields!
    var cellName = "Vehicle #1"
    
    let singleton = Global.sharedGlobal

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveSubmit: UIBarButtonItem!
    @IBOutlet weak var driverLicence: SwiftDropDownList!
    @IBOutlet weak var generoField: SwiftDropDownList!
    @IBOutlet weak var organDonor: SwiftDropDownList!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var numLicenciaSearch: UITextField!
    @IBOutlet weak var urbanizacionBarrio: UITextField!
    @IBOutlet weak var calle: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var PhoneNumber: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fechaExpiracionField: UITextField!
    @IBOutlet weak var numLicenciaField:UITextField!
    @IBOutlet weak var nombreField:UITextField!
    
    //For Scanner
    var string1 = ""
    var string2 = ""
    var string3 = ""
    var string4 = ""
    var objectNum = Int()
    var isUpdating = false
    var fetchedResultsController: NSFetchedResultsController!
    var object = [NSManagedObject]()
    var modifier = 0
    var submission = false
    
    
    //For Singleton
    var values: [String:AnyObject] = [
        "accidentfk":"",
        "personfk":""
        ]

    //For Search
    var dictionaryQuery = [String:AnyObject] ()
   
    
    var vehicle: AnyObject?
    var dictionaries: Dictionary<String,AnyObject> = ["vacio":"empty"]
    var myArray = Array<AnyObject> ()
    var myArray1 = Array<AnyObject> ()
    
    var newPersonID = Dictionary<String,AnyObject>()
    
    var transition = false
    
    var dictionary1: [String:String] = [
        "name" :"",
        "gender" :"",
        "typeLicense" :"",
        "numLicense": ""
    ]
    var converter: [String:AnyObject] = [
        "idNewPerson":""
    ]
    
    
    var listVehicles: Dictionary<String,AnyObject> = ["":""]
    var listVehiclesConvert: Dictionary<String,AnyObject> = ["":""]
    var listVehiclesDictionary: Dictionary<String,AnyObject> = ["":""]
    var problemField = ""
    var allClear = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tintColor = UIColor.blueColor()

        print(singleton.foreignKeys[0])
        
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.contentSize.height = 1000
        
        //ws
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        

        
        
        let webServicesObject = WebService.init()
        webServicesObject.initiate(3)
        
        self.view.tintColor = UIColor.blueColor()
        
        generoField.isKeyboardHidden = true
        generoField.isDismissWhenSelected = true
        generoField.isArrayWithObject = true
        generoField.keyPath = "DescriptionES"
        generoField.arrayList = webServicesObject.arrayOfDictionaries("genders")
        
        driverLicence.isKeyboardHidden = true
        driverLicence.isDismissWhenSelected = true
        driverLicence.isArrayWithObject = true
        driverLicence.keyPath = "DescriptionES"
        driverLicence.arrayList = webServicesObject.arrayOfDictionaries("driverLicenseTypes")
        
        organDonor.isKeyboardHidden = true
        organDonor.isDismissWhenSelected = true
        organDonor.isArrayWithObject = true
        organDonor.keyPath = "DescriptionES"
        organDonor.arrayList = webServicesObject.arrayOfDictionaries("organDonor")
        
        //numLicenciaSearch.text = "1678"
        submission = false
       
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
   
    }
    
    @IBAction func fechaExpiracionFieldAction(sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(NewPersonController.datePickerValueChanged1), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func datePickerValueChanged1(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        fechaExpiracionField.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    @IBAction func Guardar(sender: AnyObject) {
        dictionary1["genero"] = dictionaries["gender"] as? String
        dictionary1["name"] = dictionaries["name"] as? String
        singleton.foreignKeys[0].newPerson = 0
        
        if saveSubmit.title != "Save" {
            print("--------------------")
            let webServicesObjectPOST = WebService.init()
            
            webServicesObjectPOST.addIData("Name", value: nombreField.text)
            
            webServicesObjectPOST.addIData("Gender", value: generoField.text)
            
            webServicesObjectPOST.addIData("LicenseType", value: driverLicence.text)
            
            webServicesObjectPOST.addIData("LicenceNumber", value: numLicenciaField.text)
            
            webServicesObjectPOST.addIData("OrganDonor", value: organDonor.text)
            
            webServicesObjectPOST.addIData("ExpirationDate", value: fechaExpiracionField.text)
            
            webServicesObjectPOST.addIData("Neighborhood", value: urbanizacionBarrio.text)
            
            webServicesObjectPOST.addIData("StreetName", value: calle.text)
            
            webServicesObjectPOST.addIData("City", value: city.text)
            
            webServicesObjectPOST.addIData("StateCountry", value: state.text)
            
            webServicesObjectPOST.addIData("ZipCode", value: zipCode.text)
            
            webServicesObjectPOST.addIData("PhoneNumber", value: PhoneNumber.text)
            
            newPersonID = webServicesObjectPOST.sendPOSTs(5)
            let errorCode = newPersonID["error_code"]
            
            allClear = checkParameters()
            
            if (newPersonID.first!.0 == "error" || errorCode?.integerValue == 400 || !allClear)  {
                let alertController = UIAlertController(title: "No has llenado todos los campos o has puesto un valor erroneo.", message:
                    problemField, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                
                newPersonID.removeAll()
                
            }else{
                let myID = newPersonID["success"]
                let results = myID as? Dictionary<String,AnyObject>
                print("here boy")
                print("Here it is!",results!["NewPersonId"])
               
                singleton.foreignKeys[0].newPerson = (results!["NewPersonId"]?.integerValue)!
                
                values["personfk"] = singleton.foreignKeys[0].newPerson
                values["accidentfk"] = singleton.foreignKeys[0].crashBasicInformation
                
                let webServicesObjectPOST2 = WebService.init()
                webServicesObjectPOST2.clearPostData()
                webServicesObjectPOST2.addIData("Person_fk", value: values["personfk"]?.stringValue)
                webServicesObjectPOST2.addIData("Accident_fk", value: values["accidentfk"]?.stringValue)
                
                print("Here's postdata",webServicesObjectPOST2.PostData)
                print("here's the singleton", singleton.foreignKeys[0])
                print("here's value personfk",values["personfk"]?.stringValue)
                print("here's value accidentfk",values["accidentfk"]?.stringValue)
                webServicesObjectPOST2.sendPOSTs(10)
                
               
                
                dictionary1["name"] = nombreField.text
                dictionary1["gender"] = generoField.text
                dictionary1["typeLicense"] = driverLicence.text
                dictionary1["numLicense"] = numLicenciaField.text
                
                let newPerson = People(person: dictionary1)
                singleton.listPeople.append(newPerson)
                
                singleton.listNum[1] += 1
                
                
                submission = true
            }
            
            if submission{
                let alertController = UIAlertController(title: "Se sometio con exito!", message:
                    "Pulsa el boton para regresar.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Regresar.", style: UIAlertActionStyle.Default,handler: segueBack))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
  
        if saveSubmit.title=="Save" {
            
            singleton.foreignKeys[0].newPerson = (dictionaries["idNewPerson"] as? Int)!
            print("here boiz",singleton.foreignKeys[0].newPerson)
            
            values["personfk"] = singleton.foreignKeys[0].newPerson
            values["accidentfk"] = singleton.foreignKeys[0].crashBasicInformation
            
            let webServicesObjectPOST2 = WebService.init()
            webServicesObjectPOST2.clearPostData()
            webServicesObjectPOST2.addIData("Person_fk", value: values["personfk"]?.stringValue)
            webServicesObjectPOST2.addIData("Accident_fk", value: values["accidentfk"]?.stringValue)
            
            print("Here's postdata",webServicesObjectPOST2.PostData)
            print("here's the singleton", singleton.foreignKeys[0])
            print("here's value personfk",values["personfk"]?.stringValue)
            print("here's value accidentfk",values["accidentfk"]?.stringValue)
            webServicesObjectPOST2.sendPOSTs(10)
            
            print(singleton.foreignKeys[0])
            let newPerson = People(person: dictionary1)
            singleton.listPeople.append(newPerson)
            
            singleton.listNum[1] += 1
            
            print(singleton.listPeople)
            print(singleton.listNum)
            
            
            
            let alertController = UIAlertController(title: "Se seleccionó con éxito!", message:
                "Pulsa el boton para regresar.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Regresar.", style: UIAlertActionStyle.Default,handler: segueBack))
            self.presentViewController(alertController, animated: true, completion: nil)

        }
        
    }

    
    
    
    @IBAction func searchLicence(sender: AnyObject) {
        myArray1.removeAll()
        let webServicesQuery = WebService.init()
        webServicesQuery.initiate(1)
    
        if numLicenciaSearch.text == "" {

            myArray.append(dictionary1)
            myArray.removeAll()
        }
        else{
            dictionaryQuery = webServicesQuery.printQueryPerson(numLicenciaSearch.text!)
            print(dictionaryQuery)
            vehicle = dictionaryQuery["success"]
            myArray = (vehicle?["PersonList"])! as! Array<AnyObject>

        }
       
        
        if myArray.count != 0 {

            //put first value of array into dictionaries which is just a single dictionary
            //print("here's the array",myArray)
            dictionaries = myArray[0] as! Dictionary<String, AnyObject>
        
            //print("here's the dictionary",dictionaries)
            numLicenciaField.text = dictionaries["licenceNumber"] as? String
            driverLicence.text = dictionaries["licenseType"] as? String
            fechaExpiracionField.text = dictionaries["expirationDate"] as? String
            generoField.text = dictionaries["gender"] as? String
            organDonor.text = dictionaries["organDonor"] as? String
            city.text = dictionaries["city"] as? String
            state.text = dictionaries["stateCountry"] as? String
            urbanizacionBarrio.text = dictionaries["neighborhood"] as? String
            calle.text = dictionaries["streetName"] as? String

            zipCode.text = dictionaries["zipCode"]?.stringValue
            PhoneNumber.text = dictionaries["phoneNumber"] as? String
            nombreField.text = dictionaries["name"] as? String
            
           // singleton.foreignKeys[0].newPerson = (dictionaries["idPersonaFK"] as? Int)!
            
            singleton.foreignKeys[0].newPerson = (dictionaries["idNewPerson"]?.integerValue)!
            converter["idNewPerson"] = dictionaries["idNewPerson"]
            listVehicles = webServicesQuery.getListofVehiclesPerson((converter["idNewPerson"]?.stringValue)!)
            listVehiclesConvert = (listVehicles.first?.1)! as! Dictionary<String, AnyObject>
           
            
            myArray1 = (listVehiclesConvert.first?.1)! as! Array<AnyObject>
             print(myArray1)
            if myArray1.isEmpty {
                listVehiclesDictionary = ["Empty":"empty"]
            }else{
                listVehiclesDictionary = myArray1[0] as! Dictionary<String, AnyObject>
            }
            
            let alertController = UIAlertController(title: "Persona encontrado!", message:
                "Escoge Dismiss para buscar de nuevo.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: willNotUse))
            alertController.addAction(UIAlertAction(title: "Utilizar", style: UIAlertActionStyle.Default, handler: FoundPerson))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            //
        }
        else{
            let alertController = UIAlertController(title: "Persona no encontrado!", message:
            "Entrar informacion para añadir.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: willNotUse))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        viewDidLoad()
    }
    
    
    
    func segueBack(action: UIAlertAction){
        performSegueWithIdentifier("unwindToVC", sender: self)
    }

    func FoundPerson(action: UIAlertAction){
        saveSubmit.title = "Save"
        transition = true
        tableView.reloadData()
        singleton.foreignKeys[0].newPerson = myArray[0]["idNewPerson"] as! Int
        print(singleton.foreignKeys[0])
}
    
    
    func willNotUse(action: UIAlertAction){
        saveSubmit.title  = "Submit"
        //function to clear out fields
        numLicenciaField.text = ""
        generoField.text = ""
        organDonor.text = ""
        city.text = ""
        state.text = ""
        urbanizacionBarrio.text = ""
        calle.text = ""
        zipCode.text = ""
        PhoneNumber.text = ""
        nombreField.text = ""
        singleton.foreignKeys[0].newPerson = 0

    }
    @IBAction func unwindToPerson(segue: UIStoryboardSegue) {
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       var rows = 1
        if transition {
            
            rows = myArray1.count
            
        }else{
            
            rows = 1
            
        }
        return rows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        if transition {
            
            listVehiclesDictionary = myArray1[indexPath.row] as! Dictionary<String, AnyObject>
            
            var cellname = "Tablilla: " + (listVehiclesDictionary["plateNumber"] as? String)!
            cellname += " Marca: "
            cellname += (listVehiclesDictionary["make"]as? String)!
            cell.textLabel?.text = cellname
            
        }else{
            
            cell.textLabel?.text = cellName
        
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }

    
    func checkParameters()->Bool{
    
        problemField = ""
        
        var condition = false
        if Int(numLicenciaField.text!) != nil && (numLicenciaField.text?.characters.count == 7){
            condition = true
            
        }else{
            problemField = "Numero de licencia solo numeros, exactamente 7 digitos."
            condition = false
            return condition
        }
      
        if ((Int(zipCode.text!) != nil) && zipCode.text?.characters.count == 5){
            condition = true
        }else{
            problemField = "Zip Code solo numeros."
            condition = false
            return condition
        }
        print(PhoneNumber.text?.characters.count, "over here")
        if ((Int(PhoneNumber.text!) != nil) && (PhoneNumber.text?.characters.count == 10 )){
            condition = true
           
        }else{
            problemField = PhoneNumber.text!
            condition = false
            return condition
        }
        return condition

    }

    
}
    
    

