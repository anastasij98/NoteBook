//
//  UserDefaultsService.swift
//  NoteBook
//
//  Created by LUNNOPARK on 17.04.23.
//

import Foundation

protocol UserDefaultsServiceProtocol {
    func viewisReady()
}

class UserDefaultsService {
    
    var view: NoteBookViewController?
    

}

extension UserDefaultsService: UserDefaultsServiceProtocol {
    
    func viewisReady() {
        
    }
    
    @objc
    func addNewNote() {
        let nextVC = AddNoteViewController()
        navigationController?.pushViewController(nextVC, animated: true)
        
        nextVC.completion = {noteTitle, note in
            let model = NoteModel(title: noteTitle,
                                  text: note)
            self.view?.notes.append(model)

            if let encoded = try? JSONEncoder().encode(self.view?.notes) {
                UserDefaults.standard.set(encoded, forKey: self.view?.key)
            }
            
            self.tableView.reloadData()
        }
    }
}
