//
//  VehicleExtendedViewController.swift
//  transinfoFinal
//
//  Created by Jessica Cotrina Revilla on 7/31/16.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import UIKit
import CoreData

class VehicleExtendedViewController: UIViewController{
    
    let singleton = Global.sharedGlobal
    
    var values = Dictionary<String,AnyObject>()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var typeVehicleField: SwiftDropDownList!
    @IBOutlet weak var direccionViajeField: SwiftDropDownList!
    @IBOutlet weak var funcionEspecialField: SwiftDropDownList!
    @IBOutlet weak var usoVehiculoField: SwiftDropDownList!
    @IBOutlet weak var maniobraField: SwiftDropDownList!
    @IBOutlet weak var roadDescriptionField: SwiftDropDownList!
    @IBOutlet weak var alineamientoField: SwiftDropDownList!
    @IBOutlet weak var inclinacionField: SwiftDropDownList!
    @IBOutlet weak var categoriaField: SwiftDropDownList!
    @IBOutlet weak var typeCarrilField: SwiftDropDownList!
    @IBOutlet weak var tipoControlesField: SwiftDropDownList!
    @IBOutlet weak var operacionField: SwiftDropDownList!
    @IBOutlet weak var primerCategoria: SwiftDropDownList!
    @IBOutlet weak var segundaCategoria: SwiftDropDownList!
    @IBOutlet weak var terceraCategoria: SwiftDropDownList!
    @IBOutlet weak var cuartaCategoria: SwiftDropDownList!
    @IBOutlet weak var primerEvento: SwiftDropDownList!
    @IBOutlet weak var segundoEvento: SwiftDropDownList!
    @IBOutlet weak var tercerEvento: SwiftDropDownList!
    @IBOutlet weak var cuartoEvento: SwiftDropDownList!
    @IBOutlet weak var usoBusField: SwiftDropDownList!
    @IBOutlet weak var abandonoLugarField: SwiftDropDownList!
    @IBOutlet weak var remolcadoField: SwiftDropDownList!
    @IBOutlet weak var primerDefecto: SwiftDropDownList!
    @IBOutlet weak var segundoDefecto: SwiftDropDownList!
    @IBOutlet weak var PuntoInicialField: SwiftDropDownList!
    @IBOutlet weak var areaAfectadaField: SwiftDropDownList!
    @IBOutlet weak var gradoDanioField: SwiftDropDownList!
    @IBOutlet weak var usoVehiculoComercialField: SwiftDropDownList!
    @IBOutlet weak var vehiculoMovimientoField: SwiftDropDownList!
    @IBOutlet weak var conductorAutorizadoField: SwiftDropDownList!
    @IBOutlet weak var inspeccionDiaField: SwiftDropDownList!
    @IBOutlet weak var permisoEspecialField: SwiftDropDownList!
    @IBOutlet weak var pesoBrutoField: SwiftDropDownList!
    
    @IBOutlet weak var ocupantes: UITextField!
    

    @IBOutlet weak var confVehiculo: SwiftDropDownList!
    @IBOutlet weak var tipoVehiculoCargaField: SwiftDropDownList!
    @IBOutlet weak var vehiculoContieneMPField: SwiftDropDownList!
    @IBOutlet weak var numeroIdentificacionField: SwiftDropDownList!
    @IBOutlet weak var huboDerrameMPField: SwiftDropDownList!
    
    
    
    @IBOutlet weak var cantidadEjesField: UITextField!
    @IBOutlet weak var numberTablillaField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var marcaField: UITextField!
    @IBOutlet weak var modelField: UITextField!
    
    
    @IBOutlet weak var mphField: UITextField!
    @IBOutlet weak var mphdosField: UITextField!
    
    
    @IBOutlet weak var cantidadField: UITextField!

   var ID = [NSManagedObjectID]()
    
    var seleccionMultiple = [Int]()
    
    var dictionary: [String:String] = [
        "numDeTablilla" :"",
        "marca" :"",
        "model" :"",
        "year": "",
        "tipoVehiculoMotor": "",
        "direccionDeViaje": "",
        "funcionEspecial": "",
        "usoDeVehiculo": "",
        "maniobra": "",
        "mph": "",
        "limiteDeVelocidad": "",
        "alineamiento": "",
        "categoriaCarril": "",
        "inclinacion": "",
        "operationOrLost": "",
        "tipoCarril": "",
        "cantidadCarril": "",
        "objectNum": "",
        "primeraCategoria": "",
        "segundaCategoria": "",
        "terceraCategoria": "",
        "cuartaCategoria": "",
        "primerEvento": "",
        "segundoEvento": "",
        "tercerEvento": "",
        "cuartoEvento": "",
        "busUse": "",
        "leftPlace": "",
        "towedDamage": "",
        "primerDefectoMec": "",
        "segundoDefectoMec": "",
        "diamondIDNumber": "",
        "descripcionCarretera": "",
        "commercialVehicle": "",
        "movingVehicle": "",
        "inspectionDate": "",
        "extendDamage": "",
        "authorizedDriver": "",
        "vehicleConfiguration": "",
        "hazardousMaterial": "",
        "specialPermit": "",
        "totalAxis": "",
        "heavyVehicleType": "",
        "grossWeight": "",
        "initialContactPoint": "",
        ]
    
    var objectNum = Int()
    var isUpdating = false
    

    
    
    @IBAction func guardarCondicionAccident(sender: AnyObject) {
        print ("------------")
        
        //singleton.foreignKeys[0].newVehicle = 46
        
        values["vehiclefk"] = singleton.foreignKeys[0].newVehicle
        
        let  webServicesObjectPOST = WebService.init()
        
        webServicesObjectPOST.addIData("VehicleType", value: typeVehicleField.text)
        
        webServicesObjectPOST.addIData("Occupants", value: ocupantes.text)
        
        webServicesObjectPOST.addIData("VehicleMotor", value: "Agricultural Equipment")//??
        
        webServicesObjectPOST.addIData("DirectionTripCB", value: direccionViajeField.text)
        
        webServicesObjectPOST.addIData("FunctionSpecialMVT", value: funcionEspecialField.text)
        
        webServicesObjectPOST.addIData("MotorEmergencyVU", value: usoVehiculoField.text)
        
        webServicesObjectPOST.addIData("MPH", value: mphField.text)
        
        webServicesObjectPOST.addIData("MPHDescription", value: mphdosField.text)
        
        webServicesObjectPOST.addIData("ManeuverVehicleMotor", value: maniobraField.text)
        
        webServicesObjectPOST.addIData("DescriptionRoad", value: roadDescriptionField.text)
        
        webServicesObjectPOST.addIData("Alignment", value: alineamientoField.text)
        
        webServicesObjectPOST.addIData("Slope", value: inclinacionField.text)
        
        webServicesObjectPOST.addIData("LaneCantidad", value: cantidadField.text)
        
        webServicesObjectPOST.addIData("LaneCategoria", value: categoriaField.text)
        
        webServicesObjectPOST.addIData("LaneTipoCarril", value: typeCarrilField.text)
        
        webServicesObjectPOST.addIData("TypeControlTraffic", value: "Other")
        
        webServicesObjectPOST.addIData("InOperationLost", value: operacionField.text)
        
        webServicesObjectPOST.addIData("PrimeraCategoriaEvent", value: primerCategoria.text)
        
        webServicesObjectPOST.addIData("SegundaCategoriaEvent", value: segundaCategoria.text)
        
        webServicesObjectPOST.addIData("TerceraCategoriaEvent", value: terceraCategoria.text)
        
        webServicesObjectPOST.addIData("CuartaCategoria", value: cuartaCategoria.text)
        
        webServicesObjectPOST.addIData("PrimerEvent", value: primerEvento.text)
        
        webServicesObjectPOST.addIData("SegundoEvent", value: segundoEvento.text)
        
        webServicesObjectPOST.addIData("TecerEvent", value: tercerEvento.text)
        
        webServicesObjectPOST.addIData("CuartoEvent", value: cuartoEvento.text)
        
        webServicesObjectPOST.addIData("BusUse", value: usoBusField.text)
        
        webServicesObjectPOST.addIData("LefthPlace", value: abandonoLugarField.text)
        
        webServicesObjectPOST.addIData("TowedDamage", value: remolcadoField.text)
        
        webServicesObjectPOST.addIData("PrimerDefectoMecánico", value: primerDefecto.text)
        
        webServicesObjectPOST.addIData("SegundoDefectoMecánico", value: segundoDefecto.text)
        
        webServicesObjectPOST.addIData("InitialContactPoint", value: PuntoInicialField.text)
        
        webServicesObjectPOST.addIData("AffectedArea", value: areaAfectadaField.text)
        
        webServicesObjectPOST.addIData("ExtendDamage", value: gradoDanioField.text)
        
        webServicesObjectPOST.addIData("CommercialVehicleUse", value: usoVehiculoComercialField.text)
        
        webServicesObjectPOST.addIData("VehicleMoving", value: vehiculoMovimientoField.text)
        
        webServicesObjectPOST.addIData("AuthorizedDriver", value: conductorAutorizadoField.text)
        
        webServicesObjectPOST.addIData("InspectionUpdate", value: inspeccionDiaField.text)
        
        webServicesObjectPOST.addIData("SpecialPermit", value: permisoEspecialField.text)
        
        webServicesObjectPOST.addIData("GrossWeight", value: pesoBrutoField.text)
        
        webServicesObjectPOST.addIData("TotalAxis", value: cantidadEjesField.text)
        
        webServicesObjectPOST.addIData("VehicleConfiguration", value: confVehiculo.text)
        
        webServicesObjectPOST.addIData("HeavyVehicleType", value: tipoVehiculoCargaField.text)
        
        webServicesObjectPOST.addIData("HazardousMaterial", value: vehiculoContieneMPField.text)
        
        webServicesObjectPOST.addIData("DiamondIdNumber", value: numeroIdentificacionField.text)
        
        webServicesObjectPOST.addIData("ThereHazardousMaterial", value: huboDerrameMPField.text)
        
        webServicesObjectPOST.addIData("VehicleFK", value: values["vehiclefk"]?.stringValue)
        
        //captura el fk vehicle
        print(webServicesObjectPOST.PostData)
        
        
        //print(webServicesObjectPOST.sendPOSTs(6))
        
        var postFK = webServicesObjectPOST.sendPOSTs(6)
        
        
        
        if (postFK.first?.0 == "error"/*postFK["error_code"]?.integerValue != 200*/)  {
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
    
    
    func confirm(action: UIAlertAction){
        performSegueWithIdentifier("unwindToVC", sender: self)
    }

    
    @IBAction func seleccionMultipleTipoControlesTransito(sender: AnyObject) {
        print("gotIn")
        seleccionMultiple.append(tipoControlesField.selectedIndex)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(singleton.firstTabInfo[0].sawReport)
        if singleton.firstTabInfo[0].vehicleExtendTab["vehicleType"] != "" {
            let counter = singleton.listVehicle[0].counter
            let arrayForStuff = singleton.listVehicle[0].arrayVehicle[counter]
            remolcadoField.text = String(arrayForStuff["towedDamage"]!)
            ocupantes.text = String(arrayForStuff["occupants"]!)
            mphField.text = String(arrayForStuff["mPH"]!)
            confVehiculo.text = String(arrayForStuff["vehicleConfiguration"]!)
            cuartoEvento.text = String(arrayForStuff["cuartoEvent"]!)
            cantidadField.text = String(arrayForStuff["laneCantidad"]!)//??
            usoVehiculoField.text = String(arrayForStuff["motorEmergencyVU"]!)
            abandonoLugarField.text = String(arrayForStuff["lefthPlace"]!)
            conductorAutorizadoField.text = String(arrayForStuff["authorizedDriver"]!)
            pesoBrutoField.text = String(arrayForStuff["grossWeight"]!)
            segundoEvento.text = String(arrayForStuff["segundoEvent"]!)
            cantidadEjesField.text = String(arrayForStuff["totalAxis"]!)
            typeVehicleField.text = String(arrayForStuff["vehicleMotor"]!)
            tipoControlesField.text = String(arrayForStuff["typeControlTraffic"]!)
            cuartaCategoria.text = String(arrayForStuff["cuartaCategoria"]!)
            gradoDanioField.text = String(arrayForStuff["extendDamage"]!)
            operacionField.text = String(arrayForStuff["inOperationLost"]!)
            tipoVehiculoCargaField.text = String(arrayForStuff["heavyVehicleType"]!)
            roadDescriptionField.text = String(arrayForStuff["descriptionRoad"]!)
            typeCarrilField.text = String(arrayForStuff["laneTipoCarril"]!)
            PuntoInicialField.text = String(arrayForStuff["initialContactPoint"]!)
            numeroIdentificacionField.text = String(arrayForStuff["diamondIdNumber"]!)
            primerCategoria.text = String(arrayForStuff["primeraCategoriaEvent"]!)
            segundaCategoria.text = String(arrayForStuff["segundaCategoriaEvent"]!)
            mphdosField.text = String(arrayForStuff["mPHDescription"]!)
            inclinacionField.text = String(arrayForStuff["slope"]!)
            usoBusField.text = String(arrayForStuff["busUse"]!)
            categoriaField.text = String(arrayForStuff["laneCategoria"]!)
            vehiculoMovimientoField.text = String(arrayForStuff["vehicleMoving"]!)
            direccionViajeField.text = String(arrayForStuff["directionTripCB"]!)
            permisoEspecialField.text = String(arrayForStuff["specialPermit"]!)
            areaAfectadaField.text = String(arrayForStuff["affectedArea"]!)
            terceraCategoria.text = String(arrayForStuff["terceraCategoriaEvent"]!)
            primerDefecto.text = String(arrayForStuff["primerDefectoMec"]!)
            funcionEspecialField.text = String(arrayForStuff["functionSpecialMVT"]!)
            vehiculoContieneMPField.text = String(arrayForStuff["hazardousMaterial"]!)
            inspeccionDiaField.text = String(arrayForStuff["inspectionUpdate"]!)
            alineamientoField.text = String(arrayForStuff["alignment"]!)
            primerEvento.text = String(arrayForStuff["primerEvent"]!)
            huboDerrameMPField.text = String(arrayForStuff["thereHazardousMaterial"]!)
            typeVehicleField.text = String(arrayForStuff["vehicleType"]!)

            usoVehiculoComercialField.text = String(arrayForStuff["commercialVehicleUse"]!)

            segundoDefecto.text = String(arrayForStuff["segundoDefectoMec"]!)

            tercerEvento.text = String(arrayForStuff["tecerEvent"]!)
            maniobraField.text = String(arrayForStuff["maneuverVehicleMotor"]!)

            correctFormat()
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.contentSize.height = 2550
        //ws
        
        
        let webServicesObject = WebService.init()
        webServicesObject.initiate(6)
        
        
        
        typeVehicleField.isKeyboardHidden = true
        typeVehicleField.isDismissWhenSelected = true
        typeVehicleField.isArrayWithObject = true
        typeVehicleField.keyPath = "DescriptionES"
        typeVehicleField.arrayList = webServicesObject.arrayOfDictionaries("bodytype")
        
        direccionViajeField.isKeyboardHidden = true
        direccionViajeField.isDismissWhenSelected = true
        direccionViajeField.isArrayWithObject = true
        direccionViajeField.keyPath = "DescriptionES"
        direccionViajeField.arrayList = webServicesObject.arrayOfDictionaries("directionOfTravel")
        
        funcionEspecialField.isKeyboardHidden = true
        funcionEspecialField.isDismissWhenSelected = true
        funcionEspecialField.isArrayWithObject = true
        funcionEspecialField.keyPath = "DescriptionES"
        funcionEspecialField.arrayList = webServicesObject.arrayOfDictionaries("specialFunctions")
        
        usoVehiculoField.isKeyboardHidden = true
        usoVehiculoField.isDismissWhenSelected = true
        usoVehiculoField.isArrayWithObject = true
        usoVehiculoField.keyPath = "DescriptionES"
        usoVehiculoField.arrayList = webServicesObject.arrayOfDictionaries("emergencyUses")
        
        maniobraField.isKeyboardHidden = true
        maniobraField.isDismissWhenSelected = true
        maniobraField.isArrayWithObject = true
        maniobraField.keyPath = "DescriptionES"
        maniobraField.arrayList = webServicesObject.arrayOfDictionaries("actions")
        
        roadDescriptionField.isKeyboardHidden = true
        roadDescriptionField.isDismissWhenSelected = true
        roadDescriptionField.isArrayWithObject = true
        roadDescriptionField.keyPath = "DescriptionES"
        roadDescriptionField.arrayList = webServicesObject.arrayOfDictionaries("trafficwayDescriptions")
        
        alineamientoField.isKeyboardHidden = true
        alineamientoField.isDismissWhenSelected = true
        alineamientoField.isArrayWithObject = true
        alineamientoField.keyPath = "DescriptionES"
        alineamientoField.arrayList = webServicesObject.arrayOfDictionaries("roadwayHorizontalAlignments")
        
        inclinacionField.isKeyboardHidden = true
        inclinacionField.isDismissWhenSelected = true
        inclinacionField.isArrayWithObject = true
        inclinacionField.keyPath = "DescriptionES"
        inclinacionField.arrayList = webServicesObject.arrayOfDictionaries("roadwayGrades")
        
        categoriaField.isKeyboardHidden = true
        categoriaField.isDismissWhenSelected = true
        categoriaField.isArrayWithObject = true
        categoriaField.keyPath = "DescriptionES"
        categoriaField.arrayList = webServicesObject.arrayOfDictionaries("totalLanesCategories")
        
        typeCarrilField.isKeyboardHidden = true
        typeCarrilField.isDismissWhenSelected = true
        typeCarrilField.isArrayWithObject = true
        typeCarrilField.keyPath = "DescriptionES"
        typeCarrilField.arrayList = webServicesObject.arrayOfDictionaries("totalLanes")
        
        tipoControlesField.isKeyboardHidden = true
        tipoControlesField.isDismissWhenSelected = true
        tipoControlesField.isArrayWithObject = true
        tipoControlesField.keyPath = "DescriptionES"
        tipoControlesField.arrayList = webServicesObject.arrayOfDictionaries("TCDTypes")
        
        operacionField.isKeyboardHidden = true
        operacionField.isDismissWhenSelected = true
        operacionField.isArrayWithObject = true
        operacionField.keyPath = "DescriptionES"
        operacionField.arrayList = webServicesObject.arrayOfDictionaries("TCDWorking")
        
        primerCategoria.isKeyboardHidden = true
        primerCategoria.isDismissWhenSelected = true
        primerCategoria.isArrayWithObject = true
        primerCategoria.keyPath = "DescriptionES"
        primerCategoria.arrayList = webServicesObject.arrayOfDictionaries("harmfulEventCategories")
        
        segundaCategoria.isKeyboardHidden = true
        segundaCategoria.isDismissWhenSelected = true
        segundaCategoria.isArrayWithObject = true
        segundaCategoria.keyPath = "DescriptionES"
        segundaCategoria.arrayList = webServicesObject.arrayOfDictionaries("harmfulEventCategories")
        
        terceraCategoria.isKeyboardHidden = true
        terceraCategoria.isDismissWhenSelected = true
        terceraCategoria.isArrayWithObject = true
        terceraCategoria.keyPath = "DescriptionES"
        terceraCategoria.arrayList = webServicesObject.arrayOfDictionaries("harmfulEventCategories")
        
        cuartaCategoria.isKeyboardHidden = true
        cuartaCategoria.isDismissWhenSelected = true
        cuartaCategoria.isArrayWithObject = true
        cuartaCategoria.keyPath = "DescriptionES"
        cuartaCategoria.arrayList = webServicesObject.arrayOfDictionaries("harmfulEventCategories")
        
        primerEvento.isKeyboardHidden = true
        primerEvento.isDismissWhenSelected = true
        primerEvento.isArrayWithObject = true
        primerEvento.keyPath = "DescriptionES"
        primerEvento.arrayList = webServicesObject.arrayOfDictionaries("harmfulEvents")
        
        segundoEvento.isKeyboardHidden = true
        segundoEvento.isDismissWhenSelected = true
        segundoEvento.isArrayWithObject = true
        segundoEvento.keyPath = "DescriptionES"
        segundoEvento.arrayList = webServicesObject.arrayOfDictionaries("harmfulEvents")
        
        tercerEvento.isKeyboardHidden = true
        tercerEvento.isDismissWhenSelected = true
        tercerEvento.isArrayWithObject = true
        tercerEvento.keyPath = "DescriptionES"
        tercerEvento.arrayList = webServicesObject.arrayOfDictionaries("harmfulEvents")
        
        cuartoEvento.isKeyboardHidden = true
        cuartoEvento.isDismissWhenSelected = true
        cuartoEvento.isArrayWithObject = true
        cuartoEvento.keyPath = "DescriptionES"
        cuartoEvento.arrayList = webServicesObject.arrayOfDictionaries("harmfulEvents")
        
        usoBusField.isKeyboardHidden = true
        usoBusField.isDismissWhenSelected = true
        usoBusField.isArrayWithObject = true
        usoBusField.keyPath = "DescriptionES"
        usoBusField.arrayList = webServicesObject.arrayOfDictionaries("schoolBusRelated")
        
        abandonoLugarField.isKeyboardHidden = true
        abandonoLugarField.isDismissWhenSelected = true
        abandonoLugarField.isArrayWithObject = true
        abandonoLugarField.keyPath = "DescriptionES"
        abandonoLugarField.arrayList = webServicesObject.arrayOfDictionaries("hitAndRun")
        
        remolcadoField.isKeyboardHidden = true
        remolcadoField.isDismissWhenSelected = true
        remolcadoField.isArrayWithObject = true
        remolcadoField.keyPath = "DescriptionES"
        remolcadoField.arrayList = webServicesObject.arrayOfDictionaries("towedBy")
        
        primerDefecto.isKeyboardHidden = true
        primerDefecto.isDismissWhenSelected = true
        primerDefecto.isArrayWithObject = true
        primerDefecto.keyPath = "DescriptionES"
        primerDefecto.arrayList = webServicesObject.arrayOfDictionaries("vehicleCircumstances")
        
        segundoDefecto.isKeyboardHidden = true
        segundoDefecto.isDismissWhenSelected = true
        segundoDefecto.isArrayWithObject = true
        segundoDefecto.keyPath = "DescriptionES"
        segundoDefecto.arrayList = webServicesObject.arrayOfDictionaries("vehicleCircumstances")
        
        PuntoInicialField.isKeyboardHidden = true
        PuntoInicialField.isDismissWhenSelected = true
        PuntoInicialField.isArrayWithObject = true
        PuntoInicialField.keyPath = "DescriptionES"
        PuntoInicialField.arrayList = webServicesObject.arrayOfDictionaries("initialContactPoints")
        
        areaAfectadaField.isKeyboardHidden = true
        areaAfectadaField.isDismissWhenSelected = true
        areaAfectadaField.isArrayWithObject = true
        areaAfectadaField.keyPath = "DescriptionES"
        areaAfectadaField.arrayList = webServicesObject.arrayOfDictionaries("damagedAreas")
        
        gradoDanioField.isKeyboardHidden = true
        gradoDanioField.isDismissWhenSelected = true
        gradoDanioField.isArrayWithObject = true
        gradoDanioField.keyPath = "DescriptionES"
        gradoDanioField.arrayList = webServicesObject.arrayOfDictionaries("extentOfDamages")
        
        usoVehiculoComercialField.isKeyboardHidden = true
        usoVehiculoComercialField.isDismissWhenSelected = true
        usoVehiculoComercialField.isArrayWithObject = true
        usoVehiculoComercialField.keyPath = "DescriptionES"
        usoVehiculoComercialField.arrayList = webServicesObject.arrayOfDictionaries("motorCarrierTypes")
        
        vehiculoMovimientoField.isKeyboardHidden = true
        vehiculoMovimientoField.isDismissWhenSelected = true
        vehiculoMovimientoField.isArrayWithObject = true
        vehiculoMovimientoField.keyPath = "DescriptionES"
        vehiculoMovimientoField.arrayList = webServicesObject.arrayOfDictionaries("vehicleMovements")
        
        conductorAutorizadoField.isKeyboardHidden = true
        conductorAutorizadoField.isDismissWhenSelected = true
        conductorAutorizadoField.isArrayWithObject = true
        conductorAutorizadoField.keyPath = "DescriptionES"
        conductorAutorizadoField.arrayList = webServicesObject.arrayOfDictionaries("driverIsAuthorized")
        
        inspeccionDiaField.isKeyboardHidden = true
        inspeccionDiaField.isDismissWhenSelected = true
        inspeccionDiaField.isArrayWithObject = true
        inspeccionDiaField.keyPath = "DescriptionES"
        inspeccionDiaField.arrayList = webServicesObject.arrayOfDictionaries("driverIsAuthorized")
        
        permisoEspecialField.isKeyboardHidden = true
        permisoEspecialField.isDismissWhenSelected = true
        permisoEspecialField.isArrayWithObject = true
        permisoEspecialField.keyPath = "DescriptionES"
        permisoEspecialField.arrayList = webServicesObject.arrayOfDictionaries("driverIsAuthorized")
        
        pesoBrutoField.isKeyboardHidden = true
        pesoBrutoField.isDismissWhenSelected = true
        pesoBrutoField.isArrayWithObject = true
        pesoBrutoField.keyPath = "DescriptionES"
        pesoBrutoField.arrayList = webServicesObject.arrayOfDictionaries("GVWRGCWR")
        
        confVehiculo.isKeyboardHidden = true
        confVehiculo.isDismissWhenSelected = true
        confVehiculo.isArrayWithObject = true
        confVehiculo.keyPath = "DescriptionES"
        confVehiculo.arrayList = webServicesObject.arrayOfDictionaries("configurations")
        
        tipoVehiculoCargaField.isKeyboardHidden = true
        tipoVehiculoCargaField.isDismissWhenSelected = true
        tipoVehiculoCargaField.isArrayWithObject = true
        tipoVehiculoCargaField.keyPath = "DescriptionES"
        tipoVehiculoCargaField.arrayList = webServicesObject.arrayOfDictionaries("cargoBodyTypes")
        
        vehiculoContieneMPField.isKeyboardHidden = true
        vehiculoContieneMPField.isDismissWhenSelected = true
        vehiculoContieneMPField.isArrayWithObject = true
        vehiculoContieneMPField.keyPath = "DescriptionES"
        vehiculoContieneMPField.arrayList = webServicesObject.arrayOfDictionaries("hazMatInvolved") //si no y no aplica
        
        numeroIdentificacionField.isKeyboardHidden = true
        numeroIdentificacionField.isDismissWhenSelected = true
        numeroIdentificacionField.isArrayWithObject = true
        numeroIdentificacionField.keyPath = "DescriptionES"
        numeroIdentificacionField.arrayList = webServicesObject.arrayOfDictionaries("hazMatReleased")
        
        huboDerrameMPField.isKeyboardHidden = true
        huboDerrameMPField.isDismissWhenSelected = true
        huboDerrameMPField.isArrayWithObject = true
        huboDerrameMPField.keyPath = "DescriptionES"
        huboDerrameMPField.arrayList = webServicesObject.arrayOfDictionaries("hazMatInvolved")
        

        
        
        modelField.text = singleton.listVehicle[0].vehicle["model"]
        yearField.text = singleton.listVehicle[0].vehicle["year"]
        marcaField.text = singleton.listVehicle[0].vehicle["make"]
        numberTablillaField.text = singleton.listVehicle[0].vehicle["numTablilla"]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    func correctFormat(){
        
        
        typeVehicleField.text = typeVehicleField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        typeVehicleField.text = typeVehicleField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        typeVehicleField.text = typeVehicleField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        typeVehicleField.text = typeVehicleField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        typeVehicleField.text = typeVehicleField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        typeVehicleField.text = typeVehicleField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        typeVehicleField.text = typeVehicleField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        direccionViajeField.text = direccionViajeField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        direccionViajeField.text = direccionViajeField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        direccionViajeField.text = direccionViajeField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        direccionViajeField.text = direccionViajeField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        direccionViajeField.text = direccionViajeField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        direccionViajeField.text = direccionViajeField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        direccionViajeField.text = direccionViajeField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        funcionEspecialField.text = funcionEspecialField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        funcionEspecialField.text = funcionEspecialField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        funcionEspecialField.text = funcionEspecialField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        funcionEspecialField.text = funcionEspecialField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        funcionEspecialField.text = funcionEspecialField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        funcionEspecialField.text = funcionEspecialField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        funcionEspecialField.text = funcionEspecialField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        usoVehiculoField.text = usoVehiculoField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        usoVehiculoField.text = usoVehiculoField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        usoVehiculoField.text = usoVehiculoField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        usoVehiculoField.text = usoVehiculoField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        usoVehiculoField.text = usoVehiculoField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        usoVehiculoField.text = usoVehiculoField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        usoVehiculoField.text = usoVehiculoField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        maniobraField.text = maniobraField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        maniobraField.text = maniobraField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        maniobraField.text = maniobraField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        maniobraField.text = maniobraField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        maniobraField.text = maniobraField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        maniobraField.text = maniobraField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        maniobraField.text = maniobraField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        roadDescriptionField.text = roadDescriptionField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        roadDescriptionField.text = roadDescriptionField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        roadDescriptionField.text = roadDescriptionField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        roadDescriptionField.text = roadDescriptionField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        roadDescriptionField.text = roadDescriptionField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        roadDescriptionField.text = roadDescriptionField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        roadDescriptionField.text = roadDescriptionField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        alineamientoField.text = alineamientoField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        alineamientoField.text = alineamientoField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        alineamientoField.text = alineamientoField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        alineamientoField.text = alineamientoField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        alineamientoField.text = alineamientoField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        alineamientoField.text = alineamientoField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        alineamientoField.text = alineamientoField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        inclinacionField.text = inclinacionField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        inclinacionField.text = inclinacionField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        inclinacionField.text = inclinacionField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        inclinacionField.text = inclinacionField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        inclinacionField.text = inclinacionField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        inclinacionField.text = inclinacionField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        inclinacionField.text = inclinacionField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        categoriaField.text = categoriaField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        categoriaField.text = categoriaField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        categoriaField.text = categoriaField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        categoriaField.text = categoriaField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        categoriaField.text = categoriaField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        categoriaField.text = categoriaField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        categoriaField.text = categoriaField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        typeCarrilField.text = typeCarrilField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        typeCarrilField.text = typeCarrilField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        typeCarrilField.text = typeCarrilField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        typeCarrilField.text = typeCarrilField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        typeCarrilField.text = typeCarrilField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        typeCarrilField.text = typeCarrilField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        typeCarrilField.text = typeCarrilField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        tipoControlesField.text = tipoControlesField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        tipoControlesField.text = tipoControlesField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        tipoControlesField.text = tipoControlesField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        tipoControlesField.text = tipoControlesField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        tipoControlesField.text = tipoControlesField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        tipoControlesField.text = tipoControlesField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        tipoControlesField.text = tipoControlesField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        operacionField.text = operacionField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        operacionField.text = operacionField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        operacionField.text = operacionField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        operacionField.text = operacionField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        operacionField.text = operacionField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        operacionField.text = operacionField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        operacionField.text = operacionField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        primerCategoria.text = primerCategoria.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        primerCategoria.text = primerCategoria.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        primerCategoria.text = primerCategoria.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        primerCategoria.text = primerCategoria.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        primerCategoria.text = primerCategoria.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        primerCategoria.text = primerCategoria.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        primerCategoria.text = primerCategoria.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        segundaCategoria.text = segundaCategoria.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        segundaCategoria.text = segundaCategoria.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        segundaCategoria.text = segundaCategoria.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        segundaCategoria.text = segundaCategoria.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        segundaCategoria.text = segundaCategoria.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        segundaCategoria.text = segundaCategoria.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        segundaCategoria.text = segundaCategoria.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        terceraCategoria.text = terceraCategoria.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        terceraCategoria.text = terceraCategoria.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        terceraCategoria.text = terceraCategoria.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        terceraCategoria.text = terceraCategoria.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        terceraCategoria.text = terceraCategoria.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        terceraCategoria.text = terceraCategoria.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        terceraCategoria.text = terceraCategoria.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        cuartaCategoria.text = cuartaCategoria.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        cuartaCategoria.text = cuartaCategoria.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        cuartaCategoria.text = cuartaCategoria.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        cuartaCategoria.text = cuartaCategoria.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        cuartaCategoria.text = cuartaCategoria.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        cuartaCategoria.text = cuartaCategoria.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        cuartaCategoria.text = cuartaCategoria.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        primerEvento.text = primerEvento.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        primerEvento.text = primerEvento.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        primerEvento.text = primerEvento.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        primerEvento.text = primerEvento.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        primerEvento.text = primerEvento.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        primerEvento.text = primerEvento.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        primerEvento.text = primerEvento.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        segundoEvento.text = segundoEvento.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        segundoEvento.text = segundoEvento.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        segundoEvento.text = segundoEvento.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        segundoEvento.text = segundoEvento.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        segundoEvento.text = segundoEvento.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        segundoEvento.text = segundoEvento.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        segundoEvento.text = segundoEvento.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        tercerEvento.text = tercerEvento.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        tercerEvento.text = tercerEvento.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        tercerEvento.text = tercerEvento.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        tercerEvento.text = tercerEvento.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        tercerEvento.text = tercerEvento.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        tercerEvento.text = tercerEvento.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        tercerEvento.text = tercerEvento.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        cuartoEvento.text = cuartoEvento.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        cuartoEvento.text = cuartoEvento.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        cuartoEvento.text = cuartoEvento.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        cuartoEvento.text = cuartoEvento.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        cuartoEvento.text = cuartoEvento.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        cuartoEvento.text = cuartoEvento.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        cuartoEvento.text = cuartoEvento.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        usoBusField.text = usoBusField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        usoBusField.text = usoBusField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        usoBusField.text = usoBusField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        usoBusField.text = usoBusField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        usoBusField.text = usoBusField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        usoBusField.text = usoBusField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        usoBusField.text = usoBusField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        abandonoLugarField.text = abandonoLugarField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        abandonoLugarField.text = abandonoLugarField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        abandonoLugarField.text = abandonoLugarField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        abandonoLugarField.text = abandonoLugarField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        abandonoLugarField.text = abandonoLugarField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        abandonoLugarField.text = abandonoLugarField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        abandonoLugarField.text = abandonoLugarField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        remolcadoField.text = remolcadoField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        remolcadoField.text = remolcadoField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        remolcadoField.text = remolcadoField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        remolcadoField.text = remolcadoField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        remolcadoField.text = remolcadoField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        remolcadoField.text = remolcadoField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        remolcadoField.text = remolcadoField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        primerDefecto.text = primerDefecto.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        primerDefecto.text = primerDefecto.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        primerDefecto.text = primerDefecto.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        primerDefecto.text = primerDefecto.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        primerDefecto.text = primerDefecto.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        primerDefecto.text = primerDefecto.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        primerDefecto.text = primerDefecto.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        segundoDefecto.text = segundoDefecto.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        segundoDefecto.text = segundoDefecto.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        segundoDefecto.text = segundoDefecto.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        segundoDefecto.text = segundoDefecto.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        segundoDefecto.text = segundoDefecto.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        segundoDefecto.text = segundoDefecto.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        segundoDefecto.text = segundoDefecto.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        PuntoInicialField.text = PuntoInicialField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        PuntoInicialField.text = PuntoInicialField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        PuntoInicialField.text = PuntoInicialField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        PuntoInicialField.text = PuntoInicialField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        PuntoInicialField.text = PuntoInicialField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        PuntoInicialField.text = PuntoInicialField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        PuntoInicialField.text = PuntoInicialField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        areaAfectadaField.text = areaAfectadaField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        areaAfectadaField.text = areaAfectadaField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        areaAfectadaField.text = areaAfectadaField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        areaAfectadaField.text = areaAfectadaField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        areaAfectadaField.text = areaAfectadaField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        areaAfectadaField.text = areaAfectadaField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        areaAfectadaField.text = areaAfectadaField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        gradoDanioField.text = gradoDanioField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        gradoDanioField.text = gradoDanioField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        gradoDanioField.text = gradoDanioField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        gradoDanioField.text = gradoDanioField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        gradoDanioField.text = gradoDanioField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        gradoDanioField.text = gradoDanioField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        gradoDanioField.text = gradoDanioField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        usoVehiculoComercialField.text = usoVehiculoComercialField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        usoVehiculoComercialField.text = usoVehiculoComercialField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        usoVehiculoComercialField.text = usoVehiculoComercialField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        usoVehiculoComercialField.text = usoVehiculoComercialField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        usoVehiculoComercialField.text = usoVehiculoComercialField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        usoVehiculoComercialField.text = usoVehiculoComercialField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        usoVehiculoComercialField.text = usoVehiculoComercialField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        vehiculoMovimientoField.text = vehiculoMovimientoField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        vehiculoMovimientoField.text = vehiculoMovimientoField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        vehiculoMovimientoField.text = vehiculoMovimientoField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        vehiculoMovimientoField.text = vehiculoMovimientoField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        vehiculoMovimientoField.text = vehiculoMovimientoField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        vehiculoMovimientoField.text = vehiculoMovimientoField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        vehiculoMovimientoField.text = vehiculoMovimientoField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        conductorAutorizadoField.text = conductorAutorizadoField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        conductorAutorizadoField.text = conductorAutorizadoField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        conductorAutorizadoField.text = conductorAutorizadoField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        conductorAutorizadoField.text = conductorAutorizadoField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        conductorAutorizadoField.text = conductorAutorizadoField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        conductorAutorizadoField.text = conductorAutorizadoField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        conductorAutorizadoField.text = conductorAutorizadoField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        inspeccionDiaField.text = inspeccionDiaField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        inspeccionDiaField.text = inspeccionDiaField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        inspeccionDiaField.text = inspeccionDiaField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        inspeccionDiaField.text = inspeccionDiaField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        inspeccionDiaField.text = inspeccionDiaField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        inspeccionDiaField.text = inspeccionDiaField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        inspeccionDiaField.text = inspeccionDiaField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        permisoEspecialField.text = permisoEspecialField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        permisoEspecialField.text = permisoEspecialField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        permisoEspecialField.text = permisoEspecialField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        permisoEspecialField.text = permisoEspecialField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        permisoEspecialField.text = permisoEspecialField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        permisoEspecialField.text = permisoEspecialField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        permisoEspecialField.text = permisoEspecialField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        pesoBrutoField.text = pesoBrutoField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        pesoBrutoField.text = pesoBrutoField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        pesoBrutoField.text = pesoBrutoField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        pesoBrutoField.text = pesoBrutoField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        pesoBrutoField.text = pesoBrutoField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        pesoBrutoField.text = pesoBrutoField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        pesoBrutoField.text = pesoBrutoField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        confVehiculo.text = confVehiculo.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        confVehiculo.text = confVehiculo.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        confVehiculo.text = confVehiculo.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        confVehiculo.text = confVehiculo.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        confVehiculo.text = confVehiculo.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        confVehiculo.text = confVehiculo.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        confVehiculo.text = confVehiculo.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        tipoVehiculoCargaField.text = tipoVehiculoCargaField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        tipoVehiculoCargaField.text = tipoVehiculoCargaField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        tipoVehiculoCargaField.text = tipoVehiculoCargaField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        tipoVehiculoCargaField.text = tipoVehiculoCargaField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        tipoVehiculoCargaField.text = tipoVehiculoCargaField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        tipoVehiculoCargaField.text = tipoVehiculoCargaField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        tipoVehiculoCargaField.text = tipoVehiculoCargaField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        vehiculoContieneMPField.text = vehiculoContieneMPField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        vehiculoContieneMPField.text = vehiculoContieneMPField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        vehiculoContieneMPField.text = vehiculoContieneMPField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        vehiculoContieneMPField.text = vehiculoContieneMPField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        vehiculoContieneMPField.text = vehiculoContieneMPField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        vehiculoContieneMPField.text = vehiculoContieneMPField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        vehiculoContieneMPField.text = vehiculoContieneMPField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        numeroIdentificacionField.text = numeroIdentificacionField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        numeroIdentificacionField.text = numeroIdentificacionField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        numeroIdentificacionField.text = numeroIdentificacionField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        numeroIdentificacionField.text = numeroIdentificacionField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        numeroIdentificacionField.text = numeroIdentificacionField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        numeroIdentificacionField.text = numeroIdentificacionField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        numeroIdentificacionField.text = numeroIdentificacionField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        huboDerrameMPField.text = huboDerrameMPField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        huboDerrameMPField.text = huboDerrameMPField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        huboDerrameMPField.text = huboDerrameMPField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        huboDerrameMPField.text = huboDerrameMPField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        huboDerrameMPField.text = huboDerrameMPField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        huboDerrameMPField.text = huboDerrameMPField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        huboDerrameMPField.text = huboDerrameMPField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        cantidadEjesField.text = cantidadEjesField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        cantidadEjesField.text = cantidadEjesField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        cantidadEjesField.text = cantidadEjesField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        cantidadEjesField.text = cantidadEjesField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        cantidadEjesField.text = cantidadEjesField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        cantidadEjesField.text = cantidadEjesField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        cantidadEjesField.text = cantidadEjesField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        marcaField.text = marcaField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        marcaField.text = marcaField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        marcaField.text = marcaField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        marcaField.text = marcaField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        marcaField.text = marcaField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        marcaField.text = marcaField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        marcaField.text = marcaField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        modelField.text = modelField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        modelField.text = modelField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        modelField.text = modelField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        modelField.text = modelField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        modelField.text = modelField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        modelField.text = modelField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        modelField.text = modelField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
    }
 
}



