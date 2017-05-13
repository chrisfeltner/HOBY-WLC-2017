//
//  ScheduleViewController.swift
//  HOBY WLC 2017
//
//  Created by Christopher Feltner on 5/12/17.
//  Copyright © 2017 Christopher Feltner. All rights reserved.
//

import UIKit
import Firebase

class ScheduleEntryCell: UITableViewCell
{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!

}

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
            myEvent.day = snapshotValue?["day"] as! Int
            myEvent.startTime = snapshotValue?["startTime"] as! Int
            myEvent.endTime = snapshotValue?["endTime"] as! Int
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
        let cell = scheduleTableView.dequeueReusableCell(withIdentifier: "ScheduleEntryCell", for: indexPath) as! ScheduleEntryCell
        let index = indexPath.row
        cell.nameLabel?.text = events[index].name
        cell.startTimeLabel?.text = String(events[index].startTime)
        cell.endTimeLabel?.text = String(events[index].endTime)
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
