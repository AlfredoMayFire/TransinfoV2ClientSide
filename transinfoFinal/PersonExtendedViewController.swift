//
//  PersonExtendedViewController.swift
//  transinfoFinal
//
//  Created by Jessica Cotrina Revilla on 8/8/16.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import UIKit
import CoreData

class PersonExtendedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    let singleton = Global.sharedGlobal
    
    @IBOutlet weak var rowField: SwiftDropDownList!
    @IBOutlet weak var seatField: SwiftDropDownList!
    @IBOutlet weak var otherLocationField: SwiftDropDownList!
    @IBOutlet weak var restraintSystemField: SwiftDropDownList!
    @IBOutlet weak var usoCascoMotocicleta: SwiftDropDownList! // No lo uso, en el prototipo no se muestra.
    @IBOutlet weak var airbagsActiviationField: SwiftDropDownList!
    @IBOutlet weak var expulsionField: SwiftDropDownList!
    @IBOutlet weak var relacionadoVelocidaField: SwiftDropDownList!
    @IBOutlet weak var extractionField: SwiftDropDownList!
    @IBOutlet weak var circunstanciasConductorField: SwiftDropDownList!
    @IBOutlet weak var conductorDistraidoBy: SwiftDropDownList!
    @IBOutlet weak var condicionMomentoAccidente: SwiftDropDownList!
    @IBOutlet weak var equipoSeguridadUsado: SwiftDropDownList!
    @IBOutlet weak var estadoPrueba: SwiftDropDownList!
    @IBOutlet weak var tipoPrueba: SwiftDropDownList!
    @IBOutlet weak var resultado: SwiftDropDownList!
    @IBOutlet weak var usoSustanciasControladas: SwiftDropDownList!
    @IBOutlet weak var actionPriorToCrash: SwiftDropDownList!
    @IBOutlet weak var walkScholl: SwiftDropDownList!
    @IBOutlet weak var accionesMomentoAccident: SwiftDropDownList!
    @IBOutlet weak var localizacionMomentoAccident: SwiftDropDownList!
    @IBOutlet weak var usoAlcoholField: SwiftDropDownList!
    @IBOutlet weak var resultadoPruebaField: SwiftDropDownList!
    
    
    @IBOutlet weak var personTransport: UITextField!
    @IBOutlet weak var transportedBy: UITextField!
    @IBOutlet weak var TransportedTo: UITextField!
    @IBOutlet weak var MedicalEmergenciesNumber: UITextField!
    @IBOutlet weak var AmbulanceCSPNumber: UITextField!
    
    
    
    @IBOutlet weak var categoriaPersonField: SwiftDropDownList!
    @IBOutlet weak var typePersonField: SwiftDropDownList!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var genderField: UITextField!
 
    var fetchedResultsController: NSFetchedResultsController!
    var fetchedResultsControllerI: NSFetchedResultsController!
    
    @IBOutlet weak var estadoPruebaDosField: SwiftDropDownList!
    @IBOutlet weak var tipoPruebaDosField: SwiftDropDownList!
    @IBOutlet weak var listVehiculos: UITableView!
    
    
    var vehiculos = [NSManagedObject]()
    var modifierVehiculos = 0
    var object = [NSManagedObject]()
    var infracciones = [NSManagedObject]()
    var modifierInfracciones = 0

    @IBOutlet weak var listaInfracciones: UITableView!
    
    var name: [String:String] = [
        "name" :"",
        "categoriaPersona" :"",
        "tipoPersona" :"",
        "genero": "",
        
        "row": "",
        "seat": "",
        "otherLocation": "",
        "restraintSystem": "",
        "airbagActivation": "",
        "expulsion": "",
        "extractionDescription": "",
        "speedRelatedDescription": "",
        
        "distractedDriver": "",
        "safetyEquipment": "",
        "suspectAlcohol": "",
        "suspectSubst": "",
        "testStatusAl": "",
        "testTypeAl": "",
        "testResultAl": "",
        
        "testResultSubst": "",
        "testStatusSubst": "",
        "testTypeSubst": "",
        "waySchool": "",
        "locationWhenCollision": "",
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
    
    var dictionary: [String:String] = [
        "name" :"",
        "gender" :"",
        "typeLicense" :"",
        "numLicense": ""
        ]
    
    
    
    
    
    var objectNum = Int()
    var isUpdating = false
    
    //Actualizacion de webservice y diccionarios
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let webServicesObject1 = WebService.init()
        webServicesObject1.initiate(3)
        
        categoriaPersonField.isKeyboardHidden = true
        categoriaPersonField.isDismissWhenSelected = true
        categoriaPersonField.isArrayWithObject = true
        categoriaPersonField.keyPath = "DescriptionES"
        categoriaPersonField.arrayList = webServicesObject1.arrayOfDictionaries("personTypeCategories")
        typePersonField.isKeyboardHidden = true
        typePersonField.isDismissWhenSelected = true
        typePersonField.isArrayWithObject = true
        typePersonField.keyPath = "DescriptionES"
        typePersonField.arrayList = webServicesObject1.arrayOfDictionaries("personTypes")
//        transportedBy.isKeyboardHidden = true
//        transportedBy.isDismissWhenSelected = true
//        transportedBy.isArrayWithObject = true
//        transportedBy.keyPath = "DescriptionES"
//        transportedBy.arrayList = webServicesObject1.arrayOfDictionaries("organDonor")
        
    
        

        
        
        let webServicesObject = WebService.init()
        webServicesObject.initiate(4)
        
        nameField.text = dictionary["name"]
        categoriaPersonField.text = dictionary["gender"]
        typePersonField.text = dictionary["typeLicense"]
        
        genderField.text = dictionary["gender"]
        
        rowField.isKeyboardHidden = true
        rowField.isDismissWhenSelected = true
        rowField.isArrayWithObject = true
        rowField.keyPath = "DescriptionES"
        rowField.arrayList = webServicesObject.arrayOfDictionaries("rows")
        
        seatField.isKeyboardHidden = true
        seatField.isDismissWhenSelected = true
        seatField.isArrayWithObject = true
        seatField.keyPath = "DescriptionES"
        seatField.arrayList = webServicesObject.arrayOfDictionaries("seats")
        
        otherLocationField.isKeyboardHidden = true
        otherLocationField.isDismissWhenSelected = true
        otherLocationField.isArrayWithObject = true
        otherLocationField.keyPath = "DescriptionES"
        otherLocationField.arrayList = webServicesObject.arrayOfDictionaries("seatingOthers")
        
        restraintSystemField.isKeyboardHidden = true
        restraintSystemField.isDismissWhenSelected = true
        restraintSystemField.isArrayWithObject = true
        restraintSystemField.keyPath = "DescriptionES"
        restraintSystemField.arrayList = webServicesObject.arrayOfDictionaries("restraintSystems")
        
        airbagsActiviationField.isKeyboardHidden = true
        airbagsActiviationField.isDismissWhenSelected = true
        airbagsActiviationField.isArrayWithObject = true
        airbagsActiviationField.keyPath = "DescriptionES"
        airbagsActiviationField.arrayList = webServicesObject.arrayOfDictionaries("airbagDeployed")
        
        expulsionField.isKeyboardHidden = true
        expulsionField.isDismissWhenSelected = true
        expulsionField.isArrayWithObject = true
        expulsionField.keyPath = "DescriptionES"
        expulsionField.arrayList = webServicesObject.arrayOfDictionaries("ejections")
        
        relacionadoVelocidaField.isKeyboardHidden = true
        relacionadoVelocidaField.isDismissWhenSelected = true
        relacionadoVelocidaField.isArrayWithObject = true
        relacionadoVelocidaField.keyPath = "DescriptionES"
        relacionadoVelocidaField.arrayList = webServicesObject.arrayOfDictionaries("speedingSuspected")
        
        circunstanciasConductorField.isKeyboardHidden = true
        circunstanciasConductorField.isDismissWhenSelected = true
        circunstanciasConductorField.isArrayWithObject = true
        circunstanciasConductorField.keyPath = "DescriptionES"
        circunstanciasConductorField.arrayList = webServicesObject.arrayOfDictionaries("contribActionsCircumstances")
        
        conductorDistraidoBy.isKeyboardHidden = true
        conductorDistraidoBy.isDismissWhenSelected = true
        conductorDistraidoBy.isArrayWithObject = true
        conductorDistraidoBy.keyPath = "DescriptionES"
        conductorDistraidoBy.arrayList = webServicesObject.arrayOfDictionaries("distractedBy")
        
        condicionMomentoAccidente.isKeyboardHidden = true
        condicionMomentoAccidente.isDismissWhenSelected = true
        condicionMomentoAccidente.isArrayWithObject = true
        condicionMomentoAccidente.keyPath = "DescriptionES"
        condicionMomentoAccidente.arrayList = webServicesObject.arrayOfDictionaries("conditions")
        
        equipoSeguridadUsado.isKeyboardHidden = true
        equipoSeguridadUsado.isDismissWhenSelected = true
        equipoSeguridadUsado.isArrayWithObject = true
        equipoSeguridadUsado.keyPath = "DescriptionES"
        equipoSeguridadUsado.arrayList = webServicesObject.arrayOfDictionaries("safetyEquipments")
        
        estadoPrueba.isKeyboardHidden = true
        estadoPrueba.isDismissWhenSelected = true
        estadoPrueba.isArrayWithObject = true
        estadoPrueba.keyPath = "DescriptionES"
        estadoPrueba.arrayList = webServicesObject.arrayOfDictionaries("testStatuses")

        estadoPruebaDosField.isKeyboardHidden = true
        estadoPruebaDosField.isDismissWhenSelected = true
        estadoPruebaDosField.isArrayWithObject = true
        estadoPruebaDosField.keyPath = "DescriptionES"
        estadoPruebaDosField.arrayList = webServicesObject.arrayOfDictionaries("testStatuses")

        
        
        tipoPruebaDosField.isKeyboardHidden = true
        tipoPruebaDosField.isDismissWhenSelected = true
        tipoPruebaDosField.isArrayWithObject = true
        tipoPruebaDosField.keyPath = "DescriptionES"
        tipoPruebaDosField.arrayList = webServicesObject.arrayOfDictionaries("drugTestTypes")

        tipoPrueba.isKeyboardHidden = true
        tipoPrueba.isDismissWhenSelected = true
        tipoPrueba.isArrayWithObject = true
        tipoPrueba.keyPath = "DescriptionES"
        tipoPrueba.arrayList = webServicesObject.arrayOfDictionaries("drugTestTypes")
        
        resultado.isKeyboardHidden = true
        resultado.isDismissWhenSelected = true
        resultado.isArrayWithObject = true
        resultado.keyPath = "DescriptionES"
        resultado.arrayList = webServicesObject.arrayOfDictionaries("alcoholTestResults")
        
        resultadoPruebaField.isKeyboardHidden = true
        resultadoPruebaField.isDismissWhenSelected = true
        resultadoPruebaField.isArrayWithObject = true
        resultadoPruebaField.keyPath = "DescriptionES"
        resultadoPruebaField.arrayList = webServicesObject.arrayOfDictionaries("alcoholTestResults")
        
        
        usoSustanciasControladas.isKeyboardHidden = true
        usoSustanciasControladas.isDismissWhenSelected = true
        usoSustanciasControladas.isArrayWithObject = true
        usoSustanciasControladas.keyPath = "DescriptionES"
        usoSustanciasControladas.arrayList = webServicesObject.arrayOfDictionaries("substancesSuspected")
        
        actionPriorToCrash.isKeyboardHidden = true
        actionPriorToCrash.isDismissWhenSelected = true
        actionPriorToCrash.isArrayWithObject = true
        actionPriorToCrash.keyPath = "DescriptionES"
        actionPriorToCrash.arrayList = webServicesObject.arrayOfDictionaries("actionsPriorToCrash")
        

        walkScholl.isKeyboardHidden = true
        walkScholl.isDismissWhenSelected = true
        walkScholl.isArrayWithObject = true
        walkScholl.keyPath = "DescriptionES"
        walkScholl.arrayList = webServicesObject.arrayOfDictionaries("toFromSchool") // si np desconoce
        
        accionesMomentoAccident.isKeyboardHidden = true
        accionesMomentoAccident.isDismissWhenSelected = true
        accionesMomentoAccident.isArrayWithObject = true
        accionesMomentoAccident.keyPath = "DescriptionES"
        accionesMomentoAccident.arrayList = webServicesObject.arrayOfDictionaries("actionsAtTimeOfCrash")
        
        localizacionMomentoAccident.isKeyboardHidden = true
        localizacionMomentoAccident.isDismissWhenSelected = true
        localizacionMomentoAccident.isArrayWithObject = true
        localizacionMomentoAccident.keyPath = "DescriptionES"
        localizacionMomentoAccident.arrayList = webServicesObject.arrayOfDictionaries("nonMotoristLocations")
        
        extractionField.isKeyboardHidden = true
        extractionField.isDismissWhenSelected = true
        extractionField.isArrayWithObject = true
        extractionField.keyPath = "DescriptionES"
        extractionField.arrayList = webServicesObject.arrayOfDictionaries("extrications")
        
        extractionField.isKeyboardHidden = true
        extractionField.isDismissWhenSelected = true
        extractionField.isArrayWithObject = true
        extractionField.keyPath = "DescriptionES"
        extractionField.arrayList = webServicesObject.arrayOfDictionaries("extrications")
        
        usoAlcoholField.isKeyboardHidden = true
        usoAlcoholField.isDismissWhenSelected = true
        usoAlcoholField.isArrayWithObject = true
        usoAlcoholField.keyPath = "DescriptionES"
        usoAlcoholField.arrayList = webServicesObject.arrayOfDictionaries("substancesSuspected")
        
        resultadoPruebaField.isKeyboardHidden = true
        resultadoPruebaField.isDismissWhenSelected = true
        resultadoPruebaField.isArrayWithObject = true
        resultadoPruebaField.keyPath = "DescriptionES"
        resultadoPruebaField.arrayList = webServicesObject.arrayOfDictionaries("drugTestResults")
  
        rowField.text =  dictionary["row"]
        seatField.text = dictionary["seat"]
        otherLocationField.text = dictionary["otherLocation"]
        restraintSystemField.text = dictionary["restraintSystem"]
        airbagsActiviationField.text = dictionary["airbagActivation"]
        expulsionField.text = dictionary["expulsion"]
        extractionField.text = dictionary["extractionDescription"]
        relacionadoVelocidaField.text = dictionary["speedRelatedDescription"]
        conductorDistraidoBy.text = dictionary["distractedDriver"]
        equipoSeguridadUsado.text = dictionary["safetyEquipment"]
        usoAlcoholField.text = dictionary["suspectAlcohol"]
        usoSustanciasControladas.text = dictionary["suspectSubst"]
        estadoPrueba.text = dictionary["testStatusAl"]
        tipoPrueba.text = dictionary["testTypeAl"]
        resultado.text =  dictionary["testResultAl"]
        resultadoPruebaField.text = dictionary["testResultSubst"]
        estadoPruebaDosField.text = dictionary["testStatusSubst"]
        tipoPruebaDosField.text = dictionary["testTypeSubst"]
        walkScholl.text = dictionary["waySchool"]
        localizacionMomentoAccident.text = dictionary["locationWhenCollision"]
        

        scrollView.contentSize.height = 2600
        //scrollView.contentSize.width = 1000
        //scrollView.contentSize = CGSizeMake(500, 1599)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //todo lo de guardar y post
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        

        
    }

    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        }
    
    
    @IBAction func unwindToPersonExtended(segue: UIStoryboardSegue) {
    }

    @IBAction func submit(sender: AnyObject) {
        print ("------------")
        
        let  webServicesObjectPOST = WebService.init()
        
        webServicesObjectPOST.addIData("CategoryPerson",value: categoriaPersonField.text)
        
        webServicesObjectPOST.addIData("TypePerson",value: typePersonField.text)
        
        webServicesObjectPOST.addIData("Row", value: rowField.text)
        
        webServicesObjectPOST.addIData("Seat", value: seatField.text)
        
        webServicesObjectPOST.addIData("OtherLocation", value: otherLocationField.text)
        
        webServicesObjectPOST.addIData("RestraintSystem", value: restraintSystemField.text)
        
        webServicesObjectPOST.addIData("AirbagsActivation", value: airbagsActiviationField.text)
        
        webServicesObjectPOST.addIData("Expulsion", value: expulsionField.text)
        
        webServicesObjectPOST.addIData("SpeedRelated", value: relacionadoVelocidaField.text)
        
        webServicesObjectPOST.addIData("Extraction", value: extractionField.text)
        
        webServicesObjectPOST.addIData("DistractedDriverBy", value: conductorDistraidoBy.text)
        
        webServicesObjectPOST.addIData("ConditionCollisionTime", value: condicionMomentoAccidente.text)
        
        webServicesObjectPOST.addIData("SafetyEquipmentUsed", value: equipoSeguridadUsado.text)
        
        webServicesObjectPOST.addIData("SuspectAlcoholUse", value: usoAlcoholField.text)
        
        webServicesObjectPOST.addIData("TestStatusAl", value: estadoPrueba.text)
        
        webServicesObjectPOST.addIData("TestTypeAl", value: tipoPrueba.text)
        
        webServicesObjectPOST.addIData("TestResultAl", value: resultado.text)
        
        webServicesObjectPOST.addIData("SuscpectControlledSubstances", value: usoSustanciasControladas.text)
        
        webServicesObjectPOST.addIData("TestStatusSub", value: estadoPruebaDosField.text)
        
        webServicesObjectPOST.addIData("TestTypeSub", value: tipoPruebaDosField.text)
        
        webServicesObjectPOST.addIData("TestResultSub", value: resultadoPruebaField.text)
        
        webServicesObjectPOST.addIData("InWayToSchool", value: walkScholl.text)
        
        webServicesObjectPOST.addIData("LocationWhenCollision", value: localizacionMomentoAccident.text)
        
        webServicesObjectPOST.addIData("TransportedByME", value: personTransport.text)
        
        webServicesObjectPOST.addIData("TransportedTo", value: TransportedTo.text)
        
        webServicesObjectPOST.addIData("TransportedBy", value: transportedBy.text)
        
        webServicesObjectPOST.addIData("MedicalEmergenciesNumber", value: MedicalEmergenciesNumber.text)
        
        webServicesObjectPOST.addIData("AmbulanceCSPNumber", value: AmbulanceCSPNumber.text)
        
        //Temporary values for missing keys
        webServicesObjectPOST.addIData("PersonaFK", value: String(singleton.foreignKeys[0].newPerson))
        webServicesObjectPOST.addIData("TestResultTP", value: resultado.text)
        webServicesObjectPOST.addIData("ActionsAtCollisionTime", value: accionesMomentoAccident.text)
        webServicesObjectPOST.addIData("LocationWhenCollision", value: localizacionMomentoAccident.text)
        webServicesObjectPOST.addIData("DriverCirncunstanceBC", value: circunstanciasConductorField.text)
        webServicesObjectPOST.addIData("DistractedBy", value: conductorDistraidoBy.text)
        webServicesObjectPOST.addIData("ActionsBeforeCollision", value: accionesMomentoAccident.text)
        print(webServicesObjectPOST.PostData)
        
        var postFK = webServicesObjectPOST.sendPOSTs(7)
        
        if (/*postFK.first!.0 == "error_code" || postFK.first!.0 == "error"*/postFK["error_code"]?.integerValue != 200)  {
            let alertController = UIAlertController(title: "No has llenado todos los campos o has puesto un valor erroneo.", message:
                "Por favor llena/arregla los campos.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
            postFK.removeAll()
            
        }else{
            let myID = postFK["success"]
            let results = myID as? Dictionary<String,AnyObject>
            let alertController = UIAlertController(title: "Éxito", message:
                "Oprima para continuar.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Continuar.", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
            print("Here it is!",results!["CrashId"])
            
            
        }
    
    
    }
    
    //TABLE LOADING
    
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = listaInfracciones.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        listaInfracciones.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            listaInfracciones.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            listaInfracciones.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Move:
            break
        case .Update:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            listaInfracciones.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            listaInfracciones.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            configureCell(listaInfracciones.cellForRowAtIndexPath(indexPath!)!, indexPath: indexPath!)
        case .Move:
            listaInfracciones.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        listaInfracciones.endUpdates()
    }

    
    
    
}
