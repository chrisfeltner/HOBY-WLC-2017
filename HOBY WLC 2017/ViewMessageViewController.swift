//
//  ViewMessageViewController.swift
//  HOBY WLC 2017
//
//  Created by Christopher Feltner on 5/12/17.
//  Copyright © 2017 Christopher Feltner. All rights reserved.
//

import UIKit

class ViewMessageViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var messageWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageWebView.delegate = self
        let url =  URL(string: "https://developer.apple.com/reference/uikit/uiwebview")
        let request = URLRequest(url: url!)
        messageWebView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
