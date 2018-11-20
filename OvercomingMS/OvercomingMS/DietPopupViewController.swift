//
//  SecondViewController.swift
//  OvercomingMS
//
//  Created by Vince on 10/29/18.
//  Copyright © 2018 DrexelOvercomingMS. All rights reserved.
//

import UIKit

class DietPopupViewController: UIViewController {

    var text:String = "";
    
    //close the popupView
    @IBAction func BackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    //add (or remove) item from the user's favorites
    @IBAction func FavoritesButton(_ sender: UIButton) {
        
    }
    
    @IBOutlet var scrollTextBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollTextBox.text = text;
    }
}

