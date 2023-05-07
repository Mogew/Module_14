//
import Foundation

extension Double {
    func round(to places: Int) -> Double {
        let precisionNumber = pow(10, Double(places))
        var n = self
        n = n * precisionNumber
        n.round()
        n = n / precisionNumber
        return n
    }
}

struct PickerModel {
    var rate: Double
    
    var rateString: String {
        String(rate.round(to: 2))
    }
}
