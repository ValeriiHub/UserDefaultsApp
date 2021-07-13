//
//  StorageManager.swift
//  UserDefaultsApp
//
//  Created by Valerii D on 13.07.2021.
//

import Foundation

class StorageManager{
    static let shared = StorageManager()
    
    private var user = User()
    private let defaults = UserDefaults.standard
    
    private let documetDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! // - путь к папке documets
    private var archiveURL: URL!
    
    init() {
        archiveURL = documetDirectory.appendingPathComponent("User").appendingPathExtension("plist")
    }
    
    // если данные проходят по ключу к UserDefaults, то декодируем эти данные и присваиваем объекту user
    func getUser() -> User {
        guard let saveUser = defaults.object(forKey: "savedUser") as? Data else { return user }
        guard let loader = try? JSONDecoder().decode(User.self, from: saveUser) else { return user }
        user = loader
        return user
    }
    
    // кодируем данные в Джейсон и присваиваем ключ для UserDefaults
    func saveUser(_ user: User) {
        guard let userEncoded = try? JSONEncoder().encode(user) else { return }
        defaults.set(userEncoded, forKey: "savedUser")
    }
    
    
    // кодируем данные в файл PropertyList
    func saveUserToFile(_ user: User) {
        let encoder = PropertyListEncoder()
        guard let encodedUser = try? encoder.encode(user) else { return }
        try? encodedUser.write(to: archiveURL, options: .noFileProtection)
    }
    
    // восстанавливать данные с PropertyList файла
    func getUserFromFile() -> User {
        guard let savedUser = try? Data(contentsOf: archiveURL) else { return user}
        let decoder = PropertyListDecoder()
        guard let loadedUser = try? decoder.decode(User.self, from: savedUser) else { return user }
        user = loadedUser
        return user
    }
}

