//
//  Constants.swift
//  transinfoFinal
//
//  Created by Pedro Santiago on 11/1/16.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import Foundation
extension WebService {
    
    
    
    
    struct Constants {
        
        // URLs
        static let ApiScheme = "http://"
        static let ApiHost = "localhost:9000"
        //static let ApiHost = "136.145.116.83:8080"
        //this one static let ApiHost = "136.145.59.111:9000"
    }
    
    struct Methods {
        
        // **GETs**
        
        // Collections
        static let cities = "/cities"
        static let counties = "/counties"
        static let directions = "/directions"
        static let locations = "/locations"
        static let measurements = "/measurements"
        static let nearTo = "/nearTo"
        static let properties = "/properties"
        static let zoneTypes = "/zoneTypes"
        static let reportTypes = "/reportTypes"
        static let harmfulEvents = "/harmfulEvents"
        static let harmfulEventsCatefories = "/harmfulEventCategories"
        static let relativeToTrafficways = "/relativeToTrafficways"
        static let mannerOfCollisions = "/mannerOfCollisions"
        static let weatherConditions = "/weatherConditions"
        static let lightingConditions = "/lightingConditions"
        static let roadSurfaces = "/roadSurfaces"
        static let environmentConditions = "/environmentConditions"
        static let roadCircumstances = "/roadCircumstances"
        static let withinInterchanges = "/withinInterchanges"
        static let junctions = "/junctions"
        static let intersectionTypes = "/intersectionTypes"
        static let schoolBusRelated = "/schoolBusRelated"
        static let workzoneRelated = "/workzoneRelated"
        static let workzoneLocations = "/workzoneLocations"
        static let workzoneTypes = "/workzoneTypes"
        static let workersPresent = "/workersPresent"
        static let lawEnforcementPresent = "/lawEnforcementPresent" //este esta repetido******
        static let personTypeCategories = "/personTypeCategories"
        static let personTypes = "/personTypes"
        static let driverLicenseTypes = "/driverLicenseTypes"
        static let genders = "/genders"
        static let organDonor = "/organDonor"
        static let vehicles = "/vehicles"
        static let vehicleType = "/vehicleTypes"
        static let vehicleJurisdictions = "/vehicleJurisdictions"
        static let ListVehicleByPlateNumber = "/ListVehicleByPlateNumber"
        static let ListPersonByLicencieNumber = "/ListPersonByLicencieNumber"
        static let ListReport = "/ListReport"
        // Vehicle Tab
        static let bodyTypes = "/bodyTypes"
        static let specialFunctions = "/specialFunctions"
        static let emergencyUses = "/emergencyUses"
        static let postedSpeeds = "/postedSpeeds"
        static let directionsOfTravel = "/directionsOfTravel"
        static let trafficWayDescription = "/trafficwayDescriptions"
        static let totalLanesCategories = "/totalLanesCategories"
        static let totalLanes = "/totalLanes"
        static let roadwayHorizontalAlignments = "/roadwayHorizontalAlignments"
        static let roadwayGrades = "/roadwayGrades"
        static let TCDWorking = "/TCDWorking"
        static let TCDTypes = "/TCDTypes"
        static let actions = "/actions"
        static let initialContactPoints = "/initialContactPoints"
        static let damagedAreas = "/damagedAreas"
        static let extentOfDamages = "/extentOfDamages"
        static let hitAndRun = "/hitAndRun"
        static let towedBy = "/towedBy"
        static let vehicleCircumstances = "/vehicleCircumstances"
        static let motorCarrierTypes = "/motorCarrierTypes"
        static let vehicleMovements = "/vehicleMovements"
        static let driverIsAuthorized = "/driverIsAuthorized"
        static let inspectionUpToDate = "/inspectionUpToDate"
        static let specialPermits = "/specialPermits"
        static let GVWRGCWR = "/GVWRGCWR"
        static let configurations = "/configurations"
        static let cargoBodyTypes = "/cargoBodyTypes"
        static let hazMatInvolved = "/hazMatInvolved"
        static let placardDisplayed = "/placardDisplayed"
        static let hazMatReleased = "/hazMatReleased"
        // Person Tab
        static let rows = "/rows"
        static let seats = "/seats"
        static let seatingOthers = "/seatingOthers"
        static let restraintSystems = "/restraintSystems"
        static let helmetUses = "/helmetUses"
        static let airbagDeployed = "/airbagDeployed"
        static let ejections = "/ejections"
        static let extrications = "/extrications"
        static let speedingSuspected = "/speedingSuspected"
        static let contribActionsCircumstances = "/contribActionsCircumstances"
        static let distractedBy = "/distractedBy"
        static let conditions = "/conditions"
        static let actionsPriorToCrash = "/actionsPriorToCrash"
        static let toFromSchool = "/toFromSchool"
        static let actionsAtTimeOfCrash = "/actionsAtTimeOfCrash"
        static let nonMotoristLocations = "/nonMotoristLocations"
        static let safetyEquipments = "/safetyEquipments"
        static let substancesSuspected = "/substancesSuspected"
        static let testStatuses = "/testStatuses"
        static let alcoholTestTypes = "/alcoholTestTypes"
        static let alcoholTestResults = "/alcoholTestResults"
        static let drugTestTypes = "/drugTestTypes"
        static let drugTestResults = "/drugTestResults"
        static let transportedBy = "/transportedBy"
        
        
        // **POSTs
        static let person = "/person"
        static let ActionTimeSelection = "/ActionTimeSelection"
        static let ActionS = "/ActionS"
        static let AffectAreaSelection = "/AffectAreaSelection"
        static let CommercialVehicleHazardousMaterial = "/CommercialVehicleHazardousMaterial"
        static let ContribActionsCircumstanceS = "/ContribActionsCircumstanceS"
        static let DriverCirncunstanceSelection = "/DriverCirncunstanceSelection"
        static let safetyEquipmentSelection = "/safetyEquipmentSelection"
        static let TCDTypeSelection = "/TCDTypeSelection"
        static let LawInfraction = "/LawInfraction"
        static let NewVehicle = "/NewVehicle"
        static let NewPerson = "/NewPerson"
        static let Narrativa = "/Narrativa"
        static let InformationVehicleOccupant = "/InformationVehicleOccupant"
        static let InformationRoadVehiclePassing = "/InformationRoadVehiclePassing"
        static let InformationPCV = "/InformationPCV"
        static let InformationEventVehicle = "/InformationEventVehicle"
        static let InformationAllPerson = "/InformationAllPerson"
        static let CrashConditions = "/CrashConditions"
        static let CrashBasicInformation = "/CrashBasicInformation"
        static let VehicleInformation = "/VehicleInformation"
        static let AccidentCondition = "/AccidentCondition"
        
        static let PersonExtendInformation = "/PersonExtendInformation"
        static let VehicleExtend = "/VehicleExtend"
        static let PersonAccident = "/PersonAccident"
        static let VehicleAccident = "/VehicleAccident"
        static let AccidentNarrativa = "/AccidentNarrativa"
        static let listVehicleOfPerson = "/listVehicleOfPerson"
        
        // **Login
        static let login = "/login"
        
    }
    
}
