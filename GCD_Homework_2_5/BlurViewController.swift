//
//  BlurViewController.swift
//  GCD_Homework_2_5
//
//  Created by Лаура Есаян on 15.03.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import UIKit

class BlurViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func loadAndBlurImage(_ sender: Any) {
        imageView.setBluredImage(url: imageAddress)

    }
}


extension UIImageView {
    func setBluredImage(url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global(qos: .background).async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            var image = UIImage(data: imageData)
            image = self.addBlur(image!)

            DispatchQueue.main.async { [weak self] in
                self!.image = image
            }
        }
    }
    
    func addBlur(_ image: UIImage) -> UIImage? {
        guard let ciImg = CIImage(image: image) else { return nil }
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(ciImg, forKey: kCIInputImageKey)
        blurFilter?.setValue(8.0, forKey: kCIInputRadiusKey)
        
        if let outputImg = blurFilter?.outputImage {
            return UIImage(ciImage: outputImg)
        }
        
        return nil
    }
}
