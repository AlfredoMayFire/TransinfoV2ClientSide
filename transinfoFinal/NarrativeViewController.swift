//
//  NarrativeViewController.swift
//  transinfoFinal
//
//  Created by Jessica Cotrina Revilla on 7/28/16.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import UIKit
import CoreData

class NarrativeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let singleton = Global.sharedGlobal

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    //
    @IBOutlet weak var notifiedTimePoliceField: UITextField!
    @IBOutlet weak var timeArrivalPoliceField: UITextField!
    @IBOutlet weak var notifiedTimeEmergenceField: UITextField!
    @IBOutlet weak var timeArrivalEmergenceField: UITextField!
    @IBOutlet weak var detailField: UITextView!
    
    
    
    @IBOutlet var image: UIImageView!
    
    
    var parametersForUpload: [String:AnyObject] = [
    "fecha":"",
    "fileName":"",
    "idAccidentFK":"",
    ]
    
    
    
    var crashID = Dictionary<String,AnyObject>()
    var narrFK = String()
    var values: [String:AnyObject] = [
        "accidentfk":"",
        "narrfk":""
    ]
    var dictionaryBro: Dictionary<String,String> = ["":""]
    
    
    

    
    @IBAction func horaNotificadaField(sender: UITextField) {
        let timePicker:UIDatePicker = UIDatePicker()
        
        timePicker.datePickerMode = UIDatePickerMode.Time
        sender.inputView = timePicker
        timePicker.addTarget(self, action: #selector(NarrativeViewController.timePickerValueChangedhoraNotificadaPolice(_:)),forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func timePickerValueChangedhoraNotificadaPolice(sender:UIDatePicker) {
        
        let dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateformatter.dateFormat = "hh:mm a"
        notifiedTimePoliceField.text = dateformatter.stringFromDate(sender.date)
        if singleton.firstTabInfo[0].sawReportOnce {
            dictionaryBro = singleton.firstTabInfo[0].thirdTab
            print(dictionaryBro)
            notifiedTimePoliceField.text = dictionaryBro["notifiedTimePolice"]
            notifiedTimeEmergenceField.text = dictionaryBro["notifiedTimeEmergencie"]
            timeArrivalPoliceField.text = dictionaryBro["timeOfArrivalPolice"]
            timeArrivalEmergenceField.text = dictionaryBro["timeOfArrivalEmergencie"]
            detailField.text = dictionaryBro["details"]
            
            correctFormat()
            
        }

    }
    
    func timePickerValueChangedhoraLLegadaPolice(sender:UIDatePicker) {
        
        let dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateformatter.dateFormat = "hh:mm a"
        timeArrivalPoliceField.text = dateformatter.stringFromDate(sender.date)
        if singleton.firstTabInfo[0].sawReportOnce{
            dictionaryBro = singleton.firstTabInfo[0].thirdTab
            print(dictionaryBro)
            notifiedTimePoliceField.text = dictionaryBro["notifiedTimePolice"]
            notifiedTimeEmergenceField.text = dictionaryBro["notifiedTimeEmergencie"]
            timeArrivalPoliceField.text = dictionaryBro["timeOfArrivalPolice"]
            timeArrivalEmergenceField.text = dictionaryBro["timeOfArrivalEmergencie"]
            detailField.text = dictionaryBro["details"]
            
            correctFormat()
            
        }
        
    }

    @IBAction func horraLlegadaField(sender: UITextField) {
        
        let timePicker:UIDatePicker = UIDatePicker()
        timePicker.datePickerMode = UIDatePickerMode.Time
        sender.inputView = timePicker
        timePicker.addTarget(self, action: #selector(NarrativeViewController.timePickerValueChangedhoraLLegadaPolice(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func timePickerValueChangedhoraNotificaEmergencia(sender:UIDatePicker) {
        
        let dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateformatter.dateFormat = "hh:mm a"
        notifiedTimeEmergenceField.text = dateformatter.stringFromDate(sender.date)
        if singleton.firstTabInfo[0].sawReportOnce {
            dictionaryBro = singleton.firstTabInfo[0].thirdTab
            print(dictionaryBro)
            notifiedTimePoliceField.text = dictionaryBro["notifiedTimePolice"]
            notifiedTimeEmergenceField.text = dictionaryBro["notifiedTimeEmergencie"]
            timeArrivalPoliceField.text = dictionaryBro["timeOfArrivalPolice"]
            timeArrivalEmergenceField.text = dictionaryBro["timeOfArrivalEmergencie"]
            detailField.text = dictionaryBro["details"]
            
            correctFormat()
            
        }
        
    }
   
    @IBAction func horaNotificadEmergencia(sender: UITextField) {
        
        let timePicker:UIDatePicker = UIDatePicker()
        timePicker.datePickerMode = UIDatePickerMode.Time
        sender.inputView = timePicker
        timePicker.addTarget(self, action: #selector(NarrativeViewController.timePickerValueChangedhoraNotificaEmergencia(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func timePickerValueChangedhoraLLegadaEmergencia(sender:UIDatePicker) {
        
        let dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateformatter.dateFormat = "hh:mm a"
        timeArrivalEmergenceField.text = dateformatter.stringFromDate(sender.date)
        if singleton.firstTabInfo[0].sawReportOnce {
            dictionaryBro = singleton.firstTabInfo[0].thirdTab
            print(dictionaryBro)
            notifiedTimePoliceField.text = dictionaryBro["notifiedTimePolice"]
            notifiedTimeEmergenceField.text = dictionaryBro["notifiedTimeEmergencie"]
            timeArrivalPoliceField.text = dictionaryBro["timeOfArrivalPolice"]
            timeArrivalEmergenceField.text = dictionaryBro["timeOfArrivalEmergencie"]
            detailField.text = dictionaryBro["details"]
            
            correctFormat()
            
        }
        
    }
    @IBAction func horaLLegadaEmergencia(sender: UITextField) {
        let timePicker:UIDatePicker = UIDatePicker()
        timePicker.datePickerMode = UIDatePickerMode.Time
        sender.inputView = timePicker
        timePicker.addTarget(self, action: #selector(NarrativeViewController.timePickerValueChangedhoraLLegadaEmergencia(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        if singleton.firstTabInfo[0].sawReportOnce {
            dictionaryBro = singleton.firstTabInfo[0].thirdTab
            print(dictionaryBro)
            notifiedTimePoliceField.text = dictionaryBro["notifiedTimePolice"]
            notifiedTimeEmergenceField.text = dictionaryBro["notifiedTimeEmergencie"]
            timeArrivalPoliceField.text = dictionaryBro["timeOfArrivalPolice"]
            timeArrivalEmergenceField.text = dictionaryBro["timeOfArrivalEmergencie"]
            detailField.text = dictionaryBro["details"]
            
            correctFormat()
      
        }

        
        //colornavigation
        navigationController!.navigationBar.barTintColor = UIColor (red:28.0/255.0, green:69.0/255.0, blue:135.0/255.0, alpha:1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        //hora
       
        
  //      cargar hora automaticamente
//        notifiedTimePoliceField.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
//        timeArrivalPoliceField.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
//        timeArrivalEmergenceField.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
//        notifiedTimeEmergenceField.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
//
        // Do any additional setup after loading the view, typically from a nib.
         scrollView.contentSize.height = 1200
       
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
           // menuButton.action = "revealToggle:"
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func sendData(sender: AnyObject) {
        
        let singleton = Global.sharedGlobal
        
        let webServicesObject = WebService.init()
        webServicesObject.addIData("NotifiedTimePolice", value: notifiedTimePoliceField.text)
        webServicesObject.addIData("TimeOfArrivalPolice", value: timeArrivalPoliceField.text)
        webServicesObject.addIData("NotifiedTimeEmergencie", value: notifiedTimeEmergenceField.text)
        webServicesObject.addIData("TimeOfArrivalEmergencie", value: timeArrivalEmergenceField.text)
        webServicesObject.addIData("Details", value: detailField.text)
        
        
        crashID = webServicesObject.sendPOSTs(13)
        //print(crashID)
        let myID = crashID["success"]
        let results = myID as? Dictionary<String,AnyObject>
        
            values["narrfk"] = (results!["CrashId"]?.integerValue)!
        
        if(crashID.first!.0 == "error_code" || crashID.first!.0 == "error"){
            
            
        }else{
            singleton.foreignKeys[0].narrative = (values["narrfk"]?.integerValue)!
        }
        
        values["accidentfk"] = singleton.foreignKeys[0].crashBasicInformation
        

        let webServicesObject2 = WebService.init()
        webServicesObject2.addIData("AccidenteFK", value: values["accidentfk"]?.stringValue)
        webServicesObject2.addIData("NarrativaFK", value: values["narrfk"]?.stringValue)
       // print(webServicesObject2.PostData)
        webServicesObject2.sendPOSTs(12)
        
        let alertController = UIAlertController(title: "Reporte sometido.", message:
            "El reporte se ha sometido con exito.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)


    }
    
    //image upload and post
    
    
    
    
    
    @IBAction func selectPicture(sender: AnyObject) {
        
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(ImagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        image.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func upload_request(sender: AnyObject) {
        UploadRequest()
    }
    
    
    
    func UploadRequest()
    {
        if (image.image == nil)
        {
            return
        }
        
        let image_data = UIImagePNGRepresentation(image.image!)
        
        
        if(image_data == nil)
        {
            return
        }
        
        parametersForUpload["fecha"] = "Julio/20/2017"
        parametersForUpload["fileName"] = "testimage.png"
        parametersForUpload["path"] = "path"
        parametersForUpload["idAccidentFK"] = "7"//String(singleton.foreignKeys[0].accidentCondition)
        
     
        
        
        imageUploadRequest(imageView: image, uploadUrl: NSURL(string: "http://136.145.59.111:5000/LoadData")!, param: parametersForUpload)
        let alertController = UIAlertController(title: "Imagen subido!", message:
            "Ya su imagen se ha subido con exito!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    
    
    

    
    
    
    
    
    func imageUploadRequest(imageView imageView: UIImageView, uploadUrl: NSURL, param: [String:AnyObject]?) {
        
     
        
        
        
        
        let request = NSMutableURLRequest(URL:uploadUrl);
        request.HTTPMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = UIImagePNGRepresentation(imageView.image!)
        
        if(imageData==nil)  { return; }
        
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        //myActivityIndicator.startAnimating();
        
        let task =  NSURLSession.sharedSession().dataTaskWithRequest(request,completionHandler: {(data, response, error) -> Void in if let data = data {
            
        
            // You can print out response object
            
            print("******* response = \(response)")
            
            
            
            print(data.length)
            
            
            // you can use data here
            
            
            
            
            // Print out reponse body
            
            let responseString = NSString(data: data, encoding:NSUTF8StringEncoding)
            
            print("****** response data = \(responseString!)")
            
            
//            
//            let json =  try!NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary
//            
//            
//            
//            print("json value \(json)")
            
            
            
            //var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err)
            
            
            
            dispatch_async(dispatch_get_main_queue(),{
            
                //self.myActivityIndicator.stopAnimating()
                
                //self.imageView.image = nil;
                
            });
            
            
            
        } else if let error = error {
        
            print(error.description)
            
            }
        })
        task.resume()
        
        
    }
    
    
    func createBodyWithParameters(parameters: [String: AnyObject]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "testimage.png"
        
        let mimetype = "image/png"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    

    func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    
    
    func correctFormat(){
        
        
        notifiedTimePoliceField.text = notifiedTimePoliceField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        notifiedTimePoliceField.text = notifiedTimePoliceField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        notifiedTimePoliceField.text = notifiedTimePoliceField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        notifiedTimePoliceField.text = notifiedTimePoliceField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        notifiedTimePoliceField.text = notifiedTimePoliceField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        notifiedTimePoliceField.text = notifiedTimePoliceField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        notifiedTimePoliceField.text = notifiedTimePoliceField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
     
        timeArrivalPoliceField.text = timeArrivalPoliceField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        timeArrivalPoliceField.text = timeArrivalPoliceField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        timeArrivalPoliceField.text = timeArrivalPoliceField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        timeArrivalPoliceField.text = timeArrivalPoliceField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        timeArrivalPoliceField.text = timeArrivalPoliceField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        timeArrivalPoliceField.text = timeArrivalPoliceField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        timeArrivalPoliceField.text = timeArrivalPoliceField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        notifiedTimeEmergenceField.text = notifiedTimeEmergenceField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        notifiedTimeEmergenceField.text = notifiedTimeEmergenceField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        notifiedTimeEmergenceField.text = notifiedTimeEmergenceField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        notifiedTimeEmergenceField.text = notifiedTimeEmergenceField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        notifiedTimeEmergenceField.text = notifiedTimeEmergenceField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        notifiedTimeEmergenceField.text = notifiedTimeEmergenceField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        notifiedTimeEmergenceField.text = notifiedTimeEmergenceField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        timeArrivalEmergenceField.text = timeArrivalEmergenceField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        timeArrivalEmergenceField.text = timeArrivalEmergenceField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        timeArrivalEmergenceField.text = timeArrivalEmergenceField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        timeArrivalEmergenceField.text = timeArrivalEmergenceField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        timeArrivalEmergenceField.text = timeArrivalEmergenceField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        timeArrivalEmergenceField.text = timeArrivalEmergenceField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        timeArrivalEmergenceField.text = timeArrivalEmergenceField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        detailField.text = detailField.text?.stringByReplacingOccurrencesOfString("\\U00f1", withString: "ñ")
        detailField.text = detailField.text?.stringByReplacingOccurrencesOfString("\\U00f3", withString: "ó")
        detailField.text = detailField.text?.stringByReplacingOccurrencesOfString("\\U00d3", withString: "Ó")
        detailField.text = detailField.text?.stringByReplacingOccurrencesOfString("\\U00e1", withString: "á")
        detailField.text = detailField.text?.stringByReplacingOccurrencesOfString("\\U00ed", withString: "í")
        detailField.text = detailField.text?.stringByReplacingOccurrencesOfString("\\U00fa", withString: "ú")
        detailField.text = detailField.text?.stringByReplacingOccurrencesOfString("\"", withString: "")
        
        
    }
    

    
}// extension for impage uploading

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}
    
    
    
    
    




func supportedInterfaceOrientations() -> Int {
    let supported = UIInterfaceOrientationMask.Portrait.rawValue
    return Int(supported)
}
