//
//  ViewController.swift
//  Project2
//
//  Created by Andrew McDonnell on 13/2/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var counted = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia", "france", "germany", "ireland", "italy",
                      "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        button1.layer.borderWidth = 2
        button2.layer.borderWidth = 2
        button3.layer.borderWidth = 2
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        askQuestion(action: nil)
    }
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        let qqq: String = countries[correctAnswer].uppercased()
        if (counted == 0) {
            title = "\(qqq)"
        } else if (counted < 10) {
            title = "\(qqq) - Score = \(score) of \(counted)"
        } else {
            title = "\(qqq) - Score = \(score) of \(counted) - Finished!"
        }
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        counted = counted + 1
        if (counted == 10) {
            title = "Score = \(score) of \(counted) - Finished!"
            ac.addAction(UIAlertAction(title: "Finished!", style: .default, handler: nil))
        } else {
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        }
        present(ac, animated: true)
    }
}

