//
//  Emoticon+CoreDataProperties.swift
//  Emoticon_test
//
//  Created by 안현정 on 2021/09/23.
//
//

import Foundation
import CoreData


extension Emoticon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Emoticon> {
        return NSFetchRequest<Emoticon>(entityName: "Emoticon")
    }

    @NSManaged public var content: String?

}

extension Emoticon : Identifiable {

}
