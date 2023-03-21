
import Foundation

// Protocol to define delegate methods for PriceManager
protocol PriceManagerDelegate {
    func didUpdatePriceData(_ priceData: PriceData, forCurrency currency: String)
    func didFailWithError(_ error: Error)
}

// Struct to manage fetching and parsing price data for cryptocurrency
struct PriceManager {
    
    // Delegate for PriceManager
    var delegate: PriceManagerDelegate?
    
    // Array of currencies to be used to populate UIPickerView
    let dataArray = ["AUD", "USD", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PLN", "RON", "RUB", "SEK", "SGD", "ZAR"]
    
    // Fetches the price data for given currency using coinapi.io API
    func fetchPrice(for currency: String) {
        let apiKey = "F26B165D-C527-4177-9315-692CE4032957"
        let urlString = "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString, currency: currency)
    }
    
    // Performs a network request to fetch price data from API
    func performRequest(with urlString: String, currency: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                // Handle errors in network request
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                // If data is received, parse it and call delegate method
                if let safeData = data {
                    if let priceData = self.parseJSON(safeData) {
                        self.delegate?.didUpdatePriceData(priceData, forCurrency: currency)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    // Parse the JSON data received from the API
    func parseJSON(_ priceData: Data) -> PriceData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PriceData.self, from: priceData)
            return decodedData
        } catch {
            // Handle JSON decoding errors and call delegate method
            self.delegate?.didFailWithError(error)
            return nil
        }
    }
    
}

