//
//  Model.swift
//  RickAndMorty
//
//  Created by Tchariss on 15.04.2022.
//

import Foundation

// MARK: - CharacterModel
struct CharacterModel: Codable {
    let info: Info?
    let results: [Result]?
}

// MARK: - Info
struct Info: Codable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
    let name: String // имя
    let status: String
    let species: String // раса
    let gender: String // пол
    let location: Location?
    let image: String? // аватар
    let episode: [String?] // кол-во эпизодов
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}
