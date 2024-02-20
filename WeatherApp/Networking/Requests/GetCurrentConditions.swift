struct CurrentConditionsRequest: Request {
    var parameters = [String : String]()
    var method: RequestType = .GET
    var path: String
    
    init(locationCode: String, apiKey: String, language: String, details: String) {
        self.path = "currentconditions/v1/\(locationCode)"
        parameters["apikey"] = apiKey
        parameters["language"] = language
        parameters["details"] = details
    }
}
