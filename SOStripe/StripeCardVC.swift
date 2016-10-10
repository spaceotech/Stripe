//
//  StripeCardVC.swift
//  SOStripe
//
//  Created by Hitesh on 10/10/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

import UIKit
import Pods_SOStripe
import Stripe

class StripeCardVC: UIViewController, STPPaymentCardTextFieldDelegate {

    @IBOutlet weak var btnBuy: UIButton!
    
    let cardParams = STPCardParams()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let paymentField = STPPaymentCardTextField(frame: CGRect(x: 10, y: 100, width:self.view.frame.size.width - 20, height: 44))
        paymentField.delegate = self
        self.view.addSubview(paymentField)
        // Do any additional setup after loading the view.
        
        self.btnBuy.enabled = paymentField.isValid
        btnBuy.backgroundColor = UIColor.grayColor()
    }
    
    // MARK: STPPaymentCardTextFieldDelegate
    
    func paymentCardTextFieldDidChange(textField: STPPaymentCardTextField) {
        print("Card number: \(textField.cardParams.number) Exp Month: \(textField.cardParams.expMonth) Exp Year: \(textField.cardParams.expYear) CVC: \(textField.cardParams.cvc)")
        self.btnBuy.enabled = textField.isValid
        
        if btnBuy.enabled {
            btnBuy.backgroundColor = UIColor.blueColor()
            cardParams.number = textField.cardParams.number
            cardParams.expMonth = textField.cardParams.expMonth
            cardParams.expYear = textField.cardParams.expYear
            cardParams.cvc = textField.cardParams.cvc
        }
    }
    
    @IBAction func actionGetStripeToken() {
        STPAPIClient.sharedClient().createTokenWithCard(cardParams) { (token, error) in
            if let error = error {
                // show the error to the user
                print(error)
                self.showAlertButtonTapped("Error", strMessage: error.localizedDescription)
            } else if let token = token {
                //Send token to backend for process
                print(token)
                self.showAlertButtonTapped("Success", strMessage: "Got Token Successfully")
            }
        }
    }
    
    
    //MARK:- AlerViewController
    func showAlertButtonTapped(strTitle:String, strMessage:String) {
        // create the alert
        let alert = UIAlertController(title: strTitle, message: strMessage, preferredStyle: UIAlertControllerStyle.Alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

    @IBAction func actionBack(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
