//
//  DropDownList.swift
//  iOSPond
//
//  Created by iOSPond on 11/07/16.
//  Copyright © 2016 iOSPond. All rights reserved.
//

import UIKit
/*!
 
 - author: iOSPond
 I defined enum so that I can group my constants here.
 
 - cellIdentifier: This is identity of the cell for dropdown list tableview
 */
enum constant:String {
    case cellIdentifier="CellIdentity"
}
class SwiftDropDownList: UITextField, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    //MARK: - Global Vars
    var borderColor = UIColor(red: 0.1,green: 0.1,blue: 0.1,alpha: 0.3)
    var selectedIndex = NSIntegerMax
    var tblView:UITableView!
    var arrayList:NSArray=NSArray()
    static var arrList:NSArray!
    var isArrayWithObject:Bool = false
    var isDismissWhenSelected = true
    var isKeyboardHidden=false
    var keyPath:String!
    var textField:UITextField!
    var arrFiltered:NSArray!
    var multipleSelection:NSArray!
    //var arrFiltered:NSArray
    var superViews:UIView!
    //MARK:- Delegate object
    weak var delegates:DropDownListDelegate!
    //MARK:- Class constructor
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate=self
        self.tblView=UITableView()
        self.tblView.delegate=self
        self.tblView.dataSource=self
        self.tblView.registerClass(UITableViewCell.self, forCellReuseIdentifier: constant.cellIdentifier.rawValue)
        self.tblView.tag = 7890707
    }
    convenience init(){
        self.init()
        
    }
    //MARK:- TextField delegate methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let myStr = textField.text! as NSString
        let finalString =  myStr.stringByReplacingCharactersInRange(range, withString: string)
        if isArrayWithObject{
            if finalString.isEmpty{
                arrFiltered = arrayList
            }else{
                let pred=NSPredicate(format: "\(keyPath) beginswith[c] '\(finalString)'")
                self.arrFiltered = arrayList.filteredArrayUsingPredicate(pred)
                // self.arrFiltered = arrayList
            }
        }else{
            let array:[AnyObject]=arrayList as [AnyObject]
            if finalString.isEmpty{
                arrFiltered = arrayList
            }else{
                arrFiltered =  array.filter{($0 as! String) .localizedCaseInsensitiveContainsString(finalString)}
            }
            
        }
        
        
        //print(self.arrFiltered)
        self.tblView.reloadData()
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if self.tblView.frame.size.height > 0{
            
            UIView.animateWithDuration(0.5, animations: {
                self.tblView.frame.size.height=0
            })
        }else{
            textField.resignFirstResponder()
            self.tblView.frame.size.width = textField.frame.size.width
            self.tblView.frame.origin.x = textField.frame.origin.x
            self.tblView.frame.size.height = 0
            self.tblView.layer.borderWidth = 0.30
            self.tblView.layer.borderColor = borderColor.CGColor
            self.tblView.layer.cornerRadius = 5
            self.textField=textField
            
            self.arrFiltered = self.arrayList
            
            self.getSuperView(self.superview!)
            let rect = superViews.convertRect(textField.frame, fromView: textField.superview)
            self.tblView.frame.origin.y = rect.origin.y + rect.size.height-2
            self.tblView.frame.origin.x = rect.origin.x
            
            UIView.animateWithDuration(0.5, animations: {
                self.tblView.frame.size.height=130
                self.superViews.addSubview(self.tblView)
                self.tblView.reloadData()
            })
            
            
        }
        return !isKeyboardHidden
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        UIView.animateWithDuration(0.5, animations: {
            self.tblView.frame.size.height=0
        })
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.animateWithDuration(0.5, animations: {
            self.tblView.frame.size.height=0
        })
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        UIView.animateWithDuration(0.5, animations: {
            self.tblView.frame.size.height=0
        })
        textField.resignFirstResponder()
        return true
    }
    //MARK: - Custome Methods
    func getSuperView(views:UIView){
        superViews = views.superview
        if superViews.frame.size.height < 200{
            getSuperView(superViews!)
        }
    }
    
    //MARK- TableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFiltered.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(constant.cellIdentifier.rawValue)
        if isArrayWithObject {
            cell?.textLabel?.text = self.arrFiltered.objectAtIndex(indexPath.row).valueForKey(keyPath) as? String
            
        }else{
            cell?.textLabel?.text=self.arrFiltered.objectAtIndex(indexPath.row) as? String
        }
        if(indexPath.row == selectedIndex)
        {
            cell?.accessoryType = .Checkmark
        }
        else
        {
            cell?.accessoryType = .None
        }
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object =  self.arrFiltered.objectAtIndex(indexPath.row)
        if delegates != nil{
            self.delegates.dropDownSelectedIndex(indexPath.row, textField: self.textField, object: object)
        }
        
        if !isArrayWithObject {
            textField.text = object as? String
        }else{
            textField.text = object.valueForKeyPath(keyPath) as? String
        }
        if isDismissWhenSelected {
            //change 0
            UIView.animateWithDuration(0.5, animations: {
                self.tblView.frame.size.height=0
                }, completion: { (value: Bool) in
                    self.tblView.removeFromSuperview()
                    self.resignFirstResponder()
            })
            
        }
        selectedIndex = indexPath.row;
        tableView.reloadData()
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        tblView.flashScrollIndicators()
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        tblView.flashScrollIndicators()
    }
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .None
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        //print("Didit")
        if touch?.view?.tag != 7890707{
            //change 0
            //print("Didit")
            UIView.animateWithDuration(0.5, animations: {
                self.tblView.frame.size.height=0
                }, completion: { (value: Bool) in
                    self.tblView.removeFromSuperview()
                    self.resignFirstResponder()
            })
            
        }
    }
}
//MARK:- Protocol
protocol DropDownListDelegate:class {
    
    
    func dropDownSelectedIndex(index:Int, textField:UITextField, object:AnyObject)
}

