//
//  AsteriskDataViewController.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 10/16/22.
//

import UIKit

class AsteriskDataViewController: UIViewController {

    var asteriskEmotion: String?
    var maxEmotion: String?
    var meanEmotion: String?
    var medianEmotion: String?
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var emotionLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var meanLabel: UILabel!
    @IBOutlet weak var medianLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let aEmotion = defaults.string(forKey: "PickedEmotion") { // Access UserDefault
            asteriskEmotion = aEmotion
        }
        if let bEmotion = defaults.string(forKey: "MaxEmotion") { // Access UserDefault
            maxEmotion = bEmotion
        }
        if let cEmotion = defaults.string(forKey: "MeanEmotion") { // Access UserDefault
            meanEmotion = cEmotion
        }
        if let dEmotion = defaults.string(forKey: "MedianEmotion") { // Access UserDefault
            medianEmotion = dEmotion
        }
                       
        emotionLabel.text = asteriskEmotion ?? "No data"
        maxLabel.text = maxEmotion ?? "No data"
        meanLabel.text = meanEmotion ?? "No data"
        medianLabel.text = medianEmotion ?? "No data"
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
