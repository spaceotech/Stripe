//
//  ViewController.swift
//  SOStripe
//
//  Created by Hitesh on 10/10/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

import UIKit
import Pods_SOStripe
import Stripe

class ViewController: UIViewController, STPAddCardViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func actionAddCardDefault(sender: AnyObject) {
        let addCardViewController = STPAddCardViewController()
        addCardViewController.delegate = self
        // STPAddCardViewController must be shown inside a UINavigationController.
        let navigationController = UINavigationController(rootViewController: addCardViewController)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    // MARK: STPAddCardViewControllerDelegate
    
    func addCardViewControllerDidCancel(addCardViewController: STPAddCardViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addCardViewController(addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: STPErrorBlock) {
        //Send token to backend for process
        print(token)
        self.dismissViewControllerAnimated(true, completion: {
            completion(nil)
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

