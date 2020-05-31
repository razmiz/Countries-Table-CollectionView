//
//  CountriesViewController.swift
//  Countries-Table + CollectionView
//
//  Created by Raz on 24/05/2020.
//  Copyright © 2020 Raz. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {
    
    @IBOutlet weak var chosenRegionLabel: UILabel!
    var chosenRegionName: String = ""
    var countriesInRegion: [Country] = [Country]()
    var countriesInRegion1: [Country] = [Country]()
    var countriesInRegion2: [Country] = [Country]()
    var chosenCountry: Country?
    
    private var collectionViewFlowLayout: UICollectionViewFlowLayout!
    private var collectionViewFlowLayout1: UICollectionViewFlowLayout!
    private var collectionViewFlowLayout2: UICollectionViewFlowLayout!
    
    @IBOutlet weak var countriesCollectionView1: UICollectionView!
    @IBOutlet weak var countriesCollectionView2: UICollectionView!
    
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chosenRegionLabel.text = "Region: \(chosenRegionName)"
        splitArray()
        configurePage()
        
    }
    
    func splitArray(){
        let count = countriesInRegion.count
        if count > 1 {
            for position in 0...count / 2 {
                countriesInRegion1.append(countriesInRegion[position])
            }
            for position in count / 2...count - 1 {
                countriesInRegion2.append(countriesInRegion[position])
            }
        } else{
            countriesInRegion1 = countriesInRegion
            
        }
    }
    
    func configurePage(){
        countriesCollectionView1.register(CountryCollectionViewCell.getNib(), forCellWithReuseIdentifier: CountryCollectionViewCell.countryCollectionViewCell)
        
        countriesCollectionView2.register(CountryCollectionViewCell.getNib(), forCellWithReuseIdentifier: CountryCollectionViewCell.countryCollectionViewCell)
        
        configureCollectionViewCellSize1()
        configureCollectionViewCellSize2()
    }
    
    
    private func configureCollectionViewCellSize1(){
        if collectionViewFlowLayout1 == nil {
            
            collectionViewFlowLayout1 = .init()
            
            collectionViewFlowLayout1.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2), height: UIScreen.main.bounds.height / 4)
            collectionViewFlowLayout1.minimumInteritemSpacing = 5
            collectionViewFlowLayout1.minimumLineSpacing = 5
            collectionViewFlowLayout1.scrollDirection = .horizontal
            
            countriesCollectionView1.setCollectionViewLayout(collectionViewFlowLayout1, animated: true)
        }
    }
    private func configureCollectionViewCellSize2(){
        if collectionViewFlowLayout2 == nil {
            
            collectionViewFlowLayout2 = .init()
            
            collectionViewFlowLayout2.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2), height: UIScreen.main.bounds.height / 4)
            collectionViewFlowLayout2.minimumInteritemSpacing = 5
            collectionViewFlowLayout2.minimumLineSpacing = 5
            collectionViewFlowLayout2.scrollDirection = .horizontal
            
            countriesCollectionView2.setCollectionViewLayout(collectionViewFlowLayout2, animated: true)
        }
    }
    
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: CollectionView Extension

extension CountriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return countriesInRegion.count > 1 ? countriesInRegion.count / 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCollectionViewCell.countryCollectionViewCell, for: indexPath) as? CountryCollectionViewCell {
            
            
            if collectionView.collectionViewLayout == self.countriesCollectionView1.collectionViewLayout{
                    cell.configurecountryCell(country: self.countriesInRegion1[indexPath.item])
            }else if countriesInRegion2.count > 0{
                    cell.configurecountryCell(country: self.countriesInRegion2[indexPath.item])
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.collectionViewLayout == collectionViewFlowLayout1 {
            chosenCountry = countriesInRegion1[indexPath.item]
        } else if collectionView.collectionViewLayout == collectionViewFlowLayout2 {
            chosenCountry = countriesInRegion2[indexPath.item]
        }
        performSegue(withIdentifier: "chosenCountry", sender: chosenCountry)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chosenCountry"{
            if let dest = segue.destination as? ChosenCountryViewController {
                dest.chosenCountry = chosenCountry
            }
        }
    }
}

