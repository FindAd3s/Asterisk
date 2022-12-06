//
//  DataView.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 6/8/22.
//

import UIKit

class DataView: UIViewController {
    
    var blendEmotion: String?
    var cnnEmotion: String?
    var countX: Int?
    var countY: Int?
    var defaults = UserDefaults()
    
    @IBOutlet weak var cnnEmotionLabel: UILabel!
    @IBOutlet weak var blendEmotionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let bEmotion = defaults.string(forKey: "UserBlendShapeEmotion") { // Access UserDefault
               blendEmotion = bEmotion
        }
        
        
        
        
        if let cEmotion = defaults.string(forKey: "UserCNNEmotion") { // Access UserDefault
               cnnEmotion = cEmotion
        }
                       
        cnnEmotionLabel.text = cnnEmotion ?? "No data"
        blendEmotionLabel.text = blendEmotion ?? "No data"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func algorithmXPicked(_ sender: UIButton) {
        self.defaults.set("Algorithm X", forKey: "PickedAlgorithm") // Publish to UserDefaults
        var countX = defaults.integer(forKey: "CountX")
        countX = ((countX) + 1)
        defaults.set(countX, forKey: "CountX")
        print(countX)
        performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    @IBAction func algorithmYPicked(_ sender: UIButton) {
        self.defaults.set("Algorithm Y", forKey: "PickedAlgorithm") // Publish to UserDefaults
        var countY = defaults.integer(forKey: "CountY")
        countY = ((countY) + 1)
        print(countY)
        defaults.set(countY, forKey: "CountY")
        
        performSegue(withIdentifier: "goToResults", sender: self)
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
