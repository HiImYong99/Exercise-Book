//
//  ViewController.swift
//  Exercise Book
//
//  Created by 김용태 on 2023/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var myPrice: UILabel!
    @IBOutlet weak var myProfit: UILabel!
    @IBOutlet weak var roe: UILabel!
    @IBOutlet weak var currentProfit: UILabel!
    
    var won: Int?
    var myWon = 0
    var coinJson = CoinJson()
    var myRoe: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinJson.delegate = self
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.coinJson.fetchCoin()
            if self.myWon != 0
            {
                self.myRoe = Double(self.won! - self.myWon) / Double(self.myWon) * 100
                if self.won! - self.myWon < 0 {
                    self.roe.textColor = .blue
                    self.currentProfit.textColor = .blue
                } else {
                    self.roe.textColor = .red
                    self.currentProfit.textColor = .red
                    
                }
                self.roe.text = String(format: "수익률 %.2f%%", self.myRoe!)
                self.currentProfit.text = "현재 수익 \(self.won! - self.myWon)원"
            }
        }
        
        
    }
    
    @IBAction func touchRefresh(_ sender: UIBarButtonItem) {
        coinJson.fetchCoin()
    }
    
    @IBAction func buyCoin(_ sender: Any) {
        myWon = won ?? 0
        myProfit.textColor = .red
        myProfit.text = "실현 손익 0원"
        myPrice.text = "매수 평균가 " + DecimalWon(value: myWon)
    }
    
    @IBAction func sellCoin(_ sender: Any) {
        
        if myWon != 0 {
            if won! - myWon < 0 {
                myProfit.textColor = .blue
            } else {
                myProfit.textColor = .red
            }
            myProfit.text = "실현 손익 " + DecimalWon(value: won! - myWon)
            myPrice.text! = "매수 평균가 0원"
            roe.text = "수익률 0%"
            currentProfit.text = "현재 수익 0원"
            myWon = 0
        } else {
            myProfit.text = "실현 손익 0원"
            
        }
        
    }
    
    
    
}




//MARK: - get CoinData
extension ViewController: CoinDelegate {
    func didupdate(data: Coin) {
        DispatchQueue.main.async {
            self.won = data.trade_price
            let price = DecimalWon(value: data.trade_price)
            self.currentPrice.text = "\(price)"
            
        }
    }
}



func DecimalWon(value: Int) -> String{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    let result = numberFormatter.string(from: NSNumber(value: value))! + "원"
    return result
}
