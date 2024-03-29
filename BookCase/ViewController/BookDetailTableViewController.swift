//
//  BookDetailTableViewController.swift
//  BookCase
//
//  Created by Mohamed Zakaria on 5/11/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import UIKit

enum DetailViewState {
    case SaveBook
    case ShareBook
}

class BookDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    var book: Book!
    var detailViewState: DetailViewState!
    
    var stack: CoreDataStack {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.stack
    }
    
    private let numberOfCells = 8
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 44.0;
        navigationItem.rightBarButtonItem = makeRightNavigationBarButtonItem()
        
    }
    
    private func makeRightNavigationBarButtonItem() -> UIBarButtonItem? {
        // Check if state is set to decide which kind of button is needed
        guard let detailViewState = detailViewState else {
            assertionFailure("detailViewState not set!")
            return nil
        }
        switch detailViewState {
        case .SaveBook:
            return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(saveBook(sender:)))
        case .ShareBook:
            return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(shareBook(sender:)))
        }
        
    }
    
    // Save a book to book list (Core Data) and dismiss view
    @objc func saveBook(sender: UIBarButtonItem) {
        _ = BookCoreData(book: book, context: stack.context)
        stack.save()
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func shareBook(sender: UIBarButtonItem) {
        switch ShareMessageGenerator(book: book).shareMessage {
        case .Info(let shareMessage):
            let activityController = UIActivityViewController(activityItems: [shareMessage], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
        case .Error(let errorTitel, let errorMessage):
            showAlert(title: errorTitel, message: errorMessage)
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        // Configure cell based on cell index
        // First and last cell are different cell types
        if indexPath.row == 0 {
            let bookDetailCoverCell = tableView.dequeueReusableCell(withIdentifier: "BookDetailCoverCell", for: indexPath) as! BookDetailCoverTableViewCell
            bookDetailCoverCell.configureCell(book: book)
            cell = bookDetailCoverCell
        } else if indexPath.row == (numberOfCells - 1) {
            let bookDetailPreviewCell = tableView.dequeueReusableCell(withIdentifier: "BookDetailPreviewCell", for: indexPath) as! BookDetailPreviewTableViewCell
            bookDetailPreviewCell.configureCell(book: book)
            cell = bookDetailPreviewCell
        } else {
            let bookDetailCell = tableView.dequeueReusableCell(withIdentifier: "BookDetailCell", for: indexPath) as! BookDetailTableViewCell
            bookDetailCell.configureCell(book: book, index: indexPath.row)
            cell = bookDetailCell
        }
        
        // Disable cell selection
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // Disable cell selection
        return nil
    }
    
}
