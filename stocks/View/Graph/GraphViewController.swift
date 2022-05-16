//
//  GraphViewController.swift
//  stocks
//
//  Created by 홍태희 on 2022/05/12.
//

import UIKit
import Charts

class GraphViewController: UIViewController {
    
    @IBOutlet weak var onepast : BarChartView?
    @IBOutlet weak var nowpresent : BarChartView?
    @IBOutlet weak var onefuture : BarChartView?
    
    var months : [String]!
    var percent : [Double]!

    @IBAction func switchGraph(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            onepast?.alpha = 1.0
            nowpresent?.alpha = 0.0
            onefuture?.alpha = 0.0
        } else if sender.selectedSegmentIndex == 1 {
            onepast?.alpha = 0.0
            nowpresent?.alpha = 1.0
            onefuture?.alpha = 0.0
        } else {
            onepast?.alpha = 0.0
            nowpresent?.alpha = 0.0
            onefuture?.alpha = 1.0
        }
    }
    
    func setChart(dataPoints : [String], values : [Double]) {
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "판매량")
        let stockDataSet = LineChartDataSet(entries: dataEntries, label: "상장")

        // 차트 컬러
        chartDataSet.colors = [.systemBlue]
        stockDataSet.colors = [.systemRed]

        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        onepast?.data = chartData
        
        let stockData = LineChartData(dataSet: stockDataSet)
        nowpresent?.data = stockData
        
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        stockDataSet.highlightEnabled = false
        // 줌 안되게
        onepast?.doubleTapToZoomEnabled = false
        nowpresent?.doubleTapToZoomEnabled = false
        onefuture?.doubleTapToZoomEnabled = false

        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        onepast?.xAxis.setLabelCount(dataPoints.count, force: false)
        nowpresent?.xAxis.setLabelCount(dataPoints.count, force: false)
        // 오른쪽 레이블 제거
        onepast?.rightAxis.enabled = false
        nowpresent?.rightAxis.enabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        percent = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(dataPoints: months, values: percent)
    }

}
