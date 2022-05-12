//
//  ListsViewController.swift
//  stocks
//
//  Created by 홍태희 on 2022/05/12.
//

import UIKit
import SnapKit

class ListsViewController: UIViewController {

    @IBOutlet weak var listSearch: UISearchBar?
    @IBOutlet weak var listTable: UITableView?
    
    var allStockData : [stocks] = [] //모든 데이터
    var filterStockData : [stocks] = [] //필터링된 데이터
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listTable?.delegate = self
        listTable?.dataSource = self
    }
    
}

extension ListsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listTable?.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! ListTableViewCell
        
        cell.company?.text = "AAPL"
        cell.present?.text = "현재가"
        cell.presentmoney?.text = "280,000"
        cell.predicts?.text = "+30%"
        cell.deal?.text = "430,000"
        
        return cell
    }
    
}
