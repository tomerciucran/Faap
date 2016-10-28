//
//  EventsTableViewController.swift
//  Faap
//
//  Created by Tomer Ciucran on 10/28/16.
//  Copyright © 2016 KPT. All rights reserved.
//

import UIKit
import RealmSwift

class EventsTableViewController: UITableViewController {
    
    var events: Results<Event>?
    var realm: Realm!
    let username = "tomercukran@gmail.com"
    let password = "to300390mer"

    override func viewDidLoad() {
        super.viewDidLoad()

        SyncUser.authenticate(with: Credential.usernamePassword(username: username, password: password, actions: []), server: URL(string: "http://127.0.0.1:9080")!, onCompletion: { user, error in
            guard let user = user else {
                fatalError(String(describing: error))
            }
            
            // Open Realm
            let configuration = Realm.Configuration(
                syncConfiguration: (user, URL(string: "realm://127.0.0.1:9080/~/events")!)
            )
            
            self.realm = try! Realm(configuration: configuration)
            self.events = self.realm.objects(Event.self)
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell

        cell.eventNameLabel.text = events?[indexPath.row].name

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
