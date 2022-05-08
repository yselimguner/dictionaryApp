//
//  Wordsdao.swift
//  Dictionary
//
//  Created by Yavuz Güner on 8.05.2022.
//

import Foundation

class Wordsdao {
    
    let db:FMDatabase?
    
    init() {
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbURL = URL(fileURLWithPath: targetPath).appendingPathComponent("dictionary.sqlite")
        
        db = FMDatabase(path: dbURL.path)
    }
    
    func takeAllWords()-> [Words]{
        var list = [Words]()
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM words ", values: nil)
            
            while rs.next() {
                let word = Words(word_id: Int(rs.string(forColumn: "word_id"))!,
                                 english: rs.string(forColumn: "english")!,
                                 turkish: rs.string(forColumn: "turkish")!)
                
                list.append(word)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func searchWords(english:String)-> [Words]{
        var list = [Words]()
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM words WHERE english like '%\(english)%'", values: nil)
            
            while rs.next() {
                let word = Words(word_id: Int(rs.string(forColumn: "word_id"))!,
                                 english: rs.string(forColumn: "english")!,
                                 turkish: rs.string(forColumn: "turkish")!)
                
                list.append(word)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    
}
