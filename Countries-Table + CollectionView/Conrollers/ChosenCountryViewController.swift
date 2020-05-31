//
//  ChosenCountryViewController.swift
//  Countries-Table + CollectionView
//
//  Created by Raz on 30/05/2020.
//  Copyright © 2020 Raz. All rights reserved.
//

import UIKit
import SVGKit

class ChosenCountryViewController: UIViewController {
    
    var chosenCountry: Country?
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var flagImage: CustomImageView!
    @IBOutlet weak var capitalCityLabel: UILabel!
    @IBOutlet weak var LangugesLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var currancyLabel: UILabel!
    @IBOutlet weak var timeZoneLabel: UILabel!
    @IBOutlet weak var regionalBlocLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePage()
    }
    
    func configurePage(){
        if chosenCountry != nil {
            
            // MARK: Country Name
            countryNameLabel.text = chosenCountry?.name
            
            
            //MARK: Flag
            flagImage.loadImageUsingUrlString(urlString: chosenCountry!.flag) { (complete) in
                if !complete! {
                    print(complete!)
                }
            }
            
            
            //MARK: Capital City
            capitalCityLabel.text = "Capital City: \(chosenCountry?.capital ?? "")"
            
            
            //MARK: Country Languages
            var languages = [String]()
            chosenCountry?.languages.forEach({ (language) in
                languages.append(language.name)
            })
            LangugesLabel.text = "Languages: \(languages.joined(separator: " ,"))"
            
            
            //MARK: Population
            let fmt = NumberFormatter()
            fmt.numberStyle = .decimal
            let stringPopulation = fmt.string(from: NSNumber(value: chosenCountry?.population ?? 0))
            populationLabel.text = "Population: \(stringPopulation!) people"
            
            
            //MARK: Currancies
            var currancies: [String] = [""]
            chosenCountry?.currencies.forEach({ (currency) in
                currancies.append(currency.symbol ?? "")
            })
            currancyLabel.text = "Currancy: \(currancies.joined(separator: " "))"
            if currancies.joined(separator: " ").trimmingCharacters(in: .whitespaces) == ""{
                currancyLabel.text = "Currancy: \(chosenCountry?.currencies[0].name ?? "n/a")"
            }
            
            
            //MARK: Time Zone
            timeZoneLabel.text = "Time Zone: \(chosenCountry?.timezones[0] ?? "")"
            
            
            //MARK: Regional Bloc
            var regionalBlocs = [String]()
            chosenCountry?.regionalBlocs.forEach({ (region) in
                regionalBlocs.append(region.name.rawValue)
            })
            regionalBlocLabel.text = "Regional Bloc: \(regionalBlocs.joined(separator: " ,"))"
            if regionalBlocs.joined(separator: " ,").trimmingCharacters(in: .whitespaces) == "" {
                regionalBlocLabel.text = "Regional Bloc: n/a"
            }
            
        }
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


