//
//  PreferencesViewController.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 6/2/22.
//

import UIKit

class PreferencesView: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func mainMenuButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToMainMenu", sender: self)
        
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
