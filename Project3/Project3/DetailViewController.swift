//
//  DetailViewController.swift
//  learningProject1
//
//  Created by Andrew McDonnell on 13/2/2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var selectedImageTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // navigationItem.largeTitleDisplayMode = .never
        title = selectedImageTitle
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped)),
            UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(recommendTapped)),
            UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        ]
        // Do any additional setup after loading the view.
        if let imageToLoad = selectedImage {
            imageView.image  = UIImage(named: imageToLoad)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    @objc func searchTapped() {
        let ac = UIAlertController(title: title, message: "We could search online for similar images if we wanted to", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok!", style: .default, handler: nil))
        present(ac, animated: true)
    }

    @objc func recommendTapped() {
        let ac = UIAlertController(title: title, message: "Recommend this on twitter?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok!", style: .default, handler: nil))
        ac.addAction(UIAlertAction(title: "no thanks!", style: .default, handler: nil))
        present(ac, animated: true)
    }

    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }

        // So, if we pass both the text and the image, they both get added the note;
        // but the image is not shown in the preview (on iOS9) in that case
        // and on iOS15 simulator, we get a warning about
        // Extension request contains input items but the extension point does not specify a set of allowed payload classes. The extension point's NSExtensionContext subclass must implement `+_allowedItemPayloadClasses`. This must return the set of allowed NSExtensionItem payload classes. In future, this request will fail with an error
        // when saving to Files (not possible on iOS9)
        let vc = UIActivityViewController(activityItems: [image, selectedImageTitle!], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
