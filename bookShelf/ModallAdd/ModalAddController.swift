//
//  ModalAddBooks.swift
//  bookShelf
//
//  Created by Anak Agung Gede Agung Davin on 28/04/22.
//

import Foundation
import UIKit
import CoreData

protocol passDataHome: AnyObject{
    func passBook()
}

class ModalAddController: UIViewController, UITextViewDelegate{
    
    weak var delegate: passDataHome?
    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var statusField: UITextField!
    @IBOutlet weak var pageField: UITextField!
    var bookTitle: String = ""
    var bookStatus: String = ""
    var pageStatus: String = ""
    var bookDesc: String = ""
    let debugImage = UIImage(named:"Asset1")
    //context for CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Add Books"
        super.viewDidLoad()
        descField.delegate = self
        self.titleField.text = ""
        self.statusField.text = ""
        self.pageField.text = ""
    }

    
    @IBAction func doneBut(_ sender: Any) {
        if (bookTitle == "") && (bookStatus == "") && (pageStatus == ""){
            dismiss(animated: true)
        }
        else{
            addModel()
            dismiss(animated: true){
            self.delegate?.passBook()
            }
        }
    }
    
    func addModel(){
        
        let entity = NSEntityDescription.entity(forEntityName: "Books", in: context)
        let newBooks = Books(entity: entity!, insertInto: context)
        newBooks.descBook = self.bookDesc
        newBooks.iD = Int32(bookDatabase.count)
        let imageData : Data = debugImage!.pngData()!
        newBooks.imageBook = imageData
        newBooks.pageBook = self.pageStatus
        newBooks.statusBook = self.bookStatus
        newBooks.titleBook = self.bookTitle
        
        do{
            try context.save()
            bookDatabase.append(newBooks)
        }
        
        catch{
            print("Error while saving")
        }
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        descField.text = ""
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.bookDesc = descField.text ?? ""
    }
    

}
