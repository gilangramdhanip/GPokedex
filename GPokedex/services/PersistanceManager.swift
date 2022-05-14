//
//  PersistanceManager.swift
//  GPokedex
//
//  Created by Gilang Ramdhani Putra on 12/05/22.
//

import CoreData

class PersitanceManager {
    
    static let shared = PersitanceManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "GPokedex")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func favoritePokemon(pokemonModel : DetailPokemonModel,  isFavorite: Bool, pokemonColor : PokemonColorModel, url : String) {
        
        do {
            let pokemon = Pokemon(context: persistentContainer.viewContext)
            pokemon.url = url
            pokemon.id = "\(pokemonModel.id)"
            pokemon.color = pokemonColor.color.name
            pokemon.type = pokemonModel.types[0].type.name
            pokemon.attack = "\(pokemonModel.stats[0].baseStat)"
            pokemon.deffense = "\(pokemonModel.stats[1].baseStat)"
            pokemon.hp = "\(pokemonModel.stats[2].baseStat)"
            pokemon.isFavorite = isFavorite
            pokemon.name = pokemonModel.name
            pokemon.image = pokemonModel.sprites.other?.home.frontDefault
            
            saveContext()
        }
        
    }
    
    func unFavoritePokemon(pokemon : Pokemon) {
        persistentContainer.viewContext.delete(pokemon)
        saveContext()
    }
    
    func fetchFavoritPokemon() -> [Pokemon] {
        let  request : NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        
        var pokemon : [Pokemon] = []
        
        do {
            pokemon = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching data")
        }
        
        return pokemon
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
