//
//  User.swift
//  UserDefaultsApp
//
//  Created by Valerii D on 13.07.2021.
//

import Foundation

struct User: Codable {
    var name = "User"
    var surname = "Name"
    
    var encoded: Data? {
        let encoder = PropertyListEncoder()         // кодировщик в PropertyList
        return try? encoder.encode(self)            // кодируем структуру в PropertyList
    }
    
    init?(from data: Data) {
        let decoder = PropertyListDecoder()        // кодировщик c PropertyList
        guard let user = try? decoder.decode(User.self, from: data) else { return nil } // создаем экземпляр модели с закодированных данных
        name = user.name
        surname = user.surname
    }
    init() {}
}
