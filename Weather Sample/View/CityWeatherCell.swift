//
//  CityWeatherCell.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import UIKit

protocol CityWeatherCellDelegate: class {
    func cityWeatherSelected(model: CityWeatherCellViewModel)
}

class CityWeatherCell: TouchableTableViewCell {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    weak var delegate: CityWeatherCellDelegate?
    
    var viewModel: CityWeatherCellViewModel? {
        didSet {
            self.fillTheView(data: viewModel)
        }
    }
    
    
    func fillWith(initialData: CityWeatherCellViewModel, delegate: CityWeatherCellDelegate)  {
        self.delegate = delegate
        self.prepareForReuse()
        self.viewModel = initialData
        initialData.loadFullData {
            self.viewModel = $0
        }
    }
    
    
    override func prepareForReuse() {
        loader.isHidden = true
        cityName.text = ""
        subtitleLabel.text = nil
        weatherIcon.image = nil
    }
    
    private func fillTheView(data: CityWeatherCellViewModel?) {
        guard let data = data else {
            self.prepareForReuse()
            return
        }
        loader.isHidden = !data.isLoading
        if !loader.isHidden { loader.startAnimating()}
        cityName.text = data.title
        subtitleLabel.text = data.subTitle
        weatherIcon.load(url: data.iconURL)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            guard let delegate = delegate,
                  let viewModel = viewModel else {
                return
            }
            delegate.cityWeatherSelected(model: viewModel)
        }
    }
}
