//
//  ViewController.swift
//  DiagramaColisiones
//
//  Created by Alfredo Pomales on 9/18/16.
//  Copyright © 2016 MayFireDesigns. All rights reserved.
// Running

import UIKit
import Photos
import PhotosUI

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
//    @IBInspectable var borderColor: UIColor? {
//        set {
//            guard let uiColor = newValue else { return }
//            layer.borderColor = UIColor.init(CGColor: UIColor.blackColor())
//        }
//        get {
//            guard let color = layer.borderColor else { return nil }
//            return UIColor(CGColor: color)
//        }
//    }
}

class CollisionDiagram: UIViewController {
    
    
    
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    //random needed variables
    var angleOfRotation = 0.0
    var location = CGPoint()
    var list = ["Original","Curva Derecha","Curva Izquierda",
                "Intersección T Pare",
                "Intersección T Semaforizada",
                "Intersección X 4 Pare",
                "Intersección X 2 Pare",
                "Intersección X Semaforizada",
                "Parking",
                "Rampa de Entrada",
                "Rampa de Salida",
                "Rotonda",
                "Tangente 4 Carriles Isleta",
                "Tangente 2 Carriles"]
    var indexCounter = 0
    var carnumber = 2
    
    @IBOutlet var scrollview: UIScrollView!
    
    @IBOutlet weak var backgrounds: SwiftDropDownList!
    var backgroundList: Array<Dictionary<String,AnyObject>> = [["MeasurementID":1,"DescriptionES":"Original","DescriptionEN":"Original"],["MeasurementID":2,"DescriptionES":"Curva Derecha","DescriptionEN":"Curva Derecha"],["MeasurementID":3,"DescriptionES":"Curva Izquierda","DescriptionEN":"Curva Izquierda"],["MeasurementID":4,"DescriptionES":"Intersección T Pare","DescriptionEN":"Intersección T Pare"],["MeasurementID":5,"DescriptionES":"Intersección T Semaforizada","DescriptionEN":"Intersección T Semaforizada"],["MeasurementID":6,"DescriptionES":"Intersección X 4 Pare","DescriptionEN":"Intersección X 4 Pare"],["MeasurementID":7,"DescriptionES":"Intersección X 2 Pare","DescriptionEN":"Intersección X 2 Pare"],["MeasurementID":8,"DescriptionES":"Intersección X Semaforizada","DescriptionEN":"Intersección X Semaforizada"],["MeasurementID":9,"DescriptionES":"Parking","DescriptionEN":"Parking"],["MeasurementID":10,"DescriptionES":"Rampa de Entrada","DescriptionEN":"Rampa de Entrada"],["MeasurementID":11,"DescriptionES":"Rampa de Salida","DescriptionEN":"Rampa de Salida"],["MeasurementID":12,"DescriptionES":"Rotonda","DescriptionEN":"Rotonda"],["MeasurementID":13,"DescriptionES":"Tangente 4 Carriles Isleta","DescriptionEN":"Tangente 4 Carriles Isleta"],["MeasurementID":15,"DescriptionES":"Tangente 2 Carriles","DescriptionEN":"Tangente 2 Carriles"]]
    
    
    
    
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
    
    @IBOutlet weak var shutterButton: UIButton!
    
    
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
            self.carImage.transform = CGAffineTransformMakeRotation(CGFloat(0))
            self.carImage1.transform = CGAffineTransformMakeRotation(CGFloat(0))
            self.carImage2.transform = CGAffineTransformMakeRotation(CGFloat(0))
            self.carImage3.transform = CGAffineTransformMakeRotation(CGFloat(0))
            self.carImage4.transform = CGAffineTransformMakeRotation(CGFloat(0))
            self.carImage5.transform = CGAffineTransformMakeRotation(CGFloat(0))
            self.carImage6.transform = CGAffineTransformMakeRotation(CGFloat(0))
            self.carImage7.transform = CGAffineTransformMakeRotation(CGFloat(0))
            self.carImage8.transform = CGAffineTransformMakeRotation(CGFloat(0))
            self.carImage9.transform = CGAffineTransformMakeRotation(CGFloat(0))
            
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {
            // ...
        }
        
    }
    
    @IBAction func takeScreenshot(sender:AnyObject){
        
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, UIScreen.mainScreen().scale)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        let alertController = UIAlertController(title: "Screenshot tomado.", message:
            "Acuerdese de escoger el imagen antes de subirlo!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        
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
            carImage1.frame = carImage.frame
            //carImage1.center.y += 50
   
            carImage1.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage1.hidden = false
            carnumber += 1
        case 2:
            carImage2.frame = carImage.frame
            //carImage2.center.y += (carImage1.center.y + 50)
            carImage2.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage2.hidden = false
            carnumber += 1
        case 3:
            carImage3.frame = carImage.frame
            carImage3.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage3.hidden = false
            carnumber += 1
        case 4:
            carImage4.frame = carImage.frame
            carImage4.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage4.hidden = false
            carnumber += 1
        case 5:
            carImage5.frame = carImage.frame
            carImage5.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage5.hidden = false
            carnumber += 1
        case 6:
            carImage6.frame = carImage.frame
            carImage6.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage6.hidden = false
            carnumber += 1
        case 7:
            carImage7.frame = carImage.frame
            carImage7.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage7.hidden = false
            carnumber += 1
        case 8:
            carImage8.frame = carImage.frame
            carImage8.image = UIImage(named: "car_000\(carnumber-1)_\(carnumber)")
            carImage8.hidden = false
            carnumber += 1
        case 9:
            carImage9.frame = carImage.frame
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
  
    
  
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        let data = list[row]
        let title = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15.0, weight: UIFontWeightRegular)])
        label.attributedText = title
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7//usually 0.1
        label.textAlignment = NSTextAlignment.Center
        return label
        
    }
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
        
//       backgroundList.arrayLi
        
        
        backgrounds.isKeyboardHidden = true
        backgrounds.isDismissWhenSelected = true
        backgrounds.isArrayWithObject = true
        backgrounds.keyPath = "DescriptionES"
        backgrounds.arrayList = backgroundList
    
        
        
        
        
        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
        //Add the recognizer to your view.
        carImage.addGestureRecognizer(tapRecognizer)
        scrollview.contentSize.height = 800
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
     
        let tappedImageView = gestureRecognizer.view!
        angleOfRotation += M_PI/6
        tappedImageView.transform=CGAffineTransformMakeRotation(CGFloat(angleOfRotation));
        
        
    }
    @IBAction func longPressRecognizer(recognizer: UILongPressGestureRecognizer) {
        if let view = recognizer.view{
            print("hey")
            view.delete(view)
        }
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
    
//    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
//        let pickerLabel = UILabel()
//        let titleData = self.list[row]
//        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
//        pickerLabel.attributedText = myTitle
//        return pickerLabel
//    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        if textField == self.textBox
        {
            self.dropDown.hidden = false
            //if you dont want the users to se the keyboard type:
            textField.endEditing(true)
        }
    }
    
    @IBAction func changed(sender: SwiftDropDownList) {
        print("here")
        determineBackground()
    }
    
    @IBAction func changeBackground(sender: AnyObject) {
        determineBackground()
    }
    func determineBackground()
    {
        print("here")
        switch self.backgrounds.text {
        case "Original"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "2000px-Street_intersection_diagram.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "Curva Derecha"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "curvaderecha.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "Curva Izquierda"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "curvaizquierda.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "Intersección T Pare"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "interseccionTPARE.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "Intersección T Semaforizada"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "interseccionTSemaforizada.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "Intersección X 4 Pare"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "interseccionXCuatroPARE.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "Intersección X 2 Pare"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "interseccionXDosPARE.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "Intersección X Semaforizada"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "interseccionXSemaforizada.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "Parking"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "parking.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "Rampa de Entrada"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "rampaDeEntrada.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "Rampa de Salida"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "rampaDeSalida.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "Rotonda"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "rotonda.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "Tangente 4 Carriles Isleta"?:
            indexCounter += 1
            let backgroundImage1 = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundImage1.image = UIImage(named: "tangente4CarrilesConIsleta.png")
            let backgroundReset = UIImageView(frame: UIScreen.mainScreen().bounds)
            backgroundReset.image = UIImage(named: "white.jpg")
            self.view.insertSubview(backgroundReset, atIndex: indexCounter)
            indexCounter += 1
            self.view.insertSubview(backgroundImage1, atIndex: indexCounter)
        case "Tangente 2 Carriles"?:
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
    
    
    @IBAction func undo(sender: AnyObject) {
        
        switch (carnumber-2){
        case 0:
            carImage.hidden = true
            carnumber -= 1
            carImage.transform = CGAffineTransformMakeRotation(CGFloat(0))
        case 1:
            carImage1.hidden = true
            carnumber -= 1
             carImage1.transform = CGAffineTransformMakeRotation(CGFloat(0))
        case 2:
            carImage2.hidden = true
            carnumber -= 1
             carImage2.transform = CGAffineTransformMakeRotation(CGFloat(0))
        case 3:
            carImage3.hidden = true
            carnumber -= 1
             carImage3.transform = CGAffineTransformMakeRotation(CGFloat(0))
        case 4:
            carImage4.hidden = true
            carnumber -= 1
             carImage4.transform = CGAffineTransformMakeRotation(CGFloat(0))
        case 5:
            carImage5.hidden = true
            carnumber -= 1
             carImage5.transform = CGAffineTransformMakeRotation(CGFloat(0))
        case 6:
            carImage6.hidden = true
            carnumber -= 1
             carImage6.transform = CGAffineTransformMakeRotation(CGFloat(0))
        case 7:
            carImage7.hidden = true
            carnumber -= 1
             carImage7.transform = CGAffineTransformMakeRotation(CGFloat(0))
        case 8:
            carImage8.hidden = true
            carnumber -= 1
             carImage8.transform = CGAffineTransformMakeRotation(CGFloat(0))
            
        case 9:
            carImage9.hidden = true
            carnumber -= 1
             carImage9.transform = CGAffineTransformMakeRotation(CGFloat(0))
            
        default:
            print("Nothing Happened")
        }
        
        
    }
    
    
    
}

