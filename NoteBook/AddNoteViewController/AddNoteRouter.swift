//
//  AddNoteRouter.swift
//  NoteBook
//
//  Created by LUNNOPARK on 19.04.23.
//

import Foundation
import UIKit

protocol AddNoteRouterProtocol {
    
    func popViewController()
}

class AddNoteRouter {
    
    weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension AddNoteRouter: AddNoteRouterProtocol {
    
    func popViewController() {
        view?.navigationController?.popViewController(animated: true)
    }
}
