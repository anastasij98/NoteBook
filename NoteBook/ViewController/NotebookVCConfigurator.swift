//
//  Configurator.swift
//  NoteBook
//
//  Created by LUNNOPARK on 17.04.23.
//

import Foundation
import UIKit

class NotebookVCConfigurator {
    
    static func open(navigationController: UINavigationController){
        let viewController = Self.getViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    static func getViewController() -> NoteBookViewController {
        let viewController = NoteBookViewController()
        let userDefults = UserDefultsService()
        let router = NotebookVCRouter()
        let presenter = NotebookVCPresenter(view: viewController,
                                            router: router,
                                            usersdefaultService: userDefults)
        viewController.presenter = presenter
        router.view = viewController
        
        return viewController
    }
}
