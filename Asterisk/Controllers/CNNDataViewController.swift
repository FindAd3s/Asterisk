//
//  CNNDataViewController.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 7/15/22.
//

import UIKit

class CNNDataViewController: UIViewController {

    var emotion: String?
    var defaults = UserDefaults()
    
    @IBOutlet weak var emotionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cEmotion = defaults.string(forKey: "CNNUserEmotion") { // Access UserDefault
            emotion = cEmotion
        }
                       
        emotionLabel.text = emotion ?? "No data"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func mainMenuButton(_ sender: Any) {
        performSegue(withIdentifier: "goToMainMenu2", sender: self)
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
