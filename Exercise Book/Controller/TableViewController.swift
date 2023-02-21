//
//  TableTableViewController.swift
//  Exercise Book
//
//  Created by 김용태 on 2023/02/20.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var arr = [Item]()
    var inputText: UITextField?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        if arr.count == 0 {
            let alert = UIAlertController(title: "우측 상단 버튼을 눌러 관람한 영화를 추가하세요‼️", message: "", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default) { (ok) in
            })
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Main Contents", for: indexPath)
        let item = arr[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = arr[indexPath.row]
        
        item.done = item.done ? false : true
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add Button
    
    @IBAction func addText(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "관람한 영화 제목을 입력하세요‼️", message: "", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (ok) in
            
            let newItem = Item(context: self.context)
            newItem.title = self.inputText!.text!
            newItem.done = false
            
            self.arr.append(newItem)
            self.saveItems()
    
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
    
    
    //MARK: - Model

    func saveItems() {
        
        do{
           try context.save()

        } catch {
            print("에러: \(error)")
        }
        self.tableView.reloadData()
    }

//    func loadItems() {
//
//        do{
//
//        } catch {
//
//        }
//    }
}



