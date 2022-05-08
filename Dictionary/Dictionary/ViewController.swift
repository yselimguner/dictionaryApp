//
//  ViewController.swift
//  Dictionary
//
//  Created by Yavuz Güner on 8.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var wordTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var wordList = [Words]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        copyDatabase()
        
        
        wordTableView.delegate = self
        wordTableView.dataSource = self
        
        searchBar.delegate = self
        
        wordList = Wordsdao().takeAllWords()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Sayfalar arası veri transferini burada yapacağız. Önce worddetailviewcontroller'da tanımlamaları yaptık.
        
        let index = sender as? Int
        
        let toVC = segue.destination as! WordDetailViewController
        
        toVC.word = wordList[index!]
        
    }
    
    func copyDatabase () {
        let bundlePath = Bundle.main.path(forResource: "dictionary", ofType: ".sqlite")
        
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let copiedArea = URL(fileURLWithPath: targetPath).appendingPathComponent("dictionary.sqlite")
        
        if fileManager.fileExists(atPath: copiedArea.path) {
            print("Veritabanı zaten var kopyalamaya gerek yok.")
        }else {
            do {
                try fileManager.copyItem(atPath: bundlePath!, toPath: copiedArea.path)
            }catch {
                print(error.localizedDescription)
            }
        }
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let word = wordList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as! WordTableViewCell
        
        cell.englishLabel.text = word.english
        cell.turkishLabel.text = word.turkish
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toWordDetail", sender:indexPath.row)
        
    }
    
}

extension ViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama sonucu: \(searchText)")
        
        wordList = Wordsdao().searchWords(english: searchText)
        wordTableView.reloadData()
    }
}
