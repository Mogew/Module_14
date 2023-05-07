//
//  ViewController.swift
//  SB_Module_14
//
//  Created by Renat on 07.05.2023.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CoinManagerDelegate
{
    var model = CoinManager()

    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        // Do any additional setup after loading the view.
        //fef
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return model.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentCurrency = model.currencyArray[row]
        model.getCoinPrice(for: currentCurrency)
        return currencyNameLabel.text = currentCurrency
    }
    func didUpdateCurrency(for model: PickerModel) {
        DispatchQueue.main.async {
            self.rate.text = model.rateString
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
   

}

