//
//  SecondViewController.swift
//  OvercomingMS
//
//  Created by Vince on 10/29/18.
//  Copyright © 2018 DrexelOvercomingMS. All rights reserved.
//

import UIKit

class DietPopupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate{
    
    var myName: String = "";
    var myId: String = "";
    var prevVC: FirstViewController!;
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OptionNames.count; // your number of cell here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        cell.textLabel?.text = String(OptionNames[indexPath.row]);
        return cell;
    }
    
    //when you select an option
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        TextBox.text = "Loading";
        myName = OptionNames[indexPath.row];
        myId = OptionIds[indexPath.row];
        if(myName != ""){
            HistoryItemNames.append(myName);
            HistoryItemIds.append(myId);
        }
        SearchNDB(ndbno: String(OptionIds[indexPath.row]))
    }

    var FoodName:String = ""; //this gets set on creation from the previous view, 
    
    //close the popupView
    @IBAction func BackButton(_ sender: UIButton) {
        prevVC.tr();
        dismiss(animated: true, completion: nil)
    }
    
    //add (or remove) item from the user's favorites
    @IBAction func FavoritesButton(_ sender: UIButton) {
        if(myName != ""){
            FavItemNames.append(myName);
            FavItemIds.append(myId);
        }
    }
    
    var OptionNames: [String] = [];
    var OptionIds: [String] = [];
    
    var FromTableView: Bool = false;
    var FromTableViewID: String = "";
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var TextBox: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        TextBox.text = "Loading";
        
        if(!FromTableView){
            SearchFoodName();
        }
        else{
            SearchNDB(ndbno: FromTableViewID);
        }
    }
    
    func SearchNDB(ndbno: String){
        
        self.firstXML = false;
        let APIUrl = "https://api.nal.usda.gov/ndb/V2/reports?ndbno=" + ndbno + "&type=f&format=xml&api_key=vhuS0ESO8hNsZ4JB3vpRc1ibIzDqbivrU8SZDCi3";
        let url = URL(string: APIUrl)!;
        let task = URLSession.shared.dataTask(with: url){(data,response,error) in
            guard let data = data else {return}
            let xmlParser = XMLParser(data: data as Data);
            xmlParser.delegate = self;
            xmlParser.parse();
        }
        task.resume();
    }
    
    func SearchFoodName(){
        self.firstXML = true;
        let APIUrl = "https://api.nal.usda.gov/ndb/search/?format=xml&q="+FoodName+"&max=25&offset=0&api_key=vhuS0ESO8hNsZ4JB3vpRc1ibIzDqbivrU8SZDCi3";
        let url = URL(string: APIUrl)!;
        let task = URLSession.shared.dataTask(with: url){(data,response,error) in
            guard let data = data else {return}
            let xmlParser = XMLParser(data: data as Data);
            xmlParser.delegate = self;
            xmlParser.parse();
        }
        task.resume();
    }
    
    var currentParsingElement: String = "";
    //MARK: will need to check if not set
    var SatFats: Float = 0;
    var Omega3s: Float = 0;
    var Calories: Float = 0;
    
    var firstXML: Bool = true;
    
    //MARK:- XML Delegate methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentParsingElement = elementName
        if elementName == "Response" {
            print("Started parsing...")
        }
        if(!firstXML){
            if(elementName == "nutrient"){
                var tempId = "";
                if let id = attributeDict["nutrient_id"]{
                    tempId = id;
                }
                var tempName = "";
                if let name = attributeDict["name"]{
                    tempName = name;
                }
                var tempValue = Float(-1);
                if let val = attributeDict["value"]{
                    tempValue = Float(val) ?? -1;
                }
                if(tempName == "Fatty acids, total saturated"){
                    self.SatFats = tempValue
                }
                switch(tempId){
                case "208":
                    Calories = tempValue;
                    break;
                case "619":
                    Omega3s += tempValue;
                    break;
                case "629":
                    Omega3s += tempValue;
                    break;
                case "621":
                    Omega3s += tempValue;
                    break;
                case "631":
                    Omega3s += tempValue;
                    break;
                default:
                    break;
                }
            }
        }
    }
    
    //Mark: Note there is a bug where it splits names that have a & symbol
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let foundedChar = string.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines)
        
        if(firstXML){
            if (!foundedChar.isEmpty) {
                if currentParsingElement == "name" {
                    OptionNames.append(foundedChar);
                }
                else if(currentParsingElement == "ndbno"){
                    OptionIds.append(foundedChar);
                }
            }
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Response" {
            print("Ended parsing...")
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            // Update UI
            //self.displayOnUI()
            if(self.firstXML){
                self.tableView.reloadData();
            }
            else{
                self.TextBox.text = "Saturated Fats: " + String(self.SatFats) + " grams \n" +
                "Omega 3s: " + String(self.Omega3s) + "grams \n" +
                    "Calories: " + String(self.Calories);
            }
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
}

