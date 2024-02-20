struct City: Decodable {
    let localizedName: String
    let geoPosition: GeoPosition
    let administrativeArea: AdministrativeArea
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case localizedName = "LocalizedName"
        case geoPosition = "GeoPosition"
        case administrativeArea = "AdministrativeArea"
        case key = "Key"
    }
}

struct GeoPosition: Decodable {
    let latitude: Float
    let longitude: Float
    
    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}

struct AdministrativeArea: Decodable {
    let localizedName: String
    
    enum CodingKeys: String, CodingKey {
        case localizedName = "LocalizedName"
    }
}
