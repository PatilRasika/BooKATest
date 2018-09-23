//
//  Constants.swift
//  BookATest
//
//  Created by Rasika on 6/25/18.
//  Copyright © 2018 Rasika. All rights reserved.
//

import Foundation
import UIKit





//LOGIN

let INVALID_USER_CREDENTIALS = "Invalid User or Register"
let ALERT = "Alert"
let OKAY = "OK"

//PROFILE AND REGISTERATION
let PROFILE_HEARDER = "Profile Account of User"
let REGISTER_HEARDER = "Register your account"
let PROFILE = "PROFILE"
let REGISTER = "REGISTER"
let NAME = "name"
let EMAIL = "email"
let ADDRESS = "address"
let MOBILE = "mobile"
let PINCODE = "pincode"
let NAME_ERROR_MSG = "First Name is too short (minimum is 2 characters)"
let ADDRESS_ERROR_MSG = "Address field cannot be empty."
let PINCODE_ERROR_MSG = "Please enter valid Pincode."
let EMAIL_ERROR_MSG = "Please enter valid EMAIL."
let MOBILE_ERROR_MSG = "Please enter valid Mobile Number."
let PASSWORD_ERROR_MSG = "Password field cannot be empty."
let CONFIRM_PASSWORD_ERROR_MSG = "Confirm password and password mismatch"
let VALUE_EMPTY_MSG = "Value cannot be empty"
let REGISTERATION_SUCCESS_MSG = "Registeration done successfully.Please login again to verify."
let PROFILE_UPDATION_MSG = "Your Profile is updated successfully."
let PROFILE_ENTITY = "Profile"
let ANIMATE_VIEW = "animateView"

//BOOKING
let BOOKING = "BOOKING"
let TEST_ERROR_MSG = "Test field cannot be empty"
let LOCATION_ERROR_MSG = "Location cannot be empty. Please enter valid location"
let ORDER_DETAIL_ENTITY = "OrderDetail"
let BOOKING_SUCCESS_MSG = "Your booking for test is done successfully"
let CANCEL = "Cancel"

//BASE TAB BAR
let ACCOUNT_IMAGE = "account"
let ACCOUNT_SELECTED_IMAGE = "accountHighlight"
let BOOKING_IMAGE = "booking"
let BOOKING_SELECTED_IMAGE = "bookSelected"
let ORDER_HISTORY_IMAGE = "orderHistory"
let ORDER_HISTORY_SELECTED_IMAGE = "orderHistorySelected"

//ORDER HISTORY
let ORDER_HISTORY = "Order History"
let ORDER_HISTORY_TITLE = "ORDER HISTORY"
let ORDER_CELL_IDENTIFIER = "OrderCell"

func checkForPassword(numbers: String) -> Bool {
    var isValidNum = false
    
    if(numbers.characters.count == 0 || numbers.characters.count >= 6 || numbers.isEmpty == true)
    {
        isValidNum = true
    }
    
    return isValidNum
}

func checkForValidEMAIL(numbers: String) -> Bool {
    var isValidNum = false
    let PHONE_REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    isValidNum =  phoneTest.evaluateWithObject(numbers)
    if(numbers.characters.count == 0)
    {
        isValidNum = true
    }
    
    return isValidNum
}

func checkForPostcode(numbers: String) -> Bool {
    var isValidNum = false
    
    if(numbers.characters.count == 0 || numbers.characters.count == 6 || numbers.isEmpty == true)
    {
        isValidNum = true
    }
    
    return isValidNum
}

func dateToString(date:NSDate)-> String
{
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    let stringDate: String = dateFormatter.stringFromDate(date)
    return stringDate
}



func stringToDate(date:String) -> NSDate{
    
    let dateFormatter = NSDateFormatter()
    // Our date format needs to match our input string format
    dateFormatter.dateFormat = "MMM d, yyyy"
    
    let dateFromString = dateFormatter.dateFromString(date)
    
    return dateFromString!
}

