//
//  FirstViewController.swift
//  OvercomingMS
//
//  Created by Vince on 10/29/18.
//  Copyright © 2018 DrexelOvercomingMS. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textField.delegate = self
    }
    
    func SubmitPressed(){
        let inputString: String = TextInput.text ?? "";
        TextInput.endEditing(true); //close keyboard
        
        if(inputString != ""){
            let sb = UIStoryboard(name: "Main", bundle: nil);
            let popup = sb.instantiateViewController(withIdentifier: "DietPopupView") as! DietPopupViewController;
            popup.FoodName = TextInput.text ?? "";
            self.present(popup, animated: true, completion: nil);
            
            TextInput.text = "";
        }
    }
    @IBOutlet weak var textField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        SubmitPressed();
        return false
    }

    @IBAction func SubmitButton(_ sender: UIButton) {//present the modal view, and give it whatever you searched for if there is input
        SubmitPressed();
    }
    
    //items marked as favorites by the user should be listed here
    @IBAction func FavoritesTab(_ sender: UIButton) {
    
    }
    //previous items should be kept track of, and listed here
    @IBAction func HistoryTab(_ sender: UIButton) {
    }
    
    @IBOutlet var TextInput: UITextField!
    @IBOutlet var TextOutput: UITextView!
    
}

