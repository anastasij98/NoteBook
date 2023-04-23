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
        presenter?.didSelectRow(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
//  Оставила этот метод закомментированным, ибо он тоже работает для удаления ячейки
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let delete = UIContextualAction(style: .destructive,
//                                        title: "delete") { (action, view, handler) in
//            self.presenter?.deleteRow(index: indexPath.row,
//                                 completion: {
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            })
//        }
//        delete.backgroundColor = .red
//
//        var actions: [UIContextualAction] = [UIContextualAction]()
//        actions.append(delete)
//
//        let configuration = UISwipeActionsConfiguration(actions: actions)
//
//        return configuration
//    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.deleteRow(index: indexPath.row,
                                 completion: {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
        }
    }
}

// MARK: - UITableViewDataSource
extension NoteBookViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNotesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let item = presenter?.getItem(index: indexPath.row)
        
        var content = cell.defaultContentConfiguration()
        content.text = item?.title
        content.secondaryText = item?.text
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
