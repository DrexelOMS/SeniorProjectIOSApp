//
//  FirstViewController.swift
//  OvercomingMS
//
//  Created by Vince on 10/29/18.
//  Copyright © 2018 DrexelOvercomingMS. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func SubmitButton(_ sender: UIButton) {
        TextOutput.text = TextInput.text;
        TextInput.text = "";
    }
    @IBOutlet var TextInput: UITextField!
    @IBOutlet var TextOutput: UITextView!
    
}

