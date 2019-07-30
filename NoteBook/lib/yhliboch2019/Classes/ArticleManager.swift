//
//  ArticleManager.swift
//  yhliboch2019_Example
//
//  Created by Yaroslava HLIBOCHKO on 7/4/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class ArticleManager {
    private let context: NSManagedObjectContext = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let applicationDocumentsDirectory = urls.last!
        let podBundle = Bundle(for: ArticleManager.self)
        let modelURL = podBundle.url(forResource: "article", withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
        let url = applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        try! coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    public init() {}
    
    public func save() {
        try! context.save()
    }
    
    public func newArticle() -> Entity {
        var article : Entity!
        context.performAndWait {
            let ent = NSEntityDescription.entity(forEntityName: "Entity", in: self.context)!
            article = Entity(entity: ent, insertInto: self.context)
        }
        return article
    }
    
    public func getAllArticles() -> [Entity] {
        var articles : [Entity]!
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        context.performAndWait {
            articles = try! self.context.fetch(request) as! [Entity]
        }
        return articles
    }
    
    public func getArticles(withLang lang: String) -> [Entity] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.predicate = NSPredicate(format: "language == %@", lang)
        var articles : [Entity]!
        context.performAndWait {
            articles = try! self.context.fetch(request) as! [Entity]
        }
        return articles.sorted(by: {$0.creation!.compare($1.creation! as Date) == ComparisonResult.orderedDescending})
    }
    
    public func getArticles(containString str: String) -> [Entity] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.predicate = NSPredicate(format: "content contains[c] %@", str)
        var articles : [Entity]!
        context.performAndWait {
            articles = try! self.context.fetch(request) as! [Entity]
        }
        return articles.sorted(by: {$0.creation!.compare($1.creation! as Date) == ComparisonResult.orderedDescending})
    }
    
    public func removeArticle(article: Entity) {
        context.performAndWait{
            self.context.delete(article)
        }
    }
}
