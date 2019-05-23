//
//  ViewController.swift
//  CustomRoundTransition
//
//  Created by Stephen Bassett on 5/23/19.
//  Copyright © 2019 Stephen Bassett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        startButton.layer.cornerRadius = startButton.frame.width / CGFloat(2)
    }

    @IBAction func showNewVC(_ sender: Any) {
        performSegue(withIdentifier: "ShowNewVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? NewViewController {
            destinationVC.transitioningDelegate = self
        }
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = PresentAnimator(buttonFrame: startButton.frame)
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
}
