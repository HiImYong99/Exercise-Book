//
//  CoinJson.swift
//  Exercise Book
//
//  Created by 김용태 on 2023/02/23.
//

import UIKit

protocol CoinDelegate {
    func didupdate(data: Coin)
}

struct CoinJson {
    
    var delegate: CoinDelegate?
    
    func fetchCoin(){
            let urlString = "https://api.upbit.com/v1/ticker?markets=KRW-BTC"
            performRequest(with: urlString)
        }
    
    func performRequest(with urlString: String) {
            if let url = URL(string: urlString){
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) {data, response, error in
                    if error != nil {
                        print(error)
                        return
                    }
                    if let safeData = data {
                        if let coin = self.parseJSON(coinData: safeData) {
                            self.delegate?.didupdate(data: coin)
                        }
                    }
                }
                task.resume()
            }
        }

    func parseJSON(coinData: Data) -> Coin? {
            let decoder1 = JSONDecoder()
            do {
                let decodeData = try decoder1.decode([Coin].self, from: coinData)
                let price = decodeData[0].trade_price
                let coin = Coin(trade_price: price)
                return coin
                
            } catch {
                print(error)
                return nil
            }
            
        }
}
