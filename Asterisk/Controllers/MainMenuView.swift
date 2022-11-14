//
//  ViewController.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 4/27/22.
//

import UIKit

class MainMenuView: UIViewController {

    
    @IBOutlet weak var emotionOfUser: UILabel!
    @IBOutlet weak var mainSwitch: UISwitch!
    
    var defaults = UserDefaults.standard
    var conNode: Bool?
    var strNode: String? = "true"
    var emotion = "No Data"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let cond = defaults.string(forKey: "NodeConditional") { // Access UserDefault
                   strNode = cond
               }
               
        conNode = Bool(strNode ?? "true")
//        print(strNode!)
//        print(conNode!)
        if conNode == true{
            mainSwitch.isOn = true
        }
        else{
            mainSwitch.isOn = false
        }
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func startButton(_ sender: UIButton) {
        print("Start Button Pressed")
        
        self.performSegue(withIdentifier: "goToEmotionRec", sender: self)
        

        view.addSubview(spinner)
//        updateUI()

    }
    @IBAction func switchStateChanged(_ sender: UISwitch) {
        if mainSwitch.isOn{
            
            conNode = true
            strNode = "true"
            self.defaults.set(strNode, forKey: "NodeConditional")
            
            
        }
        else{
            
            conNode = false
            strNode = "false"
            self.defaults.set(strNode, forKey: "NodeConditional")
            
            
        }
        
    }
    
    private let spinner: UIActivityIndicatorView = {
            let spinner = UIActivityIndicatorView()
            spinner.tintColor = .label
            spinner.hidesWhenStopped = true
            return spinner
        }()
    
    @IBAction func cnnEmotionButton(_ sender: UIButton) {
        print("CNNEmotion Button Pressed")
        
        self.performSegue(withIdentifier: "goToCNN", sender: self)
    }
    
    @IBAction func blendShapeButton(_ sender: UIButton) {
        print("blendShape Button Pressed")
        
        self.performSegue(withIdentifier: "goToBlendShape", sender: self)
    }
    
    @IBAction func asteriskButton(_ sender: Any) {
        print("blendShape Button Pressed")
        
        self.performSegue(withIdentifier: "goToAsterisk", sender: self)
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
//        if segue.identifier == "goToEmotionRec"{
//            let destinationVC = segue.destination as! AREmotionView
//        }
//        updateUI()
//
//    }
    
//    func updateUI(){
//        if let uEmotion = defaults.string(forKey: "UserEmotion") { // Access UserDefault
//            emotion = uEmotion
//        }
//        emotionOfUser.text = emotion
//    }
}

