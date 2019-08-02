//
//  SecondViewController.swift
//  Collector
//
//  Created by Eric Stein on 7/25/19.
//  Copyright © 2019 Eric Stein. All rights reserved.
//

import UIKit

class SecondViewController:

UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
//    pickerController to be able to use library and camera
    var pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerController.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
    
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func mediaFolderTapped(_ sender: Any) {
        //    pickerController to be able to use library
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    @IBAction func cameraTapped(_ sender: Any) {
        //    pickerController to be able to use camera
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    @IBAction func addTapped(_ sender: Any) {
//         taping tapped button to return to the first view
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let collectable = Collectable(context:context);collectable.title = titleTextField.text
             (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
            collectable.image = imageView.image?.jpegData(compressionQuality: 1.0)
        }

        navigationController?.popViewController(animated: true)
    }
}
