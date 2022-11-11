//
//  ManagedFeedItem.swift
//  TelkomselModule
//
//  Created by Amin faruq on 11/11/22.
//

import CoreData

@objc(ManagedFeedItem)
internal class ManagedFeedItem: NSManagedObject {
    @NSManaged internal var colorTheme: String
    @NSManaged internal var desc: String
    @NSManaged internal var latestVersion: String
    @NSManaged internal var productLogo: URL
    @NSManaged internal var productName: String
    @NSManaged internal var publisher: String
    @NSManaged internal var rating: Double
    @NSManaged internal var data: Data?
}

extension ManagedFeedItem {
    static func data(with url: URL, in context: NSManagedObjectContext) throws -> Data? {
        if let data = context.userInfo[url] as? Data { return data }

        return try first(with: url, in: context)?.data
    }

    static func first(with url: URL, in context: NSManagedObjectContext) throws -> ManagedFeedItem? {
        let request = NSFetchRequest<ManagedFeedItem>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ManagedFeedItem.productLogo), url])
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        return try context.fetch(request).first
    }

    internal static func items(from localFeed: [LocalFeedItem], in context: NSManagedObjectContext) -> NSOrderedSet {
        let images = NSOrderedSet(array: localFeed.map { local in
            let managed = ManagedFeedItem(context: context)
            managed.productName = local.productName
            managed.productLogo = local.productLogo
            managed.desc = local.description
            managed.rating = local.rating
            managed.latestVersion = local.latestVersion
            managed.publisher = local.publisher
            managed.colorTheme = local.colorTheme
            managed.data = context.userInfo[local.productLogo] as? Data
            return managed
        })
        context.userInfo.removeAllObjects()
        return images
    }

    internal var local: LocalFeedItem {
        return LocalFeedItem(productName: productName, productLogo: productLogo, description: description, rating: rating, latestVersion: latestVersion, publisher: publisher, colorTheme: colorTheme)
    }

    override func prepareForDeletion() {
        super.prepareForDeletion()

        managedObjectContext?.userInfo[productLogo] = data
    }
}
