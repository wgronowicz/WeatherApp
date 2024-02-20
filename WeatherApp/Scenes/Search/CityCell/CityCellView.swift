import UIKit

final class CityCellView: UIView {
    private let cityNameLabel = UILabel(frame: .zero)
    
    private let voivodshipNameLabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .gray
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.makeConstraints()
    }
    
    func setLabels(cityName: String, voivodshipName: String) {
        self.cityNameLabel.text = cityName
        self.voivodshipNameLabel.text = voivodshipName
    }
        
    private func makeConstraints() {
        addSubview(cityNameLabel)
        addSubview(voivodshipNameLabel)
        
        cityNameLabel.snp.makeConstraints { make in
            make.top.left.equalTo(24)
            make.bottom.equalTo(-24)
        }
        
        voivodshipNameLabel.snp.makeConstraints { make in
            make.top.equalTo(24)
            make.bottom.right.equalTo(-24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
