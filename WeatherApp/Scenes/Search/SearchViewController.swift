import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController, UITableViewDelegate {
    
    private let mainView: SearchView
    private let viewModel: SearchViewModel
    
    private let disposeBag = DisposeBag()
    
    init(
        mainView: SearchView,
        viewModel: SearchViewModel
    ) {
        self.mainView = mainView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        mainView.setup()
        setupTableView()
        bind()
        title = "Wyszukaj miasto"
        mainView.searchBar.searchTextField.delegate = self
    }
    
    private func bind() {
        let output = viewModel.transform(
            input: SearchViewModel.Input(
                searchText: mainView.searchBar.rx.text.asObservable(),
                searchButtonClicked: mainView.searchBar.rx.searchButtonClicked.asObservable(),
                cityClicked: mainView.tableView.rx.modelSelected(City.self)
            )
        )
        
        output.cities
            .catchAndReturn([])
            .bind(to: mainView.tableView.rx.items(
                cellIdentifier: "cell",
                cellType: CityCell.self)
            ) { index, element, cell in
                cell.view.setLabels(
                    cityName: element.localizedName,
                    voivodshipName: element.administrativeArea.localizedName
                )
            }
            .disposed(by: disposeBag)
        
        output.currentConditions
            .subscribe { viewData in
                let viewController = UIViewController()
                viewController.view = CurrentConditionsView(viewData: viewData)
                self.navigationController?.pushViewController(
                    viewController,
                    animated: true
                )
            }
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        self.mainView.tableView.register(CityCell.self, forCellReuseIdentifier: "cell")

        mainView.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        mainView.tableView.rx
            .itemSelected
            .subscribe(onNext: { index in
                self.mainView.tableView.deselectRow(at: index, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-zĄąĆćĘęŁłŃńÓóŚśŹźŻż ].*", options: [])
            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                return false
            }
        }
        catch {
            print("ERROR")
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
