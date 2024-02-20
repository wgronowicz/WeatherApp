struct CurrentConditions: Decodable {
    let temperature: Temperature
    let weatherText: String
    
    enum CodingKeys: String, CodingKey {
        case temperature = "Temperature"
        case weatherText = "WeatherText"
    }
}

struct Temperature: Decodable {
    let metric: Metric
    
    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
    }
}

struct Metric: Decodable {
    let value: Float
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}
