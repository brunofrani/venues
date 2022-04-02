//
//  ManagedResponse+CoreDataProperties.swift
//  Venues
//
//  Created by Bruno Frani on 2.4.22.
//
//

import Foundation
import CoreData

extension ManagedResponse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedResponse> {
        return NSFetchRequest<ManagedResponse>(entityName: "ManagedResponse")
    }

    @NSManaged public var confident: Bool
    @NSManaged public var venueList: ManagedVenueList?
    @NSManaged public var venue: Set<ManagedVenue>?

}

// MARK: Generated accessors for venue
extension ManagedResponse {

    @objc(addVenueObject:)
    @NSManaged public func addToVenue(_ value: ManagedVenue)

    @objc(removeVenueObject:)
    @NSManaged public func removeFromVenue(_ value: ManagedVenue)

    @objc(addVenue:)
    @NSManaged public func addToVenue(_ values: Set<ManagedVenue>)

    @objc(removeVenue:)
    @NSManaged public func removeFromVenue(_ values: NSSet)

}

extension ManagedResponse: Identifiable {

}
