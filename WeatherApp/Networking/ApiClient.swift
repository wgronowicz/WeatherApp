import Foundation
import RxSwift
import RxCocoa

final class ApiClient {
    private func send<T: Decodable>(apiRequest: Request) -> Observable<T> {
        let request = apiRequest.request(with: Constants.baseUrl)
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(T.self, from: data)
            }
            .observe(on: MainScheduler.asyncInstance)

    }
    
    func getCity(name: String?) -> Observable<[City]> {
        return self.send(
            apiRequest: CitySearchRequest(
                cityName: name ?? "",
                apiKey: Constants.apiKey,
                language: Constants.language
            )
        )
    }
    
    func getCurrentWeather(locationCode: String) -> Observable<[CurrentConditions]> {
        return self.send(
            apiRequest: CurrentConditionsRequest(
                locationCode: locationCode,
                apiKey: Constants.apiKey,
                language: Constants.language,
                details: Constants.details
            )
        )
    }
    
    private enum Constants {
        static let baseUrl: URL = URL(string: "http://dataservice.accuweather.com/")!
        static let apiKey: String = "9EGZ2gJEmWafWZvbSlmKZPu4eUfJeCPc"
        static let language: String = "pl-pl"
        static let details: String = "true"
    }
}
