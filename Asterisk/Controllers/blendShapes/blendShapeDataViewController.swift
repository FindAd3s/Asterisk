//
//  blendShapeDataViewController.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 7/15/22.
//

import UIKit

class blendShapeDataViewController: UIViewController {

    var blendEmotion: String?
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var emotionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let bEmotion = defaults.string(forKey: "BlendShapeEmotion") { // Access UserDefault
            blendEmotion = bEmotion
        }
                       
        emotionLabel.text = blendEmotion ?? "No data"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func mainMenuButton(_ sender: Any) {
        performSegue(withIdentifier: "goToMainMenu3", sender: self)
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
