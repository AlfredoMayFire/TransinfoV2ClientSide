//
//  ForeignKeyVars.swift
//  transinfoFinal
//
//  Created by Alfredo Pomales III on 4/30/17.
//  Copyright © 2017 Universidad de puerto rico-Mayaguez. All rights reserved.
//
//  Singleton File

import Foundation
struct Info {
    
    var officerID: Int
    var officerPlate: String
    var crashBasicInformation: Int
    var accidentCondition: Int
    var newPerson: Int
    var newVehicle: Int
    var personExtended: Int
    var vehicleExtended: Int
    var narrative: Int
    var numCaso: String
    var latitude: String
    var longitude: String
    
    
    init (officerPlate:String, officerID:Int, crashBasicInformation:Int, accidentCondition:Int,newVehicle: Int, newPerson:Int,personExtended: Int,vehicleExtended: Int,narrative: Int,numCaso: String,latitude:String,longitude:String) {
        self.officerPlate=officerPlate
        self.officerID=officerID
        self.crashBasicInformation=crashBasicInformation
        self.accidentCondition=accidentCondition
        self.newPerson=newPerson
        self.newVehicle=newVehicle
        self.personExtended=personExtended
        self.vehicleExtended=vehicleExtended
        self.narrative=narrative
        self.numCaso=numCaso
        self.latitude=latitude
        self.longitude=longitude
        
    }
}

struct People {
    var person = ["name":"","gender":"","typeLicense":"","numLicense":""]//Dictionary<String,AnyObject>()
    
    init(person: Dictionary<String,String>){
        self.person=person
    }
    
}

struct Vehicle {
    var vehicle = ["numTablilla":"","year":"","make":"","model":""]
    
    init(vehicle: Dictionary<String,String>){
        self.vehicle=vehicle
    }
}

struct Report {
    var firstTab = ["address":"","caseNumber":"","cityDescriptionES":"","countryDescriptionES":"","crashDate":"","crashType":"","directionDescriptionES":"","distance":"","hour":"","latitude":"","locationDescriptionES":"","longitude":"","measurementDescriptionES":"","name":"","nearToDescriptionEs":"","propertyDescriptionES":"","status":"","unitAutomovilistas":"","unitFatalaties":"","unitInjured":"","unitVehiculos":"","unitPedestrians":"","zoneTypeDescriptionES":""]
       var secondTab = ["":""]
    var thirdTab = ["":""]
    var personTab = ["":""]
    var personExtenTab = ["":""]
    var vehicleTab = ["":""]
    var vehicleExtendTab = ["":""]
    var sawReport = false
    
    init(firstTab: Dictionary<String,String>,secondTab: Dictionary<String,String>,thirdTab: Dictionary<String,String>,personTab: Dictionary<String,String>, personExtenTab: Dictionary<String,String>,vehicleTab: Dictionary<String,String>,vehicleExtendTab: Dictionary<String,String>,sawReport: Bool){
    self.firstTab=firstTab
    self.secondTab=secondTab
    self.thirdTab=thirdTab
    self.personTab=personTab
    self.personExtenTab=personExtenTab
    self.vehicleTab=vehicleTab
    self.vehicleExtendTab=vehicleExtendTab
    self.sawReport=false
    }
 
}

class Global {
    
    // Now Global.sharedGlobal is your singleton, no need to use nested or other classes
    static let sharedGlobal = Global()
    
    var testString: String="Test" //for debugging
    
    var listNum = [0,0] // 0 index is vehicles 1 index is people
    
    var selectedKey = 0
    
    var listVehicle:[Vehicle] = []
    
    var listPeople:[People] = []
    
    var foreignKeys:[Info] = []
    
    var firstTabInfo:[Report] = []
    
    
}

