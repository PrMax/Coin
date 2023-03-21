

import UIKit

class ViewController: UIViewController {
    
    var priceManager = PriceManager()
    
    // Declare UIPickerView, UILabel to display selected currency, and UILabel to display selected price
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var currencyView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set PriceManager delegate to this ViewController
        priceManager.delegate = self
        
        // Set UIPickerView data source and delegate to this ViewController
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    // Private method to update UI with fetched price data and currency
    private func updateUIWithPriceData(_ priceData: PriceData, forCurrency currency: String) {
        DispatchQueue.main.async {
            self.priceView.text = String(priceData.price)
            self.currencyView.text = currency
        }
    }
}

// Extension for PriceManagerDelegate
extension ViewController: PriceManagerDelegate {
    // Method called when PriceManager successfully fetches price data for selected currency
    func didUpdatePriceData(_ priceData: PriceData, forCurrency currency: String) {
        updateUIWithPriceData(priceData, forCurrency: currency)
    }
    
    // Method called when PriceManager fails to fetch price data for selected currency
    func didFailWithError(_ error: Error) {
        DispatchQueue.main.async {
            let errorMessage = error.localizedDescription
            let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// Extension for UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    // Method to specify the number of components in UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Method to specify the number of rows in UIPickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priceManager.dataArray.count
    }
}

extension ViewController: UIPickerViewDelegate {
    // Specify which lines to display in UIPickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priceManager.dataArray[row]
    }
    
    // Specify what happens when the user selects a row in the UIPickerView
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priceManager.fetchPrice(for: priceManager.dataArray[row])
    }
}
