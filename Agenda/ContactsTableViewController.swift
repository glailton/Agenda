//
//  ContactsTableViewController.swift
//  Agenda
//
//  Created by Glailton Costa on 12/15/16.
//  Copyright © 2016 Glailton Costa. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    var contacts = [Contact]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contact1 = Contact(name:"Glailton", phone:"986561900")
        let contact2 = Contact(name:"Deisianne", phone:"999969149")
        
        contacts += [contact1,contact2]
        
        print(contacts)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactViewCell", for: indexPath) as!ContactsTableViewCell

        let contact = contacts[indexPath.row]
        cell.nameLabel.text = contact.name
        cell.phoneLabel.text = contact.phone

        return cell
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ContactViewController, let contact = sourceViewController.contact {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                contacts[selectedIndexPath.row] = contact
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else{
                // Add a new meal.
                let newIndexPath = IndexPath(row: contacts.count, section: 0)
                
                contacts.append(contact)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            self.tableView.reloadData()
            
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if(segue.identifier == "Edit"){
            if let dvc = segue.destination as? ContactViewController {
                let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
                let selectedContactCell = self.contacts[indexPath!.row]
                dvc.contact = selectedContactCell
            }
            
        }
    }
    

}
