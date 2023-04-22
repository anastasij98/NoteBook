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
    
    var mode: ScreenMode
    
    public var completion: ((String, String) -> Void)?
    
    init(view: AddNoteVCProtocol? = nil,
         router: AddNoteRouterProtocol,
         mode: ScreenMode) {
        self.view = view
        self.router = router
        self.mode = mode
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
        }
    }
    
    func saveNewNote() {
        router.popViewController()
    }
    
    func textCompletion(title: String, text: String) {
        completion?(title, text)
    }
}
