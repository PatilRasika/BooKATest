//
//  HomeViewController.swift
//  BookATest
//
//  Created by Rasika on 6/22/18.
//  Copyright © 2018 Rasika. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func profileTapped(sender:AnyObject){
        
        let loginVC = RegisterationViewController(nibName: "RegisterationViewController", bundle: nil)
        loginVC.isProfile = true
        self.navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
    @IBAction func bookingTapped(sender:AnyObject){
        
        let loginVC = BookingTestViewController(nibName: "BookingTestViewController", bundle: nil)
        self.navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
    @IBAction func orderHistoryTapped(sender:AnyObject){
        
        let loginVC = OrderHistoryViewController(nibName: "OrderHistoryViewController", bundle: nil)
        self.navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
