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
    var oldAlgoEmotion: String?
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var emotionLabel: UILabel!
    @IBOutlet weak var meanLabel: UILabel!
    @IBOutlet weak var medianLabel: UILabel!
    @IBOutlet weak var bufferMedianLabel: UILabel!
    @IBOutlet weak var oldAlgoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let aEmotion = defaults.string(forKey: "PickedEmotion") { // Access UserDefault
            asteriskEmotion = aEmotion
        }
        if let bEmotion = defaults.string(forKey: "MeanEmotion") { // Access UserDefault
            maxEmotion = bEmotion
        }
        if let cEmotion = defaults.string(forKey: "MedianEmotion") { // Access UserDefault
            meanEmotion = cEmotion
        }
        if let dEmotion = defaults.string(forKey: "BufferMedianEmotion") { // Access UserDefault
            medianEmotion = dEmotion
        }
        if let eEmotion = defaults.string(forKey: "oldAlgoEmotion") { // Access UserDefault
            oldAlgoEmotion = eEmotion
        }
        
        emotionLabel.text = asteriskEmotion ?? "No data"
        meanLabel.text = maxEmotion ?? "No data"
        medianLabel.text = meanEmotion ?? "No data"
        bufferMedianLabel.text = medianEmotion ?? "No data"
        oldAlgoLabel.text = oldAlgoEmotion ?? "No Data"
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
