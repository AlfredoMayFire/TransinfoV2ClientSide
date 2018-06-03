//
//  ViewController.swift
//  transinfoFinal
//
//  Created by Jessica Cotrina Revilla on 7/26/16.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var loginButton: UITextField!
    @IBOutlet weak var pass: UITextField!
    var myAO: AnyObject?
    var officerID = Dictionary<String,AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject) {
        print ("------------")
        
        print ("------outtt------")
        
        //let url = "http://localhost:9000/login"
        //let url = "http://136.145.116.83:8080/login"
        let url  = "http://136.145.59.111:9000/login"
                var loginPostResults = WebService.post(url, parameters: ["username":userTextField.text!,"password":passwordTextField.text!] )
        //print("Here's this Thing",loginPostResults["payload"])
        //print(loginPostResults["error_code"])
        //...................................
        
        
        //print("Aqui estoy",loginPostResults.popFirst())
        //myAO = loginPostResults.first!.1
        //myAO = loginPostResults["payload"]
        
        
        myAO = loginPostResults["payload"]
         let error = loginPostResults["error_code"]
        
        if error?.integerValue != 403 && error?.integerValue != 0 {

            officerID = (myAO as? Dictionary<String,AnyObject>)!
            //officerID = (myAO?.firstItem)! as! Dictionary<String, AnyObject>
            print("Here's the OfficerID",officerID["OfficerID"])
            let singleton = Global.sharedGlobal
            singleton.foreignKeys.removeAll()
            singleton.listPeople.removeAll()
            singleton.listVehicle.removeAll()
            singleton.listNum = [0,0]
            singleton.selectedKey = 0
            singleton.testString = ""
            
            
            let accidentConditionFK = Info(officerPlate: (officerID["PlateNumber"]!.stringValue), officerID: (officerID["OfficerID"] as? Int)!,crashBasicInformation: 0, accidentCondition: 0, newVehicle:0,newPerson: 0,personExtended:0,vehicleExtended:0,narrative:0,numCaso:"",latitude:"",longitude:"")
            singleton.foreignKeys.append(accidentConditionFK)
            
            let listPeopleInit = People(person: ["":""])
            singleton.listPeople.append(listPeopleInit)
            
            let listReportInit = Report(firstTab: ["":""],secondTab:["":""],thirdTab:["":""],personTab:["":""],personExtenTab:["":""],vehicleTab:["":""],vehicleExtendTab:["":""],sawReport: false,sawReportOnce: false)
            singleton.firstTabInfo.append(listReportInit)
            
            print(singleton.foreignKeys)
            print(singleton.listPeople)
            
        }else{
            let alert = UIAlertController(title: "Alert", message: "Username or password invalid", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
        
            
            
        }

    
}

