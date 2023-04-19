//
//  ViewControllerRouter.swift
//  NoteBook
//
//  Created by LUNNOPARK on 17.04.23.
//

import Foundation
import UIKit

protocol NotebookVCRouterProtocol {
    
    func goToAddNoteViewController(completion: ((String, String) -> Void)?)
}

class NotebookVCRouter {
    
    weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
}

extension NotebookVCRouter: NotebookVCRouterProtocol {
    
    func goToAddNoteViewController(completion: ((String, String) -> Void)?) {
        guard let navigationController = self.view?.navigationController else { return }
        AddNoteConfigurator.open(navigationController: navigationController,
                                 completion: completion)
    }
}
