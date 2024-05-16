//
//  DataManager.swift
//  MDCH
//
//  Created by 123 on 14.04.24.
//

import UIKit
import CoreData


class DataManager: NSManagedObject, Encodable {
    @NSManaged var newName: String
}
