//
//  ThermalChart.swift
//  group3_PhysicsApp
//
//  Created by Steven Egerszegi on 2018-12-02.
//  Copyright © 2018 Period Three. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ThermalChart : UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChartValues(count: temperatures.count)
        
    }
    
    
    func setChartValues(count: Int){
        
        //let values = (0..<count).map { (i) -> ChartDataEntry in
         //   let val = Double(arc4random_uniform(UInt32(count)) + 3)
         //   return ChartDataEntry(x: Double(i), y: val)
        //}
        
        let values = (0..<count).map { (i) -> ChartDataEntry in
               let val = temperatures[i]//Double(arc4random_uniform(UInt32(count)) + 3)
               return ChartDataEntry(x: times[i], y: val)
            }
        
        //for i in 0..<times.count{
        //ChartDataEntry(x: times[i], y: temperatures[i])
        //}
        
        
        let set1 = LineChartDataSet(values: values, label: "DataSet 1")
        let data = LineChartData(dataSet: set1)
        self.lineChartView.data = data
        
    }
    
    @IBAction func backToScene(_ sender: UIButton) {
        temperatures.removeAll()
        times.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
    
}

