//
//  ModalAddBooks.swift
//  bookShelf
//
//  Created by Anak Agung Gede Agung Davin on 28/04/22.
//

import Foundation
import UIKit
import CoreData
import Vision

protocol passDataHome: AnyObject{
    func passBook()
}

class ModalAddController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    weak var delegate: passDataHome?
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var statusField: UITextField!
    @IBOutlet weak var pageField: UITextField!
    var addedPicture = false
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
//        let imageData : Data = bookImage.image!.pngData() ?? debugImage!.pngData()!
//        newBooks.imageBook = imageData
        
        if addedPicture == true{
            let imageData : Data = bookImage.image!.pngData()!
            newBooks.imageBook = imageData
        } else{
            let imageData : Data = debugImage!.pngData()!
            recognizeText(image: debugImage)
            newBooks.imageBook = imageData
        }
        
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

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        guard let imageTaken = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            print("Image not Found")
            return
        }
        bookImage.image = imageTaken
        recognizeText(image: imageTaken)
        addedPicture = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    private func recognizeText(image: UIImage?){
        guard let cgImage = image?.cgImage else {
            fatalError("couldnot find cgimage")
        }
        
        // handler object buat minta proses satu atau lebih image analysis
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        //request ini buat detek teks. By default, a text recognition request first locates all possible glyphs or characters in the input image
        let request = VNRecognizeTextRequest {[weak self] request, error in
            //get hasil observed information (can return multiple string) A request that detects and recognizes regions of text in an image. dapet informasi lokasi dan text dari vision yg udah detek(si request)
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else{
                return
            }
            
            
            // take all those hasil teks yg diobserve trs di join/gabung dengan koma
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: ", ")
            
            DispatchQueue.main.async {
                self?.titleField.text = text
                self?.bookTitle = text
            }
            
//            let boundingRects: [CGRect] = observations.compactMap { observation in
//
//                // Find the top observation.
//                guard let candidate = observation.topCandidates(1).first else { return .zero }
//
//                // Find the bounding-box observation for the string range.
//                let stringRange = candidate.string.startIndex..<candidate.string.endIndex
//                let boxObservation = try? candidate.boundingBox(for: stringRange)
//
//                // Get the normalized CGRect value.
//                let boundingBox = boxObservation?.boundingBox ?? .zero
//
//                // Convert the rectangle from normalized coordinates to image coordinates.
//                return VNImageRectForNormalizedRect(boundingBox,
//                                                    Int((image?.size.width)!),
//                                                    Int((image?.size.height)!))
//            }
            
        }
        
        //perform request
        do{
            try handler.perform([request])
        }
        catch{
            print(error)
        }
    }
    
    @IBAction func addPicture(_ sender: Any){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
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
