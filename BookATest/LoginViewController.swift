//
//  LoginViewController.swift
//  BookATest
//
//  Created by Rasika on 6/23/18.
//  Copyright © 2018 Rasika. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
        userName.delegate = self
        password.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
        userName.text = ""
        password.text = ""
    }
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func loginTapped(sender:AnyObject){
        
        let userNameValue = userName.text
        let passwordValue = password.text
        
        let userNameDefault = NSUserDefaults.standardUserDefaults().stringForKey("userName")
        let passwordDefault = NSUserDefaults.standardUserDefaults().stringForKey("password")
        
        if (userNameValue == userNameDefault)
        {
            if (passwordValue == passwordDefault){
        
                //Login is successful
                let loginVC = BaseTabViewController(nibName: "BaseTabViewController", bundle: nil)
                self.navigationController?.pushViewController(loginVC, animated: true)
                
            }
        }
        else
        {
            displayAlert(INVALID_USER_CREDENTIALS)
        }
    }
    
    @IBAction func registerTapped(sender:AnyObject){
        
        let loginVC = RegisterationViewController(nibName: "RegisterationViewController", bundle: nil)
        loginVC.isProfile = false
        self.navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
    func displayAlert(message:String){
        
        let alert = UIAlertController(title: ALERT,message: message,preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: OKAY , style: UIAlertActionStyle.Default, handler: nil))
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
    

}
