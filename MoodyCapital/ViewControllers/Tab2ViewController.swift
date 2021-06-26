//
//  Tab2ViewController.swift
//  MoodyCapital
//
//  Created by Garrett Moody on 6/25/21.
//

import UIKit
import Charts

class Tab2ViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var mainSV: UIStackView!
    
    var lineChart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        // Do any additional setup after loading the view.
        formatViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lineChart.frame = CGRect(x:0, y: 0, width: self.view.frame.size.width - 20, height: self.view.frame.size.height - self.view.frame.size.height/1.7)
        lineChart.center = view.center
        view.addSubview(lineChart)
        
        var entries = [ChartDataEntry]()
        for x in 0..<7 {
            entries.append(ChartDataEntry(x: Double(x), y: Double(x+x*x-1)))
        }
        let set = LineChartDataSet(entries: entries, label: "Holdings Value $")
        set.drawValuesEnabled = false
        set.valueFont = UIFont.boldSystemFont(ofSize: 24)
//        set.colors = ChartColorTemplates.joyful()
        let data = LineChartData(dataSet: set)
        lineChart.data = data
    }
    
    func formatViews() {
        mainSV.backgroundColor = UIColor(red: 0.2, green: 0.5, blue: 1, alpha: 0.3)
        mainSV.layer.cornerRadius = 20
//        mainSV.layer.shadowColor = UIColor.black.cgColor
//        mainSV.layer.shadowOpacity = 0.5
//        mainSV.layer.shadowOffset = .zero
//        mainSV.layer.shadowRadius = 30
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
