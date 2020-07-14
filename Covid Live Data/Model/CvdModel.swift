//
//  CvdModel.swift
//  CVD-19
//
//  Created by Yasar on 22.06.2020.
//  Copyright © 2020 Yasar. All rights reserved.
//

import Foundation
struct CvdModel {
    let nameString: String
    let newConfirmedNumber: Double
    let totalConfirmedNumber: Double
    let newDeathsNumber: Double
    let totalDeathsNumber: Double
    let newRecoveredNumber: Double
    let totalRecoveredNumber: Double
    
    var activeCases: String{
        return String(format: "%0.f", totalConfirmedNumber-totalDeathsNumber-totalRecoveredNumber)
    }
    
    var newConfirmedString: String{
        return String(format: "%.0f", newConfirmedNumber)
    }
    
    var totalConfirmedString: String{
        return String(format: "%.0f", totalConfirmedNumber)
    }
    var newDeathsString: String {
        return String(format: "%0.f", newDeathsNumber)
    }
    
    var totalDeathsString: String{
        return String(format: "%0.f", totalDeathsNumber)
    }
    var newRecoveredString: String{
        return String(format: "%0.f", newRecoveredNumber)
    }
    var totalRecoveredString: String{
        return String(format: "%0.f", totalRecoveredNumber)
    }
}
