//
//  ViewController.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 4/27/22.
//

import UIKit

class MainMenuView: UIViewController {

    
    @IBOutlet weak var emotionOfUser: UILabel!
    
    var defaults = UserDefaults.standard
    
    var preferences: Preferences?
    var emotion = "No Data"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func startButton(_ sender: UIButton) {
        print("Start Button Pressed")
        
        self.performSegue(withIdentifier: "goToEmotionRec", sender: self)
        

        view.addSubview(spinner)
        updateUI()

    }
    
    private let spinner: UIActivityIndicatorView = {
            let spinner = UIActivityIndicatorView()
            spinner.tintColor = .label
            spinner.hidesWhenStopped = true
            return spinner
        }()
    
    @IBAction func preferencesButton(_ sender: UIButton) {
        print("Preferences Button Pressed")
        
        self.performSegue(withIdentifier: "goToPreferences", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
//        if segue.identifier == "goToEmotionRec"{
//            let destinationVC = segue.destination as! AREmotionView
//        }
//        updateUI()
//
//    }
    
    func updateUI(){
        if let uEmotion = defaults.string(forKey: "UserEmotion") { // Access UserDefault
            emotion = uEmotion
        }
        emotionOfUser.text = emotion
    }
}

