//
//  SearchResultViewController.swift
//  MusicApp
//
//  Created by yujaehong on 2023/05/25.
//

import UIKit

final class SearchResultViewController: UIViewController {
    
    // 컬렉션뷰
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 컬렉션뷰의 레이아웃을 담당하는 객체! ⭐️⭐️⭐️
    let flowLayout = UICollectionViewFlowLayout()
    
    // 네트워크 매니저 (싱글톤)
    let networkManager = NetworkManger.shared
    
    // 음악 데이터를 다루기 위해 빈 배열로 시작!
    var musicArrays: [Music] = []
    
    // 서치바에서 검색을 위한 단어를 담는 변수 (전화면에서 전달받음)
    var searchTerm: String? {
        // 글자가 바뀔때마다 호출
        didSet{
            setupDatas()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        // 컬렉션뷰의 스크롤 방향설정
        flowLayout.scrollDirection = .vertical
        
        // 셀크기
        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell.spacingWitdh * (CVCell.cellColumns - 1)) / CVCell.cellColumns
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        
        // 아이템 사이 간격 설정
        flowLayout.minimumInteritemSpacing = CVCell.spacingWitdh
        // 아이템 위아래 사이 간격 설정
        flowLayout.minimumLineSpacing = CVCell.spacingWitdh
        
        // 컬렉션뷰의 속성에 할당 ⭐️⭐️
        collectionView.collectionViewLayout = flowLayout
    }
    
    func setupDatas() {
        guard let term = searchTerm else { return }
        print("네트워킹 시작 단어 \(term)")
        
        // 네트워킹 시작전 다시 빈 배열로 만들기
        self.musicArrays = []
        
        // 네트워킹 시작
        networkManager.fetchMusic(searchTerm: term) { result in
            switch result {
            case .success(let musicDatas):
                // 결과 배열에 담고
                self.musicArrays = musicDatas
                // 컬렉션뷰 리로드 (메인쓰레드에서)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicArrays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.musicCollectionViewCellIdentifier, for: indexPath) as! MusicCollectionViewCell
        cell.imageUrl = musicArrays[indexPath.item].imageUrl
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let current = musicArrays[indexPath.item]
        // let musicPlayViewController = MusicPlayViewController
        
        
    }
    
}
