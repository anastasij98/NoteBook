//
//  AddNoteViewController.swift
//  NoteBook
//
//  Created by LUNNOPARK on 14.04.23.
//

import Foundation
import UIKit
import SnapKit

protocol AddNoteVCProtocol: AnyObject {
    
    func canEditFields(canEdit: Bool)
    func fieldsBackgroundColor()
    func getCompletion()
    
    func setupView(title: String, text: String)
}

class AddNoteViewController: UIViewController {
    
    var presenter: AddNotePresenterProtocol?

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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.becomeFirstResponder()
        setupNavigationItem()
        setupNoteViewController()
        
        presenter?.viewIsReady()
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
            getCompletion()
        }
        presenter?.saveNewNote()
        print("saved")
    }
}

extension AddNoteViewController: AddNoteVCProtocol {
    
    func canEditFields(canEdit: Bool) {
        titleField.isUserInteractionEnabled = canEdit
        noteField.isUserInteractionEnabled = canEdit
    }

    func fieldsBackgroundColor() {
        titleField.backgroundColor = .placeholderText
        noteField.backgroundColor = .placeholderText
    }
    
    func getCompletion() {
        presenter?.textCompletion(title: titleField.text ?? "",
                                  text: noteField.text)
    }
    
    func setupView(title: String, text: String) {
        titleField.text = title
        noteField.text = text
    }
}
