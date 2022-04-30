//
//  DetailViewController.swift
//  bookShelf
//
//  Created by Anak Agung Gede Agung Davin on 28/04/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController{
    
    var contentText: [String?] = []
    var bookDatabase: [BooksDatabase] = []
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var pageField: UITextField!
    @IBOutlet weak var statusField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descField.text = contentText[1]
    }
    
}
