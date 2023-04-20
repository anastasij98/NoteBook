//
//  UserDefultsService.swift
//  NoteBook
//
//  Created by LUNNOPARK on 17.04.23.
//

import Foundation

protocol UserDefultsServiceProtocol {
    
    /// saveNotes - метод, передающий массив данных в userDefaults
    /// - Parameters:
    ///   - note: передаваемый массив для кодирования и сохранения в userDefults
    func saveNotes(note: [NoteModel])
    
    /// getNotes - метод, возвращающий массив данных из userDefaults
    func getNotes() -> [NoteModel]

}

class UserDefultsService {
    
    var noteKey = "keyNotes"
}

extension UserDefultsService: UserDefultsServiceProtocol {
    
    func saveNotes(note: [NoteModel]) {
        if let encoded = try? JSONEncoder().encode(note) {
            UserDefaults.standard.set(encoded, forKey: noteKey)
        }
    }

    func getNotes() -> [NoteModel] {
        var decodedData = [NoteModel]()
        if let data = UserDefaults.standard.object(forKey: noteKey) as? Data {
            do {
                let decoded = try JSONDecoder().decode([NoteModel].self, from: data)
                decodedData = decoded
            } catch {
                print(error)
            }
        }
        return decodedData
    }
}



