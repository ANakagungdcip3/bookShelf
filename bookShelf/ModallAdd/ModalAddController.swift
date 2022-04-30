//
//  ModalAddBooks.swift
//  bookShelf
//
//  Created by Anak Agung Gede Agung Davin on 28/04/22.
//

import Foundation
import UIKit

protocol passDataHome: AnyObject{
    func passBook(Books : BooksDatabase)
}

class ModalAddController: UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var statusField: UITextField!
    @IBOutlet weak var pageField: UITextField!
    var bookTitle: String = ""
    var bookStatus: String = ""
    var pageStatus: String = ""
    
    
    var bookList: BooksDatabase?
    weak var delegate: passDataHome?
    let debugContent = "my content at row"
    let debugImage = UIImage(named:"Asset1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleField.text = ""
        self.statusField.text = ""
        self.pageField.text = ""
    }

    
    @IBAction func doneBut(_ sender: Any) {
        if bookTitle == ""{
            fatalError()
        }

        else if bookStatus == ""{
            fatalError()
        }

        else if pageStatus == ""{
            fatalError()
        }


        addModel()
//        performSegue(withIdentifier: "AddModalSegue", sender: self)
        
//        print(bookTitle)
//        print(bookStatus)
//        print(pageStatus)
        
        dismiss(animated: true){
            print(self.bookList?.bookTitles)
            self.delegate?.passBook(Books: self.bookList!)
            
        }
        
    }
    
    
    func addModel(){
        
//                print(bookTitle)
//                print(bookStatus)
//                print(pageStatus)
        
        self.bookList = BooksDatabase(assetBooks: debugImage!, bookTitles: self.bookTitle , pageTitles: self.pageStatus , statusTitle: self.bookStatus )
        
//        print(bookList?.bookTitles)
        
    
    }
    
    @IBAction func titleField(_ sender: Any) {
        self.bookTitle = titleField.text ?? ""
    }
    @IBAction func pageField(_ sender: Any) {
        self.pageStatus = pageField.text ?? ""
        
    }
    @IBAction func statusField(_ sender: Any) {
        self.bookStatus = statusField.text ?? ""
    }
}
