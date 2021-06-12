//
//  API.swift
//  CoronaInformationInJapan
//
//  Created by shunsuke.miyano on 2021/06/12.
//
import UIKit

struct CovidAPI {
    // @escapingを設定することでcompletionに渡すデータを関数外でも保持することができる
    static func getTotal(completion: @escaping (CoviInfo.Total) -> Void) {
        let url = URL(string:"http://covid19-japan-web-api.now.sh/api//v1/total")
        // アクセスできるかの保証がない。
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("error:\(error!.localizedDescription)")
            }
            if let data = data {
                let result = try! JSONDecoder().decode(CoviInfo.Total.self, from: data)
                completion(result)
            }
        }.resume()
    }
}
