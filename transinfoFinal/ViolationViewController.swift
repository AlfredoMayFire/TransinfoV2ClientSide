//
//  ViolationViewController.swift
//  transinfoFinal
//
//  Created by Jessica Cotrina Revilla on 7/31/16.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import UIKit
import CoreData


class ViolationViewController: UIViewController {
    
    
    @IBOutlet weak var numeroAltaField: UITextField!
    @IBOutlet weak var numeroArticuloField: UITextField!
    @IBOutlet weak var fechaField: UITextField!
    @IBOutlet weak var horaField: UITextField!
    
    var object = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //
        
    }

    
    @IBAction func add(sender: AnyObject) {
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        
//        let context: NSManagedObjectContext = appDel.managedObjectContext
//        
//        let newData = NSEntityDescription.insertNewObjectForEntityForName("PageTwelve", inManagedObjectContext: context)
//        newData.setValue(numeroAltaField.text, forKey: "fineNumber")
//        newData.setValue(numeroArticuloField.text, forKey: "articleNumber")
//        newData.setValue(fechaField.text, forKey: "summonsToCourt")
//        newData.setValue(horaField.text, forKey: "hora")

    }
    
}


