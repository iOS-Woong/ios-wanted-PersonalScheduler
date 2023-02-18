//
//  GeoCodeApiManager.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/18.
//

import Foundation

struct GeoCodeApiManager {
    
    func requestGeoCode(completion: @escaping (Result<ReverseGeoCode, Error>) -> Void) {
        let urlString = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=127.0848893846015,37.58365547054592&sourcecrs=epsg:4326&output=json&orders=addr,admcode,roadaddr"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue(AppKeys.naverApplicationId, forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
        request.setValue(AppKeys.naverApplicationpw, forHTTPHeaderField: "X-NCP-APIGW-API-KEY")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("에러: \(error.localizedDescription)")
                return
            }
            
            let response = response as? HTTPURLResponse
            print(response?.statusCode)
            
            do {
                guard let data = data else { return }
                let decode = try JSONDecoder().decode(ReverseGeoCode.self , from: data)
                completion(.success(decode))
                print(decode)
            } catch {
                print(error.localizedDescription)
                print("디코드실패")
            }
        }.resume()
    }
}

// MARK: - ReverGeoCode
struct ReverseGeoCode: Codable {
    let results: [Results]
}

// MARK: - Result
struct Results: Codable {
    let region: Region
    let land: Land?
}

// MARK: - Land
struct Land: Codable {
    let type, number1, number2: String
    let name: String?
}

// MARK: - Region
struct Region: Codable {
    let area0: Area
    let area1: Area1
    let area2, area3, area4: Area
}

// MARK: - Area
struct Area: Codable {
    let name: String
}

// MARK: - Area1
struct Area1: Codable {
    let name: String
    let alias: String
}





/*
 https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=128.12345,37.98&output=json
 
 https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=129.1133567,35.2982640&output=json

 request=coordsToaddr
 orders=addr,admcode
 강원 인제군 남면 부평리 2-61
 */
