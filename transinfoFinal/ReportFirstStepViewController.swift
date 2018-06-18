//
//  ReportFirstStepViewController.swift
//  transinfoFinal
//
//  Created by Jessica Cotrina Revilla on 7/27/16.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import UIKit
import CoreLocation


class ReportFirstStepViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDelegate {
//UIPickerViewDataSource
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var menuButoon: UIBarButtonItem!
    //campos

    let singleton = Global.sharedGlobal
    
    var once = false
    var failSubmit = false
    var condition = false
    var problemField = ""
    var dictionaryBro: Dictionary<String,String> = ["":""]
    var stringy: String?
    
    @IBOutlet weak var typeAccident: SwiftDropDownList!
    @IBOutlet weak var numberCaseField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var hourField: UITextField!
    @IBOutlet weak var numberVehiclesFIeld: UITextField!
    @IBOutlet weak var automovilistasField: UITextField!
    @IBOutlet weak var heridosField: UITextField!
    @IBOutlet weak var fatalitiesField: UITextField!
    @IBOutlet weak var latitudField: UITextField!
    @IBOutlet weak var longitudField: UITextField!
    @IBOutlet weak var stateField: SwiftDropDownList!
    @IBOutlet weak var direccionField: UITextField!
    @IBOutlet weak var direccionField2: UITextField!
    @IBOutlet weak var direccionField3: UITextField!
    @IBOutlet weak var cercadeField: SwiftDropDownList!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var distanceField: UITextField!
    @IBOutlet weak var UnitPedestrians: UITextField!
    
    @IBOutlet weak var medidaField: SwiftDropDownList!
    @IBOutlet weak var puntoCardinalField: SwiftDropDownList!
    @IBOutlet weak var propertyField: SwiftDropDownList!
    @IBOutlet weak var locationField: SwiftDropDownList!
    @IBOutlet weak var typeZonaField: SwiftDropDownList!
    @IBOutlet weak var municipioField: SwiftDropDownList!

   
    var converter: Dictionary<String,AnyObject> = ["":""]
    
    @IBOutlet weak var citiesTable: UITableView!
    
    var arrayList: NSArray = NSArray()
    
    let manager = CLLocationManager()


    
    //hora
    @IBAction func AccidenteHourField(sender: UITextField) {
        
        let timePicker:UIDatePicker = UIDatePicker()
        timePicker.datePickerMode = UIDatePickerMode.Time
        sender.inputView = timePicker
        timePicker.addTarget(self, action: #selector(ReportFirstStepViewController.timePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func timePickerValueChanged(sender:UIDatePicker) {
        
        let dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateformatter.dateFormat = "hh:mm a"
        hourField.text = dateformatter.stringFromDate(sender.date)
        
    }

    //Fecha
    @IBAction func AccidenteDateField(sender: UITextField) {

        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ReportFirstStepViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        //singleton.foreignKeys[0].crashBasicInformation = 167
        
        if singleton.firstTabInfo[0].sawReport {
            singleton.firstTabInfo[0].sawReport = false
            dictionaryBro = singleton.firstTabInfo[0].firstTab
            print(dictionaryBro)
            
//            typeAccident.userInteractionEnabled = false
            typeAccident.text = (dictionaryBro["crashType"])
            numberCaseField.text = dictionaryBro["caseNumber"]
            stateField.text = dictionaryBro["cityDescriptionES"]
            municipioField.text = dictionaryBro["countryDescriptionES"]
            dateTextField.text = dictionaryBro["crashDate"]
            direccionField.text = dictionaryBro["address"]
            puntoCardinalField.text = dictionaryBro["directionDescriptionES"]
            distanceField.text = dictionaryBro["distance"]
            hourField.text = dictionaryBro["hour"]
            latitudField.text = dictionaryBro["latitude"]
            longitudField.text = dictionaryBro["longitude"]
            locationField.text = dictionaryBro["locationDescriptionES"]
            medidaField.text = dictionaryBro["measurementDescriptionES"]
            nameField.text = dictionaryBro["name"]
            cercadeField.text = dictionaryBro["nearToDescriptionEs"]
            propertyField.text = dictionaryBro["propertyDescriptionES"]
            automovilistasField.text = dictionaryBro["unitAutomovilistas"]
            fatalitiesField.text = dictionaryBro["unitFatalaties"]
            heridosField.text = dictionaryBro["unitInjured"]
            UnitPedestrians.text = dictionaryBro["unitPedestrians"]
            numberVehiclesFIeld.text = dictionaryBro["unitVehiculos"]
            typeZonaField.text = dictionaryBro["zoneTypeDescriptionES"]
            correctFormat()
            
        }
        else{
            singleton.firstTabInfo[0].sawReport = false
            singleton.listPeople.removeAll()
            singleton.listVehicle.removeAll()
            print("Yesyesyesnever")
            print(singleton.listVehicle)
            print(singleton.listPeople)
            let listPeopleInit = People(person: ["":""])
            singleton.listPeople.append(listPeopleInit)
            let listVehicleInit = Vehicle(vehicle: ["":""])
            singleton.listVehicle.append(listVehicleInit)
            singleton.listNum = [0,0]
            singleton.selectedKey = 0
        }
        
        print(singleton.foreignKeys[0])
       
        //Direccion
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
//        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
//        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)]

        
        let webServicesObject = WebService.init()
        webServicesObject.initiate(1)
        
        
        typeAccident.isKeyboardHidden = true
        typeAccident.isDismissWhenSelected = true
        typeAccident.isArrayWithObject = true
        typeAccident.keyPath = "DescriptionES"
        typeAccident.arrayList = webServicesObject.arrayOfDictionaries("reportTypes")
        
        stateField.isKeyboardHidden = true
        stateField.isDismissWhenSelected = true
        stateField.isArrayWithObject = true
        stateField.keyPath = "DescriptionES"//
        stateField.arrayList = webServicesObject.arrayOfDictionaries("cities")//cities
        
        municipioField.isKeyboardHidden = true
        municipioField.isDismissWhenSelected = true
        municipioField.isArrayWithObject = true
        municipioField.keyPath = "DescriptionES"
        municipioField.arrayList = webServicesObject.arrayOfDictionaries("counties")
        
        medidaField.isKeyboardHidden = true
        medidaField.isDismissWhenSelected = true
        medidaField.isArrayWithObject = true
        medidaField.keyPath = "DescriptionES"
        medidaField.arrayList = webServicesObject.arrayOfDictionaries("measurements")
        
        puntoCardinalField.isKeyboardHidden = true
        puntoCardinalField.isDismissWhenSelected = true
        puntoCardinalField.isArrayWithObject = true
        puntoCardinalField.keyPath = "DescriptionES"
        puntoCardinalField.arrayList = webServicesObject.arrayOfDictionaries("directions")
        
        propertyField.isKeyboardHidden = true
        propertyField.isDismissWhenSelected = true
        propertyField.isArrayWithObject = true
        propertyField.keyPath = "DescriptionES"
        propertyField.arrayList = webServicesObject.arrayOfDictionaries("properties")
       
        locationField.isKeyboardHidden = true
        locationField.isDismissWhenSelected = true
        locationField.isArrayWithObject = true
        locationField.keyPath = "DescriptionES"
        locationField.arrayList = webServicesObject.arrayOfDictionaries("locations")
        
        typeZonaField.isKeyboardHidden = true
        typeZonaField.isDismissWhenSelected = true
        typeZonaField.isArrayWithObject = true
        typeZonaField.keyPath = "DescriptionES"
        typeZonaField.arrayList = webServicesObject.arrayOfDictionaries("zoneTypes")
        
        cercadeField.isKeyboardHidden = true
        cercadeField.isDismissWhenSelected = true
        cercadeField.isArrayWithObject = true
        cercadeField.keyPath = "DescriptionES"
        cercadeField.arrayList = webServicesObject.arrayOfDictionaries("nearTo")
        
        
        
        //colornavigation
        navigationController!.navigationBar.barTintColor = UIColor (red:28.0/255.0, green:69.0/255.0, blue:135.0/255.0, alpha:1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        // Do any additional setup after loading the view, typically from a nib.
        dateTextField.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle)
        hourField.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        
       
        
        //ADD SCROLL VIEW DIMENTIONS
        scrollview.contentSize.height = 1375
        
        //menu
        if revealViewController() != nil {
            menuButoon.target = revealViewController()
            menuButoon.action = #selector(SWRevealViewController.revealToggle(_:))
        }
        
        
        //if you're having gps troubles use this
        //        latitudField.text = "1"
        //        longitudField.text = "1"

    
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "accidenteCondiciones"{
        
        
        
        }
    }
    @IBAction func ReportFirst(sender: AnyObject) {
        print ("------------")
        
        self.view.endEditing(true)
        
        
        converter["officerID"] = singleton.foreignKeys[0].officerID
        
        let  webServicesObjectPOST = WebService.init()
        webServicesObjectPOST.addIData("CrashType", value: typeAccident.text)
        webServicesObjectPOST.addIData("CaseNumber", value: numberCaseField.text)
        webServicesObjectPOST.addIData("CrashDate", value: dateTextField.text)
        webServicesObjectPOST.addIData("Hour", value: hourField.text)
        webServicesObjectPOST.addIData("UnitVehiculos", value: numberVehiclesFIeld.text)
        webServicesObjectPOST.addIData("UnitAutomovilistas", value: automovilistasField.text)
        webServicesObjectPOST.addIData("UnitPedestrians", value: UnitPedestrians.text)
        webServicesObjectPOST.addIData("UnitInjured", value: heridosField.text)
        webServicesObjectPOST.addIData("UnitFatalaties", value: fatalitiesField.text)
        webServicesObjectPOST.addIData("Latitude", value: latitudField.text)
        webServicesObjectPOST.addIData("Longitude", value: longitudField.text)
        webServicesObjectPOST.addIData("Address", value: direccionField.text)
        webServicesObjectPOST.addIData("CityDescriptionES", value: stateField.text)
        webServicesObjectPOST.addIData("CountryDescriptionES", value: municipioField.text)
        webServicesObjectPOST.addIData("NearToDescriptionEs", value: cercadeField.text)
        webServicesObjectPOST.addIData("Name", value: nameField.text)
        webServicesObjectPOST.addIData("Distance", value: distanceField.text)
        webServicesObjectPOST.addIData("MeasurementDescriptionES", value: medidaField.text)
        webServicesObjectPOST.addIData("DirectionDescriptionES", value: puntoCardinalField.text)
        webServicesObjectPOST.addIData("PropertyDescriptionES", value: propertyField.text)
        webServicesObjectPOST.addIData("LocationDescriptionES", value: locationField.text)
        webServicesObjectPOST.addIData("ZoneTypeDescriptionES", value: typeZonaField.text)
        webServicesObjectPOST.addIData("Officerfk", value: converter["officerID"]?.stringValue)//valor se captura del login
    
        var crashID = webServicesObjectPOST.sendPOSTs(1)
        
        singleton.foreignKeys[0].numCaso = numberCaseField.text!
        
        if (crashID["error_code"]?.integerValue==400 || crashID.first!.0 == "error")  {
            let alertController = UIAlertController(title: "No has llenado todos los campos o has puesto un valor erroneo.", message:
                problemField, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
            crashID.removeAll()
            failSubmit = true
        }else{
            
            let myID = crashID["success"]
            let results = myID as? Dictionary<String,AnyObject>
            print("Here it is!",results!["CrashId"])
            singleton.foreignKeys[0].crashBasicInformation = (results!["CrashId"]?.integerValue)!
            print(singleton.foreignKeys[0].crashBasicInformation)
            
            let alertController = UIAlertController(title: "Éxito", message:
                "Oprima para continuar.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Continuar.", style: UIAlertActionStyle.Default,handler: confirm))
            self.presentViewController(alertController, animated: true, completion: nil)
           singleton.firstTabInfo[0].sawReportOnce = false
           // clear(self)
        }
        print ("******************")
    }
    
    func addInfoDirection(info: String?) ->String{
    
        if info != nil{
            return "\(info!)\n"
        }
        else {
        return ""
        }
    }
    
    @IBAction func updateCoordinates(sender: AnyObject) {
        self.latitudField.text = String(singleton.foreignKeys[0].latitude)
        self.longitudField.text = String(singleton.foreignKeys[0].longitude)
        
    }
    //función cargar dato de direccion en la tabla
    func locationManager(manager:CLLocationManager, didUpdateLocations locations: [CLLocation]){
       
        if let userLocation = locations.first {
            
            if !self.once{
                self.latitudField.text = "\(userLocation.coordinate.latitude)"
                self.longitudField.text = "\(userLocation.coordinate.longitude)"

            }
            
            
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) in
            if error != nil && !self.once {
                print(error)
            }
            else {
                if let p = placemarks?[0]{
                    if self.direccionField.text != ""{
                        var address = ""
                        address = address + self.addInfoDirection(p.thoroughfare)
                        address = address + self.addInfoDirection(p.subThoroughfare)
                        //self.direccionField.text = address
                        print(userLocation)

                    }
                }
            }
        })
    }
        once = true
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clear(sender: AnyObject) {
        typeAccident.text = ""
        numberCaseField.text = ""
        dateTextField.text = ""
        hourField.text = ""
        numberVehiclesFIeld.text = ""
        automovilistasField.text = ""
        heridosField.text = ""
        fatalitiesField.text = ""
        latitudField.text = ""
        longitudField.text = ""
        stateField.text = ""
        direccionField.text = ""
        cercadeField.text = ""
        nameField.text = ""
        distanceField.text = ""
        UnitPedestrians.text = ""
        medidaField.text = ""
        puntoCardinalField.text = ""
        propertyField.text = ""
        locationField.text = ""
        typeZonaField.text = ""
        municipioField.text = ""
    }
    
    @IBAction func unwindToFirstStep(segue: UIStoryboardSegue) {
    }
    
    func confirm(action: UIAlertAction){
//        performSegueWithIdentifier("accidenteCondiciones", sender: self)
    }
    func checkValues()->Bool{
        if Int(numberCaseField.text!) != nil {
            condition=true
        }else{
            problemField = "Numero de caso erróneo."
        }
        if Int(distanceField.text!) != nil{
            condition=true
        }
        else{
            problemField = "Campo de distancia erróneo."
            condition=false
        }
        if Int(numberVehiclesFIeld.text!) != nil && Int(automovilistasField.text!) != nil && Int(UnitPedestrians.text!) != nil && Int(heridosField.text!) != nil && Int(fatalitiesField.text!) != nil{
            condition=true
        }else{
            problemField = "Unidades involucradas, información errónea."
            condition=false
        }
        
        return condition
    }
    func correctFormat(){
        
        typeAccident.text = typeAccident.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        typeAccident.text = typeAccident.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        typeAccident.text = typeAccident.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        typeAccident.text = typeAccident.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        typeAccident.text = typeAccident.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        typeAccident.text = typeAccident.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        typeAccident.text = typeAccident.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        numberCaseField.text = numberCaseField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        numberCaseField.text = numberCaseField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        numberCaseField.text = numberCaseField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        numberCaseField.text = numberCaseField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        numberCaseField.text = numberCaseField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        numberCaseField.text = numberCaseField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        numberCaseField.text = numberCaseField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        
        dateTextField.text = dateTextField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        dateTextField.text = dateTextField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        dateTextField.text = dateTextField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        dateTextField.text = dateTextField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        dateTextField.text = dateTextField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        dateTextField.text = dateTextField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        dateTextField.text = dateTextField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        hourField.text = hourField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        hourField.text = hourField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        hourField.text = hourField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        hourField.text = hourField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        hourField.text = hourField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        hourField.text = hourField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        hourField.text = hourField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        numberVehiclesFIeld.text = numberVehiclesFIeld.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        numberVehiclesFIeld.text = numberVehiclesFIeld.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        numberVehiclesFIeld.text = numberVehiclesFIeld.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        numberVehiclesFIeld.text = numberVehiclesFIeld.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        numberVehiclesFIeld.text = numberVehiclesFIeld.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        numberVehiclesFIeld.text = numberVehiclesFIeld.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        numberVehiclesFIeld.text = numberVehiclesFIeld.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        automovilistasField.text = automovilistasField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        automovilistasField.text = automovilistasField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        automovilistasField.text = automovilistasField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        automovilistasField.text = automovilistasField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        automovilistasField.text = automovilistasField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        automovilistasField.text = automovilistasField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        automovilistasField.text = automovilistasField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        
        heridosField.text = heridosField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        heridosField.text = heridosField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        heridosField.text = heridosField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        heridosField.text = heridosField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        heridosField.text = heridosField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        heridosField.text = heridosField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        heridosField.text = heridosField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        fatalitiesField.text = fatalitiesField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        fatalitiesField.text = fatalitiesField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        fatalitiesField.text = fatalitiesField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        fatalitiesField.text = fatalitiesField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        fatalitiesField.text = fatalitiesField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        fatalitiesField.text = fatalitiesField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        fatalitiesField.text = fatalitiesField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        latitudField.text = latitudField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        latitudField.text = latitudField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        latitudField.text = latitudField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        latitudField.text = latitudField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        latitudField.text = latitudField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        latitudField.text = latitudField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        latitudField.text = latitudField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        longitudField.text = longitudField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        longitudField.text = longitudField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        longitudField.text = longitudField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        longitudField.text = longitudField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        longitudField.text = longitudField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        longitudField.text = longitudField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        longitudField.text = longitudField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        stateField.text = stateField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        stateField.text = stateField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        stateField.text = stateField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        stateField.text = stateField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        stateField.text = stateField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        stateField.text = stateField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        stateField.text = stateField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        direccionField.text = direccionField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        direccionField.text = direccionField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        direccionField.text = direccionField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        direccionField.text = direccionField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        direccionField.text = direccionField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        direccionField.text = direccionField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        direccionField.text = direccionField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        cercadeField.text = cercadeField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        cercadeField.text = cercadeField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        cercadeField.text = cercadeField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        cercadeField.text = cercadeField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        cercadeField.text = cercadeField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        cercadeField.text = cercadeField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        cercadeField.text = cercadeField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        nameField.text = nameField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        nameField.text = nameField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        nameField.text = nameField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        nameField.text = nameField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        nameField.text = nameField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        nameField.text = nameField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        nameField.text = nameField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        distanceField.text = distanceField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        distanceField.text = distanceField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        distanceField.text = distanceField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        distanceField.text = distanceField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        distanceField.text = distanceField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        distanceField.text = distanceField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        distanceField.text = distanceField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        UnitPedestrians.text = UnitPedestrians.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        UnitPedestrians.text = UnitPedestrians.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        UnitPedestrians.text = UnitPedestrians.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        UnitPedestrians.text = UnitPedestrians.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        UnitPedestrians.text = UnitPedestrians.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        UnitPedestrians.text = UnitPedestrians.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        UnitPedestrians.text = UnitPedestrians.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        medidaField.text = medidaField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        medidaField.text = medidaField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        medidaField.text = medidaField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        medidaField.text = medidaField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        medidaField.text = medidaField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        medidaField.text = medidaField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        medidaField.text = medidaField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        propertyField.text = propertyField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        propertyField.text = propertyField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        propertyField.text = propertyField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        propertyField.text = propertyField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        propertyField.text = propertyField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        propertyField.text = propertyField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        propertyField.text = propertyField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        locationField.text = locationField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        locationField.text = locationField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        locationField.text = locationField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        locationField.text = locationField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        locationField.text = locationField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        locationField.text = locationField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        locationField.text = locationField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        typeZonaField.text = typeZonaField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        typeZonaField.text = typeZonaField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        typeZonaField.text = typeZonaField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        typeZonaField.text = typeZonaField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        typeZonaField.text = typeZonaField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        typeZonaField.text = typeZonaField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        typeZonaField.text = typeZonaField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        municipioField.text = municipioField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        municipioField.text = municipioField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        municipioField.text = municipioField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        municipioField.text = municipioField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        municipioField.text = municipioField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        municipioField.text = municipioField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        municipioField.text = municipioField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
    }
}
