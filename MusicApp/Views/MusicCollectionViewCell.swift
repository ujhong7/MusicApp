//
//  MusicCollectionViewCell.swift
//  MusicApp
//
//  Created by yujaehong on 2023/05/26.
//

import UIKit

final class MusicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var mainImageView: UIImageView!
    
    // 이미지 URL을 전달받는 속성
    var imageUrl: String? {
        didSet{
            loadImage()
        }
    }
    
    // URL -> 이미지 셋팅하는 메서드
    private func loadImage() {
        // self.imageUrl이 비어있지 않고, URL 객체로 변환될 수 있는 유효한 문자열인 경우에만 계속해서 실행
        guard let urlString = self.imageUrl, let url = URL(string: urlString) else { return }
        
        // 오래걸리는 작업을 동시성 처리 (다른 쓰레드에서 일시킴)
        DispatchQueue.global().async {
            // URL을 가지고 데이터를 만드는 메서드 (오래걸리는데 동기적인 실행)
            // (일반적으로 이미지를 가져올때 사용)
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거!
            guard self.imageUrl! == url.absoluteString else { return }
            
            // 작업의 결과물을 이미지로 표시 (메인큐)
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
    // 셀이 재사용되기 전에 호출되는 메서드
    override func prepareForReuse() {
        super.prepareForReuse()
        // 일반적으로 이미지가 바뀌는 것처럼 보이는 현상을 없애기 위해서 실행
        self.mainImageView.image = nil
    }
}
