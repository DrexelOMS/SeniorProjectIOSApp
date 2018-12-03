//
//  FirstViewController.swift
//  OvercomingMS
//
//  Created by Vince on 10/29/18.
//  Copyright © 2018 DrexelOvercomingMS. All rights reserved.
//

import UIKit

var HistoryItemNames: [String] = [];
var HistoryItemIds: [String] = [];
var FavItemNames: [String] = [];
var FavItemIds: [String] = [];

class FirstViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrentListItems.count; // your number of cell here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        cell.textLabel?.text = String(CurrentListItems[indexPath.row]);
        cell.backgroundColor = UIColor.lightGray;
        return cell;
    }
    
    //when you select an option
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        LoadWithItemSelected(id: String(CurrentListIds[indexPath.row]))
    }
    
    func LoadWithItemSelected(id: String){
        let sb = UIStoryboard(name: "Main", bundle: nil);
        let popup = sb.instantiateViewController(withIdentifier: "DietPopupView") as! DietPopupViewController;
        popup.FoodName = TextInput.text ?? "";
        popup.FromTableView = true;
        popup.FromTableViewID = id;
        popup.prevVC = self;
        self.present(popup, animated: true, completion: nil);
    }
    
    var CurrentListItems: [String] = [];
    var CurrentListIds: [String] = [];
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destinationVC = segue.destination as? DietPopupViewController{
            destinationVC.prevVC = self;
            myTableView.reloadData();
            CurrentListItems = HistoryItemNames;
            CurrentListIds = HistoryItemIds;
        }
    }
    
    func tr(){
        myTableView.reloadData();
        CurrentListItems = HistoryItemNames;
        CurrentListIds = HistoryItemIds;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textField.delegate = self
        
        myTableView.delegate = self;
        myTableView.dataSource = self;
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(false)
        
        myTableView.reloadData();
    }
    
    func SubmitPressed(){
        let inputString: String = TextInput.text ?? "";
        TextInput.endEditing(true); //close keyboard
        
        if(inputString != ""){
            let sb = UIStoryboard(name: "Main", bundle: nil);
            let popup = sb.instantiateViewController(withIdentifier: "DietPopupView") as! DietPopupViewController;
            popup.FoodName = TextInput.text ?? "";
            popup.prevVC = self;
            self.present(popup, animated: true, completion: nil);
            
            TextInput.text = "";
        }
    }
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var myTableView: UITableView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        SubmitPressed();
        return false
    }

    @IBAction func SubmitButton(_ sender: UIButton) {//present the modal view, and give it whatever you searched for if there is input
        SubmitPressed();
    }
    
    @IBOutlet var FavButton: UIButton!
    @IBOutlet var HistButton: UIButton!
    //items marked as favorites by the user should be listed here
    @IBAction func FavoritesTab(_ sender: UIButton) {
        FavButton.backgroundColor = UIColor.lightGray;
        HistButton.backgroundColor = UIColor.white;
        CurrentListItems = FavItemNames;
        CurrentListIds = FavItemIds;
        myTableView.reloadData();
    }
    //previous items should be kept track of, and listed here
    @IBAction func HistoryTab(_ sender: UIButton) {
        HistButton.backgroundColor = UIColor.lightGray;
        FavButton.backgroundColor = UIColor.white;
        CurrentListItems = HistoryItemNames;
        CurrentListIds = HistoryItemIds;
        myTableView.reloadData();
    }
    
    
    @IBOutlet var TextInput: UITextField!
    @IBOutlet var TextOutput: UITextView!
    
}

