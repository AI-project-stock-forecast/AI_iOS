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
    @IBOutlet weak var nowpresent : LineChartView?
    @IBOutlet weak var onefuture : LineChartView?
    
    @IBOutlet weak var company: UILabel? //회사
    @IBOutlet weak var today: UILabel? //현재가
    @IBOutlet weak var predict: UILabel? //예측률
    
    //값을 서버에서 어떤식으로 받을진 잘 모르겠다..
    var times : [String]! //시각
    var pastValue : [Double]! //값 ( 1주 전 )
    var presentValue : [Double]! //값 ( 현재 )
    var futureValue : [Double]! //값 ( 1주 후 )
    
    var dummy = ["애플", "삼성", "테슬라", "현대", "대한항공", "제주여객", "애플", "삼성", "테슬라", "현대", "대한항공", "제주여객", "애플", "삼성", "테슬라", "현대", "대한항공", "제주여객"]
    
    @IBAction func switchGraph(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            onepast?.alpha = 1.0
            nowpresent?.alpha = 0.0
            onefuture?.alpha = 0.0
            setPast(dates: times, values: pastValue)
        } else if sender.selectedSegmentIndex == 1 {
            onepast?.alpha = 0.0
            nowpresent?.alpha = 1.0
            onefuture?.alpha = 0.0
            setPresent(dates: times, values: presentValue)
        } else {
            onepast?.alpha = 0.0
            nowpresent?.alpha = 0.0
            onefuture?.alpha = 1.0
            setFuture(dates: times, nowValue: futureValue, predictValue: pastValue)
        }
    }
    
    func setPast(dates : [String], values : [Double]) {
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dates.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "판매량")

        // 차트 컬러
        chartDataSet.colors = [.systemBlue]

        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        onepast?.data = chartData
        
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        
        // 줌 안되게
        onepast?.doubleTapToZoomEnabled = false
        
        // X축 레이블 위치 조정
        onepast?.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        onepast?.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)

        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        onepast?.xAxis.setLabelCount(dates.count, force: false)
        // 오른쪽 레이블 제거
        onepast?.rightAxis.enabled = false
    }
    
    func setPresent(dates : [String], values : [Double]) {
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dates.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let stockDataSet = LineChartDataSet(entries: dataEntries, label: "상장")
        stockDataSet.colors = [.systemRed]
        
        stockDataSet.lineWidth = 2.0
        stockDataSet.circleRadius = 2.0
        stockDataSet.mode = .cubicBezier

        let stockData = LineChartData(dataSet: stockDataSet)
        nowpresent?.data = stockData
        
        stockDataSet.highlightEnabled = false
        nowpresent?.xAxis.labelPosition = .bottom
        nowpresent?.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        nowpresent?.doubleTapToZoomEnabled = false
        nowpresent?.xAxis.setLabelCount(dates.count, force: false)
        nowpresent?.rightAxis.enabled = false
    }
    
    func setFuture(dates : [String], nowValue : [Double], predictValue : [Double]) {
        
        // 데이터 생성
        var nowEntries: [BarChartDataEntry] = []
        //var predictEntries : [BarChartDataEntry] = []
        
        for i in 0..<dates.count {
            let nowEntry = BarChartDataEntry(x: Double(i), y: nowValue[i])
            nowEntries.append(nowEntry)
        }
        
        let nowDataSet = LineChartDataSet(entries: nowEntries, label: "현재")
        nowDataSet.colors = [.systemRed]
        
        nowDataSet.lineWidth = 2.0
        nowDataSet.circleRadius = 2.0
        nowDataSet.mode = .cubicBezier
        
        let nowData = LineChartData(dataSet: nowDataSet)
        onefuture?.data = nowData
        
        nowDataSet.highlightEnabled = false
        
        onefuture?.xAxis.labelPosition = .bottom
        onefuture?.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        onefuture?.doubleTapToZoomEnabled = false
        onefuture?.xAxis.setLabelCount(dates.count, force: false)
        onefuture?.rightAxis.enabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        times = ["9:00", "10:00", "11:00", "12:00", "13:00"]
        pastValue = [20.0, 4.0, 6.0, 3.0, 12.0]
        presentValue = [30.0, 5.0, 10.0, 7.0, 20.0]
        futureValue = [6.0, 3.0, 12.0, 16.0, 9.0]

        setPast(dates: times, values: pastValue)
        
        //서버에서 받을때는 [String]이 아니라 String이므로.. 에러날일 없을듯함.
        //company?.text = dummy
    }

}
