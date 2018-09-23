//
//  BaseTabViewController.swift
//  BookATest
//
//  Created by Rasika on 6/24/18.
//  Copyright © 2018 Rasika. All rights reserved.
//

import UIKit

class BaseTabViewController: UITabBarController {

    var bookingController: BookingTestViewController?
    var registerController: RegisterationViewController?
    var orderController: OrderHistoryViewController?
    
    var subViewControllers:[UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        tabBar.barTintColor = UIColor(red: 85.0/255.0, green: 181.0/255.0, blue: 221.0/255.0, alpha: 1.0)

        
        bookingController = BookingTestViewController()
        registerController = RegisterationViewController()
        orderController = OrderHistoryViewController()
        
        subViewControllers.append(registerController!)
        subViewControllers.append(bookingController!)
        subViewControllers.append(orderController!)
        
        registerController?.tabBarItem.title = PROFILE
        registerController?.isProfile = true
        registerController?.tabBarItem.image = UIImage(named: ACCOUNT_IMAGE)?.imageWithRenderingMode(.AlwaysOriginal)
        registerController?.tabBarItem.selectedImage = UIImage(named: ACCOUNT_SELECTED_IMAGE)!.imageWithRenderingMode(.AlwaysOriginal)
        registerController?.tabBarItem.tag = 0
        
        bookingController?.tabBarItem.title = BOOKING
        bookingController?.tabBarItem.image = UIImage(named: BOOKING_IMAGE)?.imageWithRenderingMode(.AlwaysOriginal)
        bookingController?.tabBarItem.selectedImage = UIImage(named: BOOKING_SELECTED_IMAGE)!.imageWithRenderingMode(.AlwaysOriginal)
        bookingController?.tabBarItem.tag = 1
        
        orderController?.tabBarItem.title = ORDER_HISTORY_TITLE
        orderController?.tabBarItem.image = UIImage(named: ORDER_HISTORY_IMAGE)?.imageWithRenderingMode(.AlwaysOriginal)
        orderController?.tabBarItem.selectedImage = UIImage(named: ORDER_HISTORY_SELECTED_IMAGE)!.imageWithRenderingMode(.AlwaysOriginal)
        orderController?.tabBarItem.tag = 2
        
        self.setViewControllers(subViewControllers, animated: true)
        self.selectedIndex = 0
        self.selectedViewController = registerController
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
