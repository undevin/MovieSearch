//
//  UITableViewExtension.swift
//  MovieSearch
//
//  Created by Devin Flora on 1/29/21.
//

import UIKit

extension UITableViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "Error Fetching Movies", message: localizedError.localizedDescription, preferredStyle: .actionSheet)
        let dismissAlert = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(dismissAlert)
        present(alertController, animated: true)
    }
}
