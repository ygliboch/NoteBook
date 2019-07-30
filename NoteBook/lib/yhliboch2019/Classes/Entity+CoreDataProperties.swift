//
//  Entity+CoreDataProperties.swift
//  yhliboch2019_Example
//
//  Created by Yaroslava HLIBOCHKO on 7/4/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var tille: String?
    @NSManaged public var content: String?
    @NSManaged public var language: String?
    @NSManaged public var image: NSData?
    @NSManaged public var creation: NSDate?
    @NSManaged public var modification: NSDate?

    override public var description: String {
        return "\(tille ?? "error")\n \(content ?? "error")\n \(language ?? "error")\n \(image?.description ?? "error")\n \(creation?.description ?? "error")\n \(modification?.description ?? "error")\n"
    }
    
}
