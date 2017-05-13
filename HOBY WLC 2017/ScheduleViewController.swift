//
//  ScheduleViewController.swift
//  HOBY WLC 2017
//
//  Created by Christopher Feltner on 5/12/17.
//  Copyright © 2017 Christopher Feltner. All rights reserved.
//

import UIKit
import Firebase

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var scheduleTableView: UITableView!
    var events : [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        
        FIRDatabase.database().reference().child("events").observe((FIRDataEventType.childAdded), with: { (snapshot) in
            print(snapshot)
            let myEvent = Event()
            let snapshotValue = snapshot.value as? NSDictionary
            myEvent.name = snapshotValue?["name"] as! String
            myEvent.day = snapshotValue?["day"] as! Int64
            myEvent.startTime = snapshotValue?["startTime"] as! Int64
            myEvent.endTime = snapshotValue?["endTime"] as! Int64
            self.events.append(myEvent)
            self.scheduleTableView.reloadData()
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = events[indexPath.row].name
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
