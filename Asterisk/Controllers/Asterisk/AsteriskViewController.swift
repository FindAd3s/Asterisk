//
//  blendShapeViewController.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 7/15/22.
//

import UIKit
import ARKit

class AsteriskViewController: UIViewController, ARSCNViewDelegate {
    
    struct Constants{
        
        /// Emotion
        static var emotion = ""
        
        /// Left Eye
        static let eyeBlinkLeft = 0.0
        static let eyeLookDownLeft = 0.0
        static let eyeLookInLeft = 0.0
        static let eyeLookOutLeft = 0.0
        static let eyeLookUpLeft = 0.0
        static let eyeSquintLeft = 0.0
        static let eyeWideLeft = 0.0
        
        /// Right Eye
        static let eyeBlinkRight = 0.0
        static let eyeLookDownRight = 0.0
        static let eyeLookInRight = 0.0
        static let eyeLookOutRight = 0.0
        static let eyeLookUpRight = 0.0
        static let eyeSquintRight = 0.0
        static let eyeWideRight = 0.0
        
        /// Mouth
        static let mouthFunnel = 0.0
        static let mouthPucker = 0.0
        static let mouthLeft = 0.0
        static let mouthRight = 0.0
        static var mouthSmileLeft = 0.0
        static var mouthSmileRight = 0.0
        static var mouthFrownLeft = 0.0
        static var mouthFrownRight = 0.0
        static let mouthDimpleLeft = 0.0
        static let mouthDimpleRight = 0.0
        static let mouthStretchLeft = 0.0
        static let mouthStretchRight = 0.0
        static let mouthRollLower = 0.0
        static let mouthRollUpper = 0.0
        static let mouthShrugLower = 0.0
        static let mouthShrugUpper = 0.0
        static let mouthPressLeft = 0.0
        static let mouthPressRight = 0.0
        static let mouthLowerDownLeft = 0.0
        static let mouthLowerDownRight = 0.0
        static let mouthUpperUpLeft = 0.0
        static let mouthUpperUpRight = 0.0
        
        /// Jaw
        static let jawForward = 0.0
        static let jawLeft = 0.0
        static let jawRight = 0.0
        static let jawOpen = 0.0
        
        /// Eyebrows
        static var browDownLeft = 0.0
        static var browDownRight = 0.0
        static let browInnerUp = 0.0
        static let browOuterUpLeft = 0.0
        static let browOuterUpRight = 0.0
        
        /// Cheeks
        static let cheekPuff = 0.0
        static let cheekSquintLeft = 0.0
        static let cheekSquintRight = 0.0
        
        /// Nose
        static let noseSneerLeft = 0.0
        static let noseSneerRight = 0.0
        
        /// Tounge
        static let toungeOut = 0.0
                

//
//        print("Emotion: \(newFacePoseResult)")
//        print("mouthSmileLeft: \(smileLeft!)")
//        print("mouthSmileRight: \(smileRight!)")
//        print("browInnerUp: \(innerUp!)")
    }
    
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
        let innerUp = anchor.blendShapes[.browInnerUp]
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
        
        if ((frownLeft?.decimalValue ?? 0.0) + (frownRight?.decimalValue ?? 0.0) + (jawOpen?.decimalValue ?? 0.0)) > 0.2 {
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
        
//
        
        
        AsteriskViewController.Constants.emotion = newFacePoseResult
        AsteriskViewController.Constants.mouthSmileLeft = smileLeft as! Double
        AsteriskViewController.Constants.mouthSmileRight = smileRight as! Double
        AsteriskViewController.Constants.mouthFrownLeft = frownLeft as! Double
        AsteriskViewController.Constants.mouthFrownRight = frownRight as! Double
        AsteriskViewController.Constants.browDownLeft = browLeft as! Double
        AsteriskViewController.Constants.browDownRight = browRight as! Double
        AsteriskViewController.Constants.mouthSmileLeft = smileLeft as! Double
        
        
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
//        print(facePoseResult)
        
//        print("", terminator: Array(repeating: "\n", count: 20).joined())
        
        print("\nEmotion: \(AsteriskViewController.Constants.emotion)\n")
        
        print("mouthSmileLeft: \(AsteriskViewController.Constants.mouthSmileLeft)")
        print("mouthSmileRight: \(AsteriskViewController.Constants.mouthSmileRight)")
        print("mouthFrownLeft: \(AsteriskViewController.Constants.mouthFrownLeft)")
        print("mouthFrownRight: \(AsteriskViewController.Constants.mouthFrownRight)")
        print("browDownLeft: \(AsteriskViewController.Constants.browDownLeft)")
        print("browDownRight: \(AsteriskViewController.Constants.browDownRight)")
        print("jawOpen: \(AsteriskViewController.Constants.jawOpen)")
                
        self.defaults.set(facePoseResult, forKey: "AsteriskEmotion") // Publish to UserDefaults
        
        performSegue(withIdentifier: "goToAsteriskData", sender: self)
        
//        self.dismiss(animated: true, completion: nil)
    }
}
