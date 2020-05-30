//
//  CountryCollectionViewCell.swift
//  Countries-Table + CollectionView
//
//  Created by Raz on 24/05/2020.
//  Copyright © 2020 Raz. All rights reserved.
//

import UIKit
import SVGKit

class CountryCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    public static let countryCollectionViewCell = "CountryCollectionViewCell"
    
    @IBOutlet weak var flagImage: CustomImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    //MARK: Functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configurecountryCell(country: Country){
        activityIndicator.startAnimating()
        if countryNameLabel != nil{
            countryNameLabel.text = country.alpha3Code
            
            flagImage.loadImageUsingUrlString(urlString: country.flag) { (complete) in
                if complete! {
                    self.activityIndicator.stopAnimating()
                }else{
                    print(complete!)
                }
            }
        }
    }
    
    public static func getNib() -> UINib{
        return UINib(nibName: countryCollectionViewCell, bundle: Bundle.main)
    }
}

