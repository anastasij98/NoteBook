//
//  AddNotePresenter.swift
//  NoteBook
//
//  Created by LUNNOPARK on 19.04.23.
//

import Foundation

protocol AddNotePresenterProtocol {
    
    func viewIsReady()
    func saveNewNote()
    func textCompletion(title: String,
                        text: String)
}

class AddNotePresenter {
    
    weak var view: AddNoteVCProtocol?
    var router: AddNoteRouterProtocol
    
    var userDef: UserDefultsServiceProtocol
    
    var mode: ScreenMode
    
    var note: NoteModel?

    public var completion: ((String, String) -> Void)?
    
    init(view: AddNoteVCProtocol? = nil,
         router: AddNoteRouterProtocol,
         mode: ScreenMode,
         userDef: UserDefultsServiceProtocol) {
        self.view = view
        self.router = router
        self.mode = mode
        self.userDef = userDef
    }
}

extension AddNotePresenter: AddNotePresenterProtocol{
    
    func viewIsReady() {
        switch mode {
        case .writeMode:
            print(mode)
            
        case .readMode:
            print(mode)
            
            view?.canEditFields(canEdit: false)
            view?.fieldsBackgroundColor()
            view?.setupTitle(title: note?.title ?? "title")
            view?.setupText(text: note?.text ?? "text")
        }
    }
    
    func saveNewNote() {
        router.popViewController()
    }
    
    func textCompletion(title: String, text: String) {
        completion?(title, text)
    }
}
