//
//  NetworkError.swift
//  Pokedex
//
//  Created by Frederic Rey Llanos on 09/05/2022.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badData
    case badServerResponse(Int)
    case decodeError(String)
    case generalError(Error)
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return NSLocalizedString("Bad URL, could not convert input string to a URL", comment: "Bad URL")
        case .badData:
            return NSLocalizedString("Bad Data, the data was corrupted or missing", comment: "Bad Data")
        case .badServerResponse(let statusCode):
            return NSLocalizedString("The network was not successful, received error code \(statusCode)", comment: "Bad Server Response")
        case .decodeError(let message):
            return NSLocalizedString("Decoding failure. Something is missing in the model object or incorrect. Decoding message: \(message)", comment: "Decode Error")
        case .generalError(let err):
            return NSLocalizedString("General Error that is unknown. Logged info: \(err)", comment: "General Error")
        }
    }
    
}
