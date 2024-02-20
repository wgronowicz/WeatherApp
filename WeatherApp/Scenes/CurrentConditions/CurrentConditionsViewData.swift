import UIKit

struct CurrentConditionsViewData {
    let temperatureText: String
    let temperatureLabelColor: UIColor
}

extension CurrentConditions {
    func mapToViewData() -> CurrentConditionsViewData {
        let temperature = temperature.metric.value.rounded()
        var temperatureLabelColor: UIColor
        
        if temperature < 10 {
            temperatureLabelColor = .blue
        } else if temperature >= 10 && temperature <= 20 {
            temperatureLabelColor = .black
        } else {
            temperatureLabelColor = .red
        }

        return CurrentConditionsViewData(
            temperatureText: temperature.description + "°C",
            temperatureLabelColor: temperatureLabelColor
        )
    }
}
