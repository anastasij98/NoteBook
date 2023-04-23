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
    func viewWillAppear()
    func getNotesCount() -> Int
    func getItem(index: Int) -> NoteModel
    func deleteRow(index: Int,
                   completion: () -> Void)
    func didSelectRow(index: Int)
    func addNoteButtonTouched()
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
    
    func didSelectRow(index: Int) {
        router.goToAddNoteViewController(mode: .readMode(model: notes[index])) { [weak self] noteTitle, note in
            guard let self = self else { return }
            let model = NoteModel(title: noteTitle,
                                  text: note)
            self.notes[index] = model
            self.usersdefaultService.saveNotes(note: self.notes)
            self.view?.reloadTableView()
        }
    }
    
    func addNoteButtonTouched() {
        router.goToAddNoteViewController(mode: .writeMode) { [weak self] noteTitle, note in
            guard let self = self else { return }
            let model = NoteModel(title: noteTitle,
                                  text: note)
            self.notes.append(model)
            self.usersdefaultService.saveNotes(note: self.notes)
            self.view?.reloadTableView()
        }
    }
//
//    func goToViewController(mode: ScreenMode) {
//        let completion: ((String, String) -> Void)?
//
//        switch mode {
//        case .writeMode:
//            completion = { noteTitle, note in
//                let model = NoteModel(title: noteTitle,
//                                      text: note)
//                self.notes.append(model)
//                self.usersdefaultService.saveNotes(note: self.notes)
//                self.view?.reloadTableView()
//            }
//        case .readMode:
//            completion = nil
//        }
//        router.goToAddNoteViewController(mode: mode,
//                                         completion: completion)
//    }

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
        if !notes.isEmpty {
            return notes[index]
        } else {
            return NoteModel(title: "",
                             text: "")
        }
    }

    func deleteRow(index: Int,
                   completion: () -> Void ) {
        notes.remove(at: index)
        usersdefaultService.saveNotes(note: notes)
        completion()
    }
}

