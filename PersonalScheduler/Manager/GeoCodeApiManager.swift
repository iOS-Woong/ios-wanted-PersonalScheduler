//
//  GeoCodeApiManager.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/18.
//

import Foundation

struct GeoCodeApiManager {
    
    func requestGeoCode(coords: Coords, completion: @escaping (Result<ReverseGeoCode, Error>) -> Void) {
        let urlString = makeUrl(coords: coords)
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
    
    private func makeUrl(coords: Coords) -> String {
        let coordsString = "coords=\(coords.longitude),\(coords.latitude)"
        let urlString = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&\(coordsString)&sourcecrs=epsg:4326&output=json&orders=addr,admcode,roadaddr"
        return urlString
    }
    
}





/*
 https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=128.12345,37.98&output=json
 
 https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=129.1133567,35.2982640&output=json

 request=coordsToaddr
 orders=addr,admcode
 강원 인제군 남면 부평리 2-61

 기기에서 좌표값 받아오기(필요없음) ->

 계정생성 시
 1. 기사의 등록지역을 기점으로 ~~~~범위의 좌표값을 임의로 10개 주어지게함.
 2. 계정 생성 시, 10개의 좌표로 Data를 세팅하도록 한다.

 임의 호출 시
 1. 기사의 등록지역을 기점으로 ~~~~범위의 좌표값을 임의로 호출을 생성한다.
 2. 무작위로 호출란으로 이동시키고, 호출을 생성한다.
 3. 터치하여 체크할 경우, 이용내역으로 이동시키고 호출란의 임의값은 삭제시킨다.
 */
