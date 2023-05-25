//
//  ViewController.swift
//  MusicApp
//
//  Created by yujaehong on 2023/05/25.
//

import UIKit

class ViewController: UIViewController {

    // SearchResultController
    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultController") as! SearchResultViewController)
    
    
    // 네트워크 매니저 (싱글톤)
    let networkManger = NetworkManger.shared
    
    // (음악 데이터를 다루기 위함) 빈배열로 시작
    var musicArrays: [Music] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    // 서치바 세팅
    func setupSearchBar() {
        self.title = "Music Search"
        
    }
    
    // 데이터 셋팅
    func setupDatas() {
        
    }
}

extension ViewController: UITableViewDataSource {
    
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UISearchResultsUpdating {
    
}

