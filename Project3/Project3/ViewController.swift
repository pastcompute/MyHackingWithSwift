//
//  ViewController.swift
//  learningProject1
//
//  Created by Andrew McDonnell on 12/2/2022.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // navigationController?.navigationBar.prefersLargeTitles = true
        title = "Storm Viewer"
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load!
                pictures.append(item)
            }
        }
        pictures.sort(by: >)
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        //+ " " + String(format: "%d of %d", indexPath.row+1, pictures.count)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedImageTitle = pictures[indexPath.row] + String(format: " - %d of %d", indexPath.row+1, pictures.count)

            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // https://stackoverflow.com/questions/54031018/xcode-warning-estimated-section-footer-height-before-ios-11-what-does-it-mean
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat = 40
        if #available(iOS 11.0, *) {
            tableView.estimatedSectionHeaderHeight = headerHeight
            return UITableView.automaticDimension
        } else {
            return headerHeight
        }
    }
}

