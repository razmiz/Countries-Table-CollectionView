//
//  JsonParser.swift
//  Countries-Table + CollectionView
//
//  Created by Raz on 24/05/2020.
//  Copyright © 2020 Raz. All rights reserved.
//

import Foundation
import UIKit

class JsonParser {
    
    let url = URL(string: "https://restcountries.eu/rest/v2/all")
//    var region: [Region]!
    var country: [Country]!
   
    public func parseCountryJsonFromUrl(completion: @escaping ([Country]) -> ()) {
        if let url = url {
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        self.country = try
                            JSONDecoder().decode([Country].self, from: data)
                        
                        completion(self.country)
                    } catch let error {
                        print(error)
                    }
                }
                
            }.resume()
        }
    }
    
    

}
