//
//  PastReadsListTableViewController.swift
//  Readr
//
//  Created by Adetokunbo Babatunde on 8/21/20.
//  Copyright © 2020 Kristin Samuels . All rights reserved.
//

import UIKit

class PastReadsListTableViewController: UITableViewController {

    var pastReads: [String]?
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBooks()
    }
    
    // MARK: - Helpers
    
    func fetchBooks() {
        guard let pastReads = pastReads else {return}
        let group = DispatchGroup()
        for ISBN in pastReads {
            group.enter()
            BookController.fetchOneBookWith(ISBN: ISBN) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let book):
                        self.books.append(book)
                    case .failure(_):
                        print("we could not load pastreads")
                    }
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? PastReadsTableViewCell else {return UITableViewCell()}
        let book = books[indexPath.row]
        cell.book = book
        

        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
