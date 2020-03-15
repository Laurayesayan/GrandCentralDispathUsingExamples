import UIKit

let imageAddress = "https://img13.postila.ru/resize?w=660&src=%2Fdata%2F27%2F71%2F13%2Fce%2F277113ce8a822350d127b74955080b1cfc81c6924024bab1616ff9c341fc9876.jpg"

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func loadImage(_ sender: Any) {
        imageView.setImage(url: imageAddress)
    }
    
}

extension UIImageView {
    func setImage(url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global(qos: .background).async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            
            DispatchQueue.main.async { [weak self] in
                self!.image = image
            }
        }
    }
}

