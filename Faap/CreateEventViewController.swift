//
//  CreateEventViewController.swift
//  Faap
//
//  Created by Tomer Ciucran on 10/28/16.
//  Copyright © 2016 KPT. All rights reserved.
//

import UIKit
import RealmSwift

class CreateEventViewController: UITableViewController {

    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    var events: List<Event>!
    var event = Event()
    var realm: Realm!
    let username = "tomercukran@gmail.com"
    let password = "to300390mer"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateTextField.text = dateFormatter.string(from: sender.date)
        event.timeDate = sender.date
    }
    
    @IBAction func dateTextFieldEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func createButtonAction(_ sender: AnyObject) {
        event.name = eventNameTextField.text
        
        SyncUser.authenticate(with: Credential.usernamePassword(username: username, password: password, actions: []), server: URL(string: "http://127.0.0.1:9080")!, onCompletion: { user, error in
            guard let user = user else {
                fatalError(String(describing: error))
            }
            
            // Open Realm
            let configuration = Realm.Configuration(
                syncConfiguration: (user, URL(string: "realm://127.0.0.1:9080/~/events")!)
            )
            
            self.realm = try! Realm(configuration: configuration)
            try! self.realm.write {
                self.realm.add(self.event)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
