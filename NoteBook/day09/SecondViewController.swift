//
//  SecondViewController.swift
//  day09
//
//  Created by Yaroslava HLIBOCHKO on 7/6/19.
//  Copyright © 2019 Yaroslava HLIBOCHKO. All rights reserved.
//

import UIKit
import yhliboch2019

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let pickerController = UIImagePickerController()
    var articleManager = ArticleManager()
    let firstView = TableViewController()
    var article: Entity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cooseButton.layer.cornerRadius = 5
        takeButton.layer.cornerRadius = 5
        pickerController.delegate = self
        if article != nil {
            if let image = article?.image {
                newPicture.image = UIImage(data: image as Data)
            }
            newTitleTextField.text = article?.tille
            newContentTextView.text = article?.content
        }
    }
    
    @IBOutlet weak var newPicture: UIImageView!
    @IBOutlet weak var newTitleTextField: UITextField!
    @IBOutlet weak var newContentTextView: UITextView!
    @IBOutlet weak var cooseButton: UIButton!
    @IBOutlet weak var takeButton: UIButton!
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if article != nil {
            article?.modification = NSDate()
            //            if newArticle.tille == "" {
            article?.creation = article?.creation
            //            }
            article?.content = newContentTextView.text
            article?.tille = newTitleTextField.text
            article?.language = "en"
            if let imageUI = newPicture.image, let selectedImage = imageUI.pngData() as NSData? {
                article?.image = selectedImage
            }
            firstView.articleManeger.save()
            article = nil
            performSegue(withIdentifier: "backSegue", sender: "Foo")
        } else {
            let newArticle = firstView.articleManeger.newArticle()
            if newTitleTextField.text?.isEmpty == false && newContentTextView.text.isEmpty == false {
                newArticle.modification = NSDate()
                newArticle.creation = newArticle.modification
                newArticle.content = newContentTextView.text
                newArticle.tille = newTitleTextField.text
                newArticle.language = "en"
                if let imageUI = newPicture.image, let selectedImage = imageUI.pngData() as NSData? {
                    newArticle.image = selectedImage
                }
                firstView.articleManeger.save()
                performSegue(withIdentifier: "backSegue", sender: "Foo")
            }
        }
    }
    
    @IBAction func tekePictureButton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerController.sourceType = .camera
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func choosePictureButton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        newPicture.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    }
    
}
