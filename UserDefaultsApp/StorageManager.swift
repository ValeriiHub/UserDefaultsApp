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
    
    private let documetDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! // - путь к папке documets В которой будет находиться файл
    private var archiveURL: URL!
    
    init() {
        archiveURL = documetDirectory.appendingPathComponent("User").appendingPathExtension("plist") // путь к новому файлу User.plist по пути documetDirectory
    }
    
    //MARK: - JSON
    // если данные проходят по ключу к UserDefaults, то декодируем эти данные с помощью JSONDecoder и присваиваем объекту user
    func getUser() -> User {
        guard let saveUser = defaults.object(forKey: "savedUser") as? Data else { return user }
        guard let loader = try? JSONDecoder().decode(User.self, from: saveUser) else { return user }
        user = loader
        return user
    }
    
    // кодируем данные с помощью JSONEncoder и присваиваем ключ для UserDefaults
    func saveUser(_ user: User) {
        guard let userEncoded = try? JSONEncoder().encode(user) else { return }
        defaults.set(userEncoded, forKey: "savedUser")
    }
    
    //MARK: - PropertyList
    // кодируем данные в файл PropertyList
    func saveUserToFile(_ user: User) {
        guard let encodedUser = try? PropertyListEncoder().encode(user) else { return }   //  используем PropertyListEncoder() для кодирования
        try? encodedUser.write(to: archiveURL, options: .noFileProtection)
    }
    
    // восстанавливать данные с PropertyList файла
    func getUserFromFile() -> User {
        guard let savedUser = try? Data(contentsOf: archiveURL) else { return user}
        guard let loadedUser = try? PropertyListDecoder().decode(User.self, from: savedUser) else { return user } // используем PropertyListDecoder() для декодирования
        user = loadedUser
        return user
    }
}
