//
//  ViewController.swift
//  SaveAndLoad
//
//  Created by Aaron Bradley on 4/17/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

import UIKit

// Documents Directory  /User/aaronb/.../Documents/
func documentsDirectory() -> String {
    let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
    return documentsFolderPath
}

func fileInDocumentsDirectory(fileName: String) -> String {
    return documentsDirectory().stringByAppendingPathComponent(fileName)
}

// File in Documents Directory  /User/aaronb/.../Documents/Photo.png



class ViewController: UIViewController {


    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        println("Documents: \(documentsDirectory())")

        let imagePath = fileInDocumentsDirectory("Photo.jpg")
        println("Photo path: \(imagePath)")

        // Load image from Resource Bundle (read only)
        var image = UIImage(named: "photo.png")
        if image != nil {
            // Save it to Documents folder
            println(image)

            let result = saveImage(image!, path: imagePath)
            println("saveImage: \(result)")

            // Load image
            var loadedImage = loadImageFromPath(imagePath)
            if loadedImage != nil {
                println("Image loaded: \(loadedImage!)")

                imageView.image = loadedImage
            }
        }

        // Text Loading and Saving
        let textPath = fileInDocumentsDirectory("help.txt")
        let status = saveText("Save ME Yo!", path: textPath)
        println("Saved text: \(status)")

        // Load text
//        let loadedText = loadTextFromPath(textPath)
//        if loadedText != nil {
//            println("Loaded Text: \(loadedText!)")
//        }

        if let loadedText = loadTextFromPath(textPath) {
            println("Loaded Text v2: \(loadedText)")
        }


    }

    func saveImage(image: UIImage, path: String) -> Bool {
        let jpgImageData = UIImagePNGRepresentation(image)
        let result = jpgImageData.writeToFile(path, atomically: true)
        return result
    }

    func loadImageFromPath(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            println("No image here bruh: \(path)")
        }
        return image
    }

    // Save text
    func saveText(text: String, path: String) -> Bool {
        var error: NSError? = nil
        let status = text.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: &error)

        if !status {
            println("Error saving file at path: \(path) with error: \(error?.localizedDescription)")
        }

        return status
    }

    // Load text
    func loadTextFromPath(path: String) -> String? {
        var error: NSError? = nil
        let text = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: &error)
        if text == nil {
            println("Error loading text from path: \(path) with Error: \(error?.localizedDescription)")
        }
        return text
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

