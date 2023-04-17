//
//  DetailedVC.swift
//  NoteBook
//
//  Created by LUNNOPARK on 25.03.23.
//

import Foundation
import UIKit
import SnapKit

class NoteDescriptionViewController: UIViewController {
    
    lazy var titleField: UILabel = {
        let view = UILabel()
        view.backgroundColor = .systemYellow.withAlphaComponent(0.1)
        return view
    }()
    
    lazy var noteField: UITextView = {
        let view = UITextView()
        view.backgroundColor = .systemBlue.withAlphaComponent(0.1)

        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNoteDescripton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = .white
    }

    func setupNoteDescripton() {
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
    }
}
