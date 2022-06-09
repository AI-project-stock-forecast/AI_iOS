//
//  ListsViewController.swift
//  stocks
//
//  Created by 홍태희 on 2022/05/12.
//

import UIKit
import Moya

class ListsViewController: UIViewController {
    
    @IBOutlet weak var listTable: UITableView?
    @IBOutlet weak var nav: UINavigationItem?
    
    let listSearch = UISearchController()
    
    var stockData : [stocks] = []
    var stockD : stocks? //cellData
    let provider = MoyaProvider<moneyGraph>()
    
    var filterCompany : [stocks] = [] //필터링된 회사이름
    
    var dummy = ["애플", "삼성", "테슬라", "현대", "대한항공", "제주여객", "애플", "삼성", "테슬라", "현대", "대한항공", "제주여객", "애플", "삼성", "테슬라", "현대", "대한항공", "제주여객"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listTable?.delegate = self
        listTable?.dataSource = self
        
        requests()
        searches()
    }
    
    func requests() {
        
        //하나씩? 그룹으로 묶고 하나에 다?
        provider.request(.name) { (result) in
            switch result {
            case let .success(response) :
                let result = try? JSONDecoder().decode([stocks].self, from: response.data)
                
                DispatchQueue.main.sync {
                    self.stockData = result!
                    self.listTable?.reloadData()
                }
            case let .failure(error) :
                print(error.localizedDescription)
            }
        }
    }
    
    func searches() {
        
        listSearch.searchBar.placeholder = "회사명을 입력해주세요"
        
        nav?.titleView = listSearch.searchBar
        nav?.hidesSearchBarWhenScrolling = false
        
        listSearch.searchResultsUpdater = self
        listSearch.obscuresBackgroundDuringPresentation = false
        listSearch.hidesNavigationBarDuringPresentation = false
    }
}

extension ListsViewController : UISearchResultsUpdating {
    
    func filteredContentForSearchText(_ searchText:String) {
        filterCompany = stockData.filter( { (stocks) -> Bool in
            return (stocks.name.lowercased().contains(searchText.lowercased()))
        })
        listTable?.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(listSearch.searchBar.text ?? "")
    }
}

extension ListsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listTable?.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! ListTableViewCell
        
        cell.company?.text = "\(String(describing: stockD? .name))" //dummy의 type는 [String]
        cell.present?.text = "현재가"
        cell.presentmoney?.text = "\(String(describing: stockD?.currentPrice))"
        cell.predicts?.text = "\(String(describing: stockD?.upsidePredictionRate))"
        cell.deal?.text = "\(String(describing: stockD?.tradingVolume))"
        
        return cell
    }
    
}
