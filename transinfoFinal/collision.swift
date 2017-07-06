//
//  ViewController.swift
//  DiagramaColisiones
//
//  Created by Alfredo Pomales on 9/18/16.
//  Copyright © 2016 MayFireDesigns. All rights reserved.
// Running

import UIKit

class CollisionDiagram: UIViewController {
    
    
    //random needed variables
    var angleOfRotation = 0.0
    var location = CGPoint()
    var list = ["1","2","3","4","5","6","7","8","9","10","11","12","13"]
    var indexCounter = 0
    var carnumber = 2
    
    
    
    
    
    //Storyboard Elements
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carImage1: UIImageView!
    @IBOutlet weak var carImage2: UIImageView!
    @IBOutlet weak var carImage3: UIImageView!
    @IBOutlet weak var carImage4: UIImageView!
    @IBOutlet weak var carImage5: UIImageView!
    @IBOutlet weak var carImage6: UIImageView!
    @IBOutlet weak var carImage7: UIImageView!
    @IBOutlet weak var carImage8: UIImageView!
    @IBOutlet weak var carImage9: UIImageView!
    
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    
    
    
    //Button Functionalities
    
    
    @IBAction func resetButton(sender: AnyObject) {
        let alertController = UIAlertController(title: "Caution!", message: "You are about to reset the diagram. Continue?", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
            self.carImage.hidden = true
            self.carImage1.hidden = true
            self.carImage2.hidden = true
            self.carImage3.hidden = true
            self.carImage4.hidden = true
            self.carImage5.hidden = true
            self.carImage6.hidden = true
            self.carImage7.hidden = true
            self.carImage8.hidden = true
            self.carImage9.hidden = true
            self.carnumber = 1
            
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {
            // ...
        }
        
    }
    
    
    
    @IBAction func addTruck(sender: AnyObject) {
        switch (carnumber-1){
        case 0:
            carImage.image = UIImage(named: "truck_000\(carnumber-1)_\(carnumber)")
            carImage.hidden = false
            carnumber += 1
        case 1:
            carImage1.image = UIImage(named: "truck_000\(carnumber-1)_\(carnumber)")
            carImage1.hidden = false
            carnumber += 1
        case 2:
            carImage2.image = UIImage(named: "truck_000\(carnumber-1)_\(carnumber)")
            carImage2.hidden = false
            carnumber += 1
        case 3:
            carImage3.image = UIImage(named: "truck_000\(carnumber-1)_\(carnumber)")
            carImage3.hidden = false
            carnumber += 1
        case 4:
            carImage4.image = UIImage(named: "truck_000\(carnumber-1)_\(carnumber)")
            carImage4.hidden = false
            carnumber += 1
        case 5:
            carImage5.image = UIImage(named: "truck_000\(carnumber-1)_\(carnumber)")
            carImage5.hidden = false
            carnumber += 1
        case 6:
            carImage6.image = UIImage(named: "truck_000\(carnumber-1)_\(carnumber)")
            carImage6.hidden = false
            carnumber += 1
        case 7:
            carImage7.image = UIImage(named: "truck_000\(carnumber-1)_\(carnumber)")
            carImage7.hidden = false
            carnumber += 1
        case 8:
            carImage8.image = UIImage(named: "truck_000\(carnumber-1)_\(carnumber)")
            carImage8.hidden = false
            carnumber += 1
        case 9:
            carImage9.image = UIImage(named: "truck_000\(carnumber-1)_\(carnumber)")
            carImage9.hidden = false
            carnumber += 1
        default:
            print("Nothing Happened")
        }
        
    }
    
    
    @IBAction func addMotorcycle(sender: AnyObject) {
        switch (carnumber-1){
        case 0:
            carImage.image = UIImage(named: "moto_000\(carnumber-1)_\(carnumber)")
            carImage.hidden = false
            carnumber += 1
        case 1:
            carImage1.image = UIImage(named: "moto_000\(carnumber-1)_\(carnumber)")
            carImage1.hidden = false
            carnumber += 1
        case 2:
            carImage2.image = UIImage(named: "moto_000\(carnumber-1)_\(carnumber)")
            carImage2.hidden = false
            carnumber += 1
        case 3:
            carImage3.image = UIImage(named: "moto_000\(carnumber-1)_\(carnumber)")
            carImage3.hidden = false
            carnumber += 1
        case 4:
            carImage4.image = UIImage(named: "moto_000\(carnumber-1)_\(carnumber)")
            carImage4.hidden = false
            carnumber += 1
        case 5:
            carImage5.image = UIImage(named: "moto_000\(carnumber-1)_\(carnumber)")
            carImage5.hidden = false
            carnumber += 1
        case 6:
            carImage6.image = UIImage(named: "moto_000\(carnumber-1)_\(carnumber)")
            carImage6.hidden = false
            carnumber += 1
        case 7:
            carImage7.image = UIImage(named: "moto_000\(carnumber-1)_\(carnumber)")
            carImage7.hidden = false
            carnumber += 1
        case 8:
            carImage8.image = UIImage(named: "moto_000\(carnumber-1)_\(carnumber)")
            carImage8.hidden = false
            carnumber += 1
        case 9:
            carImage9.image = UIImage(named: "moto_000\(carnumber-1)_\(carnumber)")
            carImage9.hidden = false
            carnumber += 1
            
        default:
            print("Nothing Happened")
        }
        
    }
    
    
    @IBAction func addCar(sender: AnyObject) {
        switch (carnumber-1){
        case 0:
            carImage.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage.hidden = false
            carnumber += 1
        case 1:
            carImage1.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage1.hidden = false
            carnumber += 1
        case 2:
            carImage2.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage2.hidden = false
            carnumber += 1
        case 3:
            carImage3.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage3.hidden = false
            carnumber += 1
        case 4:
            
            carImage4.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage4.hidden = false
            carnumber += 1
        case 5:
            carImage5.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage5.hidden = false
            carnumber += 1
        case 6:
            carImage6.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage6.hidden = false
            carnumber += 1
        case 7:
            carImage7.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage7.hidden = false
            carnumber += 1
        case 8:
            carImage8.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage8.hidden = false
            carnumber += 1
        case 9:
            carImage9.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage9.hidden = false
            carnumber += 1
            
        default:
            print("Nothing Happened")
        }
    }
    
    
    @IBAction func addBus(sender: AnyObject) {
        switch (carnumber-1){
        case 0:
            carImage.image = UIImage(named: "bus_000\(carnumber-1)_\(carnumber)")
            carImage.hidden = false
            carnumber += 1
        case 1:
            carImage1.image = UIImage(named: "bus_000\(carnumber-1)_\(carnumber)")
            carImage1.hidden = false
            carnumber += 1
        case 2:
            carImage2.image = UIImage(named: "bus_000\(carnumber-1)_\(carnumber)")
            carImage2.hidden = false
            carnumber += 1
        case 3:
            carImage3.image = UIImage(named: "bus_000\(carnumber-1)_\(carnumber)")
            carImage3.hidden = false
            carnumber += 1
        case 4:
            carImage4.image = UIImage(named: "bus_000\(carnumber-1)_\(carnumber)")
            carImage4.hidden = false
            carnumber += 1
        case 5:
            carImage5.image = UIImage(named: "bus_000\(carnumber-1)_\(carnumber)")
            carImage5.hidden = false
            carnumber += 1
        case 6:
            carImage6.image = UIImage(named: "bus_000\(carnumber-1)_\(carnumber)")
            carImage6.hidden = false
            carnumber += 1
        case 7:
            carImage7.image = UIImage(named: "bus_000\(carnumber-1)_\(carnumber)")
            carImage7.hidden = false
            carnumber += 1
        case 8:
            carImage8.image = UIImage(named: "bus_000\(carnumber-1)_\(carnumber)")
            carImage8.hidden = false
            carnumber += 1
        case 9:
            carImage9.image = UIImage(named: "bus_000\(carnumber-1)_\(carnumber)")
            carImage9.hidden = false
            carnumber += 1
            
        default:
            print("Nothing Happened")
        }
    }
    
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
        //Add the recognizer to your view.
        carImage.addGestureRecognizer(tapRecognizer)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //Set up background, imageviews, etc.
    func setup() -> Void
    {
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "2000px-Street_intersection_diagram.png")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        self.textBox.hidden = true
        carImage1.hidden = true
        carImage2.hidden = true
        carImage3.hidden = true
        carImage4.hidden = true
        carImage5.hidden = true
        carImage6.hidden = true
        carImage7.hidden = true
        carImage8.hidden = true
        carImage9.hidden = true
        
    }
    
    
    //touch, tap and pan functionality
    
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer)
    {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view
        {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }
    @IBAction func handleRotate(recognizer : UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = CGAffineTransformRotate(view.transform, recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    
    func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
        //tappedImageView will be the image view that was tapped.
        //dismiss it, animate it off screen, whatever.
        let tappedImageView = gestureRecognizer.view!
        angleOfRotation += M_PI/6
        tappedImageView.transform=CGAffineTransformMakeRotation(CGFloat(angleOfRotation));
        
        
    }
    
    
    
    
    
    
    //Set in stone down below
    
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return list.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        self.view.endEditing(true)
        return list[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.textBox.text = self.list[row]
        //self.dropDown.hidden = true
        determineBackground()
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        if textField == self.textBox
        {
            self.dropDown.hidden = false
            //if you dont want the users to se the keyboard type:
            textField.endEditing(true)
        }
    }
    
    func determineBackground()
    {
        switch self.textBox.text {
        case "1"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "curvaderecha.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "2"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "curvaizquierda.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "3"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "interseccionTPARE.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "4"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "interseccionTSemaforizada.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "5"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "interseccionXCuatroPARE.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "6"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "interseccionXDosPARE.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "7"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "interseccionXSemaforizada.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "8"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "parking.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "9"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "rampaDeEntrada.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "10"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "rampaDeSalida.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "11"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "rotonda.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "12"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "tangente4CarrilesConIsleta.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "13"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "tangenteDosCarriles.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
            
        default:
            print("Nothing Happened")
        }
        //if self.textBox.text == "13"
    }
    
    
    
    
    
}

