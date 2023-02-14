//
//  ProductService.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import Foundation
import CoreData

final class ProductService: CoreDataService {
    private let productEntity: String = "Product"
    private var products: [Product] = []

    func saveProduct(name: String,
                     value: Double,
                     isCard: Bool,
                     image: Data?,
                     state: State) -> [Product] {
        guard let context = context else {return []}
        let product = Product(context: context)
        product.name = name
        product.value = value
        product.isCard = isCard
        product.photo = image
        product.state = state
        do {
            try context.save()
            return loadProducts()
        } catch {
            print("Error - DataManagerProduct - saveProduct()")
            return []
        }
    }

    func loadProducts() -> [Product] {
        guard let context = context else { return [] }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: productEntity)
        let result = try? context.fetch(request)
        products = result as? [Product] ?? []
        return products
    }

    func deleteProduct(id: NSManagedObjectID) -> [Product] {
        guard let context = context else { return [] }
        let object = context.object(with: id)

        context.delete(object)
        do {
            try context.save()
            return loadProducts()
        } catch {
            return []
        }
    }

    func editProduct(id: NSManagedObjectID,
                   name: String,
                   value: Double,
                   isCard: Bool,
                   image: Data?,
                   state: State) -> [Product] {
        guard let context = context else { return [] }
        let object = context.object(with: id) as? Product
        object?.name = name
        object?.value = value
        object?.isCard = isCard
        object?.photo = image
        object?.state = state

        do {
            try context.save()
            return loadProducts()
        } catch {
            return []
        }
    }
}
