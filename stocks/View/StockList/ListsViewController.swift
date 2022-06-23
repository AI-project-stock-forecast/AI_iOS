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
    
    //get해온 데이터 저장할 배열
    var nameData : [String] = [] //String
    var presentData : [Any] = [] //Int
    var upside : [Any] = [] //String
    var trade : [Any] = [] //String
    
    let provider = MoyaProvider<moneyGraph>()
    
    var filterCompany : [stocks] = [] //필터링된 회사이름
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listTable?.delegate = self
        listTable?.dataSource = self
        
        request()
        searches()
    }
    
    func request() {
        
        //code는 검색할 때 사용?
        
        provider.request(.name) { (result) in
            switch result {
            case let .success(response) :
                //let result = try? JSONDecoder().decode([stocks].self, from: response.data)
                let result = try? response.mapJSON()
                
                DispatchQueue.main.sync {
                    self.nameData = result as! [String] //받아온 데이터 namedata에 저장
                    self.listTable?.reloadData()
                }
            case let .failure(error) :
                print(error.localizedDescription)
            }
        }
        
        provider.request(.currentPrice) { (result) in
            switch result {
            case let .success(response) :
                let result = try? JSONDecoder().decode([stocks].self, from: response.data)
                
                DispatchQueue.main.sync {
                    self.presentData = result!
                    self.listTable?.reloadData()
                }
            case let .failure(error) :
                print(error.localizedDescription)
            }
        }
        
        provider.request(.upsidePredictionRate) { (result) in
            switch result {
            case let .success(response) :
                let result = try? JSONDecoder().decode([stocks].self, from: response.data)
                
                DispatchQueue.main.sync {
                    self.upside = result!
                    self.listTable?.reloadData()
                }
            case let .failure(error) :
                print(error.localizedDescription)
            }
        }
        
        provider.request(.tradingVolume) { (result) in
            switch result {
            case let .success(response) :
                let result = try? JSONDecoder().decode([stocks].self, from: response.data)
                
                DispatchQueue.main.sync {
                    self.trade = result!
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
        
        //listSearch.searchResultsUpdater = self
        listSearch.obscuresBackgroundDuringPresentation = false
        listSearch.hidesNavigationBarDuringPresentation = false
    }
}

//extension ListsViewController : UISearchResultsUpdating {
//
//    func filteredContentForSearchText(_ searchText:String) {
//        filterCompany = nameData.filter( { (stocks) -> Bool in
//            return (stocks.name.lowercased().contains(searchText.lowercased()))
//        })
//        listTable?.reloadData()
//    }
//
//    func updateSearchResults(for searchController: UISearchController) {
//        filteredContentForSearchText(listSearch.searchBar.text ?? "")
//    }
//}

extension ListsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //검색했을 때 보이는 cell 설정은 어떻게?
        
        let cell = listTable?.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! ListTableViewCell

        cell.company?.text = nameData[indexPath.row]
        cell.present?.text = "현재가"
        cell.presentmoney?.text = presentData[indexPath.row] as? String
        cell.predicts?.text = upside[indexPath.row] as? String
        cell.deal?.text = trade[indexPath.row] as? String
        
        return cell
    }
    
}
