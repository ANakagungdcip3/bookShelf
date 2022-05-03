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
        BooksDatabase(assetBooks: UIImage(named: "Asset1")!, bookTitles: "Milk and Honey", pageTitles: "ada1", statusTitle: "ada"),
        BooksDatabase(assetBooks: UIImage(named: "Asset1")!, bookTitles: "Milk and Honey", pageTitles: "ada2", statusTitle: "ada"),
        BooksDatabase(assetBooks: UIImage(named: "Asset1")!, bookTitles: "Milk and Honey", pageTitles: "ada3", statusTitle: "ada")
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
    
    
    //ngebuat si reusable cell isinya bakal gimana, pakenya identifier buat nama class
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewBooks.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCell
        cell.bookImage.image = UIImage(named: assetBooks[0])
        cell.tBook.text = bookDatabase[indexPath.row].bookTitles
        cell.tPage.text = bookDatabase[indexPath.row].pageTitles
        cell.tDesc.text = "What a nice books..."
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
        destinationVC.desc = bookDatabase[indexPath.row].bookTitles!
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    func passBook(Books: BooksDatabase) {
        bookDatabase.append(Books)
        print(bookDatabase.count)
        collectionViewBooks.reloadData()
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
