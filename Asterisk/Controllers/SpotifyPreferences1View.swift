//
//  SpotifyPreferences1View.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 6/14/22.
//

import UIKit

class SpotifyPreferences1View: UIViewController {

    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnToPreferencesView(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToPreferences1", sender: self)
        
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
