//
//  ViewController.swift
//  Countries-Table + CollectionView
//
//  Created by Raz on 24/05/2020.
//  Copyright © 2020 Raz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    let countriesSegue = "countriesSegue"
    var curentChosenRegion = ""
    @IBOutlet weak var tableView: UITableView!
    var regionSet = Set<String>()
    var country: [Country]? {
        didSet{
            if let country = country{
                for item in country{
                    regionSet.insert(item.region.rawValue)
                    regionArray = getArrayFromSet(set: regionSet)
                }
            }
        }
    }
    
    var regionArray = [String](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        parseCountry()
    }
    
    func parseCountry(){
        JsonParser().parseCountryJsonFromUrl { (country) in
            self.country = country
        }
    }
    
    func getArrayFromSet(set: Set<String>) -> [String]{
        let regionSet = set
        var regionArray = [String]()
        for item in regionSet {
            if item != ""{
                regionArray.append(item)
            }
            regionArray.sort()
        }
        return regionArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CountriesViewController{
            dest.chosenRegionName = curentChosenRegion
            dest.countriesInRegion = configureCountriesInRegion(countries: country!, region: curentChosenRegion)
        }
    }
    
    func configureCountriesInRegion(countries: [Country], region: String) -> [Country] {
        var countriesInRegion:[Country] = [Country]()
        for country in countries {
            if country.region.rawValue == region{
                countriesInRegion.append(country)
            }
        }
        return countriesInRegion
    }
    
    
    func getCountriesArrayFromRegion(country: [Country], region: String) -> [String] {
        var countriesArray = [""]
        for country in country {
            if country.region.rawValue == region{
                countriesArray.append(country.name)
            }
        }
        return countriesArray
    }
}


//MARK: TableView Extension

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell") as? RegionTableViewCell {
            let text = regionArray[indexPath.row]
            cell.regionLabel.text = text
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        curentChosenRegion = "\(regionArray[indexPath.row])"
        performSegue(withIdentifier: countriesSegue, sender: self)
    }
    
}
