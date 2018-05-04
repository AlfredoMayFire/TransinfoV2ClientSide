//
//  ReportsListController.swift
//  
//
//  Created by Pedro Santiago on 3/5/17.
//
//

import Foundation
import UIKit


class ReportController: UIViewController{
    let singleton = Global.sharedGlobal
    
    
    @IBOutlet weak var reportText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let WebServicesQuery = WebService.init()
        let caseNumber = singleton.foreignKeys[0].crashBasicInformation
        let accidentFK = singleton.foreignKeys[0].accidentCondition
        singleton.foreignKeys[0].crashBasicInformation = 0
        singleton.foreignKeys[0].accidentCondition = 0
        
        let firstTab = WebServicesQuery.letsReport(String(caseNumber))
        let secondTab = WebServicesQuery.secondTab(String(accidentFK))
        let newPerson = WebServicesQuery.personTab(String(accidentFK))
        let newVehicle = WebServicesQuery.vehicleTab(String(accidentFK))
        let narrative = WebServicesQuery.narrativeTab(String(accidentFK))
        print(firstTab)
        print(secondTab)
        print(newPerson)
        print(newVehicle)
        print(narrative)
        reportText.insertText(String(firstTab.first))
        reportText.insertText(String(secondTab.first))
        reportText.insertText(String(newPerson.first))
        reportText.insertText(String(newVehicle.first))
        reportText.insertText(String(narrative.first))
     
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}