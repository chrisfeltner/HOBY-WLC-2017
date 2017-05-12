//
//  ClockViewController.swift
//  HOBY WLC 2017
//
//  Created by Christopher Feltner on 5/12/17.
//  Copyright © 2017 Christopher Feltner. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var clockLabel: UILabel!
    var timer = Timer()
    let WLCDate = NSDateComponents()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        runTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func runTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ClockViewController.findTimeDifference)), userInfo: nil, repeats: true)
    }
    

    func findTimeDifference()
    {
        let date = NSDate()
        let calendar = Calendar.current
        //set WLC date
        WLCDate.year = 2017
        WLCDate.month = 7
        WLCDate.day = 21
        WLCDate.hour = 0
        WLCDate.minute = 0
        WLCDate.second = 0
        let WLCDay = calendar.date(from: WLCDate as DateComponents)!
        
        //set current time and date
        let components = calendar.dateComponents([.hour, .minute, .second, .month, .year, .day], from: date as Date)
        let currentTime = calendar.date(from: components)
        
        //find time difference
        let timeDifference = calendar.dateComponents([.day, .hour, .minute, .second], from: WLCDay, to: currentTime!)
        
        print(timeDifference)
        updateClock(timeDifference: timeDifference)
        
    }
    
    func updateClock(timeDifference: DateComponents)
    {
        let daysLeft = timeDifference.day!
        let hoursLeft = timeDifference.hour!
        let minutesLeft = timeDifference.minute!
        let secondsLeft = timeDifference.second!
        if(secondsLeft < 0 && minutesLeft < 0 && hoursLeft < 0 && daysLeft < 0)
        {
            titleLabel.text = "Time until HOBY WLC 2017:"
            clockLabel.text = "\(abs(daysLeft)) Days, \(abs(hoursLeft)) Hours, \(abs(minutesLeft)) Minutes, \(abs(secondsLeft)) Seconds";
        }
        else
        {
            titleLabel.text = "WLC"
        }
    }
    


}

