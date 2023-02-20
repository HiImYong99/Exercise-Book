//
//  TableTableViewController.swift
//  Exercise Book
//
//  Created by 김용태 on 2023/02/20.
//

import UIKit

class TableViewController: UITableViewController {

    var arr = [String]()
    var inputText: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func addText(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "우측 상단 버튼을 터치하여 리스트를 추가하세요‼️", message: "", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (ok) in
            print((self.inputText?.text!)!)
            self.arr.append((self.inputText?.text!)!)
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel) { (cancel) in
            
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addTextField { myText in
            myText.placeholder = "추가할 내용을 입력하세요!"
            self.inputText = myText
        }
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Main Contents", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
        } else {
            cell?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
}
