import RxSwift
import RxCocoa

final class SearchViewModel: ViewModel {
    private let apiClient: ApiClient

    struct Input {
        let searchText: Observable<String?>
        let searchButtonClicked: Observable<Void>
        let cityClicked: ControlEvent<City>
    }
    
    struct Output {
        let cities: Observable<[City]>
        let currentConditions: Observable<CurrentConditionsViewData>
    }
    
    init(
        apiClient: ApiClient
    ) {
        self.apiClient = apiClient
    }

    func transform(input: Input) -> Output {
        let cities = input.searchButtonClicked
            .withLatestFrom(input.searchText)
            .flatMap { cityName in
                self.apiClient.getCity(name: cityName)
            }
        
        let currentConditions = input.cityClicked
            .flatMap { city in
                self.apiClient.getCurrentWeather(locationCode: city.key)
            }
            .map { currentConditions -> CurrentConditionsViewData in
                return currentConditions[0].mapToViewData()
            }

        return Output(
            cities: cities,
            currentConditions: currentConditions
        )
    }
}
