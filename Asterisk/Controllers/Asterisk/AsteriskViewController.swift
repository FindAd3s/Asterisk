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
        static var oldAlgoEmotion = ""
        static var maxEmotion = ""
        static var medianEmotion = ""
        static var bufferMedianEmotion = ""
        static var meanEmotion = ""
        
        
        /// Left Eye
        static var eyeBlinkLeft = 0.0
        static var eyeLookDownLeft = 0.0
        static var eyeLookInLeft = 0.0
        static var eyeLookOutLeft = 0.0
        static var eyeLookUpLeft = 0.0
        static var eyeSquintLeft = 0.0
        static var eyeWideLeft = 0.0
        
        /// Right Eye
        static var eyeBlinkRight = 0.0
        static var eyeLookDownRight = 0.0
        static var eyeLookInRight = 0.0
        static var eyeLookOutRight = 0.0
        static var eyeLookUpRight = 0.0
        static var eyeSquintRight = 0.0
        static var eyeWideRight = 0.0
        
        /// Mouth
        static var mouthFunnel = 0.0
        static var mouthPucker = 0.0
        static var mouthLeft = 0.0
        static var mouthRight = 0.0
        static var mouthSmileLeft = 0.0
        static var mouthSmileRight = 0.0
        static var mouthFrownLeft = 0.0
        static var mouthFrownRight = 0.0
        static var mouthDimpleLeft = 0.0
        static var mouthDimpleRight = 0.0
        static var mouthStretchLeft = 0.0
        static var mouthStretchRight = 0.0
        static var mouthRollLower = 0.0
        static var mouthRollUpper = 0.0
        static var mouthShrugLower = 0.0
        static var mouthShrugUpper = 0.0
        static var mouthPressLeft = 0.0
        static var mouthPressRight = 0.0
        static var mouthLowerDownLeft = 0.0
        static var mouthLowerDownRight = 0.0
        static var mouthUpperUpLeft = 0.0
        static var mouthUpperUpRight = 0.0
        
        /// Jaw
        static var jawForward = 0.0
        static var jawLeft = 0.0
        static var jawRight = 0.0
        static var jawOpen = 0.0
        
        /// Eyebrows
        static var browDownLeft = 0.0
        static var browDownRight = 0.0
        static var browInnerUp = 0.0
        static var browOuterUpLeft = 0.0
        static var browOuterUpRight = 0.0
        
        /// Cheeks
        static var cheekPuff = 0.0
        static var cheekSquintLeft = 0.0
        static var cheekSquintRight = 0.0
        
        /// Nose
        static var noseSneerLeft = 0.0
        static var noseSneerRight = 0.0
        
        /// Tounge
        static var tongueOut = 0.0
                

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
    var oldAlgoResult = ""
    var medianResult = ""
    var bufferMedianResult = ""
    var maxResult = ""
    var meanResult = ""
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
                self.outputLabel.text = self.bufferMedianResult
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
//        let blinkLeft = anchor.blendShapes[.eyeBlinkLeft]
//        let blinkRight = anchor.blendShapes[.eyeBlinkRight]
//        let mouthDLeft = anchor.blendShapes[.mouthLowerDownLeft]
//        let mouthDRight = anchor.blendShapes[.mouthLowerDownRight]
//        let mouthULeft = anchor.blendShapes[.mouthUpperUpLeft]
//        let mouthURight = anchor.blendShapes[.mouthUpperUpRight]
//        let squintLeft = anchor.blendShapes[.cheekSquintLeft]
//        let squintRight = anchor.blendShapes[.cheekSquintRight]
//        let mouthLeft = anchor.blendShapes[.mouthStretchLeft]
//        let mouthRight = anchor.blendShapes[.mouthStretchRight]
        
        
        var maxNewFacePoseResult = "Neutral"
        var medianNewFacePoseResult = "Neutral"
        var bufferMedianNewFacePoseResult = "Neutral"
        var meanNewFacePoseResult = "Neutral"
        var oldAlgoFacePoseResult = "Neutral"
        let medianHappyLeft = 0.7848998308 as Decimal
        let medianHappyRight = 0.7775132656 as Decimal
        let medianSadLeft = 0.399635613 as Decimal
        let medianSadRight = 0.3996578455 as Decimal
        let medianAngryLeft = 0.2136782855 as Decimal
        let medianAngryRight = 0.2186324745 as Decimal
        
        
//        if ((blinkLeft?.decimalValue ?? 0.0) + (blinkRight?.decimalValue ?? 0.0) + (jawOpen?.decimalValue ?? 0.0)) > 0.4 {
//            oldAlgoFacePoseResult = "Sleepy"
//        }
        
        /// Maximum values
        
//        if ((browLeft?.decimalValue ?? 0.0) + (browRight?.decimalValue ?? 0.0)) > 0.9 {
//            maxNewFacePoseResult = "Angry"
//        }
//
//        if (((frownLeft?.decimalValue ?? 0.0) + (frownRight?.decimalValue ?? 0.0)) > 0.9) && (((browLeft?.decimalValue ?? 0.0) + (browRight?.decimalValue ?? 0.0)) > 0.9) {
//            maxNewFacePoseResult = "Sad"
//        }
        
//        if (smileLeft?.decimalValue ?? 0.0) > 0.9 && (smileRight?.decimalValue ?? 0.0) > 0.9 && (mouthDLeft?.decimalValue ?? 0.0) > 0.81 && (mouthDRight?.decimalValue ?? 0.0) > 0.81 && (mouthULeft?.decimalValue ?? 0.0) > 0.6 && (mouthURight?.decimalValue ?? 0.0) > 0.6 && (squintRight?.decimalValue ?? 0.0) > 0.81 && (squintRight?.decimalValue ?? 0.0) > 0.81{
//            maxNewFacePoseResult = "Happy"
//        }
        
        /// Old Algorithm
        if ((browLeft?.decimalValue ?? 0.0) + (browRight?.decimalValue ?? 0.0)) > 0.9 {
            oldAlgoFacePoseResult = "Angry"
        }

        if ((frownLeft?.decimalValue ?? 0.0) + (frownRight?.decimalValue ?? 0.0) + (jawOpen?.decimalValue ?? 0.0)) > 0.2 {
            if ((browLeft?.decimalValue ?? 0.0) + (browRight?.decimalValue ?? 0.0)) > 0.9 {
                oldAlgoFacePoseResult = "Angry"
            }
            else {
                oldAlgoFacePoseResult = "Sad"
            }
        }

        if ((smileLeft?.decimalValue ?? 0.0) + (smileRight?.decimalValue ?? 0.0)) > 0.3 {
            if ((browLeft?.decimalValue ?? 0.0) + (browRight?.decimalValue ?? 0.0)) > 0.9 {
                oldAlgoFacePoseResult = "Angry"
            }
            else {
                oldAlgoFacePoseResult = "Happy"
            }
        }
        
        /// MAX VALUES
        
        if (smileLeft?.decimalValue ?? 0.0) >= 0.9281300306 && (smileRight?.decimalValue ?? 0.0) >= 0.9272118807 {
            maxNewFacePoseResult = "Happy"
        }
        
        if (browLeft?.decimalValue ?? 0.0) >= 0.8491612077 && (browRight?.decimalValue ?? 0.0) >= 0.849167347 {
            maxNewFacePoseResult = "Angry"
        }
        
        if (frownLeft?.decimalValue ?? 0.0) >= 0.8057038784 && (frownRight?.decimalValue ?? 0.0) >= 0.802146256 {
            maxNewFacePoseResult = "Sad"
        }
        
        /// MEDIAN VALUES
        
        if (smileLeft?.decimalValue ?? 0.0) >= medianHappyLeft && (smileRight?.decimalValue ?? 0.0) >= medianHappyRight {
            medianNewFacePoseResult = "Happy"
        }
        
        if (browLeft?.decimalValue ?? 0.0) >= medianAngryLeft && (browRight?.decimalValue ?? 0.0) >= medianAngryRight {
            medianNewFacePoseResult = "Angry"
        }
        
        if (frownLeft?.decimalValue ?? 0.0) >= medianSadLeft && (frownRight?.decimalValue ?? 0.0) >= medianSadRight {
            medianNewFacePoseResult = "Sad"
        }
        
//        / 50 - 75% MEDIAN VALUES (Buffer 2)
//      50% buffer
//        if (smileLeft?.decimalValue ?? 0.0) >= medianHappyLeft*0.5 && (smileRight?.decimalValue ?? 0.0) >= medianHappyRight*0.5{
//            bufferMedianNewFacePoseResult = "Happy"
//        }
////      70% buffer
//        if (browLeft?.decimalValue ?? 0.0) >= medianAngryLeft*0.7 && (browRight?.decimalValue ?? 0.0) >= medianAngryRight*0.7{
//            bufferMedianNewFacePoseResult = "Angry"
//        }
////      60% buffer
//        if (frownLeft?.decimalValue ?? 0.0) >= medianSadLeft*0.6 && (frownRight?.decimalValue ?? 0.0) >= medianSadRight*0.6{
//            bufferMedianNewFacePoseResult = "Sad"
//        }
        
        /// 50 - 75% MEDIAN VALUES (Buffer 2) (Try number 2)
////      50% buffer
//        if (smileLeft?.decimalValue ?? 0.0) >= medianHappyLeft*0.5 && (smileRight?.decimalValue ?? 0.0) >= medianHappyRight*0.5{
//            bufferMedianNewFacePoseResult = "Happy"
//        }
////      70% buffer
//        if (browLeft?.decimalValue ?? 0.0) >= medianAngryLeft*0.7 && (browRight?.decimalValue ?? 0.0) >= medianAngryRight*0.7{
//            bufferMedianNewFacePoseResult = "Angry"
//        }
////      60% buffer
//        if (frownLeft?.decimalValue ?? 0.0) >= medianSadLeft*0.6 && (frownRight?.decimalValue ?? 0.0) >= medianSadRight*0.6{
//            bufferMedianNewFacePoseResult = "Sad"
//        }
        
        if (browLeft?.decimalValue ?? 0.0) >= medianAngryLeft*0.7 && (browRight?.decimalValue ?? 0.0) >= medianAngryRight*0.7 {
            bufferMedianNewFacePoseResult = "Angry"
        }

        if (frownLeft?.decimalValue ?? 0.0) >= medianSadLeft*0.5 && (frownRight?.decimalValue ?? 0.0) >= medianSadRight*0.5 {
            if (browLeft?.decimalValue ?? 0.0) >= medianAngryLeft*1.8 && (browRight?.decimalValue ?? 0.0) >= medianAngryRight*1.8 {
                bufferMedianNewFacePoseResult = "Angry"
            }
            else {
                bufferMedianNewFacePoseResult = "Sad"
            }
        }

        if (smileLeft?.decimalValue ?? 0.0) >= medianHappyLeft*0.5 && (smileRight?.decimalValue ?? 0.0) >= medianHappyRight*0.5 {
            if (browLeft?.decimalValue ?? 0.0) >= medianAngryLeft*1.8 && (browRight?.decimalValue ?? 0.0) >= medianAngryRight*1.8 {
                bufferMedianNewFacePoseResult = "Angry"
            }
            else {
                bufferMedianNewFacePoseResult = "Happy"
            }
        }
        /// 50% MEDIAN VALUES (Buffer 1)
        
//        if (smileLeft?.decimalValue ?? 0.0) >= 0.3924499154 && (smileRight?.decimalValue ?? 0.0) >= 0.3887566328 {
//            medianMedianNewFacePoseResult = "Happy"
//        }
//
//        if (browLeft?.decimalValue ?? 0.0) >= 0.1998178065 && (browRight?.decimalValue ?? 0.0) >= 0.1998289228 {
//            medianMedianNewFacePoseResult = "Angry"
//        }
//
//        if (frownLeft?.decimalValue ?? 0.0) >= 0.1068391428 && (frownRight?.decimalValue ?? 0.0) >= 0.1093162372 {
//            medianMedianNewFacePoseResult = "Sad"
//        }
        
        /// MEAN VALUES
        
        if (smileLeft?.decimalValue ?? 0.0) >= 0.7292401787 && (smileRight?.decimalValue ?? 0.0) >= 0.7209242408 {
            meanNewFacePoseResult = "Happy"
        }
        
        if (browLeft?.decimalValue ?? 0.0) >= 0.4066765674 && (browRight?.decimalValue ?? 0.0) >= 0.4068068881 {
            meanNewFacePoseResult = "Angry"
        }
        
        if (frownLeft?.decimalValue ?? 0.0) >= 0.3350247763 && (frownRight?.decimalValue ?? 0.0) >= 0.33875591 {
            meanNewFacePoseResult = "Sad"
        }
        
//        if (smileLeft?.decimalValue ?? 0.0) > 0.7 && (smileRight?.decimalValue ?? 0.0) > 0.7 && (mouthDLeft?.decimalValue ?? 0.0) > 0.4 && (mouthDRight?.decimalValue ?? 0.0) > 0.4 {
//            medianNewFacePoseResult = "Happy"
//        }
        
//      Possible 4th Group
//        if (smileLeft?.decimalValue ?? 0.0) > 0.5 && (smileRight?.decimalValue ?? 0.0) > 0.5 && (mouthDLeft?.decimalValue ?? 0.0) > 0.4 && (mouthDRight?.decimalValue ?? 0.0) > 0.4 && (mouthULeft?.decimalValue ?? 0.0) > 0.4 && (mouthURight?.decimalValue ?? 0.0) > 0.4 && (squintRight?.decimalValue ?? 0.0) > 0.4 && (squintRight?.decimalValue ?? 0.0) > 0.4{
//            newFacePoseResult = "Happy"
//        }
        
        if self.oldAlgoResult != oldAlgoFacePoseResult {
            self.oldAlgoResult = oldAlgoFacePoseResult
        }
        if self.medianResult != medianNewFacePoseResult {
            self.medianResult = medianNewFacePoseResult
        }
        if self.bufferMedianResult != bufferMedianNewFacePoseResult {
            self.bufferMedianResult = bufferMedianNewFacePoseResult
        }
        
        if self.maxResult != maxNewFacePoseResult {
            self.maxResult = maxNewFacePoseResult
        }
        if self.meanResult != meanNewFacePoseResult {
            self.meanResult = meanNewFacePoseResult
        }
        
//
        /// Emotion Recognition data points
        
        AsteriskViewController.Constants.medianEmotion = medianNewFacePoseResult
        AsteriskViewController.Constants.bufferMedianEmotion = bufferMedianNewFacePoseResult
        AsteriskViewController.Constants.maxEmotion = maxNewFacePoseResult
        AsteriskViewController.Constants.meanEmotion = meanNewFacePoseResult
        AsteriskViewController.Constants.oldAlgoEmotion = oldAlgoFacePoseResult
        AsteriskViewController.Constants.mouthSmileLeft = smileLeft as! Double//
        AsteriskViewController.Constants.mouthSmileRight = smileRight as! Double//
        AsteriskViewController.Constants.mouthFrownLeft = frownLeft as! Double//
        AsteriskViewController.Constants.mouthFrownRight = frownRight as! Double//
        AsteriskViewController.Constants.browDownLeft = browLeft as! Double
        AsteriskViewController.Constants.browDownRight = browRight as! Double
        AsteriskViewController.Constants.jawOpen = jawOpen as! Double
        
        /// Remaining Data Points
        
        /// Eyes
        AsteriskViewController.Constants.eyeBlinkLeft =  anchor.blendShapes[.eyeBlinkLeft] as! Double
        AsteriskViewController.Constants.eyeBlinkRight =  anchor.blendShapes[.eyeBlinkRight] as! Double
        AsteriskViewController.Constants.eyeLookDownLeft = anchor.blendShapes[.eyeLookDownLeft] as! Double
        AsteriskViewController.Constants.eyeLookDownRight = anchor.blendShapes[.eyeLookDownRight] as! Double
        AsteriskViewController.Constants.eyeLookInLeft =  anchor.blendShapes[.eyeLookInLeft] as! Double
        AsteriskViewController.Constants.eyeLookInRight =  anchor.blendShapes[.eyeLookInRight] as! Double
        AsteriskViewController.Constants.eyeLookUpLeft =  anchor.blendShapes[.eyeLookUpLeft] as! Double
        AsteriskViewController.Constants.eyeLookUpRight =  anchor.blendShapes[.eyeLookUpRight] as! Double
        AsteriskViewController.Constants.eyeLookOutLeft =  anchor.blendShapes[.eyeLookOutLeft] as! Double
        AsteriskViewController.Constants.eyeLookOutRight =  anchor.blendShapes[.eyeLookOutRight] as! Double
        AsteriskViewController.Constants.eyeSquintLeft =  anchor.blendShapes[.eyeSquintLeft] as! Double
        AsteriskViewController.Constants.eyeSquintRight =  anchor.blendShapes[.eyeSquintRight] as! Double
        AsteriskViewController.Constants.eyeWideLeft =  anchor.blendShapes[.eyeWideLeft] as! Double
        AsteriskViewController.Constants.eyeWideRight =  anchor.blendShapes[.eyeWideRight] as! Double
        
        ///Mouth
        AsteriskViewController.Constants.mouthFunnel =  anchor.blendShapes[.mouthFunnel] as! Double
        AsteriskViewController.Constants.mouthPucker =  anchor.blendShapes[.mouthPucker] as! Double
        AsteriskViewController.Constants.mouthLeft =  anchor.blendShapes[.mouthLeft] as! Double
        AsteriskViewController.Constants.mouthRight =  anchor.blendShapes[.mouthRight] as! Double
//        AsteriskViewController.Constants.mouthSmileLeft =  anchor.blendShapes[.mouthSmileLeft] as! Double
//        AsteriskViewController.Constants.mouthSmileRight =  anchor.blendShapes[.mouthSmileRight] as! Double
//        AsteriskViewController.Constants.mouthFrownLeft =  anchor.blendShapes[.mouthFrownLeft] as! Double
//        AsteriskViewController.Constants.mouthFrownRight =  anchor.blendShapes[.mouthFrownRight] as! Double
        AsteriskViewController.Constants.mouthDimpleLeft =  anchor.blendShapes[.mouthDimpleLeft] as! Double
        AsteriskViewController.Constants.mouthDimpleRight =  anchor.blendShapes[.mouthDimpleRight] as! Double
        AsteriskViewController.Constants.mouthStretchLeft =  anchor.blendShapes[.mouthStretchLeft] as! Double
        AsteriskViewController.Constants.mouthStretchRight =  anchor.blendShapes[.mouthStretchRight] as! Double
        AsteriskViewController.Constants.mouthRollLower =  anchor.blendShapes[.mouthRollLower] as! Double
        AsteriskViewController.Constants.mouthRollUpper =  anchor.blendShapes[.mouthRollUpper] as! Double
        AsteriskViewController.Constants.mouthShrugLower =  anchor.blendShapes[.mouthShrugLower] as! Double
        AsteriskViewController.Constants.mouthShrugUpper =  anchor.blendShapes[.mouthShrugUpper] as! Double
        AsteriskViewController.Constants.mouthPressLeft =  anchor.blendShapes[.mouthPressLeft] as! Double
        AsteriskViewController.Constants.mouthPressRight =  anchor.blendShapes[.mouthPressRight] as! Double
        AsteriskViewController.Constants.mouthLowerDownLeft =  anchor.blendShapes[.mouthLowerDownLeft] as! Double
        AsteriskViewController.Constants.mouthLowerDownRight =  anchor.blendShapes[.mouthLowerDownRight] as! Double
        AsteriskViewController.Constants.mouthUpperUpLeft =  anchor.blendShapes[.mouthUpperUpLeft] as! Double
        AsteriskViewController.Constants.mouthUpperUpRight =  anchor.blendShapes[.mouthUpperUpRight] as! Double
        
        /// Jaw
        AsteriskViewController.Constants.jawForward =  anchor.blendShapes[.jawForward] as! Double
//        AsteriskViewController.Constants.jawOpen =  anchor.blendShapes[.jawOpen] as! Double
        AsteriskViewController.Constants.jawLeft =  anchor.blendShapes[.jawLeft] as! Double
        AsteriskViewController.Constants.jawRight =  anchor.blendShapes[.jawRight] as! Double
        
        /// Eyebrows
//        AsteriskViewController.Constants.browDownLeft =  anchor.blendShapes[.browDownLeft] as! Double
//        AsteriskViewController.Constants.browDownRight =  anchor.blendShapes[.browDownRight] as! Double
        AsteriskViewController.Constants.browInnerUp =  anchor.blendShapes[.browInnerUp] as! Double
        AsteriskViewController.Constants.browOuterUpLeft =  anchor.blendShapes[.browOuterUpLeft] as! Double
        AsteriskViewController.Constants.browOuterUpRight =  anchor.blendShapes[.browOuterUpRight] as! Double
        
        /// Cheeks
        AsteriskViewController.Constants.cheekPuff =  anchor.blendShapes[.cheekPuff] as! Double
        AsteriskViewController.Constants.cheekSquintLeft =  anchor.blendShapes[.cheekSquintLeft] as! Double
        AsteriskViewController.Constants.cheekSquintRight =  anchor.blendShapes[.cheekSquintRight] as! Double
        
        /// Nose
        AsteriskViewController.Constants.noseSneerLeft =  anchor.blendShapes[.noseSneerLeft] as! Double
        AsteriskViewController.Constants.noseSneerRight =  anchor.blendShapes[.noseSneerRight] as! Double
        
        /// Tounge
        AsteriskViewController.Constants.tongueOut =  anchor.blendShapes[.tongueOut] as! Double
        
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
        var userPicked: String?
//        print(facePoseResult)
        
//        print("", terminator: Array(repeating: "\n", count: 20).joined())
        /*
        print("\nEmotion: \(AsteriskViewController.Constants.emotion)\n")
        
        print("mouthSmileLeft: \(AsteriskViewController.Constants.mouthSmileLeft)")
        print("mouthSmileRight: \(AsteriskViewController.Constants.mouthSmileRight)")
        print("mouthFrownLeft: \(AsteriskViewController.Constants.mouthFrownLeft)")
        print("mouthFrownRight: \(AsteriskViewController.Constants.mouthFrownRight)")
        print("browDownLeft: \(AsteriskViewController.Constants.browDownLeft)")
        print("browDownRight: \(AsteriskViewController.Constants.browDownRight)")
        print("jawOpen: \(AsteriskViewController.Constants.jawOpen)")
        
        print("\nMiscellaneous Data points")
        
        print("\nEyes")
        print("eyeBlinkLeft: \(AsteriskViewController.Constants.eyeBlinkLeft)")
        print("eyeBlinkRight: \(AsteriskViewController.Constants.eyeBlinkRight)")
        print("eyeLookDownLeft: \(AsteriskViewController.Constants.eyeLookDownLeft)")
        print("eyeLookDownRight: \(AsteriskViewController.Constants.eyeLookDownRight)")
        print("eyeLookInLeft: \(AsteriskViewController.Constants.eyeLookInLeft)")
        print("eyeLookInRight: \(AsteriskViewController.Constants.eyeLookInRight)")
        print("eyeLookUpLeft: \(AsteriskViewController.Constants.eyeLookUpLeft)")
        print("eyeLookUpRight: \(AsteriskViewController.Constants.eyeLookUpRight)")
        print("eyeLookOutLeft: \(AsteriskViewController.Constants.eyeLookOutLeft)")
        print("eyeLookOutRight: \(AsteriskViewController.Constants.eyeLookOutRight)")
        print("eyeSquintLeft: \(AsteriskViewController.Constants.eyeSquintLeft)")
        print("eyeSquintRight: \(AsteriskViewController.Constants.eyeSquintRight)")
        print("eyeWideLeft: \(AsteriskViewController.Constants.eyeWideLeft)")
        print("eyeWideRight: \(AsteriskViewController.Constants.eyeWideRight)")
        
        print("\nMouth")
        print("mouthFunnel: \(AsteriskViewController.Constants.mouthFunnel)")
        print("mouthPucker: \(AsteriskViewController.Constants.mouthPucker)")
        print("mouthLeft: \(AsteriskViewController.Constants.mouthLeft)")
        print("mouthRight: \(AsteriskViewController.Constants.mouthRight)")
        print("mouthDimpleLeft: \(AsteriskViewController.Constants.mouthDimpleLeft)")
        print("mouthDimpleRight: \(AsteriskViewController.Constants.mouthDimpleRight)")
        print("mouthStretchLeft: \(AsteriskViewController.Constants.mouthStretchLeft)")
        print("mouthStretchRight: \(AsteriskViewController.Constants.mouthStretchRight)")
        print("mouthRollLower: \(AsteriskViewController.Constants.mouthRollLower)")
        print("mouthRollUpper: \(AsteriskViewController.Constants.mouthRollUpper)")
        print("mouthShrugLower: \(AsteriskViewController.Constants.mouthShrugLower)")
        print("mouthShrugUpper: \(AsteriskViewController.Constants.mouthShrugUpper)")
        print("mouthPressLeft: \(AsteriskViewController.Constants.mouthPressLeft)")
        print("mouthPressRight: \(AsteriskViewController.Constants.mouthPressRight)")
        print("mouthLowerDownLeft: \(AsteriskViewController.Constants.mouthLowerDownLeft)")
        print("mouthLowerDownRight: \(AsteriskViewController.Constants.mouthLowerDownRight)")
        print("mouthUpperUpLeft: \(AsteriskViewController.Constants.mouthUpperUpLeft)")
        print("mouthUpperUpRight: \(AsteriskViewController.Constants.mouthUpperUpRight)")
        
        print("\nJaw")
        print("jawForward: \(AsteriskViewController.Constants.jawForward)")
        print("jawLeft: \(AsteriskViewController.Constants.jawLeft)")
        print("jawRight: \(AsteriskViewController.Constants.jawRight)")
        
        print("\nEyebrows")
        print("browInnerUp: \(AsteriskViewController.Constants.browInnerUp)")
        print("browOuterUpLeft: \(AsteriskViewController.Constants.browOuterUpLeft)")
        print("browOuterUpRight: \(AsteriskViewController.Constants.browOuterUpRight)")
        
        print("\nCheeks")
        print("cheekPuff: \(AsteriskViewController.Constants.cheekPuff)")
        print("cheekSquintLeft: \(AsteriskViewController.Constants.cheekSquintLeft)")
        print("cheekSquintRight: \(AsteriskViewController.Constants.cheekSquintRight)")
        
        print("\nNose")
        print("noseSneerLeft: \(AsteriskViewController.Constants.noseSneerLeft)")
        print("noseSneerRight: \(AsteriskViewController.Constants.noseSneerRight)")
        
        print("\nTongue")
        print("tongueOut: \(AsteriskViewController.Constants.tongueOut)")
        */
        
        if let pickedEmotion = defaults.string(forKey: "PickedEmotion") { // Access UserDefault
            userPicked = pickedEmotion
        }
        
        
        print("\n")
        print(userPicked!)
//        print("Intended Emotion: \(userPicked!)")
        print(AsteriskViewController.Constants.maxEmotion)
        print(AsteriskViewController.Constants.meanEmotion)
        print(AsteriskViewController.Constants.medianEmotion)
        print(AsteriskViewController.Constants.bufferMedianEmotion)
        print(AsteriskViewController.Constants.oldAlgoEmotion)
//        print("Median Emotion: \((AsteriskViewController.Constants.medianEmotion as String?)!)")
//        print("Mean Emotion: \((AsteriskViewController.Constants.meanEmotion as String?)!)")
        
        
        print(AsteriskViewController.Constants.mouthSmileLeft)
        print(AsteriskViewController.Constants.mouthSmileRight)
        print(AsteriskViewController.Constants.mouthFrownLeft)
        print(AsteriskViewController.Constants.mouthFrownRight)
        print(AsteriskViewController.Constants.browDownLeft)
        print(AsteriskViewController.Constants.browDownRight)
        print(AsteriskViewController.Constants.jawOpen)
        
        print(AsteriskViewController.Constants.eyeBlinkLeft)
        print(AsteriskViewController.Constants.eyeBlinkRight)
        print(AsteriskViewController.Constants.eyeLookDownLeft)
        print(AsteriskViewController.Constants.eyeLookDownRight)
        print(AsteriskViewController.Constants.eyeLookInLeft)
        print(AsteriskViewController.Constants.eyeLookInRight)
        print(AsteriskViewController.Constants.eyeLookUpLeft)
        print(AsteriskViewController.Constants.eyeLookUpRight)
        print(AsteriskViewController.Constants.eyeLookOutLeft)
        print(AsteriskViewController.Constants.eyeLookOutRight)
        print(AsteriskViewController.Constants.eyeSquintLeft)
        print(AsteriskViewController.Constants.eyeSquintRight)
        print(AsteriskViewController.Constants.eyeWideLeft)
        print(AsteriskViewController.Constants.eyeWideRight)
        
        print(AsteriskViewController.Constants.mouthFunnel)
        print(AsteriskViewController.Constants.mouthPucker)
        print(AsteriskViewController.Constants.mouthLeft)
        print(AsteriskViewController.Constants.mouthRight)
        print(AsteriskViewController.Constants.mouthDimpleLeft)
        print(AsteriskViewController.Constants.mouthDimpleRight)
        print(AsteriskViewController.Constants.mouthStretchLeft)
        print(AsteriskViewController.Constants.mouthStretchRight)
        print(AsteriskViewController.Constants.mouthRollLower)
        print(AsteriskViewController.Constants.mouthRollUpper)
        print(AsteriskViewController.Constants.mouthShrugLower)
        print(AsteriskViewController.Constants.mouthShrugUpper)
        print(AsteriskViewController.Constants.mouthPressLeft)
        print(AsteriskViewController.Constants.mouthPressRight)
        print(AsteriskViewController.Constants.mouthLowerDownLeft)
        print(AsteriskViewController.Constants.mouthLowerDownRight)
        print(AsteriskViewController.Constants.mouthUpperUpLeft)
        print(AsteriskViewController.Constants.mouthUpperUpRight)
        
        print(AsteriskViewController.Constants.jawForward)
        print(AsteriskViewController.Constants.jawLeft)
        print(AsteriskViewController.Constants.jawRight)
        
        print(AsteriskViewController.Constants.browInnerUp)
        print(AsteriskViewController.Constants.browOuterUpLeft)
        print(AsteriskViewController.Constants.browOuterUpRight)
        
        print(AsteriskViewController.Constants.cheekPuff)
        print(AsteriskViewController.Constants.cheekSquintLeft)
        print(AsteriskViewController.Constants.cheekSquintRight)
        
        print(AsteriskViewController.Constants.noseSneerLeft)
        print(AsteriskViewController.Constants.noseSneerRight)
        
        print(AsteriskViewController.Constants.tongueOut)
        
        self.defaults.set(oldAlgoResult, forKey: "oldAlgoEmotion") // Publish to UserDefaults
        self.defaults.set(maxResult, forKey: "MaxEmotion") // Publish to UserDefaults
        self.defaults.set(medianResult, forKey: "MedianEmotion") // Publish to UserDefaults
        self.defaults.set(bufferMedianResult, forKey: "BufferMedianEmotion") // Publish to UserDefaults
        self.defaults.set(meanResult, forKey: "MeanEmotion") // Publish to UserDefaults
        
        
        performSegue(withIdentifier: "goToAsteriskData", sender: self)
        
//        self.dismiss(animated: true, completion: nil)
    }
}
