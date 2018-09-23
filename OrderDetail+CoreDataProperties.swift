//
//  OrderDetail+CoreDataProperties.swift
//  BookATest
//
//  Created by Rasika on 6/24/18.
//  Copyright © 2018 Rasika. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension OrderDetail {

    @NSManaged var date: NSDate?
    @NSManaged var firstName: String?
    @NSManaged var testName: String?

}
