//
//  BookingTestViewController.swift
//  BookATest
//
//  Created by Rasika on 6/23/18.
//  Copyright © 2018 Rasika. All rights reserved.
//

import UIKit
import CoreData

class BookingTestViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource ,UITextFieldDelegate{

    var testPicker: UIPickerView!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var pinCode: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var test: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var address: UITextView!
    
    @IBOutlet weak var bookingLabel: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    let datePicker = UIDatePicker()
    
    let testPickerValues = ["","THYROID", "BP", "DIABESTES","KERATIN","CBC","CMP","GLYCOHEMOGLOBIN","ANA","ESR"]

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = false
        location.delegate = self
        
        testPicker = UIPickerView()
        testPicker.dataSource = self
        testPicker.delegate = self
        test.inputView = testPicker
        test.text = testPickerValues[0]
        
        createDatePicker()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
         self.navigationController!.topViewController!.title = BOOKING;
        
        UIView.animateWithDuration(5.0, delay: 1, options: ([.CurveLinear, .Repeat]), animations: {() -> Void in
            self.bookingLabel.center = CGPointMake(0 - self.bookingLabel.bounds.size.width / 2, self.bookingLabel.center.y)
            }, completion:  { _ in })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
    }
        
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    //MARK UIACTIONS FUNCTIONS
    @IBAction func submitButtonTapped(sender:AnyObject){
        
        if((name.text?.isEmpty == true) || (name.text?.isEmpty == nil) || (name.text?.characters.count < 2))
        {
            displayAlert(NAME_ERROR_MSG)
            return
            
        }
        else if((address?.text == nil) || (address?.text.isEmpty == true))
        {
            displayAlert(ADDRESS_ERROR_MSG)
            return
        }
        else if(!checkForPostcode((pinCode?.text)!)){
            displayAlert(PINCODE_ERROR_MSG)
            return
        }
        else if((!checkForValidEMAIL((email?.text)!)))
        {
            displayAlert(EMAIL_ERROR_MSG)
            return
        }
        else if((mobile.text?.isEmpty == true) || (mobile.text?.isEmpty == nil) || (mobile.text?.characters.count < 10))
        {
            displayAlert(MOBILE_ERROR_MSG)
            return
        }
        if((test.text?.isEmpty == true) || (test.text?.isEmpty == nil))
        {
            displayAlert(TEST_ERROR_MSG)
            return
            
        }
        if((location.text?.isEmpty == true) || (location.text?.isEmpty == nil))
        {
            displayAlert(LOCATION_ERROR_MSG)
            return
            
        }
        
        
       //SAVING OF DATA
        
        let entityDescription =
            NSEntityDescription.entityForName(ORDER_DETAIL_ENTITY,
                                              inManagedObjectContext: managedObjectContext)
        
        let orderDetail = OrderDetail(entity: entityDescription!,
                               insertIntoManagedObjectContext: managedObjectContext)
        
        orderDetail.firstName = name.text
        orderDetail.testName = test.text
        orderDetail.date = stringToDate(date.text!)
        
        
        do {
            try managedObjectContext.save()
            let alert = UIAlertController(title: ALERT,message: BOOKING_SUCCESS_MSG,preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: OKAY, style: UIAlertActionStyle.Default, handler: {
                action in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            name.text = ""
            test.text = ""
            date.text = ""
            address.text = ""
            pinCode.text = ""
            email.text = ""
            location.text = ""
            mobile.text = ""
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    //MARK Textfield Delegates
    
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(true, moveValue: 100)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 100)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:NSTimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( ANIMATE_VIEW, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    
    func displayAlert(message:String){
        
        let alert = UIAlertController(title: ALERT,message: message,preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: OKAY, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Picker View Delegates
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return testPickerValues.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return testPickerValues[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        test.text = testPickerValues[row]
        self.view.endEditing(true)
    }
    
    //MARK:- DATE PICKER
    func createDatePicker(){
        //format for datepicker display
        datePicker.datePickerMode = .Date
        
        //assign datepicker to our textfield
        date.inputView = datePicker
        
        //create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //add a done button on this toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem:.Done, target: nil, action: #selector(doneClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: CANCEL, style: .Plain, target: self, action: #selector(cancelClick))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        date.inputAccessoryView = toolbar
    }
    
    func cancelClick() {
        self.view.endEditing(true)
    }
    
    func doneClicked(){
        
        //format for displaying the date in our textfield
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .NoStyle
        date.text = dateFormatter.stringFromDate(datePicker.date)
        self.view.endEditing(true)
    }

}
