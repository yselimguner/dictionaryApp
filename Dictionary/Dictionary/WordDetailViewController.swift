//
//  WordDetailViewController.swift
//  Dictionary
//
//  Created by Yavuz Güner on 8.05.2022.
//

import UIKit

class WordDetailViewController: UIViewController {
    @IBOutlet weak var englishDetailLabel: UILabel!
    @IBOutlet weak var turkishDetailLabel: UILabel!
    
    var word:Words?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let w = word {
            englishDetailLabel.text = w.english
            turkishDetailLabel.text = w.turkish
        }
    }
    

    

}
