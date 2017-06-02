//
//  WebServices.swift
//  transinfoFinal
//
//  Created by Pedro Santiago on 10/20/16.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import Foundation

class WebService : NSObject{
    
    var GetsData : Dictionary<String,Array<Dictionary<String,AnyObject>>> = ["empty":[["vacio":"empty", "0":"empty"]]]              //THE GET DICTIONARY
    var Data : Dictionary<String, String> = ["empty":"empty"]                                    //THE DATA DICTIONARY
    var PostData : Dictionary<String, String> = ["empty":"empty"]                                //THE POST DATA
    
    private let url = Constants.ApiScheme + Constants.ApiHost                        //URL
    private var dataDownloaded : Array<Bool> = [false,false,false,false,false,false]       //Variable for AlreadyDownloaded()
    private var dataSended : Array<Bool> = [false, false, false]                     //Variable for cheking If data was sended
    
    override init(){
        GetsData.removeAll()
        Data.removeAll()
        PostData.removeAll()
    }
    
    //GET group of GET's ******TODO traducir(anadir ES o EN)*******
    func initiate(calls:Int) {
        
        switch calls {
            
        case 1:     // Informacion basica del accidente
            if(!checkInitiation(calls-1)){
                
                self.addDatatoGetsData("counties", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.counties)))
                self.addDatatoGetsData("cities", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.cities)))
                self.addDatatoGetsData("zoneTypes", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.zoneTypes)))
                self.addDatatoGetsData("measurements", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.measurements)))
                self.addDatatoGetsData("properties", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.properties)))
                self.addDatatoGetsData("directions", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.directions)))
                self.addDatatoGetsData("locations", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.locations)))
                self.addDatatoGetsData("reportTypes", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.reportTypes)))
                self.addDatatoGetsData("nearTo", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.nearTo)))
                dataDownloaded[calls-1]=true
            }else{
                print("Recalling same methods attempted")
            }
            break
            
        case 2:     // Condiciones del Accidente
            if(!checkInitiation(calls-1)){
                
                //   self.addDatatoGetsData("collisionTypes", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.coll)))
                self.addDatatoGetsData("harmfulEvents", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.harmfulEvents)))
                self.addDatatoGetsData("harmfulEventCategories", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.harmfulEventsCatefories)))
                self.addDatatoGetsData("mannerOfColisions", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.mannerOfCollisions)))
                self.addDatatoGetsData("weatherConditions", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.weatherConditions)))
                self.addDatatoGetsData("lightingConditions", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.lightingConditions)))
                self.addDatatoGetsData("roadSurfaces", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.roadSurfaces)))
                self.addDatatoGetsData("environmentConditions", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.environmentConditions)))
                self.addDatatoGetsData("roadCircumstances", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.roadCircumstances)))
                self.addDatatoGetsData("withinInterchanges", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.withinInterchanges)))
                self.addDatatoGetsData("junctions", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.junctions)))
                self.addDatatoGetsData("intersectionTypes", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.intersectionTypes)))
                self.addDatatoGetsData("schoolBusRelated", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.schoolBusRelated)))
                self.addDatatoGetsData("workzoneRelated", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.workzoneRelated)))
                self.addDatatoGetsData("workzoneLocations", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.workzoneLocations)))
                self.addDatatoGetsData("workzoneTypes", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.workzoneTypes)))
                self.addDatatoGetsData("workersPresent", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.workersPresent)))
                self.addDatatoGetsData("lawEnforcementPresent", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.lawEnforcementPresent)))
                dataDownloaded[calls-1]=true
            }else{
                print("Recalling same methods attempted")
            }
            break
            
        case 3:     // Nueva Persona
            
            if(!checkInitiation(calls-1)){
                
                self.addDatatoGetsData("personTypeCategories", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.personTypeCategories)))
                self.addDatatoGetsData("personTypes", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.personTypes)))
                self.addDatatoGetsData("driverLicenseTypes", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.driverLicenseTypes)))
                self.addDatatoGetsData("genders", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.genders)))
                self.addDatatoGetsData("organDonor", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.organDonor)))
                self.addDatatoGetsData("counties", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.counties)))
                self.addDatatoGetsData("transportedBy", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.transportedBy)))
                self.addDatatoGetsData("cities", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.cities)))
                dataDownloaded[calls-1]=true
            }else{
                print("Recalling same methods attempted")
            }
            break
            
        case 4:     // Persona Detallado
            
            if(!checkInitiation(calls-1)){
                
                self.addDatatoGetsData("rows", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.rows)))
                self.addDatatoGetsData("seats", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.seats)))
                self.addDatatoGetsData("seatingOthers", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.seatingOthers)))
                self.addDatatoGetsData("restraintSystems", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.restraintSystems)))
                self.addDatatoGetsData("airbagDeployed", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.airbagDeployed)))
                self.addDatatoGetsData("ejections", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.ejections)))
                self.addDatatoGetsData("speedingSuspected", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.speedingSuspected)))
                self.addDatatoGetsData("contribActionsCircumstances", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.contribActionsCircumstances)))
                self.addDatatoGetsData("distractedBy", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.distractedBy)))
                self.addDatatoGetsData("conditions", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.conditions)))
                self.addDatatoGetsData("safetyEquipments", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.safetyEquipments)))
                self.addDatatoGetsData("testStatuses", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.testStatuses)))
                self.addDatatoGetsData("drugTestTypes", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.drugTestTypes)))
                self.addDatatoGetsData("alcoholTestTypes", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.alcoholTestTypes)))
                self.addDatatoGetsData("alcoholTestResults", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.alcoholTestResults)))
                self.addDatatoGetsData("drugTestResults", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.drugTestResults)))
                self.addDatatoGetsData("actionsPriorToCrash", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.actionsPriorToCrash)))
                self.addDatatoGetsData("toFromSchool", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.toFromSchool)))
                self.addDatatoGetsData("nonMotoristLocations", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.nonMotoristLocations)))
                self.addDatatoGetsData("extrications", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.extrications)))
                self.addDatatoGetsData("substancesSuspected", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.substancesSuspected)))
                self.addDatatoGetsData("testStatuses", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.testStatuses)))
                self.addDatatoGetsData("actionsAtTimeOfCrash", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.actionsAtTimeOfCrash)))

                dataDownloaded[calls-1]=true
            }else{
                print("Recalling same methods attempted")
            }
            break
            
        case 5:     // Nuevo Vehiculo
            
            if(!checkInitiation(calls-1)){
                
                self.addDatatoGetsData("vehicleTypes", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.vehicleType)))
                self.addDatatoGetsData("vehicleJurisdictions", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.vehicleJurisdictions)))
                dataDownloaded[calls-1]=true
            }else{
                print("Recalling same methods attempted")
            }
            break
            
        case 6:     // Vehiculo Detallado
            
            if(!checkInitiation(calls-1)){
                
                self.addDatatoGetsData("bodytype", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.bodyTypes)))
                self.addDatatoGetsData("directionOfTravel", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.directionsOfTravel)))
                self.addDatatoGetsData("specialFunctions", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.specialFunctions)))
                self.addDatatoGetsData("emergencyUses", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.emergencyUses)))
                self.addDatatoGetsData("postedSpeeds", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.postedSpeeds)))
                self.addDatatoGetsData("actions", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.actions)))
                self.addDatatoGetsData("trafficwayDescriptions", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.trafficWayDescription)))
                self.addDatatoGetsData("roadwayHorizontalAlignments", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.roadwayHorizontalAlignments)))
                self.addDatatoGetsData("roadwayGrades", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.roadwayGrades)))
                self.addDatatoGetsData("totalLanesCategories", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.totalLanesCategories)))
                self.addDatatoGetsData("totalLanes", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.totalLanes)))
                self.addDatatoGetsData("harmfulEventCategories", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.harmfulEventsCatefories)))
                self.addDatatoGetsData("schoolBusRelated", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.schoolBusRelated)))
                self.addDatatoGetsData("towedBy", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.towedBy)))
                self.addDatatoGetsData("vehicleCircumstances", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.vehicleCircumstances)))
                self.addDatatoGetsData("initialContactPoints", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.initialContactPoints)))
                self.addDatatoGetsData("damagedAreas", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.damagedAreas)))
                self.addDatatoGetsData("extentOfDamages", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.extentOfDamages)))
                self.addDatatoGetsData("vehicleMovements", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.vehicleMovements)))
                self.addDatatoGetsData("driverIsAuthorized", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.driverIsAuthorized)))
                self.addDatatoGetsData("inspectionUpToDate", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.inspectionUpToDate)))
                self.addDatatoGetsData("GVWRGCWR", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.GVWRGCWR)))
                self.addDatatoGetsData("configurations", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.configurations)))
                self.addDatatoGetsData("initialContactPoints", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.initialContactPoints)))
                self.addDatatoGetsData("damagedAreas", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.damagedAreas)))
                self.addDatatoGetsData("motorCarrierTypes", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.motorCarrierTypes)))
                self.addDatatoGetsData("hazMatInvolved", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.hazMatInvolved)))
                self.addDatatoGetsData("specialPermits", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.specialPermits)))
                self.addDatatoGetsData("TCDTypes", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.TCDTypes)))
                self.addDatatoGetsData("TCDWorking", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.TCDWorking)))
                self.addDatatoGetsData("harmfulEvents", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.harmfulEvents)))
                self.addDatatoGetsData("hitAndRun", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.hitAndRun)))
                self.addDatatoGetsData("cargoBodyTypes", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.cargoBodyTypes)))
                self.addDatatoGetsData("hazMatReleased", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.hazMatReleased)))
                dataDownloaded[calls-1]=true
            }else{
                print("Recalling same methods attempted")
            }
            break
            
            
        default:
            print("Invalid Initiate case Number, pick from 1 to 8")
        }
    }
    
    //Check if already initiated
    func checkInitiation(calls:Int)->Bool{
        return  dataDownloaded[calls]
    }
    
    //Add array to the Dictionary
    private func addDatatoGetsData(key: String, item : Array<Dictionary<String,AnyObject>>){
        GetsData[key] = item
    }
    
    //GET
    static func get(url : String)-> Dictionary<String, AnyObject> {
        
        var session = NSURLSession.sharedSession()
        
        
        var collectedData : Dictionary <String,AnyObject> = ["somethingBad": true]
        var requestCompleted = false
        
        // create url and request
        let urlReal = NSURL(string: url)
        let request = NSURLRequest(URL: urlReal!)
        
        // create network request
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            // if an error occurs
            func displayError(error: String) {
                print(error)
                print("URL at time of error: \(url)")
                requestCompleted = true
            }
            
            // GUARD: Was there an error?
            guard (error == nil) else {
                displayError("There was an error with your request: \(error)")
                return
            }
            
            // Did we get a successful 2XX response?
            let statusCode = (response as? NSHTTPURLResponse)?.statusCode
            guard (statusCode >= 200 && statusCode <= 299 ) else {
                displayError("Your request returned a status code other than 2xx: -> \(statusCode) \n\(error)")
                return
            }
            
            // GUARD: Was there any data returned?
            guard let data = data else {
                displayError("No data was returned by the request!")
                return
            }
            
            // parse the data
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                collectedData = parsedResult as! Dictionary<String, AnyObject>
            } catch {
                displayError("Could not parse the data as JSON: '\(data)'")
                return
            }
            requestCompleted = true
        }
        task.resume()
        
        print("\t\tGetting Data: \"\(url)\"")
        print("\t\t...")
        while !requestCompleted{
            //Waiting for get method to finish
        }
        print("\t\tCompleted")
        
        return collectedData
    }
    
    //POST
    static func post(url: String, parameters: [String:AnyObject]) -> Dictionary<String,AnyObject> {
        
        let session = NSURLSession.sharedSession()
        
        var completed = false
        var results: [String:AnyObject] = [
            "somethingBad" : true,
            ]
        
        let urlReal = NSURL(string: url)
        print(urlReal)
        
        // Build the URL, Configure the request
        let request = NSMutableURLRequest(URL: urlReal!)
        
        let jsonTodo: NSData
        do {
            jsonTodo = try NSJSONSerialization.dataWithJSONObject(parameters, options: [])
            request.HTTPBody = jsonTodo
        } catch {
            print("Error: cannot create JSON from todo")
        }
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        // Make the request
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print("There was an error with your request: \(error)")
                return
            }
            
            let statusCode = (response as? NSHTTPURLResponse)?.statusCode
            /* GUARD: Did we get a successful 2XX response? */
            guard (statusCode >= 200 && statusCode <= 299 ) else {
                print("Your request returned a status code other than 2xx: -> \(statusCode)")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }
            
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            } catch {
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            results = parsedResult as! Dictionary<String,AnyObject>
            completed = true
            
        }
        task.resume()
        
        print("Sending Data...")
        while !completed {
            //Waiting...
        }
        print("Complete")
        
        return results
    }
    
    //Modify url for POST
    private func escapedParameters(parameters: [String:AnyObject]) -> String {
        
        if parameters.isEmpty {
            return ""
        } else {
            var keyValuePairs = [String]()
            
            for (key, value) in parameters {
                
                // make sure that it is a string value
                let stringValue = "\(value)"
                
                // escape it
                let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
                
                // append it
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
                
            }
            return "?\(keyValuePairs.joinWithSeparator("&"))"
        }
    }
    
    
    /*
     //Converts the Data from Json Object
     static func filterJson(dic : Dictionary<String, AnyObject>, word : String)->Array<Dictionary<String,AnyObject>>{
     
     var arreglo : Array<Dictionary<String,AnyObject>> = [["empty":"", "empty2": ""],["empty":"", "empty2": ""]]
     
     //Swift doesn't let me create empty arrays.
     arreglo.removeAll()
     
     //Get the payload array of dictionaries("payload" is the key for the data in Json)
     for (key,items) in dic{
     if (key == "payload"){
     arreglo = items as! Array<Dictionary<String, AnyObject>>
     }
     }
     
     return arreglo
     }*/
    
    //Converts JSON data to usable data
    static func getsArrayOfDictionaries(dic : Dictionary<String, AnyObject>)->Array<Dictionary<String,AnyObject>>{
        
        var arreglo : Array<Dictionary<String,AnyObject>> = [["empty":true, "empty2": true],["empty":true, "empty2": true]]
        
        //Swift doesn't let me create empty arrays.
        arreglo.removeAll()
        
        //Get the payload array of dictionaries("payload" is the key for the data in Json)
        for (key,items) in dic{
            if (key == "payload"){
                arreglo = items as! Array<Dictionary<String, AnyObject>>
            }
        }
        
        return arreglo
    }
    
    //This is what you call to get data from Dictionary
    func arrayOfDictionaries(key:String)->Array<Dictionary<String,AnyObject>>{
        
        if(GetsData[key]==nil){
            print("Key does not exist")
            return [["error": "key \"\(key)\" does not exist"]]
            
        }else{
            return GetsData[key]!
        }
        
    }
    
    
    //Send group of POST's ********
    func sendPOSTs(calls:Int){
        switch calls{
        case 1:     //Informacion Basica Del Accidente
            if(readyToPOST(calls)){
                WebService.post("\(url)\(WebService.Methods.CrashBasicInformation)", parameters: PostData)
            }else{
                print("\t\tCouldn't POST data.")
            }
            break
            
        case 2:     //Condiciones Del Accidente
            if(readyToPOST(calls)){
                WebService.post("\(url)\(WebService.Methods.CrashConditions)", parameters: PostData)
            }else{
                print("\t\tCouldn't POST data.")
            }
            break
            
        case 3:     //Narrativa
            if(readyToPOST(calls)){
                WebService.post("\(url)\(WebService.Methods.Narrativa)", parameters: PostData)
            }else{
                print("\t\tCouldn't POST data, parameters misssing")
            }
            break
            
        case 4:     // NewVehicle
            if(readyToPOST(calls)){
                WebService.post("\(url)\(WebService.Methods.NewVehicle)", parameters: PostData)
            }else{
                print("\t\tCouldn't POST data, parameters misssing")
            }
            break
            
        case 5:     // NewPerson
            if(readyToPOST(calls)){
                WebService.post("\(url)\(WebService.Methods.NewPerson)", parameters: PostData)
            }else{
                print("\t\tCouldn't POST data, parameters misssing")
            }
            break
            
        case 6:     // Vehicle Extended
            if(readyToPOST(calls)){
                WebService.post("\(url)\(WebService.Methods.InformationEventVehicle)", parameters: PostData)
                // WebService.post("\(url)\(WebService.Methods.InformationRoadVehiclePassing)", parameters: PostData)
                WebService.post("\(url)\(WebService.Methods.TCDTypeSelection)", parameters: PostData)
                //WebService.post("\(url)\(WebService.Methods.CommercialVehicleHazardousMaterial)", parameters: PostData)
                WebService.post("\(url)\(WebService.Methods.AffectAreaSelection)", parameters: PostData)
                //Vehicle INFORMATION *******ADD*******
            }else{
                print("\t\tCouldn't POST data, parameters misssing")
            }
            break
            
        case 7:     // Person Extended
            if(readyToPOST(calls)){
                WebService.post("\(url)\(WebService.Methods.InformationVehicleOccupant)", parameters: PostData)
                // WebService.post("\(url)\(WebService.Methods.safetyEquipmentSelection)", parameters: PostData)
                WebService.post("\(url)\(WebService.Methods.InformationAllPerson)", parameters: PostData)
                WebService.post("\(url)\(WebService.Methods.LawInfraction)", parameters: PostData)
            }else{
                print("\t\tCouldn't POST data, parameters misssing")
            }
            break
            
        default:
            print("Invalid number, most be from 1 to 3")
        }
    }
    
    //Check if you can send  ***********
    func readyToPOST(calls:Int)->Bool{
        switch calls{
        case 1:     //Informaciond Basica Del Accidente
            if(!(((PostData["CrashType"]?.isEmpty)==nil)
                || ((PostData["UnitPedestrians"]?.isEmpty)==nil)
                || ((PostData["CityDescriptionES"]?.isEmpty)==nil)
                || ((PostData["CaseNumber"]?.isEmpty)==nil)
                || ((PostData["UnitInjured"]?.isEmpty)==nil)
                || ((PostData["CountryDescriptionES"]?.isEmpty)==nil)
                || ((PostData["CrashDate"]?.isEmpty)==nil)
                || ((PostData["UnitFatalaties"]?.isEmpty)==nil)
                || ((PostData["NearToDescriptionEs"]?.isEmpty)==nil)
                || ((PostData["Hour"]?.isEmpty)==nil)
                || ((PostData["Longitude"]?.isEmpty)==nil)
                || ((PostData["Name"]?.isEmpty)==nil)
                || ((PostData["UnitVehiculos"]?.isEmpty)==nil)
                || ((PostData["Latitude"]?.isEmpty)==nil)
                || ((PostData["Distance"]?.isEmpty)==nil)
                || ((PostData["UnitAutomovilistas"]?.isEmpty)==nil)
                || ((PostData["Address"]?.isEmpty)==nil)
                || ((PostData["MeasurementDescriptionES"]?.isEmpty)==nil)
                || ((PostData["DirectionDescriptionES"]?.isEmpty)==nil)
                || ((PostData["PropertyDescriptionES"]?.isEmpty)==nil)
                || ((PostData["LocationDescriptionES"]?.isEmpty)==nil)
                || ((PostData["ZoneTypeDescriptionES"]?.isEmpty)==nil))){
                return true
            }else{
                return false
            }
            
        case 2:     //Condiciones Del Accidente
            if(!(((PostData["CollisionTypeDescriptionES"]?.isEmpty)==nil)
                || ((PostData["EventDescriptionES"]?.isEmpty)==nil)
                || ((PostData["EventLocationDescriptionES"]?.isEmpty)==nil)
                || ((PostData["MannerofColisionDescriptionES"]?.isEmpty)==nil)
                || ((PostData["WeatherConditionUno"]?.isEmpty)==nil)
                || ((PostData["WeatherConditionDos"]?.isEmpty)==nil)
                || ((PostData["VisibilityCondition"]?.isEmpty)==nil)
                || ((PostData["PavementCondition"]?.isEmpty)==nil)
                || ((PostData["Environmental"]?.isEmpty)==nil)
                || ((PostData["RoadDescription"]?.isEmpty)==nil)
                || ((PostData["WithinInterchange"]?.isEmpty)==nil)
                || ((PostData["SpecifLocation"]?.isEmpty)==nil)
                || ((PostData["InserctionType"]?.isEmpty)==nil)
                || ((PostData["SchoolBusRelated"]?.isEmpty)==nil)
                || ((PostData["NearConstruction"]?.isEmpty)==nil)
                || ((PostData["CrashLocation"]?.isEmpty)==nil)
                || ((PostData["WorkerZoneType"]?.isEmpty)==nil)
                || ((PostData["WorkerPresent"]?.isEmpty)==nil)
                || ((PostData["PolicePresent"]?.isEmpty)==nil))){
                return true
            }else{
                return false
            }
            
        case 3:     //Narrativa
            if(!((PostData["NotifiedTimePolice"]?.isEmpty)==nil
                || (PostData["TimeOfArrivalPolice"]?.isEmpty)==nil
                || (PostData["NotifiedTimeEmergencie"]?.isEmpty)==nil
                || (PostData["TimeOfArrivalEmergencie"]?.isEmpty)==nil
                || (PostData["Details"]?.isEmpty)==nil)){
                return true
            }else{
                return false
            }
            
        case 4:     //New Vehicle
            if(!((PostData["VehicleType"]?.isEmpty)==nil
                || (PostData["Occupants"]?.isEmpty)==nil
                || (PostData["PlateNumber"]?.isEmpty)==nil
                || (PostData["VehicleJurisdiction"]?.isEmpty)==nil
                || (PostData["State"]?.isEmpty)==nil
                || (PostData["Vin"]?.isEmpty)==nil
                || (PostData["Year"]?.isEmpty)==nil
                || (PostData["Make"]?.isEmpty)==nil
                || (PostData["modelos"]?.isEmpty)==nil
                || (PostData["RegistrationNumber"]?.isEmpty)==nil
                || (PostData["InsuranceCompany"]?.isEmpty)==nil
                || (PostData["PurchaseDate"]?.isEmpty)==nil
                || (PostData["ExpirationDate"]?.isEmpty)==nil)){
                return true
            }else{
                return false
            }
            
        case 5:     //New Person
            if(!((PostData["PersonaCategory"]?.isEmpty)==nil
                || (PostData["PersonaType"]?.isEmpty)==nil
                || (PostData["Name"]?.isEmpty)==nil
                || (PostData["Gender"]?.isEmpty)==nil
                || (PostData["LicenseType"]?.isEmpty)==nil
                || (PostData["LicenceNumber"]?.isEmpty)==nil
                || (PostData["OrganDonor"]?.isEmpty)==nil
                || (PostData["ExpirationDate"]?.isEmpty)==nil
                || (PostData["Neighborhood"]?.isEmpty)==nil
                || (PostData["StreetName"]?.isEmpty)==nil
                || (PostData["City"]?.isEmpty)==nil
                || (PostData["StateCountry"]?.isEmpty)==nil
                || (PostData["ZipCode"]?.isEmpty)==nil
                || (PostData["PhoneNumber"]?.isEmpty)==nil
                || (PostData["TransportedByMedicalEmergencies"]?.isEmpty)==nil
                || (PostData["TransportedTo"]?.isEmpty)==nil
                || (PostData["TransportedBy"]?.isEmpty)==nil
                || (PostData["MedicalEmergenciesNumber"]?.isEmpty)==nil
                || (PostData["AmbulanceCSPNumber"]?.isEmpty)==nil
                || (PostData["idNewVehicle"]?.isEmpty)==nil)){
                return true
            }else{
                return false
            }
            
            
        default:
            print("Invalid number for readyToPOST(), use a number from 1 to 3")
            return false
        }
    }
    
    //Add item to POST DICTIONARY
    func addIData(key:String, value:String!){
        PostData[key]=value
    }
    
    
}
