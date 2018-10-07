//
//  DateDescription+CoreDataProperties.swift
//  CoreData_Add_Update_Delete
//
//  Created by Sujananth on 10/7/18.
//  Copyright © 2018 sujananth. All rights reserved.
//
//

import Foundation
import CoreData


extension DateDescription {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DateDescription> {
        return NSFetchRequest<DateDescription>(entityName: "DateDescription")
    }

    @NSManaged public var dateInfo: String?
    @NSManaged public var additionalInfo: String?

}
