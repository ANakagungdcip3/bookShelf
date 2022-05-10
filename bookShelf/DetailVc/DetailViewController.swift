//
//  DetailViewController.swift
//  bookShelf
//
//  Created by Anak Agung Gede Agung Davin on 28/04/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController{
    
//    var bookDatabase: [BooksDatabase] = []
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var pageField: UITextField!
    @IBOutlet weak var statusField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    
    var descBook: String = ""
    var bookTitle: String = ""
    var bookStatus: String = ""
    var pageStatus: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descField.text = descBook
        pageField.text = pageStatus
        statusField.text = bookStatus
        titleField.text = bookTitle
        
        }
    }
    
