//
//  PersistenceService.swift
//  Venues
//
//  Created by Bruno Frani on 1.4.22.
//

import Foundation
import CoreData

class PersistenceService {

  let persistentContainer: NSPersistentContainer

  init(persistentContainer: NSPersistentContainer) {
    self.persistentContainer = persistentContainer
    self.persistentContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
  }

  func saveVenuesList(_ venuesList: VenuesList) throws {
    guard let response = venuesList.response else {
      throw AppError(title: "Core Data Error", description: "Can't unwrap response from venues list")
    }

    let managedVenuesList = ManagedVenueList(context: persistentContainer.viewContext)

    let managedResponse = try parseToManagedResponse(response, context: persistentContainer.viewContext)
    managedVenuesList.response = managedResponse

    try persistentContainer.viewContext.save()
  }
}

// MARK: Helper functions
extension PersistenceService {

  func parseToManagedResponse(_ response: Response, context: NSManagedObjectContext) throws -> ManagedResponse {
    guard let venues = response.venues else {
      throw AppError(title: "Core Data Error", description: "Can't unwrap venues array from response")
    }

    let managedResponse = ManagedResponse(context: context)
    managedResponse.confident = response.confident ?? false

    let managedVenues = try venues.map { venue -> ManagedVenue in
      return try parseToManagedVenue(venue, context: context)
    }
    managedResponse.venue = Set(managedVenues)
    return managedResponse
  }

  func parseToManagedVenue( _ venue: Venue, context: NSManagedObjectContext) throws -> ManagedVenue {
    // swiftlint:disable identifier_name
    guard let id = venue.id else {
      throw AppError(title: "Core Data Error", description: "Can't unrap id of venue")
    }
    let idPredicate = NSPredicate(format: "id == %@", id)

    let fetchRequest = ManagedVenue.fetchRequest()
    fetchRequest.predicate = idPredicate

    if let managedVenue = try persistentContainer.viewContext.fetch(fetchRequest).first {
      managedVenue.allwMenuUrlEdit = venue.allowMenuUrlEdit ?? false
      managedVenue.canonicalName = venue.canonicalName
      managedVenue.name = venue.name
      managedVenue.id = venue.id
      return managedVenue

    } else {

      let managedVenue = ManagedVenue(context: context)
      managedVenue.allwMenuUrlEdit = venue.allowMenuUrlEdit ?? false
      managedVenue.canonicalName = venue.canonicalName
      managedVenue.name = venue.name
      managedVenue.id = venue.id
      return managedVenue
    }
  }
}
