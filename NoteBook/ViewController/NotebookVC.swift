//
//  ViewController.swift
//  NoteBook
//
//  Created by LUNNOPARK on 25.03.23.
//
import Foundation
import UIKit

protocol NoteBookViewControllerProtocol: AnyObject {
    
    func notesInTableView(notesAreInMemory: Bool)
    func reloadTableView()
}

class NoteBookViewController: UIViewController {
    
   var presenter: NotebookVCPresenterProtocol?
    
   lazy var tableView: UITableView = {
        var view = UITableView()
        return view
    }()
    
    lazy var label: UILabel = {
        var view = UILabel()
        return view
    }()
    
    lazy var noNotesLabel: UILabel = {
        var view = UILabel()
        view.text = "You don't have any notes yet :c"
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 20, weight: .regular)
        return view
    }()
    
    lazy var addButton: UIBarButtonItem = {
        let view = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
        
        return view
    }()
    
    var identifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNoteBookScreen()
        setupTableView()
        
        presenter?.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    func setupNoteBookScreen() {
        self.title = "Notes"
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(noNotesLabel)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        noNotesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noNotesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            noNotesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            noNotesLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            noNotesLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    @objc
    func addNewNote() {
        presenter?.goToViewController(mode: .writeMode,
                                      index: 0)
    }
}

extension NoteBookViewController: NoteBookViewControllerProtocol {
    
    func notesInTableView(notesAreInMemory: Bool) {
        tableView.isHidden = notesAreInMemory
        noNotesLabel.isHidden = !notesAreInMemory
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}
