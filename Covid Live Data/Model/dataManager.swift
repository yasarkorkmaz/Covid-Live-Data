//
//  DataManager.swift
//  CVD-19
//
//  Created by Yasar on 20.06.2020.
//  Copyright © 2020 Yasar. All rights reserved.
//

import UIKit

protocol DataManagerDelegate {
    
    func didUpdateData(_ dataManager: DataManager, cvd: CvdModel)
    func didFailWithError(error: Error)
}

struct DataManager {
    
    var delegate: DataManagerDelegate?
    
    let baseURL = "https://api.covid19api.com/summary"
    let apiKey =  "PMAK-5eee0aff710555004ea31835-ab6aa9f5502a1a2123753b12ea0836d0c4b"
    
    func getCountry (with urlString:String) {
        
        let urlString = "\(baseURL)?apikey=\(apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let cvd = self.parseJSON(safeData) {
                        self.delegate?.didUpdateData(self, cvd: cvd)
                    }
                }
            }
            task.resume()
        }
    }
    
    var rowNo : Int = 1
    
    func parseJSON(_ cvdData: Data) -> CvdModel? {
        let decoder = JSONDecoder()
        do {
            
            let decodedData = try decoder.decode(CvdData.self, from: cvdData)
            let name = decodedData.Countries[rowNo].Country
            let newConfirmed = decodedData.Countries[rowNo].NewConfirmed
            let totalConfirmed = decodedData.Countries[rowNo].TotalConfirmed
            let newDeaths = decodedData.Countries[rowNo].NewDeaths
            let totalDeaths = decodedData.Countries[rowNo].TotalDeaths
            let newRecovered = decodedData.Countries[rowNo].NewRecovered
            let totalRecovered = decodedData.Countries[rowNo].TotalRecovered
            
            let cvd = CvdModel(nameString: name, newConfirmedNumber: newConfirmed, totalConfirmedNumber: totalConfirmed, newDeathsNumber: newDeaths, totalDeathsNumber: totalDeaths, newRecoveredNumber: newRecovered, totalRecoveredNumber: totalRecovered)
            return cvd
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    let countryArray = [ "Afghanistan","Albania","Algeria","Andorra","Angola","Antigua and Barbuda","Argentina","Armenia","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bhutan","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Brunei Darussalam","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo (Brazzaville)","Congo (Kinshasa)","Costa Rica","Croatia","Cuba","Cyprus","Czech Republic","Côte d'Ivoire","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Ethiopia","Fiji","Finland","France","Gabon","Gambia","Georgia","Germany","Ghana","Greece","Grenada","Guatemala","Guinea","Guinea-Bissau","Guyana","Haiti","Holy See (Vatican City State)","Honduras","Hungary","Iceland","India","Indonesia","Iran, Islamic Republic of","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Korea (South)","Kuwait","Kyrgyzstan","Lao PDR","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macedonia, Republic of","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palestinian Territory","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Qatar","Republic of Kosovo","Romania","Russian Federation","Rwanda","Saint Kitts and Nevis","Saint Lucia","Saint Vincent and Grenadines","San Marino","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","Somalia","South Africa","South Sudan","Spain","Sri Lanka","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syrian Arab Republic (Syria)","Taiwan, Republic of China","Tajikistan","Tanzania, United Republic of","Thailand","Timor-Leste","Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States of America","Uruguay","Uzbekistan","Venezuela (Bolivarian Republic)","Viet Nam","Western Sahara","Yemen","Zambia","Zimbabwe" ]
}
