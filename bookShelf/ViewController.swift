//
//  ViewController.swift
//  bookShelf
//
//  Created by Anak Agung Gede Agung Davin on 27/04/22.
//

import Foundation
import UIKit
import CoreData

var bookDatabase = [Books]()
var longPressed = false

//implement/protocol/subscribe
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, passDataHome{
    
    
//    var bookDatabase: [BooksDatabase] = [
//        BooksDatabase(assetBooks: UIImage(named: "Asset1")!, bookTitles: "Milk and Honey", pageTitles: "ada1", statusTitle: "ada"),
//        BooksDatabase(assetBooks: UIImage(named: "Asset1")!, bookTitles: "Milk and Honey", pageTitles: "ada2", statusTitle: "ada"),
//        BooksDatabase(assetBooks: UIImage(named: "Asset1")!, bookTitles: "Milk and Honey", pageTitles: "ada3", statusTitle: "ada")
//    ]
    
    let assetBooks = ["Asset1", "Asset2", "Asset3", "Asset4"]
//    let titles = ["Milk and Honey", "This is a Title", "Nice man1", "Nice man4"]
//    let debugContent = "my content at row"
    var firstLoad = true
    @IBOutlet weak var collectionViewBooks: UICollectionView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(firstLoad)
        {
            firstLoad=false
            let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Books")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let book = result as! Books
                    bookDatabase.append(book)
                }
            }
            catch
            {
                print("Fetch Failed")
            }
            
            handleLongPress()
            if longPressed == true{
                collectionViewBooks.reloadData()
            }
            else if longPressed == false{
                return
            }
            
    }
            
        for book in 0 ..< bookDatabase.count {
            print(bookDatabase[book])
        }
        
        collectionViewBooks.dataSource = self
        collectionViewBooks.delegate = self
    }
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "AddModalSegue", sender: nil)
    }
    
    
    //ngebuat si reusable cell isinya bakal gimana, pakenya identifier buat nama class
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewBooks.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCell
        
        let thisBook : Books!
        thisBook = bookDatabase[indexPath.row]
        let tempImageBox = UIImage.create(data: thisBook.imageBook) ?? UIImage.create(named: "Asset1")
//        let tempImageBox = UIImage(data: thisBook.imageBook!)
        
        cell.bookImage.image = tempImageBox
        cell.tBook.text = thisBook.titleBook as String?
        cell.tPage.text = thisBook.pageBook as String?
        cell.tDesc.text = thisBook.descBook as String?
        return cell
    }
    
    //basically buat item collectionviewnya ada brp
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookDatabase.count
    }
    
    //bedain didSelect sama didDeselect di bagian parameter
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionViewBooks.deselectItem(at: indexPath, animated: true)
        
        //another way to perform pindah page selain segue klo ini gaperlu prepare, kenapa pake ini? karena perlu akses si indexpath.row, sedangakan prepare cuma bisa override yg harus diluar function
        guard let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewSB") as? DetailViewController else {
            return
        }
        let thisBook : Books!
        thisBook = bookDatabase[indexPath.row]
        let tempImageBox =  UIImage.create(data: thisBook.imageBook) ?? UIImage.create(named: "Asset1")
        
        destinationVC.bookImage = tempImageBox
        destinationVC.bookTitle = thisBook.titleBook! as String
        destinationVC.bookStatus = thisBook.statusBook! as String
        destinationVC.pageStatus = thisBook.pageBook! as String
        destinationVC.descBook = thisBook.descBook! as String
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    private func handleLongPress(){
        longPressed = true
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
            longPressedGesture.minimumPressDuration = 0.5
            longPressedGesture.delegate = self
            longPressedGesture.delaysTouchesBegan = true
            collectionViewBooks?.addGestureRecognizer(longPressedGesture)
        
        }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }

        let p = gestureRecognizer.location(in: self.collectionViewBooks)

        if let indexPath = self.collectionViewBooks?.indexPathForItem(at: p) {
            print("Long press at item: \(indexPath.row)")
            
            let sheet = UIAlertController(title: "Edit Action", message: nil, preferredStyle: .actionSheet)
            sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                //handle delete item in core data and cell
                self.deleteModel(item: bookDatabase[indexPath.item], path: indexPath)
                self.collectionViewBooks.deleteItems(at: [indexPath])
            }))
            
            sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in print("Cancelled")}
            ))
            
            self.present(sheet, animated: true)
        }
    }
    
    //function buat ngereload doang si
    func passBook() {
        collectionViewBooks.reloadData()
    }
    
    func deleteModel(item: Books, path: IndexPath){
        context.delete(item)
        bookDatabase.remove(at: path.item)
        do{
            try context.save()
        }
        catch{
            print("Error while updating")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "BooksDetailSegue"{
//            if let destinationVC = segue.destination as? DetailViewController{
//                destinationVC.bookDatabase = self.bookDatabase
//            }
//        }

         if segue.identifier == "AddModalSegue"{

            let destinationVC = segue.destination as? ModalAddController
            destinationVC?.delegate = self
        }
    }
}

//Handling UIImage coredata wrapping
extension UIImage {
    static func create(data: Data?) -> UIImage? {
         guard let data = data else { return nil }
         return UIImage(data: data)
    }

    static func create(named: String?) -> UIImage? {
         guard let string = named else { return nil }
         return UIImage(named: string)
    }
}

class PostCell: UICollectionViewCell{
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var tPage: UILabel!
    @IBOutlet weak var tBook: UILabel!
    @IBOutlet weak var tDesc: UILabel!
    
    
    override func awakeFromNib() {
        bookImage.layer.cornerRadius = 8
        background.layer.cornerRadius = 8
    }
}
