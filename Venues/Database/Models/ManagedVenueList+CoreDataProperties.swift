//
//  ManagedVenueList+CoreDataProperties.swift
//  Venues
//
//  Created by Bruno Frani on 2.4.22.
//
//

import Foundation
import CoreData

extension ManagedVenueList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedVenueList> {
        return NSFetchRequest<ManagedVenueList>(entityName: "ManagedVenueList")
    }

    @NSManaged public var response: ManagedResponse?

}

extension ManagedVenueList: Identifiable {

}
