//
//  SpotifyPreferences2View.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 6/14/22.
//

import UIKit

class SpotifyPreferences2View: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnToPreferencesButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToPreferences2", sender: self)
        
        
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
