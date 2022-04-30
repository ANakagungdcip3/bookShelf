//
//  ViewController.swift
//  bookShelf
//
//  Created by Anak Agung Gede Agung Davin on 27/04/22.
//

import Foundation
import UIKit

//implement/protocol/subscribe
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, passDataHome{
    
    
    
    var bookDatabase: [BooksDatabase] = [
        BooksDatabase(assetBooks: UIImage(named: "Asset1")!, bookTitles: "Milk and Honey", pageTitles: "ada", statusTitle: "ada"),
        BooksDatabase(assetBooks: UIImage(named: "Asset1")!, bookTitles: "Milk and Honey", pageTitles: "ada", statusTitle: "ada"),
        BooksDatabase(assetBooks: UIImage(named: "Asset1")!, bookTitles: "Milk and Honey", pageTitles: "ada", statusTitle: "ada")
    ]
    let assetBooks = ["Asset1", "Asset2", "Asset3", "Asset4"]
    let titles = ["Milk and Honey", "This is a Title", "Nice man1", "Nice man4"]
    let debugContent = "my content at row"
    @IBOutlet weak var collectionViewBooks: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for book in 0 ..< bookDatabase.count {
            print(bookDatabase[book])
        }
        collectionViewBooks.dataSource = self
        collectionViewBooks.delegate = self
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        performSegue(withIdentifier: "AddModalSegue", sender: nil)
    }
    
    //basically buat item collectionviewny ada brp
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookDatabase.count
    }
    
    //ngebuat si reusable cell, pakenya identifier buat nama class
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewBooks.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCell
        cell.bookImage.image = UIImage(named: assetBooks[0])
        cell.tBook.text = bookDatabase[indexPath.row].bookTitles
        cell.tPage.text = bookDatabase[indexPath.row].pageTitles
        cell.tDesc.text = "What a nice books..."
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionViewBooks.deselectItem(at: indexPath, animated: true)
        performSegue(withIdentifier: "BooksDetailSegue", sender: self)
    }
    
    
    
    func passBook(Books: BooksDatabase) {
        bookDatabase.append(Books)
        print(bookDatabase.count)
        collectionViewBooks.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BooksDetailSegue"{
            if let destinationVC = segue.destination as? DetailViewController{
                destinationVC.contentText = titles
            }
        }
        else if segue.identifier == "AddModalSegue"{
            
            
            let destinationVC = segue.destination as? ModalAddController
            destinationVC?.delegate = self
        }
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
