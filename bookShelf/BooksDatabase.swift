//
//  BooksDatabase.swift
//  bookShelf
//
//  Created by Anak Agung Gede Agung Davin on 28/04/22.
//

import Foundation
import UIKit

struct BooksDatabase{
    var assetBooks: UIImage?
    var bookTitles: String?
    var pageTitles: String?
    var statusTitle: String?
    
    init(assetBooks: UIImage, bookTitles: String, pageTitles: String, statusTitle: String){
        self.assetBooks = assetBooks
        self.bookTitles = bookTitles
        self.pageTitles = pageTitles
        self.statusTitle = statusTitle
    }
}

let BookList: [BooksDatabase] = []
