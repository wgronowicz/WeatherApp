import UIKit

final class CurrentConditionsView: UIView {
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font.withSize(40)
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font.withSize(30)
        label.textColor = .gray
        label.text = "Temperatura"
        return label
    }()

    private let temperatureValueLabel: UILabel = {
        let label = UILabel()
        label.font.withSize(30)
        return label
    }()
    
    
    init(viewData: CurrentConditionsViewData) {
        super.init(frame: .zero)
        temperatureValueLabel.text = viewData.temperatureText
        temperatureValueLabel.textColor = viewData.temperatureLabelColor
        setupViews()
        backgroundColor = .white
    }
    
    private func setupViews() {
        addSubview(temperatureLabel)
        addSubview(temperatureValueLabel)
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.left.equalTo(24)
        }
        
        temperatureValueLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.top)
            make.right.equalTo(-24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
