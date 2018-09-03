//
//  HistoryViewModel.swift
//  WatsonTranslator
//
//  Created by Сергей on 02/09/2018.
//  Copyright © 2018 Сергей Кононов. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class HistoryViewModel {
    
    var coreDataObject = [HistoryModel]()
    
    init() {
        fetchData()
    }
    
    func saveToCD(name: HistoryModel) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "History",
                                       in: managedContext)!
        
        let data = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        data.setValue(name.currentText, forKeyPath: "currentText")
        data.setValue(name.currentLanguage, forKeyPath: "currentLanguage")
        data.setValue(name.translatedText, forKeyPath: "translatedText")
        data.setValue(name.translatedLanguage, forKeyPath: "translatedLanguage")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "History")
        var data = [NSManagedObject]()
        do {
            data = try managedContext.fetch(fetchRequest)
            create(data: data)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    private func create(data: [NSManagedObject]) {
        coreDataObject = []
        for item in data {
            coreDataObject.append(HistoryModel(currentText: item.value(forKeyPath: "currentText") as! String,
                                       currentLanguage: item.value(forKeyPath: "currentLanguage") as! String,
                                       translatedText: item.value(forKeyPath: "translatedText") as! String,
                                       translatedLanguage: item.value(forKeyPath: "translatedLanguage") as! String))
        }
    }
    
    func clearEntity() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            self.coreDataObject = []
        } catch {
            print ("There was an error")
        }
    }
    
    
    
    
}
