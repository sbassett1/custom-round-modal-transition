//
//  NewViewController.swift
//  CustomRoundTransition
//
//  Created by Stephen Bassett on 5/23/19.
//  Copyright © 2019 Stephen Bassett. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet var hideButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func hideNewVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
