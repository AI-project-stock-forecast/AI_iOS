//
//  ListsViewController.swift
//  stocks
//
//  Created by 홍태희 on 2022/05/12.
//

import UIKit
import SnapKit
import Then

class ListsViewController: UIViewController {
    
    @IBOutlet weak var listTable: UITableView?
    @IBOutlet weak var nav: UINavigationItem?
    
    let listSearch = UISearchController()
    
    var company : [stocks] = [] //모든 회사이름
    var filterCompany : [stocks] = [] //필터링된 회사이름
    
    var dummy = ["애플", "삼성", "테슬라", "현대", "대한항공", "제주여객", "애플", "삼성", "테슬라", "현대", "대한항공", "제주여객", "애플", "삼성", "테슬라", "현대", "대한항공", "제주여객"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listTable?.delegate = self
        listTable?.dataSource = self
        
        searches()
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
    
    func filteredContentForSearchText(_ searchText:String){
        filterCompany = company.filter( { (stocks) -> Bool in
            return stocks.name.lowercased().contains(searchText.lowercased())
        })
        listTable?.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(listSearch.searchBar.text ?? "")
    }
}

extension ListsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count //return company.count ( 약 100개정도? )
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listTable?.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! ListTableViewCell
        
        cell.company?.text = self.dummy[indexPath.row]
        cell.present?.text = "현재가"
        cell.presentmoney?.text = "280,000"
        cell.predicts?.text = "+30%"
        cell.deal?.text = "430,000"
        
        return cell
    }
    
}
