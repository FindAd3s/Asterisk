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
    
    @IBAction func mainMenuButton(_ sender: Any) {
        performSegue(withIdentifier: "goToMainMenu1", sender: self)
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
