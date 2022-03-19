//
//  ViewController.swift
//  Project7
//
//  Created by Andrew McDonnell on 14/3/2022.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad()")
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(showCredits)),
        ]
        
        let urlString: String
        // same view controller, different tab...
        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        // So, Data(contentsOf) is a blocking call, so for proj9 we want to use GCD to make it async
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    // we're OK to parse!
                    print("viewDidLoad() loaded from url \(url)")
                    self.parse(json: data)
                    return
                }
            }
            DispatchQueue.main.async {
                // I think it is better explit here rather than changing the function - time will tell?
                self.showError()
            }
        }
    }
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "Created with We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    func parse(json: Data) {
        NSLog("Parsing json")
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            print("parsed \(petitions.count) items")
            DispatchQueue.main.async {
                // now we got here from an async call, do the gui update on gui thread
                self.tableView.reloadData()
            }
        }
        
        // we can also refactor all this to use performselector
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

