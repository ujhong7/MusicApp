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
    
    @IBOutlet weak var musicTabelView: UITableView!
    
    // 네트워크 매니저 (싱글톤)
    let networkManger = NetworkManger.shared
    
    // (음악 데이터를 다루기 위함) 빈배열로 시작
    var musicArrays: [Music] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        setupTableView()
        setupDatas()
    }


    // 서치바 세팅
    func setupSearchBar() {
        self.title = "Music Search"
        navigationItem.searchController = searchController
        
        // SearchController의 사용 (복잡한 구현가능) -> 글자마다 검색 가능 + 새로운 화면을 보여주는 것도 가능
        searchController.searchResultsUpdater = self
        
        // 첫글자 대문자 없애기
        searchController.searchBar.autocapitalizationType = .none
    }
    
    // 테이블뷰 셋팅
    func setupTableView() {
        musicTabelView.dataSource = self
        musicTabelView.delegate = self
        
        // 🔴 Nib파일을 사용한다면 등록과정 필요
        musicTabelView.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
    }

    // 데이터 셋팅
    func setupDatas() {
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musicArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTabelView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MusicCell
        
        cell.imageUrl = musicArrays[indexPath.row].imageUrl // ⭐️⭐️⭐️⭐️
        
        cell.songNameLabel.text = musicArrays[indexPath.row].songName
        cell.artistNameLabel.text = musicArrays[indexPath.row].artistName
        cell.albumNameLabel.text = musicArrays[indexPath.row].albumName
        cell.releaseDateLabel.text = musicArrays[indexPath.row].releaseDateString
        
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    // 테이블뷰 셀의 높이를 유동적으로 조절하고 싶을때 구현하는 메서드
    // musicTabelView.rowHeight = 120 (대신 사용가능)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

// MARK: - 검색하는 동안 (새로운 화면을 보여주는) 복잡한 내용 구현 가능
extension ViewController: UISearchResultsUpdating {
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드 -> 일반적으로 다른 화면을 보여줄때 구현
    func updateSearchResults(for searchController: UISearchController) {
        print("서치바에 입력되는 단어", searchController.searchBar.text ?? "")
        // 글자를 치는 순간에 다른 화면을 보여주고 싶다면
        let vc = searchController.searchResultsController as! SearchResultViewController
        // 컬렉션뷰에 찾으려는 단어 전달
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
    
    
}

