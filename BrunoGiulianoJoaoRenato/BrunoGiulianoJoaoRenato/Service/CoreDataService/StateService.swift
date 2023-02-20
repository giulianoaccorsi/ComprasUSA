//
//  StateService.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import Foundation
import CoreData

final class StateService: CoreDataService {
    private let stateEntity: String = "State"
    private var states: [State] = []
    
    func saveState(name: String, tax: Double) -> [State] {
        guard let context = context else { return [] }
        let state = State(context: context)
        state.name = name
        state.tax = tax
        do {
            try context.save()
            return loadStates()
        } catch {
            print("Error - DataManagerState - saveState()")
            return []
        }
    }
    
    func loadStates() -> [State] {
        guard let context = context else { return [] }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: stateEntity)
        let result = try? context.fetch(request)
        states = result as? [State] ?? []
        return states
    }
    
    func deleteState(id: NSManagedObjectID) -> [State] {
        guard let context = context else { return [] }
        let object = context.object(with: id)
        
        context.delete(object)
        do {
            try context.save()
            return loadStates()
        } catch {
            return []
        }
    }

    func getState(id: NSManagedObjectID) -> State? {
        let object = context?.object(with: id) as? State
        return object

    }
    
    func editState(id: NSManagedObjectID, newName: String, newTax: Double) -> [State] {
        guard let context = context else { return [] }
        let object = context.object(with: id) as? State
        object?.name = newName
        object?.tax = newTax
        
        do {
            try context.save()
            return loadStates()
        } catch {
            return []
        }
    }
}
