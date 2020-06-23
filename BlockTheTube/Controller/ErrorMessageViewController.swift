//
//  ErrorMessageViewController.swift
//  BlockTheTube
//
//  Created by Ramya Seshagiri on 23/06/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import UIKit

class ErrorMessageViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.setBordersSettings()

    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
 

}


extension UIButton {
func setBordersSettings() {
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }
}
