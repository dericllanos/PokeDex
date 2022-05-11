//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Frederic Rey Llanos on 10/05/2022.
//

import Foundation

struct PokemonDetails: Decodable {
    var abilities: [Ability]
    var moves: [Moves]
    var baseExperience: Int?
    var forms: [BasicData]
    var gameIndices: [GameIndex]?
    var height: Int
    var id: Int
    var isDefault: Bool?
    var locationAreaEncounters: String?
    var name: String
    var order: Int
    var sprites: Sprites
    var types: [Types]
    var weight: Int
    
    // Note: Do not forget the first is plural, the last is singular
    enum Codingkeys: String, CodingKey {
        case baseExperience = "base_experience"
        case gameIndices = "game_indices"
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case abilities, forms, height, id
        case moves, name, order, species
        case sprites, stats, types, weight
    }
}

struct Sprite: Decodable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "front_default"
    }
}

struct Ability: Decodable {
    let ability: BasicData
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case ability, slot
    }
}

struct Moves: Decodable {
    let move: BasicData
}

struct Types: Decodable {
    let slot: Int
    let type: BasicData
}

struct Sprites: Decodable {
    var backDefault: String?
    var backFemale: String?
    var backShiny: String?
    var backShinyFemale: String?
    var frontDefault: String?
    var frontFemale: String?
    var frontShiny: String?
    var frontShinyFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

struct GameIndex: Decodable {
    var gameIndex: Int
    var version: BasicData
    
    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

struct Stat: Decodable {
    let baseStat: Int
    let stat: BasicData
    
    private enum CodingKeys: String, CodingKey {
        case stat
        case baseStat = "base_stat"
    }
}

struct BasicData: Decodable {
    let name: String
    let url: String
}

func parsePokemonManually(baseDict: [String: Any]) -> PokemonDetails? {
    // Abilities
    guard let abilitiesArr = baseDict["abilities"] as? [[String: Any]] else {
        print("Failed: AbilitiesArr")
        return nil
    }
    var actualAbilities: [Ability] = []
    abilitiesArr.forEach {
        guard let abilityDict = $0["ability"] as? [String: Any] else {
            print("Failed: Ability Dict")
            return
        }
        guard let ability = createBasicData(dict: abilityDict) else { return }
        guard let isHidden = $0["is_hidden"] as? Bool else { return }
        guard let slot = $0["slot"] as? Int else { return }
        actualAbilities.append(Ability(ability: ability, isHidden: isHidden, slot: slot))
    }
    
    guard let typesArr = baseDict["types"] as? [[String: Any]] else { return nil }
    var types: [Types] = []
    typesArr.forEach{
        guard let slot = $0["slot"] as? Int else { return }
        guard let typeDict = $0["type"] as? [String: Any] else { return }
        guard let typeBasicData = createBasicData(dict: typeDict) else { return }
        types.append(Types(slot: slot, type: typeBasicData))
     }
    //Getting the sprites
    guard let spritesDict = baseDict["sprites"] as? [String: Any] else { return nil }
    let backDefault = spritesDict["back_default"] as? String
    let backFemale = spritesDict["back_female"] as? String
    let backShiny = spritesDict["back_shiny"] as? String
    let backShinyFemale = spritesDict["back_shiny_female"] as? String
    let frontDefault = spritesDict["front_default"] as? String
    let frontFemale = spritesDict["front_female"] as? String
    let frontShiny = spritesDict["front_shiny"] as? String
    let frontShinyFemale = spritesDict["front_shiny_female"] as? String
    let sprites = Sprites(backDefault: backDefault, backFemale: backFemale, backShiny: backShiny, backShinyFemale: backShinyFemale, frontDefault: frontDefault, frontFemale: frontFemale, frontShiny: frontShiny, frontShinyFemale: frontShinyFemale)
    
    // Moves
    guard let movesArr = baseDict["moves"] as? [[String: Any]] else {
        return nil
    }
    var moveIndeces: [Moves] = []
    movesArr.forEach {
        guard let moves_ = $0["move"] as? [String: Any] else { return }
        guard let _moves = createBasicData(dict: moves_) else { return }
        moveIndeces.append(Moves(move: _moves))
    }
    
    let baseExp = 0
    let basicForms: [BasicData] = []
    let gameIndeces: [GameIndex] = []
    let height = 0
    let id = 0
    let isDefault = true
    let locations = ""
    let name = ""
    let order = 0
    guard let weight = baseDict["weight"] as? Int else { return nil }
    
    return PokemonDetails(abilities: actualAbilities, moves: moveIndeces, baseExperience: baseExp, forms: basicForms, gameIndices: gameIndeces, height: height, id: id, isDefault: isDefault, locationAreaEncounters: locations, name: name, order: order, sprites: sprites, types: types, weight: weight)
}

func createBasicData(dict: [String: Any]) -> BasicData? {
    guard let name = dict["name"] as? String else { return nil }
    guard let url = dict["url"] as? String else { return nil }
    return BasicData(name: name, url: url)
}

func fetchDetails(url: String) -> PokemonDetails? {
    guard let urlToSend = URL(string: url) else { return nil }
    do {
        let data = try Data(contentsOf: urlToSend)
        let jsonObj = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        guard let baseDict = jsonObj as? [String: Any] else { return nil }
        return parsePokemonManually(baseDict: baseDict)
    } catch {
        print(error)
    }
    return nil
}

