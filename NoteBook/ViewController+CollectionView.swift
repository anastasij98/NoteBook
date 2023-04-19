//
//  ViewController+CollectionView.swift
//  NoteBook
//
//  Created by LUNNOPARK on 17.04.23.
//

import Foundation
import UIKit

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

