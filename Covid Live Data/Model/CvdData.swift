//
//  CvdData.swift
//  CVD-19
//
//  Created by Yasar on 20.06.2020.
//  Copyright © 2020 Yasar. All rights reserved.
//

import Foundation

struct CvdData: Codable {
    let Countries: [Countries]
}

struct Countries: Codable {
    var Country: String
    var NewConfirmed: Double
    var TotalConfirmed: Double
    var NewDeaths: Double
    var TotalDeaths: Double
    var NewRecovered: Double
    var TotalRecovered: Double
}
