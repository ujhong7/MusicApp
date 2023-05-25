//
//  NetworkManager.swift
//  MusicApp
//
//  Created by yujaehong on 2023/05/25.
//

import Foundation

// MARK: - 네트워크에서 발생할 수 있는 에러 정의
enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

// MARK: - Networking (서버와 통신하는) 클래스 모델
final class NetworkManger {
    // 여러화면에서 통신을 한다면, 일반적으로 싱글톤으로 만듦
    static let shared = NetworkManger()
    
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
    
}

