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

    @IBAction func SubmitButton(_ sender: UIButton) {//present the modal view, and give it whatever you searched for if there is input
        let inputString: String = TextInput.text ?? "";
        TextInput.endEditing(true); //close keyboard
        
        if(inputString != ""){
            let sb = UIStoryboard(name: "Main", bundle: nil);
            let popup = sb.instantiateViewController(withIdentifier: "DietPopupView") as! DietPopupViewController;
            popup.text = TextInput.text ?? "";
            self.present(popup, animated: true, completion: nil);
            
            TextInput.text = "";
        }
    }
    
    //previous items should be kept track of, and listed here
    @IBAction func HistoryTab(_ sender: UIButton) {
    
    }
    
    //items marked as favorites by the user should be listed here
    @IBAction func FavoritesTab(_ sender: UIButton) {
    }
    
    @IBOutlet var TextInput: UITextField!
    @IBOutlet var TextOutput: UITextView!
    
}

