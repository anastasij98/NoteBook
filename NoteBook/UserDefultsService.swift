//
//  UserDefultsService.swift
//  NoteBook
//
//  Created by LUNNOPARK on 17.04.23.
//

import Foundation

protocol UserDefultsServiceProtocol {
    
    /// saveNotes
    /// - Parameters:
    ///   - note: передаваемый массив для кодирования и сохранения в userDefults
    ///   - key: ключ, под которым будет доступ к массиву
    func saveNotes(note: [NoteModel], key: String)
    
    /// getNotes
    /// - Parameters:
    ///   - key: ключ, по которому можно получить доступ к массиву
    ///   - completion: замыкание, передающие раскодрованный массив
    func getNotes(key: String,
                  completion: @escaping ([NoteModel]) -> Void)
}

class UserDefultsService {
    
}

extension UserDefultsService: UserDefultsServiceProtocol {
    
    func saveNotes(note: [NoteModel], key: String) {
        if let encoded = try? JSONEncoder().encode(note) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
        print("encoded")
    }
    
    func getNotes(key: String,
                  completion: @escaping ([NoteModel]) -> Void) {
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
            do {
                let decoded = try JSONDecoder().decode([NoteModel].self, from: data)
                completion(decoded)
            } catch  {
                print(error)
            }
        }
    }
}



