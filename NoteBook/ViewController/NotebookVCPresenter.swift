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
    func addViewControllerAndNote()
    func viewWillAppear()
    func getNotesCount() -> Int
    func getItem(index: Int) -> NoteModel
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
        usersdefaultService.getNotes(key: noteKey) {notesItems in
            self.notes = notesItems
        }
    }
    
    func addViewControllerAndNote() {
        router.goToAddNoteViewController { noteTitle, note in
            let model = NoteModel(title: noteTitle,
                                  text: note)
            self.notes.append(model)
            self.usersdefaultService.saveNotes(note: self.notes,
                                               key: self.noteKey)
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
}

