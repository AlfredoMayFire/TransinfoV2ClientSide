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
        
        print(singleton.foreignKeys[0])
   
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
        
        if singleton.firstTabInfo[0].sawReportOnce {
            let counter = singleton.listPeople[0].counter
            print(singleton.listPeople[0].arrayPerson)
            if ((singleton.listPeople[0].arrayPerson.first?.isEmpty) != nil){
                singleton.listPeople[0].arrayPerson.removeAtIndex(0)
            }
            print(singleton.listPeople[0].arrayPerson.count)
            print(counter)
            
            let arrayForStuff = singleton.listPeople[0].arrayPerson[counter]
            
            accionesMomentoAccident.text = String(arrayForStuff["actionsAtCollisionTime"]!)//??
            accionesMomentoAccident.text = String(arrayForStuff["actionsBeforeCollision"]!)//??
            airbagsActiviationField.text = String(arrayForStuff["airbagsActivation"]!)
            AmbulanceCSPNumber.text = String(arrayForStuff["ambulanceCSPNumber"]!)
            condicionMomentoAccidente.text = String(arrayForStuff["conditionCollisionTime"]!)
            conductorDistraidoBy.text = String(arrayForStuff["distractedBy"]!)//??
            conductorDistraidoBy.text = String(arrayForStuff["distractedDriverBy"]!)//??
            circunstanciasConductorField.text = String(arrayForStuff["driverCirncunstanceBC"]!)
            expulsionField.text = String(arrayForStuff["expulsion"]!)
            extractionField.text = String(arrayForStuff["extraction"]!)
            walkScholl.text = String(arrayForStuff["inWayToSchool"]!)
            localizacionMomentoAccident.text = String(arrayForStuff["locationWhenCollision"]!)
            MedicalEmergenciesNumber.text = String(arrayForStuff["medicalEmergenciesNumber"]!)
            otherLocationField.text = String(arrayForStuff["otherLocation"]!)
            restraintSystemField.text = String(arrayForStuff["restraintSystem"]!)
            rowField.text = String(arrayForStuff["row"]!)
            equipoSeguridadUsado.text = String(arrayForStuff["safetyEquipmentUsed"]!)
            seatField.text = String(arrayForStuff["seat"]!)
            relacionadoVelocidaField.text = String(arrayForStuff["speedRelated"]!)
            usoSustanciasControladas.text = String(arrayForStuff["suscpectControlledSubstances"]!)
            usoAlcoholField.text = String(arrayForStuff["suspectAlcoholUse"]!)
            resultado.text = String(arrayForStuff["testResultAl"]!)//??
            resultadoPruebaField.text = String(arrayForStuff["testResultSub"]!)
            resultado.text = String(arrayForStuff["testStatusAl"]!)//??
            estadoPruebaDosField.text = String(arrayForStuff["testStatusSub"]!)
            tipoPrueba.text = String(arrayForStuff["testTypeAl"]!)
            tipoPruebaDosField.text = String(arrayForStuff["testTypeSub"]!)
            transportedBy.text = String(arrayForStuff["transportedBy"]!)
            personTransport.text = String(arrayForStuff["transportedByME"]!)
            TransportedTo.text = String(arrayForStuff["transportedTo"]!)
            
            correctFormat()
            
        }
        

        
        
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
  
//        rowField.text =  dictionary["row"]
//        seatField.text = dictionary["seat"]
//        otherLocationField.text = dictionary["otherLocation"]
//        restraintSystemField.text = dictionary["restraintSystem"]
//        airbagsActiviationField.text = dictionary["airbagActivation"]
//        expulsionField.text = dictionary["expulsion"]
//        extractionField.text = dictionary["extractionDescription"]
//        relacionadoVelocidaField.text = dictionary["speedRelatedDescription"]
//        conductorDistraidoBy.text = dictionary["distractedDriver"]
//        equipoSeguridadUsado.text = dictionary["safetyEquipment"]
//        usoAlcoholField.text = dictionary["suspectAlcohol"]
//        usoSustanciasControladas.text = dictionary["suspectSubst"]
//        estadoPrueba.text = dictionary["testStatusAl"]
//        tipoPrueba.text = dictionary["testTypeAl"]
//        resultado.text =  dictionary["testResultAl"]
//        resultadoPruebaField.text = dictionary["testResultSubst"]
//        estadoPruebaDosField.text = dictionary["testStatusSubst"]
//        tipoPruebaDosField.text = dictionary["testTypeSubst"]
//        walkScholl.text = dictionary["waySchool"]
//        localizacionMomentoAccident.text = dictionary["locationWhenCollision"]
        

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
        
        webServicesObjectPOST.addIData("DistractedDriverBy", value: conductorDistraidoBy.text)//??
        
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
        
        webServicesObjectPOST.addIData("TransportedTo", value: TransportedTo.text)//?? reverse
        
        webServicesObjectPOST.addIData("TransportedBy", value: transportedBy.text)//?? reverse
        
        webServicesObjectPOST.addIData("MedicalEmergenciesNumber", value: MedicalEmergenciesNumber.text)
        
        webServicesObjectPOST.addIData("AmbulanceCSPNumber", value: AmbulanceCSPNumber.text)
        
        //Temporary values for missing keys
        webServicesObjectPOST.addIData("PersonaFK", value: String(singleton.foreignKeys[0].newPerson))
        webServicesObjectPOST.addIData("TestResultTP", value: resultado.text)
        webServicesObjectPOST.addIData("ActionsAtCollisionTime", value: accionesMomentoAccident.text)//??
        webServicesObjectPOST.addIData("LocationWhenCollision", value: localizacionMomentoAccident.text)
        webServicesObjectPOST.addIData("DriverCirncunstanceBC", value: circunstanciasConductorField.text)
        webServicesObjectPOST.addIData("DistractedBy", value: conductorDistraidoBy.text)
        webServicesObjectPOST.addIData("ActionsBeforeCollision", value: accionesMomentoAccident.text)//??
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

    
    func correctFormat(){
        
        
        rowField.text = rowField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        rowField.text = rowField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        rowField.text = rowField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        rowField.text = rowField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        rowField.text = rowField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        rowField.text = rowField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        rowField.text = rowField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        seatField.text = seatField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        seatField.text = seatField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        seatField.text = seatField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        seatField.text = seatField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        seatField.text = seatField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        seatField.text = seatField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        seatField.text = seatField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        otherLocationField.text = otherLocationField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        otherLocationField.text = otherLocationField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        otherLocationField.text = otherLocationField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        otherLocationField.text = otherLocationField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        otherLocationField.text = otherLocationField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        otherLocationField.text = otherLocationField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        otherLocationField.text = otherLocationField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        restraintSystemField.text = restraintSystemField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        restraintSystemField.text = restraintSystemField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        restraintSystemField.text = restraintSystemField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        restraintSystemField.text = restraintSystemField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        restraintSystemField.text = restraintSystemField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        restraintSystemField.text = restraintSystemField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        restraintSystemField.text = restraintSystemField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        usoCascoMotocicleta.text = usoCascoMotocicleta.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        usoCascoMotocicleta.text = usoCascoMotocicleta.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        usoCascoMotocicleta.text = usoCascoMotocicleta.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        usoCascoMotocicleta.text = usoCascoMotocicleta.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        usoCascoMotocicleta.text = usoCascoMotocicleta.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        usoCascoMotocicleta.text = usoCascoMotocicleta.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        usoCascoMotocicleta.text = usoCascoMotocicleta.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        airbagsActiviationField.text = airbagsActiviationField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        airbagsActiviationField.text = airbagsActiviationField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        airbagsActiviationField.text = airbagsActiviationField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        airbagsActiviationField.text = airbagsActiviationField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        airbagsActiviationField.text = airbagsActiviationField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        airbagsActiviationField.text = airbagsActiviationField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        airbagsActiviationField.text = airbagsActiviationField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        expulsionField.text = expulsionField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        expulsionField.text = expulsionField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        expulsionField.text = expulsionField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        expulsionField.text = expulsionField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        expulsionField.text = expulsionField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        expulsionField.text = expulsionField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        expulsionField.text = expulsionField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        relacionadoVelocidaField.text = relacionadoVelocidaField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        relacionadoVelocidaField.text = relacionadoVelocidaField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        relacionadoVelocidaField.text = relacionadoVelocidaField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        relacionadoVelocidaField.text = relacionadoVelocidaField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        relacionadoVelocidaField.text = relacionadoVelocidaField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        relacionadoVelocidaField.text = relacionadoVelocidaField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        relacionadoVelocidaField.text = relacionadoVelocidaField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        extractionField.text = extractionField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        extractionField.text = extractionField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        extractionField.text = extractionField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        extractionField.text = extractionField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        extractionField.text = extractionField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        extractionField.text = extractionField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        extractionField.text = extractionField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        circunstanciasConductorField.text = circunstanciasConductorField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        circunstanciasConductorField.text = circunstanciasConductorField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        circunstanciasConductorField.text = circunstanciasConductorField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        circunstanciasConductorField.text = circunstanciasConductorField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        circunstanciasConductorField.text = circunstanciasConductorField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        circunstanciasConductorField.text = circunstanciasConductorField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        circunstanciasConductorField.text = circunstanciasConductorField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        conductorDistraidoBy.text = conductorDistraidoBy.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        conductorDistraidoBy.text = conductorDistraidoBy.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        conductorDistraidoBy.text = conductorDistraidoBy.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        conductorDistraidoBy.text = conductorDistraidoBy.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        conductorDistraidoBy.text = conductorDistraidoBy.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        conductorDistraidoBy.text = conductorDistraidoBy.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        conductorDistraidoBy.text = conductorDistraidoBy.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        condicionMomentoAccidente.text = condicionMomentoAccidente.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        condicionMomentoAccidente.text = condicionMomentoAccidente.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        condicionMomentoAccidente.text = condicionMomentoAccidente.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        condicionMomentoAccidente.text = condicionMomentoAccidente.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        condicionMomentoAccidente.text = condicionMomentoAccidente.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        condicionMomentoAccidente.text = condicionMomentoAccidente.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        condicionMomentoAccidente.text = condicionMomentoAccidente.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        equipoSeguridadUsado.text = equipoSeguridadUsado.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        equipoSeguridadUsado.text = equipoSeguridadUsado.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        equipoSeguridadUsado.text = equipoSeguridadUsado.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        equipoSeguridadUsado.text = equipoSeguridadUsado.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        equipoSeguridadUsado.text = equipoSeguridadUsado.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        equipoSeguridadUsado.text = equipoSeguridadUsado.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        equipoSeguridadUsado.text = equipoSeguridadUsado.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        estadoPrueba.text = estadoPrueba.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        estadoPrueba.text = estadoPrueba.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        estadoPrueba.text = estadoPrueba.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        estadoPrueba.text = estadoPrueba.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        estadoPrueba.text = estadoPrueba.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        estadoPrueba.text = estadoPrueba.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        estadoPrueba.text = estadoPrueba.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        tipoPrueba.text = tipoPrueba.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        tipoPrueba.text = tipoPrueba.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        tipoPrueba.text = tipoPrueba.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        tipoPrueba.text = tipoPrueba.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        tipoPrueba.text = tipoPrueba.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        tipoPrueba.text = tipoPrueba.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        tipoPrueba.text = tipoPrueba.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        resultado.text = resultado.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        resultado.text = resultado.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        resultado.text = resultado.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        resultado.text = resultado.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        resultado.text = resultado.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        resultado.text = resultado.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        resultado.text = resultado.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        usoSustanciasControladas.text = usoSustanciasControladas.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        usoSustanciasControladas.text = usoSustanciasControladas.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        usoSustanciasControladas.text = usoSustanciasControladas.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        usoSustanciasControladas.text = usoSustanciasControladas.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        usoSustanciasControladas.text = usoSustanciasControladas.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        usoSustanciasControladas.text = usoSustanciasControladas.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        usoSustanciasControladas.text = usoSustanciasControladas.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        actionPriorToCrash.text = actionPriorToCrash.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        actionPriorToCrash.text = actionPriorToCrash.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        actionPriorToCrash.text = actionPriorToCrash.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        actionPriorToCrash.text = actionPriorToCrash.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        actionPriorToCrash.text = actionPriorToCrash.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        actionPriorToCrash.text = actionPriorToCrash.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        actionPriorToCrash.text = actionPriorToCrash.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        walkScholl.text = walkScholl.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        walkScholl.text = walkScholl.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        walkScholl.text = walkScholl.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        walkScholl.text = walkScholl.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        walkScholl.text = walkScholl.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        walkScholl.text = walkScholl.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        walkScholl.text = walkScholl.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        accionesMomentoAccident.text = accionesMomentoAccident.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        accionesMomentoAccident.text = accionesMomentoAccident.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        accionesMomentoAccident.text = accionesMomentoAccident.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        accionesMomentoAccident.text = accionesMomentoAccident.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        accionesMomentoAccident.text = accionesMomentoAccident.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        accionesMomentoAccident.text = accionesMomentoAccident.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        accionesMomentoAccident.text = accionesMomentoAccident.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        localizacionMomentoAccident.text = localizacionMomentoAccident.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        localizacionMomentoAccident.text = localizacionMomentoAccident.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        localizacionMomentoAccident.text = localizacionMomentoAccident.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        localizacionMomentoAccident.text = localizacionMomentoAccident.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        localizacionMomentoAccident.text = localizacionMomentoAccident.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        localizacionMomentoAccident.text = localizacionMomentoAccident.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        localizacionMomentoAccident.text = localizacionMomentoAccident.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        usoAlcoholField.text = usoAlcoholField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        usoAlcoholField.text = usoAlcoholField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        usoAlcoholField.text = usoAlcoholField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        usoAlcoholField.text = usoAlcoholField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        usoAlcoholField.text = usoAlcoholField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        usoAlcoholField.text = usoAlcoholField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        usoAlcoholField.text = usoAlcoholField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        resultadoPruebaField.text = resultadoPruebaField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        resultadoPruebaField.text = resultadoPruebaField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        resultadoPruebaField.text = resultadoPruebaField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        resultadoPruebaField.text = resultadoPruebaField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        resultadoPruebaField.text = resultadoPruebaField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        resultadoPruebaField.text = resultadoPruebaField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        resultadoPruebaField.text = resultadoPruebaField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        personTransport.text = personTransport.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        personTransport.text = personTransport.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        personTransport.text = personTransport.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        personTransport.text = personTransport.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        personTransport.text = personTransport.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        personTransport.text = personTransport.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        personTransport.text = personTransport.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        transportedBy.text = transportedBy.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        transportedBy.text = transportedBy.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        transportedBy.text = transportedBy.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        transportedBy.text = transportedBy.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        transportedBy.text = transportedBy.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        transportedBy.text = transportedBy.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        transportedBy.text = transportedBy.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        TransportedTo.text = TransportedTo.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        TransportedTo.text = TransportedTo.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        TransportedTo.text = TransportedTo.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        TransportedTo.text = TransportedTo.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        TransportedTo.text = TransportedTo.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        TransportedTo.text = TransportedTo.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        TransportedTo.text = TransportedTo.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        MedicalEmergenciesNumber.text = MedicalEmergenciesNumber.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        MedicalEmergenciesNumber.text = MedicalEmergenciesNumber.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        MedicalEmergenciesNumber.text = MedicalEmergenciesNumber.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        MedicalEmergenciesNumber.text = MedicalEmergenciesNumber.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        MedicalEmergenciesNumber.text = MedicalEmergenciesNumber.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        MedicalEmergenciesNumber.text = MedicalEmergenciesNumber.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        MedicalEmergenciesNumber.text = MedicalEmergenciesNumber.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        AmbulanceCSPNumber.text = AmbulanceCSPNumber.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        AmbulanceCSPNumber.text = AmbulanceCSPNumber.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        AmbulanceCSPNumber.text = AmbulanceCSPNumber.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        AmbulanceCSPNumber.text = AmbulanceCSPNumber.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        AmbulanceCSPNumber.text = AmbulanceCSPNumber.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        AmbulanceCSPNumber.text = AmbulanceCSPNumber.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        AmbulanceCSPNumber.text = AmbulanceCSPNumber.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        categoriaPersonField.text = categoriaPersonField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        categoriaPersonField.text = categoriaPersonField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        categoriaPersonField.text = categoriaPersonField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        categoriaPersonField.text = categoriaPersonField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        categoriaPersonField.text = categoriaPersonField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        categoriaPersonField.text = categoriaPersonField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        categoriaPersonField.text = categoriaPersonField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        typePersonField.text = typePersonField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        typePersonField.text = typePersonField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        typePersonField.text = typePersonField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        typePersonField.text = typePersonField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        typePersonField.text = typePersonField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        typePersonField.text = typePersonField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        typePersonField.text = typePersonField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        nameField.text = nameField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        nameField.text = nameField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        nameField.text = nameField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        nameField.text = nameField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        nameField.text = nameField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        nameField.text = nameField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        nameField.text = nameField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        
        genderField.text = genderField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        genderField.text = genderField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        genderField.text = genderField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        genderField.text = genderField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        genderField.text = genderField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        genderField.text = genderField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        genderField.text = genderField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        
        
    }
    
    
    
}
