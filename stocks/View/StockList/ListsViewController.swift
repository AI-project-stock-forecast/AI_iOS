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
    
    //get해온 데이터 저장할 배열 ( get data save array )
    var stockList = [[Any]]()
    
    
    let provider = MoyaProvider<moneyGraph>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listTable?.delegate = self
        listTable?.dataSource = self
        
        request()
//        searches()
    }
    
    func request() {
                
        provider.request(.getList) { (result) in
            switch result {
            case let .success(res):
                switch res.statusCode {
                case 200:
                    //decode here
                    
                    print(res)
                default:
                    print(res.statusCode)
                }
            case let .failure(error):
                print(error.localizedDescription)

            }
        }
        
        provider.request(.searchCode("KODEX 200선물인버스2X")) { result in
            switch result {
            case let .success(res):
                switch res.statusCode {
                case 200:
                    print(res)
                default:
                    print(res.statusCode)
                }
            case let .failure(error):
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
        return stockList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //검색했을 때 보이는 cell 설정은 어떻게?

        let cell = listTable?.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! ListTableViewCell

//        cell.company?.text = stockList[indexPath.row]
//        cell.present?.text = "현재가"
//        cell.presentmoney?.text = stockList[indexPath.row]
//        cell.predicts?.text = stockList[indexPath.row]
//        cell.deal?.text = stockList[indexPath.row]

        return cell
    }

}

