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
                     completion: ((String, String) -> Void)?) {
        let viewController = Self.getViewController(completion: completion)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    static func getViewController(completion: ((String, String) -> Void)?) -> AddNoteViewController {
        
        let viewController = AddNoteViewController()
        viewController.completion = completion
        return viewController
    }
}
