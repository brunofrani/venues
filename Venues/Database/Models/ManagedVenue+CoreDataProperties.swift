//
//  ManagedVenue+CoreDataProperties.swift
//  Venues
//
//  Created by Bruno Frani on 2.4.22.
//
//

import Foundation
import CoreData
// swiftlint:disable identifier_name
extension ManagedVenue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedVenue> {
        return NSFetchRequest<ManagedVenue>(entityName: "ManagedVenue")
    }

    @NSManaged public var allwMenuUrlEdit: Bool
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var canonicalName: String?
    @NSManaged public var response: ManagedResponse?

}

extension ManagedVenue: Identifiable {

}
