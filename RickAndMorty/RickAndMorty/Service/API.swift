//
//  File.swift
//  RickAndMorty
//
//  Created by Tchariss on 15.04.2022.
//

import Foundation

class API {
    
    var nextPage: String? = "https://rickandmortyapi.com/api/character"
    
    func createRequest(completion: @escaping (Swift.Result<CharacterModel, Error>) -> Void) {
        
        guard let nextPage = nextPage else { return }
        guard let url = URL(string: nextPage) else { return } // URL
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error :", error)
                completion(.failure(error))
            }

            if let data = data {
                do {
                    let character = try JSONDecoder().decode(CharacterModel.self, from: data)
                    self.nextPage = character.info?.next
                    completion(.success(character))
                } catch let error {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}
