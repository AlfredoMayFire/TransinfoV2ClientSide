//
//  ReportSecondStepViewController.swift
//  transinfoFinal
//
//  Created by Jessica Cotrina Revilla on 7/27/16.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import UIKit
import CoreData

class ReportSecondStepViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDelegate {
    
    @IBOutlet weak var numCasoLabel: UILabel!
   
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!    
   
    @IBOutlet weak var typeColisionField: SwiftDropDownList!
    @IBOutlet weak var eventField: SwiftDropDownList!
    @IBOutlet weak var eventLocationField: SwiftDropDownList!
    @IBOutlet weak var mannerColisionField: SwiftDropDownList!
    @IBOutlet weak var condition1Field: SwiftDropDownList!
    @IBOutlet weak var condition2Field: SwiftDropDownList!
    @IBOutlet weak var visibilidadConditionField: SwiftDropDownList!
    @IBOutlet weak var pavimentCondition: SwiftDropDownList!
    @IBOutlet weak var circunstanciaAmbientalField: SwiftDropDownList!
    @IBOutlet weak var circunstanciaCarreteraField: SwiftDropDownList!
    @IBOutlet weak var interseccionDesnivelField: SwiftDropDownList!
    @IBOutlet weak var lugarEspecificoField: SwiftDropDownList!
    @IBOutlet weak var tipoIntersecciónField: SwiftDropDownList!
    @IBOutlet weak var RelacionadoOmnibusField: SwiftDropDownList!
    @IBOutlet weak var relacionField: SwiftDropDownList!
    @IBOutlet weak var localizacionAccidenteField: SwiftDropDownList!
    @IBOutlet weak var typezonaField: SwiftDropDownList!
    @IBOutlet weak var trabajadoresPresentesField: SwiftDropDownList!
    @IBOutlet weak var policiaPresenteField: SwiftDropDownList!
    
    @IBOutlet weak var narrativeField: UITextView!
    
    var crashID = Dictionary<String,AnyObject>()
    var values: [String:AnyObject] = [
    "AccidenteFK":"",
    "CrashConditionFK":"",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ws
        
        let singleton = Global.sharedGlobal
        
        print(singleton.foreignKeys)

        //singleton.foreignKeys[0].crashBasicInformation = 112
        
        let webServicesObject = WebService.init()
        
        webServicesObject.initiate(2)
        
        
        typeColisionField.isKeyboardHidden = true
        typeColisionField.isDismissWhenSelected = true
        typeColisionField.isArrayWithObject = true
        typeColisionField.keyPath = "DescriptionES"
        typeColisionField.arrayList = webServicesObject.arrayOfDictionaries("harmfulEventCategories")
        
        eventField.isKeyboardHidden = true
        eventField.isDismissWhenSelected = true
        eventField.isArrayWithObject = true
        eventField.keyPath = "DescriptionES"
        eventField.arrayList = webServicesObject.arrayOfDictionaries("harmfulEvents")
        
        eventLocationField.isKeyboardHidden = true
        eventLocationField.isDismissWhenSelected = true
        eventLocationField.isArrayWithObject = true
        eventLocationField.keyPath = "DescriptionES"
        eventLocationField.arrayList = webServicesObject.arrayOfDictionaries("relativeToTrafficways")
        
        mannerColisionField.isKeyboardHidden = true
        mannerColisionField.isDismissWhenSelected = true
        mannerColisionField.isArrayWithObject = true
        mannerColisionField.keyPath = "DescriptionES"
        mannerColisionField.arrayList = webServicesObject.arrayOfDictionaries("mannerOfColisions")
        
        condition1Field.isKeyboardHidden = true
        condition1Field.isDismissWhenSelected = true
        condition1Field.isArrayWithObject = true
        condition1Field.keyPath = "DescriptionES"
        condition1Field.arrayList = webServicesObject.arrayOfDictionaries("weatherConditions")
        
        condition2Field.isKeyboardHidden = true
        condition2Field.isDismissWhenSelected = true
        condition2Field.isArrayWithObject = true
        condition2Field.keyPath = "DescriptionES"
        condition2Field.arrayList = webServicesObject.arrayOfDictionaries("weatherConditions")
        
        visibilidadConditionField.isKeyboardHidden = true
        visibilidadConditionField.isDismissWhenSelected = true
        visibilidadConditionField.isArrayWithObject = true
        visibilidadConditionField.keyPath = "DescriptionES"
        visibilidadConditionField.arrayList = webServicesObject.arrayOfDictionaries("lightingConditions")
        
        pavimentCondition.isKeyboardHidden = true
        pavimentCondition.isDismissWhenSelected = true
        pavimentCondition.isArrayWithObject = true
        pavimentCondition.keyPath = "DescriptionES"
        pavimentCondition.arrayList = webServicesObject.arrayOfDictionaries("roadSurfaces")
        
        circunstanciaAmbientalField.isKeyboardHidden = true
        circunstanciaAmbientalField.isDismissWhenSelected = true
        circunstanciaAmbientalField.isArrayWithObject = true
        circunstanciaAmbientalField.keyPath = "DescriptionES"
        circunstanciaAmbientalField.arrayList = webServicesObject.arrayOfDictionaries("environmentConditions")
        
        circunstanciaCarreteraField.isKeyboardHidden = true
        circunstanciaCarreteraField.isDismissWhenSelected = true
        circunstanciaCarreteraField.isArrayWithObject = true
        circunstanciaCarreteraField.keyPath = "DescriptionES"
        circunstanciaCarreteraField.arrayList = webServicesObject.arrayOfDictionaries("roadCircumstances")
        
        interseccionDesnivelField.isKeyboardHidden = true
        interseccionDesnivelField.isDismissWhenSelected = true
        interseccionDesnivelField.isArrayWithObject = true
        interseccionDesnivelField.keyPath = "DescriptionES"
        interseccionDesnivelField.arrayList = webServicesObject.arrayOfDictionaries("roadSurfaces")
        
        lugarEspecificoField.isKeyboardHidden = true
        lugarEspecificoField.isDismissWhenSelected = true
        lugarEspecificoField.isArrayWithObject = true
        lugarEspecificoField.keyPath = "DescriptionES"
        lugarEspecificoField.arrayList = webServicesObject.arrayOfDictionaries("junctions")
        
        tipoIntersecciónField.isKeyboardHidden = true
        tipoIntersecciónField.isDismissWhenSelected = true
        tipoIntersecciónField.isArrayWithObject = true
        tipoIntersecciónField.keyPath = "DescriptionES"
        tipoIntersecciónField.arrayList = webServicesObject.arrayOfDictionaries("intersectionTypes")
        
        RelacionadoOmnibusField.isKeyboardHidden = true
        RelacionadoOmnibusField.isDismissWhenSelected = true
        RelacionadoOmnibusField.isArrayWithObject = true
        RelacionadoOmnibusField.keyPath = "DescriptionES"
        RelacionadoOmnibusField.arrayList = webServicesObject.arrayOfDictionaries("schoolBusRelated")
        
        relacionField.isKeyboardHidden = true
        relacionField.isDismissWhenSelected = true
        relacionField.isArrayWithObject = true
        relacionField.keyPath = "DescriptionES"
        relacionField.arrayList = webServicesObject.arrayOfDictionaries("workzoneRelated")
        
        localizacionAccidenteField.isKeyboardHidden = true
        localizacionAccidenteField.isDismissWhenSelected = true
        localizacionAccidenteField.isArrayWithObject = true
        localizacionAccidenteField.keyPath = "DescriptionES"
        localizacionAccidenteField.arrayList = webServicesObject.arrayOfDictionaries("workzoneLocations")
        
        typezonaField.isKeyboardHidden = true
        typezonaField.isDismissWhenSelected = true
        typezonaField.isArrayWithObject = true
        typezonaField.keyPath = "DescriptionES"
        typezonaField.arrayList = webServicesObject.arrayOfDictionaries("workzoneTypes")
        
        trabajadoresPresentesField.isKeyboardHidden = true
        trabajadoresPresentesField.isDismissWhenSelected = true
        trabajadoresPresentesField.isArrayWithObject = true
        trabajadoresPresentesField.keyPath = "DescriptionES"
        trabajadoresPresentesField.arrayList = webServicesObject.arrayOfDictionaries("workersPresent")
        
        policiaPresenteField.isKeyboardHidden = true
        policiaPresenteField.isDismissWhenSelected = true
        policiaPresenteField.isArrayWithObject = true
        policiaPresenteField.keyPath = "DescriptionES"
        policiaPresenteField.arrayList = webServicesObject.arrayOfDictionaries("lawEnforcementPresent")
        
        //colornavigation
        navigationController!.navigationBar.barTintColor = UIColor (red:28.0/255.0, green:69.0/255.0, blue:135.0/255.0, alpha:1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        scrollview.contentSize.height = 1000
        //
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
        
        numCasoLabel.text = "Caso #" + singleton.foreignKeys[0].numCaso
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func auto(sender: AnyObject) {
        if relacionField.text == "No" {
            localizacionAccidenteField.text = "No aplica"
            typezonaField.text = "No aplica"
            trabajadoresPresentesField.text = "No aplica"
            policiaPresenteField.text = "No aplica"
        }

    }
    @IBAction func auto(sender: SwiftDropDownList, forEvent event: UIEvent) {
        if relacionField.text == "No" {
            localizacionAccidenteField.text = "No aplica"
            typezonaField.text = "No aplica"
            trabajadoresPresentesField.text = "No aplica"
            policiaPresenteField.text = "No aplica"
        }
    }
    
    
    @IBAction func Guardar(sender: AnyObject) {
        print("--------------------")
        
        let webServicesObjectPOST = WebService.init()

        webServicesObjectPOST.addIData("CollisionTypeDescriptionES", value: typeColisionField.text)
        
        webServicesObjectPOST.addIData("EventDescriptionES", value: eventField.text)
        
        webServicesObjectPOST.addIData("EventLocationDescriptionES", value: eventLocationField.text)
        
        webServicesObjectPOST.addIData("MannerofColisionDescriptionES", value: mannerColisionField.text)
        
        webServicesObjectPOST.addIData("WeatherConditionUno", value: condition1Field.text)
        
        webServicesObjectPOST.addIData("WeatherConditionDos", value: condition2Field.text)
        
        webServicesObjectPOST.addIData("VisibilityCondition", value: visibilidadConditionField.text)
        
        webServicesObjectPOST.addIData("PavementCondition", value: pavimentCondition.text)
        
        webServicesObjectPOST.addIData("Environmental", value: circunstanciaAmbientalField.text)
        
        webServicesObjectPOST.addIData("RoadDescription", value: circunstanciaCarreteraField.text)
        
        webServicesObjectPOST.addIData("WithinInterchange", value: interseccionDesnivelField.text)
        
        webServicesObjectPOST.addIData("SpecifLocation", value: lugarEspecificoField.text)
        
        webServicesObjectPOST.addIData("InserctionType", value: tipoIntersecciónField.text)
        
        webServicesObjectPOST.addIData("SchoolBusRelated", value: RelacionadoOmnibusField.text)
        
        webServicesObjectPOST.addIData("NearConstruction", value: relacionField.text)
        
        webServicesObjectPOST.addIData("CrashLocation", value: localizacionAccidenteField.text)
        
        webServicesObjectPOST.addIData("WorkerZoneType", value: typezonaField.text)
        
        webServicesObjectPOST.addIData("WorkerPresent", value: trabajadoresPresentesField.text)
        
        webServicesObjectPOST.addIData("PolicePresent", value: policiaPresenteField.text)
        
        crashID = webServicesObjectPOST.sendPOSTs(2)
        
        let webServicesObject2 = WebService.init()
      
        let singleton = Global.sharedGlobal
        
        if (crashID["error_code"]?.integerValue == 400 || crashID.first!.0 == "error")  {
            let alertController = UIAlertController(title: "No has llenado todos los campos o has puesto un valor erroneo.", message:
                "Por favor llena/arregla los campos.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
            crashID.removeAll()
            
        }else{
            let myID = crashID["success"]
            let results = myID as? Dictionary<String,AnyObject>
            singleton.foreignKeys[0].accidentCondition = (results!["NarrativaId"]?.integerValue)!
            //conditional code
            
            
            values["AccidenteFK"] = singleton.foreignKeys[0].crashBasicInformation
            
            values["CrashConditionFK"] = singleton.foreignKeys[0].accidentCondition
            
            print("Here's the singleton",singleton.foreignKeys)
            
            webServicesObject2.clearPostData()
            
            webServicesObject2.addIData("AccidenteFK", value: values["AccidenteFK"]?.stringValue)
            
            webServicesObject2.addIData("CrashConditionFK", value: values["CrashConditionFK"]?.stringValue)
            
            print(webServicesObject2.PostData)
            
            
           let secondPostID = webServicesObject2.sendPOSTs(9)
            var whatINeed = Dictionary<String,AnyObject>()
            whatINeed["error"] = secondPostID["error"]
            whatINeed["success"] = secondPostID["success"]
            //print(whatINeed!["message"])
            
            if(singleton.foreignKeys[0].crashBasicInformation == 0 || singleton.foreignKeys[0].accidentCondition == 0){
                let alertController = UIAlertController(title: "Hubo un error!", message:
                    "Por favor intentalo luego de verificar la informacion nuevamente.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }else{
                clear()
                let alertController = UIAlertController(title: "Éxito", message:
                    "Oprima para continuar.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Continuar.", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
        }

    
        
      
        
        
    }
    
    func clear(){
        typeColisionField.text = ""
        eventField.text = ""
        eventLocationField.text = ""
        mannerColisionField.text = ""
        condition1Field.text = ""
        condition2Field.text = ""
        visibilidadConditionField.text = ""
        pavimentCondition.text = ""
        circunstanciaAmbientalField.text = ""
        circunstanciaCarreteraField.text = ""
        interseccionDesnivelField.text = ""
        lugarEspecificoField.text = ""
        tipoIntersecciónField.text = ""
        RelacionadoOmnibusField.text = ""
        relacionField.text = ""
        localizacionAccidenteField.text = ""
        typezonaField.text = ""
        trabajadoresPresentesField.text = ""
        policiaPresenteField.text = ""
        narrativeField.text = ""
    }
    
}
