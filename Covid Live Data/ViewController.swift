//
//  ViewController.swift
//  CVD-19
//
//  Created by Yasar on 20.06.2020.
//  Copyright © 2020 Yasar. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataManager.countryArray.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataManager.countryArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCountry = dataManager.countryArray[row]
        dataManager.rowNo = row
        dataManager.getCountry(with: selectedCountry)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newConfirmed: UILabel!
    @IBOutlet weak var totalConfirmed: UILabel!
    @IBOutlet weak var newDeaths: UILabel!
    @IBOutlet weak var totalDeaths: UILabel!
    @IBOutlet weak var newRecovered: UILabel!
    @IBOutlet weak var totalRecovered: UILabel!
    @IBOutlet weak var activeCases: UILabel!
    @IBOutlet weak var dateToday: UILabel!
    
    var dataManager = DataManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    @IBOutlet weak var pickerView: UIPickerView!

}

extension ViewController: DataManagerDelegate {
    
    func didUpdateData(_ dataManager: DataManager, cvd: CvdModel) {
        DispatchQueue.main.async {
            let date = Date()
            let format = DateFormatter()
            format.dateFormat = "dd-MM-yyy"
            self.titleLabel.text = cvd.nameString
            self.titleLabel.sizeToFit()
            self.newConfirmed.text = cvd.newConfirmedString
            self.totalConfirmed.text = cvd.totalConfirmedString
            self.newDeaths.text = cvd.newDeathsString
            self.totalDeaths.text = cvd.totalDeathsString
            self.newRecovered.text = cvd.newRecoveredString
            self.totalRecovered.text = cvd.totalRecoveredString
            self.activeCases.text = cvd.activeCases
            self.dateToday.text = "\(format.string(from: date))"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

