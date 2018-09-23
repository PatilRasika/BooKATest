//
//  RegisterationViewController.swift
//  BookATest
//
//  Created by Rasika on 6/23/18.
//  Copyright © 2018 Rasika. All rights reserved.
//

import UIKit
import CoreData

class RegisterationViewController: UIViewController ,UITextFieldDelegate{

    
    var isProfile: Bool!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //name.delegate = self
        userName.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
      //  pinCode.delegate = self
        email.delegate = self
        
        if (isProfile == true){
            userName.hidden = true
            password.hidden = true
            confirmPassword.hidden = true
            userNameLabel.hidden = true
            confirmPasswordLabel.hidden = true
            passwordLabel.hidden = true
            doneBtn.hidden = true
            headerLabel.text = PROFILE_HEARDER
            editBtn.hidden = false
            name.userInteractionEnabled = false
            address.userInteractionEnabled = false
            mobile.userInteractionEnabled = false
            email.userInteractionEnabled = false
            pinCode.userInteractionEnabled = false
            fetchData()
        }
        else{
            userName.hidden = false
            password.hidden = false
            confirmPassword.hidden = false
            userNameLabel.hidden = false
            confirmPasswordLabel.hidden = false
            passwordLabel.hidden = false
            doneBtn.hidden = false
            headerLabel.text = REGISTER_HEARDER
            editBtn.hidden = true
            saveBtn.hidden = true
            
            name.userInteractionEnabled = true
            address.userInteractionEnabled = true
            mobile.userInteractionEnabled = true
            email.userInteractionEnabled = true
            pinCode.userInteractionEnabled = true
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
        if (isProfile == true){
            self.navigationController!.topViewController!.title = PROFILE;
            
        }
        else {
            self.navigationController!.topViewController!.title = REGISTER;
        }
        
        UIView.animateWithDuration(5.0, delay: 1, options: ([.CurveLinear, .Repeat]), animations: {() -> Void in
            self.headerLabel.center = CGPointMake(0 - self.headerLabel.bounds.size.width / 2, self.headerLabel.center.y)
            }, completion:  { _ in })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var pinCode: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var address: UITextView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    
    
    
    //MARK: Database Functions
    
    
    func saveData(){
        let entityDescription =
            NSEntityDescription.entityForName(PROFILE_ENTITY,
                                              inManagedObjectContext: managedObjectContext)
        
        let user = Profile(entity: entityDescription!,
                               insertIntoManagedObjectContext: managedObjectContext)
        
        user.name = name.text!
        user.address = address.text!
        user.mobile = mobile.text!
        user.address = address.text!
        user.pincode = pinCode.text!
        user.email = email.text!
        
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print(error)
        }
    
    }
    
    func updateData(){
        
        let entityDescription =
            NSEntityDescription.entityForName(PROFILE_ENTITY,
                                              inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        do {
            var profileUpdatedArray =
                try managedObjectContext.executeFetchRequest(request)
            
            if profileUpdatedArray.count > 0 {
                
                profileUpdatedArray[0].setValue(name.text, forKey: NAME)
                profileUpdatedArray[0].setValue(email.text, forKey: EMAIL)
                profileUpdatedArray[0].setValue(address.text, forKey: ADDRESS)
                profileUpdatedArray[0].setValue(mobile.text, forKey: MOBILE)
                profileUpdatedArray[0].setValue(pinCode.text, forKey: PINCODE)
            }
        } catch {
            print("Fetch Failed: \(error)")
        }
        
        do { 
           try managedObjectContext.save()
        }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    
    }
    
    
    func fetchData(){
        
        let entityDescription =
            NSEntityDescription.entityForName(PROFILE_ENTITY,
                                              inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        do {
             var profileArray =
                try managedObjectContext.executeFetchRequest(request)
            
                    if profileArray.count > 0 {
                        let match = profileArray[0] as! NSManagedObject
                        name.text = match.valueForKey(NAME) as? String
                        address.text = match.valueForKey(ADDRESS) as? String
                        mobile.text = match.valueForKey(MOBILE) as? String
                        pinCode.text = match.valueForKey(PINCODE) as? String
                        email.text = match.valueForKey(EMAIL) as? String
                    }
            
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    
    @IBAction func registerDoneTapped(sender:AnyObject){
        
        let userNameValue = userName.text
        let passwordValue = password.text
        
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
        else if((!checkForPassword((password?.text)!)))
        {
            displayAlert(PASSWORD_ERROR_MSG)
            return
        }
        else if((confirmPassword.text != password?.text))
        {
            displayAlert(CONFIRM_PASSWORD_ERROR_MSG)
            return
        }
        
        if (userNameValue!.isEmpty || passwordValue!.isEmpty)
        {
            displayAlert(VALUE_EMPTY_MSG)
            return
        }
        
        
        NSUserDefaults.standardUserDefaults().setObject(userNameValue, forKey: "userName")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        NSUserDefaults.standardUserDefaults().setObject(passwordValue, forKey: "password")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let alert = UIAlertController(title: ALERT,message: REGISTERATION_SUCCESS_MSG,preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: OKAY, style: UIAlertActionStyle.Default, handler: {
            action in
            self.saveData()
            self.updateData()
            self.dismissViewControllerAnimated(true, completion: nil)
            self.navigationController?.popViewControllerAnimated(true)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func editTapped(sender:AnyObject){
        saveBtn.hidden = false
        name.userInteractionEnabled = true
        address.userInteractionEnabled = true
        mobile.userInteractionEnabled = true
        email.userInteractionEnabled = true
        pinCode.userInteractionEnabled = true

    }
    
    @IBAction func saveTapped(sender:AnyObject){
        self.updateData()
        displayAlert(PROFILE_UPDATION_MSG)
        
    }
    
    
    func displayAlert(message:String){
        
        let alert = UIAlertController(title: ALERT,message: message,preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: OKAY, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    //MARK Textfield Delegates
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
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

}
