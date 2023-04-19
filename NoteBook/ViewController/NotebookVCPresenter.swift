//
//  ViewControllerPresenter.swift
//  NoteBook
//
//  Created by LUNNOPARK on 17.04.23.
//

import Foundation

struct NoteModel: Codable {
    let title: String
    let text: String
}

protocol NotebookVCPresenterProtocol {
    
    func viewIsReady()
    func goToViewController()
    func viewWillAppear()
    func getNotesCount() -> Int
    func getItem(index: Int) -> NoteModel
    func deleteRow(index: Int,
                   completion: () -> Void)
}

class NotebookVCPresenter {
    
    weak var view: NoteBookViewControllerProtocol?
    var router: NotebookVCRouterProtocol
    var usersdefaultService: UserDefultsServiceProtocol
    
    
    var noteKey = "keyNotes"
    var notes: [NoteModel] = []
    
    init(view: NoteBookViewControllerProtocol? = nil,
         router: NotebookVCRouterProtocol,
         usersdefaultService: UserDefultsServiceProtocol) {
        self.view = view
        self.router = router
        self.usersdefaultService = usersdefaultService
    }
}

extension NotebookVCPresenter: NotebookVCPresenterProtocol {
    
    func viewIsReady() {
        notes = usersdefaultService.getNotes()
    }
    
    func goToViewController() {
        router.goToAddNoteViewController { noteTitle, note in
            let model = NoteModel(title: noteTitle,
                                  text: note)
            self.notes.append(model)
            self.usersdefaultService.saveNotes(note: self.notes)
            self.view?.reloadTableView()
        }
    }

    func viewWillAppear() {
        if notes.isEmpty {
            view?.notesInTableView(notesAreInMemory: true)
        } else {
            view?.notesInTableView(notesAreInMemory: false)
        }
    }
    
    func getNotesCount() -> Int {
        notes.count
    }
    
    func getItem(index: Int) -> NoteModel {
        notes[index]
    }
    
//    func deleteRow(index: Int, indexPath: IndexPath) {
//        notes.remove(at: index)
//        usersdefaultService.saveNotes(note: notes)
//
//        view?.deleteRow(indexPath: indexPath)
//    }
    func deleteRow(index: Int,
                   completion: () -> Void ) {
        notes.remove(at: index)
        usersdefaultService.saveNotes(note: notes)
        completion()
//        view?.deleteRow(completion: completion)
    }
}

