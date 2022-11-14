//
//  EmotionSelectViewController.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 11/13/22.
//

import UIKit

class EmotionSelectViewController: UIViewController {
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func happyButtonPressed(_ sender: Any) {
        
        self.defaults.set("Happy", forKey: "PickedEmotion") // Publish to UserDefaults
        
        performSegue(withIdentifier: "goToAsterisk1", sender: self)
        
    }
    
    @IBAction func sadButtonPressed(_ sender: Any) {
        
        self.defaults.set("Sad", forKey: "PickedEmotion") // Publish to UserDefaults
        performSegue(withIdentifier: "goToAsterisk1", sender: self)
        
    }
    
    @IBAction func angryButtonPressed(_ sender: Any) {
        
        self.defaults.set("Angry", forKey: "PickedEmotion") // Publish to UserDefaults
        performSegue(withIdentifier: "goToAsterisk1", sender: self)
        
    }
    
    @IBAction func neutralButtonPressed(_ sender: Any) {
        
        self.defaults.set("Neutral", forKey: "PickedEmotion") // Publish to UserDefaults
        
        performSegue(withIdentifier: "goToAsterisk1", sender: self)
        
    }
    
    @IBAction func returnToMenuButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToMenu5", sender: self)
        
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
