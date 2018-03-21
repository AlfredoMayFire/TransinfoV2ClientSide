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
        
        webServicesObjectPOST.addIData("VehicleMotor", value: "Agricultural Equipment")
        
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
        
        webServicesObjectPOST.addIData("AffectedArea", value: "12")
        
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
        
        print(singleton.foreignKeys[0])
        
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
 
}



