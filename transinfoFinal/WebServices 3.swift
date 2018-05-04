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
    var Data : Dictionary<String, String> = ["empty":"empty"]                                                                       //THE DATA DICTIONARY
    
    var PostData : Dictionary<String, String> = ["empty":"empty"]                                                                   //THE POST DICTIONARY
    
    var emptyArray: Array<Dictionary<String, AnyObject>> = [["AccidenteFK":"0", "CrashConditionFK":"0"]]
    
//
//    var resultMessage: AnyObject?
//    var myArray = Array<AnyObject> ()
    
    private let url = Constants.ApiScheme + Constants.ApiHost                                                                       //URL
    private var dataDownloaded : Array<Bool> = [false,false,false,false,false,false]       //Variable for AlreadyDownloaded()
    private var dataSended : Array<Bool> = [false, false, false]                     //Variable for cheking If data was sended
    
    override init(){
        GetsData.removeAll()
        Data.removeAll()
        PostData.removeAll()
    }
    
    
    func printQuery(numDeTablilla: String ) -> Dictionary<String,AnyObject>{
        return WebService.get(url + Methods.ListVehicleByPlateNumber + "/" + numDeTablilla)
    }
    func printQueryPerson(numDeLicencia: String ) -> Dictionary<String,AnyObject>{
        return WebService.get(url + Methods.ListPersonByLicencieNumber + "/" + numDeLicencia)
    }
    func getListofVehiclesPerson(numDeLicencia: String) -> Dictionary<String,AnyObject>{
        return WebService.get(url + Methods.listVehicleOfPerson + "/" + numDeLicencia)
    }
    func getListOfReports(date: String) -> Dictionary<String,AnyObject>{
        return WebService.get(url + Methods.ListReport + "/" + date)
    }
    func letsReport(numCaso:String) -> Dictionary<String,AnyObject>{
        return WebService.get(url + Methods.ListAccidentByCaseNumber + "/" + numCaso)
    }
    func secondTab(numIdCrashBasicInformation:String) -> Dictionary<String,AnyObject>{ return WebService.get(url + "/CrashConditionsByIdAccident/"+numIdCrashBasicInformation)
    }
    func personTab(numIdCrashBasicInformation:String) -> Dictionary<String,AnyObject>{ return WebService.get(url + "/NewPersonByIdAccident/"+numIdCrashBasicInformation)
    }
    func vehicleTab(numIdCrashBasicInformation:String) -> Dictionary<String,AnyObject>{ return WebService.get(url + "/NewVehicleByIdAccident/"+numIdCrashBasicInformation)
    }
    func narrativeTab(numIdCrashBasicInformation:String) -> Dictionary<String,AnyObject>{ return WebService.get(url + "/NarrativeByIdAccident/"+numIdCrashBasicInformation)
    }
    func vehicleExtendedTab(idVehicleFK:String) -> Dictionary<String,AnyObject>{ return WebService.get(url + "/ListVehicleExtend/"+idVehicleFK)
    }
    func personExtendedTab(idPersonFK:String) -> Dictionary<String,AnyObject>{ return WebService.get(url + "/ListPersonExtend/"+idPersonFK)
    }

    
    
    
    //******************************************* GETS Dictionary Functions **************************************************
    
    /**
     Calls the group of GET's and saves it on "GetsData" Dictionary.
     - parameters int: Int from 1 to 6.
     */
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
                //self.addDatatoGetsData("ListVehicleByPlateNumber", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.ListVehicleByPlateNumber + "/7")))
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
                self.addDatatoGetsData("mannerOfCollisions", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.mannerOfCollisions)))
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
                self.addDatatoGetsData("relativeToTrafficways", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.relativeToTrafficways)))
                
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
                self.addDatatoGetsData("ListVehicleByPlateNumber", item: WebService.getsArrayOfDictionaries(WebService.get(url + Methods.ListVehicleByPlateNumber)))
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
//        case 7:
//            if(!checkInitiation(calls-1)){
//                self.addDatatoGetsData("AccidenteFK", item: emptyArray)
//            }
            
        default:
            print("Invalid case: /(calls)")
        }
    }
    
    /**
    Check if group of GET's was initiated
     */
    func checkInitiation(calls:Int)->Bool{
        return  dataDownloaded[calls]
    }
    
    /**
     Add array to the Gets Dictionary
     */
    private func addDatatoGetsData(key: String, item : Array<Dictionary<String,AnyObject>>){
        GetsData[key] = item
    }
    
    
    
    //******************************************* Standar GET & POST Functions **********************************************
    
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
        
        print(parameters)
        let session = NSURLSession.sharedSession()
       //aniadir variable
        var has_error = false
        
        var statusCode = 0
        
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
                has_error = true
                return
            }
            
            statusCode = ((response as? NSHTTPURLResponse)?.statusCode)!
            
            /* GUARD: Did we get a successful 2XX response? */
            guard (statusCode >= 200 && statusCode <= 299 ) else {
                print("Your request returned a status code other than 2xx: -> \(statusCode)")
                has_error = true
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No data was returned by the request!")
                has_error = true
                return
            }
            
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            } catch {
                print("Could not parse the data as JSON: '\(data)'")
                has_error = true
                return
            }
            results = parsedResult as! Dictionary<String,AnyObject>
            completed = true
            
        }
        task.resume()
        print(has_error)
        print("Sending Data...")
        while (!completed && !has_error) {
            //Waiting...
//            print("comprueba")
        }
        if (has_error){
            results["error_code"] = statusCode
        }
        results["error_code"] = statusCode
        print("Complete")
        print(results)
        return results
    }
    
    
    
    //******************************************** Tools Functions *********************************************************
    
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
    
    /**
     Returns array of dictionaries from the downloaded GET's.
     */
    func arrayOfDictionaries(key:String)->Array<Dictionary<String,AnyObject>>{
        
        if(GetsData[key]==nil){
            print("Key \(key) does not exist")
            return [["error": "key \"\(key)\" does not exist"]]
            
        }else{
            return GetsData[key]!
        }
        
    }
    
    /**
     Clear the POST Dictionary.
     */
    func clearPostData(){
        PostData.removeAll()
    }
    
    
    
    //******************************************** POST Functions ***********************************************************
    
    /**
    Send group of POST's.
    */
    func sendPOSTs(calls:Int) -> Dictionary<String,AnyObject> {
        
        var response = Dictionary<String,AnyObject>()
        let error: [String:AnyObject] = ["error":"parameters missing"]
        
        switch calls{
        case 1:     //Informacion Basica Del Accidente
            if(readyToPOST(calls)){
                response = WebService.post("\(url)\(WebService.Methods.CrashBasicInformation)", parameters:PostData)
            }else{
                print("\t\tCouldn't POST data, parameters misssing.")
                response = error
            }
            break
            
        case 2:     //Condiciones Del Accidente
            if(readyToPOST(calls)){
               // WebService.post("\(url)\(WebService.Methods.CrashConditions)", parameters: PostData)
//                print(PostData)
//                print("HERE")
                response = WebService.post("\(url)\(WebService.Methods.CrashConditions)", parameters:PostData)
                print("Here's PostData:",PostData)
            }else{
                print("\t\tCouldn't POST data, parameters misssing.")
                response = error
            }

            break
            
        case 3:     //Narrativa
            if(readyToPOST(calls)){
                WebService.post("\(url)\(WebService.Methods.Narrativa)", parameters: PostData)
            }else{
                print("\t\tCouldn't POST data, parameters misssing")
            }
            break
            
        case 4:     // NewVehicle (Multiple)
            if(readyToPOST(calls)){
                 response = WebService.post("\(url)\(WebService.Methods.NewVehicle)", parameters: PostData)
            }else{
                response = error
                print("\t\tCouldn't POST data, parameters misssing")
            }
            break
            
        case 5:     // NewPerson  (Multiple)
            if(readyToPOST(calls)){
                print("Here's PostData:",PostData)
                response = WebService.post("\(url)\(WebService.Methods.NewPerson)", parameters: PostData)
            }else{
                response = error
                print("\t\tCouldn't POST data, parameters misssing")
            }
            break
            
        case 6:     // Vehicle Extended (Multiple)
            if(readyToPOST(calls)){
                response = WebService.post("\(url)\(WebService.Methods.VehicleExtend)", parameters: PostData)
              
                //Vehicle INFORMATION *******ADD*******
            }else{
                print("\t\tCouldn't POST data, parameters misssing")
                response = error
            }
            break
            
        case 7:     // Person Extended (Multiple)
            if(readyToPOST(calls)){
                 response = WebService.post("\(url)\(WebService.Methods.PersonExtendInformation)", parameters: PostData)
//                WebService.post("\(url)\(WebService.Methods.InformationVehicleOccupant)", parameters: PostData)
//                WebService.post("\(url)\(WebService.Methods.safetyEquipmentSelection)", parameters: PostData)
//                WebService.post("\(url)\(WebService.Methods.InformationAllPerson)", parameters: PostData)
                //WebService.post("\(url)\(WebService.Methods.LawInfraction)", parameters: PostData)
            }else{
                print("\t\tCouldn't POST data, parameters misssing")
                response = error
            }
            break
            
        case 8:     // Login
            if(readyToPOST(calls)){
               WebService.post("\(url)\(WebService.Methods.login)", parameters: PostData)
            }else{
                print("\t\tCouldn't POST data, parameters misssing")
            }
            break
        case 9:     // Table assign
            if(readyToPOST(calls)){
                
                response = WebService.post("\(url)\(WebService.Methods.AccidentCondition)", parameters: PostData)

            }else{
                print("\t\tCouldn't POST data, parameters misssing")
                response = error
            }
            break
        case 10:     // person accident
            if(readyToPOST(calls)){
                
                response = WebService.post("\(url)\(WebService.Methods.PersonAccident)", parameters: PostData)
                
            }else{
                print("\t\tCouldn't POST data, parameters misssing")
                response = error
            }
            break
        case 11:     // vehicle accident
            if(readyToPOST(calls)){
                
                response = WebService.post("\(url)\(WebService.Methods.VehicleAccident)", parameters: PostData)
                
            }else{
                print("\t\tCouldn't POST data, parameters misssing")
                response = error
            }
            break
        case 12:     //accident narrativa
            if(readyToPOST(calls)){
                
                response = WebService.post("\(url)\(WebService.Methods.AccidentNarrativa)", parameters: PostData)
                
            }else{
                print("\t\tCouldn't POST data, parameters misssing")
                response = error
            }
            break
        case 13:     // narrativa
            if(readyToPOST(calls)){
                
                response = WebService.post("\(url)\(WebService.Methods.Narrativa)", parameters: PostData)
                
            }else{
                print("\t\tCouldn't POST data, parameters misssing")
                response = error
            }
            break




        default:
            print("Invalid number, most be from 1 to 7")
        }
        return response
    }
    
    /*
     Check if you can send the group of POST.
     */
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
            if(!(
                //|| (PostData["Occupants"]?.isEmpty)==nil
                 (PostData["PlateNumber"]?.isEmpty)==nil
                || (PostData["VehicleJurisdiction"]?.isEmpty)==nil
                || (PostData["State"]?.isEmpty)==nil
                || (PostData["Vin"]?.isEmpty)==nil
                || (PostData["Year"]?.isEmpty)==nil
                || (PostData["Make"]?.isEmpty)==nil
                || (PostData["modelos"]?.isEmpty)==nil
                || (PostData["RegistrationNumber"]?.isEmpty)==nil
                || (PostData["InsuranceCompany"]?.isEmpty)==nil
                || (PostData["PurchaseDate"]?.isEmpty)==nil
                || (PostData["idPersonaFK"]?.isEmpty)==nil
                || (PostData["ExpirationDate"]?.isEmpty)==nil)){
                return true
            }else{
                return false
            }
            
        case 5:     //New Person
            if(!((PostData["Name"]?.isEmpty)==nil
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
                || (PostData["PhoneNumber"]?.isEmpty)==nil)){
                return true
            }else{
                return false
            }
            //
        case 6:     //Vehicle Extend Multiple -InformationEventVehicle
            if(!((PostData["PrimeraCategoriaEvent"]?.isEmpty)==nil
                || (PostData["SegundaCategoriaEvent"]?.isEmpty)==nil
                || (PostData["TerceraCategoriaEvent"]?.isEmpty)==nil
                || (PostData["CuartaCategoria"]?.isEmpty)==nil
                || (PostData["PrimerEvent"]?.isEmpty)==nil
                || (PostData["SegundoEvent"]?.isEmpty)==nil
                || (PostData["TecerEvent"]?.isEmpty)==nil
                || (PostData["CuartoEvent"]?.isEmpty)==nil
                || (PostData["BusUse"]?.isEmpty)==nil
                || (PostData["LefthPlace"]?.isEmpty)==nil
                || (PostData["TowedDamage"]?.isEmpty)==nil
                || (PostData["PrimerDefectoMecánico"]?.isEmpty)==nil
                || (PostData["SegundoDefectoMecánico"]?.isEmpty)==nil
                //|| (PostData["VehicleFK"]?.isEmpty)==nil
                //InformationRoadVehiclePassing
                || (PostData["MPH"]?.isEmpty)==nil
                || (PostData["MotorEmergencyVU"]?.isEmpty)==nil
                || (PostData["VehicleType"]?.isEmpty)==nil
                || (PostData["FunctionSpecialMVT"]?.isEmpty)==nil
                || (PostData["VehicleMotor"]?.isEmpty)==nil
                || (PostData["DirectionTripCB"]?.isEmpty)==nil
                || (PostData["MPHDescription"]?.isEmpty)==nil
                || (PostData["Occupants"]?.isEmpty)==nil
                || (PostData["AffectedArea"]?.isEmpty)==nil
                || (PostData["DescriptionRoad"]?.isEmpty)==nil
                || (PostData["ManeuverVehicleMotor"]?.isEmpty)==nil
                || (PostData["DescriptionRoad"]?.isEmpty)==nil
                || (PostData["Alignment"]?.isEmpty)==nil
                || (PostData["Slope"]?.isEmpty)==nil
                || (PostData["LaneCantidad"]?.isEmpty)==nil
                || (PostData["LaneCategoria"]?.isEmpty)==nil
                || (PostData["LaneTipoCarril"]?.isEmpty)==nil
                || (PostData["InOperationLost"]?.isEmpty)==nil
                //|| (PostData["idNewVehicleFK"]?.isEmpty)==nil
                // TCDTypeSelection
                || (PostData["TypeControlTraffic"]?.isEmpty)==nil
                //|| (PostData["idInformationRoadVehiclePasssing"]?.isEmpty)==nil
                //|| (PostData["idNewVehicleFK"]?.isEmpty)==nil
                //CommercialVehicleHazardousMaterial
                || (PostData["InitialContactPoint"]?.isEmpty)==nil
                || (PostData["ExtendDamage"]?.isEmpty)==nil
                || (PostData["CommercialVehicleUse"]?.isEmpty)==nil
                || (PostData["VehicleMoving"]?.isEmpty)==nil
                || (PostData["AuthorizedDriver"]?.isEmpty)==nil
                || (PostData["InspectionUpdate"]?.isEmpty)==nil
                || (PostData["SpecialPermit"]?.isEmpty)==nil
                || (PostData["GrossWeight"]?.isEmpty)==nil
                || (PostData["TotalAxis"]?.isEmpty)==nil
                || (PostData["VehicleConfiguration"]?.isEmpty)==nil
                || (PostData["HeavyVehicleType"]?.isEmpty)==nil
                || (PostData["HazardousMaterial"]?.isEmpty)==nil
                || (PostData["DiamondIdNumber"]?.isEmpty)==nil
                || (PostData["VehicleFK"]?.isEmpty)==nil
                //|| (PostData["DueCollision"]?.isEmpty)==nil
                //|| (PostData["idNewVehicleFK"]?.isEmpty)==nil
                // Affect Area Selection
                 //|| (PostData["IdCommercialVehicleHazardousMaterialFK"]?.isEmpty)==nil
                 //|| (PostData["damageAreaIDFK"]?.isEmpty)==nil
                || (PostData["ThereHazardousMaterial"]?.isEmpty)==nil)){
                print("Entre al mega if")
                return true
            }else{
                return false
            }
            
        case 7:     //Information Person Extend - Keys de PersonExtendInformationModel in Webservices Java project
            if(!((PostData["PersonaFK"]?.isEmpty)==nil
                || (PostData["CategoryPerson"]?.isEmpty)==nil
                || (PostData["TypePerson"]?.isEmpty)==nil
                || (PostData["Row"]?.isEmpty)==nil
                || (PostData["Seat"]?.isEmpty)==nil
                || (PostData["OtherLocation"]?.isEmpty)==nil
                || (PostData["RestraintSystem"]?.isEmpty)==nil
                || (PostData["AirbagsActivation"]?.isEmpty)==nil
                || (PostData["Expulsion"]?.isEmpty)==nil
                || (PostData["SpeedRelated"]?.isEmpty)==nil
                || (PostData["Extraction"]?.isEmpty)==nil
                || (PostData["DriverCirncunstanceBC"]?.isEmpty)==nil
                || (PostData["DistractedDriverBy"]?.isEmpty)==nil
                || (PostData["DistractedBy"]?.isEmpty)==nil
                || (PostData["ConditionCollisionTime"]?.isEmpty)==nil
                || (PostData["SafetyEquipmentUsed"]?.isEmpty)==nil
                || (PostData["SuspectAlcoholUse"]?.isEmpty)==nil
                || (PostData["TestStatusAl"]?.isEmpty)==nil
                || (PostData["TestTypeAl"]?.isEmpty)==nil
                || (PostData["TestResultAl"]?.isEmpty)==nil
                || (PostData["TestResultTP"]?.isEmpty)==nil
                || (PostData["SuscpectControlledSubstances"]?.isEmpty)==nil
                || (PostData["TestStatusSub"]?.isEmpty)==nil
                || (PostData["TestTypeSub"]?.isEmpty)==nil
                || (PostData["TestResultSub"]?.isEmpty)==nil
                || (PostData["ActionsBeforeCollision"]?.isEmpty)==nil
                || (PostData["InWayToSchool"]?.isEmpty)==nil
                || (PostData["ActionsAtCollisionTime"]?.isEmpty)==nil
                || (PostData["LocationWhenCollision"]?.isEmpty)==nil
                || (PostData["TransportedByME"]?.isEmpty)==nil
                || (PostData["TransportedTo"]?.isEmpty)==nil
                || (PostData["TransportedBy"]?.isEmpty)==nil
                || (PostData["MedicalEmergenciesNumber"]?.isEmpty)==nil
                || (PostData["AmbulanceCSPNumber"]?.isEmpty)==nil)){
                return true
            }else{
                return false
            }
            //
            
        case 8:     //Login
            if(!((PostData["username"]?.isEmpty)==nil
                || (PostData["password"]?.isEmpty)==nil)){
                return true
            }else{
                return false
            }
        case 9:     //AccidentCondition
            if(!((PostData["AccidenteFK"]?.isEmpty)==nil
                || (PostData["CrashConditionFK"]?.isEmpty)==nil)){
                return true
            }else{
                return false
            }
        case 10:     //Person Accident
            if(!((PostData["Accident_fk"]?.isEmpty)==nil
                || (PostData["Person_fk"]?.isEmpty)==nil)){
                return true
            }else{
                return false
            }
        case 11:     //Vehicle Accident
            if(!((PostData["Accidentfk"]?.isEmpty)==nil
                || (PostData["Vehiclefk"]?.isEmpty)==nil)){
                return true
            }else{
                return false
            }
        case 12:     //Accident Narrativa
            if(!((PostData["AccidenteFK"]?.isEmpty)==nil
                || (PostData["NarrativaFK"]?.isEmpty)==nil)){
                return true
            }else{
                return false
            }
        case 13:     //Narrativa
            if(!((PostData["NotifiedTimePolice"]?.isEmpty)==nil
                || (PostData["TimeOfArrivalPolice"]?.isEmpty)==nil
                || (PostData["NotifiedTimeEmergencie"]?.isEmpty)==nil
                || (PostData["TimeOfArrivalEmergencie"]?.isEmpty)==nil
                || (PostData["Details"]?.isEmpty)==nil
                )){
                return true
            }else{
                return false
            }

            
        default:
            print("Invalid number for readyToPOST(), use a number from 1 to 5 o 8")
            return false
        }
    }
    
    /**
    Add item to POST DICTIONARY(the sending dictionary)
     */
    func addIData(key:String, value:String!){
        PostData[key]=value
    }
    
    
}
