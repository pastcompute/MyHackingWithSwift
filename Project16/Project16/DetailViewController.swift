//
//  DetailViewController.swift
//  Project16
//
//  Created by Andrew McDonnell on 18/3/2022.
//

import UIKit
import WebKit
class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Capital?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let detailItem = detailItem else { return }
        let url = URL(string: detailItem.url)!
        webView.load(URLRequest(url: url))
    }
    override func loadView() {
        webView = WKWebView()
        view = webView
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
