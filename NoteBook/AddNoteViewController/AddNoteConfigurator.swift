//
//  AddNoteConfigurator.swift
//  NoteBook
//
//  Created by LUNNOPARK on 18.04.23.
//

import Foundation
import UIKit

class AddNoteConfigurator {
    
    static func open(navigationController: UINavigationController,
                     mode: ScreenMode,
                     note: NoteModel,
                     completion: ((String, String) -> Void)?) {
        let viewController = Self.getViewController(mode: mode,
                                                    note: note,
                                                    completion: completion)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    static func getViewController(mode: ScreenMode,
                                  note: NoteModel,
                                  completion: ((String, String) -> Void)?) -> AddNoteViewController {
        
        let viewController = AddNoteViewController()
        let router = AddNoteRouter()
        let userDef = UserDefultsService()
        let presenter = AddNotePresenter(view: viewController,
                                         router: router,
                                         mode: mode,
                                         userDef: userDef)
        router.view = viewController
        viewController.presenter = presenter
        presenter.completion = completion
        presenter.note = note

        return viewController
    }
}
