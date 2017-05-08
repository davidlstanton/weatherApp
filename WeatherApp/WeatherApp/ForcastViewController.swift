//
//  ForcastViewController.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

class ForcastViewController: UIViewController {

    @IBOutlet weak var tableView: ForcastTableView!
    let dataProvider = WeekForecastController(networkService: OpenWeatherMapService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider.viewModelForForecast(cityId: 2648110) { (model, error) in
            if let error = error {
                //TO DO handle error
                print(error)
                return
            }
            if let model = model{
                self.tableView.setData(viewModel: model)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
