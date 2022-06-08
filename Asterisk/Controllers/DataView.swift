//
//  DataView.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 6/8/22.
//

import UIKit

class DataView: UIViewController {
    
    var emotion: String?
    
    @IBOutlet weak var emotionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        emotionLabel.text = "Emotion of user: \(emotion ?? "No data")"
        // Do any additional setup after loading the view.
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
