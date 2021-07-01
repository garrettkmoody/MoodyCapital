//
//  Tab2ViewController.swift
//  MoodyCapital
//
//  Created by Garrett Moody on 6/25/21.
//

import UIKit
import Charts
import Firebase

class Tab2ViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var mainSV: UIStackView!
    
    @IBOutlet weak var nameLB: UILabel!
    
    @IBOutlet weak var percentLB: UILabel!
    
    @IBOutlet weak var holdingValueLB: UILabel!
    
    var lineChart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        
        // Do any additional setup after loading the view.
        formatViews()
        retrieveFireBaseData()
        
    }
    
    func trunc(thisNum : Double, places : Int)-> Double {
            return Double(floor(pow(10.0, Double(places)) * thisNum)/pow(10.0, Double(places)))
        }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lineChart.frame = CGRect(x:0, y: 0, width: self.view.frame.size.width - 20, height: self.view.frame.size.height - self.view.frame.size.height/1.7)
        lineChart.center = view.center
        lineChart.extraTopOffset = 40
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
    
    func retrieveFireBaseData() {
        
        var initial:Double = 0
        var share:Double = 0
        
        let user = Auth.auth().currentUser
        let ref = Database.database().reference().child("users").child(user!.uid).child("username")
        
        
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if let username = snapshot.value as? String {
                
                UIView.transition(with: self.nameLB,
                              duration: 0.25,
                               options: .transitionCrossDissolve,
                            animations: { [weak self] in
                                self?.nameLB.text = username
                         }, completion: nil)
            }
        })
        
        let ref2 = Database.database().reference().child("users").child(user!.uid)
        

        ref2.observeSingleEvent(of: .value, with: { snapshot in
            
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                switch snap.key {
                case "initial":
                    initial = snap.value as! Double
                case "share":
                    share = snap.value as! Double
                default:
                    print("Not in list")
                }
                
            }
            
        })
        
        let ref3 = Database.database().reference().child("holdings")

        ref3.observeSingleEvent(of: .value, with: { (snapshot) in

            if let balance = snapshot.value as? Double {

                let balanceTruncated = self.trunc(thisNum: balance * share, places: 2)
                
                let percent = self.trunc(thisNum: (balanceTruncated / initial - 1) * 100, places: 2)

                UIView.transition(with: self.holdingValueLB,
                              duration: 0.25,
                               options: .transitionCrossDissolve,
                            animations: { [weak self] in
                                self?.holdingValueLB.text = "$\(balanceTruncated)"
                         }, completion: nil)
                
                
                UIView.transition(with: self.percentLB,
                              duration: 0.25,
                               options: .transitionCrossDissolve,
                            animations: { [weak self] in
                                self?.percentLB.text = "\(percent)%"
                         }, completion: nil)
            }
        })
        
        
        
    }
    
    func formatViews() {
        nameLB.text = " "
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
