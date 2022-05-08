//
//  Words.swift
//  Dictionary
//
//  Created by Yavuz Güner on 8.05.2022.
//

import Foundation

class Words {
    var word_id:Int?
    var english:String?
    var turkish:String?
    
    init() {
        
    }
    init(word_id:Int, english:String, turkish:String) {
        self.word_id = word_id
        self.english = english
        self.turkish = turkish
    }
}
