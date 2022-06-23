//
//  GraphViewController.swift
//  stocks
//
//  Created by 홍태희 on 2022/05/12.
//

import UIKit
import Charts

class GraphViewController: UIViewController {
    
    @IBOutlet weak var nowPresent: CandleStickChartView?
    
    @IBOutlet weak var company: UILabel? //회사
    @IBOutlet weak var today: UILabel? //현재가
    @IBOutlet weak var predict: UILabel? //예측률
    
    func formattString(string : String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0
    }
    
    //그래프 변수 설정 : 서버에 나온대로 제작 예정
    func setPresent(graph : [datas]) {
        
        //데이터 생성 ( x = 회사이름, y = 값 ( 현재 / 예측 ) )
        let entries = graph.compactMap { [weak self] overview -> BarChartDataEntry? in
            guard let self = self else { return nil }
                return BarChartDataEntry(
                    x: self.formattString(string: overview.title),
                    y: self.formattString(string: overview.description)
                )
        }

        let presentChart1 = LineChartDataSet(entries: entries, label: "")
        presentChart1.lineDashLengths = [0]
        presentChart1.colors = [.blue]
        presentChart1.highlightEnabled = false
        presentChart1.drawCirclesEnabled = false
                
        let presentChart2 = LineChartDataSet(entries: entries, label: "")
        presentChart2.lineDashLengths = [10]
        presentChart2.colors = [.red]
        presentChart2.highlightEnabled = false
        presentChart2.drawCirclesEnabled = false
                
        // 데이터 삽입
        let chartData = LineChartData(dataSet: [presentChart1, presentChart2] as! ChartDataSetProtocol)
        nowPresent?.data = chartData

        nowPresent?.doubleTapToZoomEnabled = false

        nowPresent?.xAxis.labelPosition = .bottom
                
        // X축 레이블 포맷 지정
        //onepast?.xAxis.valueFormatter = IndexAxisValueFormatter(values: <#T##[String]#>)
        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        nowPresent?.xAxis.setLabelCount(graph.count, force: false)
        nowPresent?.rightAxis.enabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //서버 통신이 성공했을 때, 실패했을 때
    }

}
