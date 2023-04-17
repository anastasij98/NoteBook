//
//  ViewController.swift
//  NoteBook
//
//  Created by LUNNOPARK on 25.03.23.
//
import Foundation
import UIKit

struct NoteModel: Codable {
    let title: String
    let text: String
}

class NoteBookViewController: UIViewController {
    
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
    var notes: [NoteModel] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNoteBookScreen()
        setupTableView()
        
        if let data = UserDefaults.standard.object(forKey: "notes") as? Data,
           let decoded = try? JSONDecoder().decode([NoteModel].self, from: data) {
            notes = decoded
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if notes.isEmpty {
            tableView.isHidden = true
            noNotesLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noNotesLabel.isHidden = true
        }
    }
    
    func setupNoteBookScreen() {
        self.title = "Notes"
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        let nextVC = AddNoteViewController()
        navigationController?.pushViewController(nextVC, animated: true)
        
        nextVC.completion = {noteTitle, note in
            let model = NoteModel(title: noteTitle,
                                  text: note)
            self.notes.append(model)

            if let encoded = try? JSONEncoder().encode(self.notes) {
                UserDefaults.standard.set(encoded, forKey: "notes")
            }
            
            self.tableView.reloadData()
        }
    }
}
// MARK: - UITableViewDelegate
extension NoteBookViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = NoteDescriptionViewController()
        detailedVC.titleField.text = notes[indexPath.row].title
        detailedVC.noteField.text = notes[indexPath.row].text

        navigationController?.pushViewController(detailedVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension NoteBookViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = notes[indexPath.row].title
        content.secondaryText = notes[indexPath.row].text
        cell.contentConfiguration = content

        return cell
    }
    
}
