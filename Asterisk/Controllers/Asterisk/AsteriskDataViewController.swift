//
//  AsteriskDataViewController.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 10/16/22.
//

import UIKit

class AsteriskDataViewController: UIViewController {

    var asteriskEmotion: String?
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var emotionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let aEmotion = defaults.string(forKey: "AsteriskEmotion") { // Access UserDefault
            asteriskEmotion = aEmotion
        }
                       
        emotionLabel.text = asteriskEmotion ?? "No data"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func mainMenuButton(_ sender: Any) {
        performSegue(withIdentifier: "goToMainMenu4", sender: self)
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
