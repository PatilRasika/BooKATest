//
//  Profile+CoreDataProperties.swift
//  BookATest
//
//  Created by Anamika on 6/24/18.
//  Copyright © 2018 Rasika. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Profile {

    @NSManaged var name: String?
    @NSManaged var address: String?
    @NSManaged var pincode: String?
    @NSManaged var mobile: String?
    @NSManaged var email: String?

}
