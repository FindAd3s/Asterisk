//
//  ViewController.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 4/27/22.
//

import UIKit

class MainMenuView: UIViewController {

    
    @IBOutlet weak var emotionOfUser: UILabel!
    
    var preferences: Preferences?
    var emotion: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func startButton(_ sender: UIButton) {
        print("Start Button Pressed")
        
        self.performSegue(withIdentifier: "goToEmotionRec", sender: self)
        self.performSegue(withIdentifier: "goToEmotionRec", sender: self)
        updateUI()

    }
    
    @IBAction func preferencesButton(_ sender: UIButton) {
        print("Preferences Button Pressed")
        print(emotion ?? "No data")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        if segue.identifier == "goToEmotionRec"{
            let destinationVC = segue.destination as! AREmotionView
        }
        updateUI()

    }
    
    func updateUI(){
        let emotionUser = preferences?.userEmotion() ?? "[Data Unavailable]"
        
        emotionOfUser.text = "\(emotionUser)"
    }
}

