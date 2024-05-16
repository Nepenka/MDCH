//
//  SaveInfo.swift
//  MDCH
//
//  Created by 123 on 14.04.24.
//

import UIKit
import CoreData


class SaveInfo {
    
    static let shared = SaveInfo()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SaveInfoModel")
        container.loadPersistentStores(completionHandler: { _ , error in
            if let error = error {
                fatalError("Failed to load CoreData stack \(error)")
            }
            
        })
        return container
    }()
    
    func saveNewUserName(newName: String) {
        let context = persistentContainer.newBackgroundContext()
        
        context.perform {
            let saveInfoFromFirebase = SaveInfoFromFirebase(context: context)
            saveInfoFromFirebase.newName = newName
        }
        
        do {
                try context.save()
                print("Данные успешно сохранены в Core Data")
        }catch {
             print("Error saving: \(error)")
        }
    }
}
