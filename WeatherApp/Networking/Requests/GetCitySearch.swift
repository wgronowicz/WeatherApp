struct CitySearchRequest: Request {
    var parameters = [String : String]()
    var method: RequestType = .GET
    var path: String = "locations/v1/cities/search"
    
    init(cityName: String, apiKey: String, language: String) {
        parameters["apikey"] = apiKey
        parameters["q"] = cityName
        parameters["language"] = language
    }
}
