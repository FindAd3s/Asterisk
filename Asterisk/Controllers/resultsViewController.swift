//
//  resultsViewController.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 11/22/22.
//

import UIKit

class resultsViewController: UIViewController {
    
    let defaults = UserDefaults()

    @IBOutlet weak var algorithmXLabel: UILabel!
    @IBOutlet weak var algorithmYLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        algorithmXLabel.text = String(defaults.integer(forKey: "CountX"))
        algorithmYLabel.text = String(defaults.integer(forKey: "CountY"))

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        defaults.set(0, forKey: "CountX")
        defaults.set(0, forKey: "CountY")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
