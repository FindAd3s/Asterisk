//
//  blendShapeViewController.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 7/15/22.
//

import UIKit
import ARKit

class AsteriskViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
//    @IBOutlet weak var outputView: UIView!
    @IBOutlet weak var outputLabel: UILabel!
    
    var defaults = UserDefaults.standard
    var facePoseResult = ""
    var conNode: Bool?
    var strNode: String? = "true"
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        guard ARFaceTrackingConfiguration.isSupported else {
            fatalError("Face tracking not available on this on this device model!")
        }
        if let cond = defaults.string(forKey: "NodeConditional") { // Access UserDefault
           strNode = cond
       }
               
        conNode = Bool(strNode ?? "true")
        print(strNode!)
        print(conNode!)
                
        
        
//        outputView.layer.cornerRadius = 15
        sceneView.delegate = self
        sceneView.showsStatistics = true
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARFaceTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let faceMesh = ARSCNFaceGeometry(device: sceneView.device!)
        let node = SCNNode(geometry: faceMesh)
        
        if conNode == true{
            node.geometry?.firstMaterial?.fillMode = .lines
        }
        else{
            node.geometry?.firstMaterial?.transparency = 0
        }
        
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry {
            faceGeometry.update(from: faceAnchor.geometry)
            facePoseAnalyzer(anchor: faceAnchor)
            
            DispatchQueue.main.async {
                self.outputLabel.text = self.facePoseResult
            }
            
        }
    }
    
    
    
    func facePoseAnalyzer(anchor: ARFaceAnchor) {
        let smileLeft = anchor.blendShapes[.mouthSmileLeft]
        let smileRight = anchor.blendShapes[.mouthSmileRight]
//        let innerUp = anchor.blendShapes[.browInnerUp]
//        let tongue = anchor.blendShapes[.tongueOut]
//        let cheekPuff = anchor.blendShapes[.cheekPuff]
//        let eyeBlinkLeft = anchor.blendShapes[.eyeBlinkLeft]
        let jawOpen = anchor.blendShapes[.jawOpen]
        let browLeft = anchor.blendShapes[.browDownLeft]
        let browRight = anchor.blendShapes[.browDownRight]
        let frownLeft = anchor.blendShapes[.mouthFrownLeft]
        let frownRight = anchor.blendShapes[.mouthFrownRight]
        let blinkLeft = anchor.blendShapes[.eyeBlinkLeft]
        let blinkRight = anchor.blendShapes[.eyeBlinkRight]
        
//        let mouthLeft = anchor.blendShapes[.mouthStretchLeft]
//        let mouthRight = anchor.blendShapes[.mouthStretchRight]
        
        var newFacePoseResult = "Neutral"
        
        
        if ((browLeft?.decimalValue ?? 0.0) + (browRight?.decimalValue ?? 0.0)) > 0.9 {
            newFacePoseResult = "Angry"
        }
        
        if ((frownLeft?.decimalValue ?? 0.0) + (frownRight?.decimalValue ?? 0.0) + (jawOpen?.decimalValue ?? 0.0)) > 0.1 {
            if ((browLeft?.decimalValue ?? 0.0) + (browRight?.decimalValue ?? 0.0)) > 0.9 {
                newFacePoseResult = "Angry"
            }
            else {
                newFacePoseResult = "Sad"
            }
        }
        
        if ((smileLeft?.decimalValue ?? 0.0) + (smileRight?.decimalValue ?? 0.0)) > 0.5 {
            if ((browLeft?.decimalValue ?? 0.0) + (browRight?.decimalValue ?? 0.0)) > 0.9 {
                newFacePoseResult = "Angry"
            }
            else {
                newFacePoseResult = "Happy"
            }
        }
        
//        if ((blinkLeft?.decimalValue ?? 0.0) + (blinkRight?.decimalValue ?? 0.0) + (jawOpen?.decimalValue ?? 0.0)) > 0.4 {
//            newFacePoseResult = "Sleepy"
//        }
               
        
        if self.facePoseResult != newFacePoseResult {
            self.facePoseResult = newFacePoseResult
        }
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    @IBAction func captureButtonPressed(_ sender: UIButton) {
        print(facePoseResult)
                
        self.defaults.set(facePoseResult, forKey: "AsteriskEmotion") // Publish to UserDefaults
        
        performSegue(withIdentifier: "goToAsteriskData", sender: self)
        
//        self.dismiss(animated: true, completion: nil)
    }
}
