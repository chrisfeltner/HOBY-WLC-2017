//
//  SecondViewController.swift
//  HOBY WLC 2017
//
//  Created by Christopher Feltner on 5/12/17.
//  Copyright © 2017 Christopher Feltner. All rights reserved.
//

import UIKit
import Firebase

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var messageTableView: UITableView!
    var messages : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageTableView.delegate = self
        self.messageTableView.dataSource = self
        FIRDatabase.database().reference().child("messages").observe((FIRDataEventType.childAdded), with: { (snapshot) in
            print(snapshot)
            let snapshotValue = snapshot.value as? NSDictionary
            let myMessage = Message()
            myMessage.subject = snapshotValue?["subject"] as! String
            self.messages.append(myMessage)
            print(self.messages)
            self.messageTableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(messages.count)
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = messages[indexPath.row].subject
        print(cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myMessage = messages[indexPath.row]
        self.performSegue(withIdentifier: "ViewMessageSegue", sender: myMessage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

