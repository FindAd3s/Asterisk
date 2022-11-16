//
//  ComparisonResultsViewController.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 11/15/22.
//

import UIKit

class ComparisonResultsViewController: UIViewController {
    var algoResult: String?
    var algorithm: String?
    var defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let algorithm = defaults.string(forKey: "PickedAlgorithm") { // Access UserDefault
               algoResult = algorithm
        }
        print(algoResult!)
        resultLabel.text = algoResult

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func returnButton(_ sender: UIButton) {
        
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
