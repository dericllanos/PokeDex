//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Frederic Rey Llanos on 09/05/2022.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseURL = "https://pokeapi.co/api/v2/"

}

extension NetworkManager {
    
    func fetchData(page: Int, completion: @escaping (Result<PageResult, Error>) -> Void) {
        guard let url = URL(string: baseURL + "pokemon?limit=151&offset=0") else { completion(.failure(NetworkError.badURL))
            return }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.badServerResponse(httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }

            do {
                let pageResult = try JSONDecoder().decode(PageResult.self, from: data)
                completion(.success(pageResult))
            } catch {
                completion(.failure(NetworkError.decodeError("\(error)")))
            }
        }.resume()
    }
    
    func fetchShiny(spritePath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(spritePath).png") else {
            completion(.failure(NetworkError.badURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.badServerResponse(httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }

            completion(.success(data))

        }.resume()
    }

    func fetchSprites(spritePath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(spritePath).png") else {
            completion(.failure(NetworkError.badURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.badServerResponse(httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }

            completion(.success(data))

        }.resume()
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
}
