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
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SaveInfoFromFirebase> = SaveInfoFromFirebase.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            if let userInfo = results.first {
                userInfo.newName = newName
            } else {
                let newUser = SaveInfoFromFirebase(context: context)
                newUser.newName = newName
            }
            
            try context.save()
            print("Данные успешно сохранены в Core Data")
        } catch {
            print("Error saving: \(error)")
        }
    }
    
}
