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
    var desc: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descField.text = desc
        }
    }
    
