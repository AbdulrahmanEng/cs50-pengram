//
//  ViewController.swift
//  Pengram
//
//  Created by Abdulrahman on 02/12/2020.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Define context for the button methods
    let context = CIContext()
    var original: UIImage?
    
    // Connect to the imageView
    @IBOutlet var imageView: UIImageView!
    // Connect to the nav button
    @IBAction func choosePhoto()
    {
        // Check for permission to get an image
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            // Create a picker
            let picker = UIImagePickerController()
            // Delegate response to this class
            picker.delegate = self
            // Check the source
            picker.sourceType = .photoLibrary
            // Specify behaviour of navigation
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func applySepia()
    {
        guard let original = original else {
            return
        }
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        let output = filter?.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            original = image
        }
    }
}

