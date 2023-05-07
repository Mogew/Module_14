import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(for currency: PickerModel)
    func didFailWithError(error: Error)
}

struct CoinManager{
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "DAF917F0-2CBB-4090-AEF4-A32BC8D7EC41"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["USD","AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let request = baseURL + "/\(currency)" + "?apikey=" + apiKey
        performRequest(with: request)
    }
    
    func performRequest(with urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session task
            let task = session.dataTask(with: url, completionHandler: {data, response, error in
                guard error == nil else {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    parseJSON(safeData)
                }
            })
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data){
        // default JSON decoder
        let decoder = JSONDecoder()
        // if decoding will go wrong, we will catch an error
        do{
            // creating an object of type WeatherData and write data with the same var name inside object
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            delegate?.didUpdateCurrency(for: PickerModel(rate: rate))
        } catch {
            delegate?.didFailWithError(error: error)
        }
    }
}
