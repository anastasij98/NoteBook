//
//  AddNoteViewController.swift
//  NoteBook
//
//  Created by LUNNOPARK on 14.04.23.
//

import Foundation
import UIKit

class AddNoteViewController: UIViewController {
    
    lazy var titleField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .systemMint.withAlphaComponent(0.1)
        return view
    }()
    
    lazy var noteField: UITextView = {
        let view = UITextView()
        view.backgroundColor = .systemPurple.withAlphaComponent(0.1)
        
        return view
    }()
    
    public var completion: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.becomeFirstResponder()
        setupNavigationItem()
        setupNoteViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = .white
    }
    
    func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveNewNote))
    }
    
    func setupNoteViewController() {
        view.addSubview(titleField)
        view.addSubview(noteField)
        
        titleField.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(80)
        }
        
        noteField.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(titleField.snp.bottom).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.title = "New Note"
    }
    
    @objc
    func saveNewNote() {
        if titleField.hasText, noteField.hasText {
            completion?(titleField.text ?? "", noteField.text)
        }
        navigationController?.popViewController(animated: true)
        print("saved")
    }
}
