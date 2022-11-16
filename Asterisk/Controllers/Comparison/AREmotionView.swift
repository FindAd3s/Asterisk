//
//  ViewController.swift
//  ARKit-CoreML-Emotion-Classification
//
//  Created by Adrian Co on 7/15/2022
//

import UIKit
import ARKit

class AREmotionView: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var userEmotionText: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var userBlendShapeText: UILabel!
//    @IBOutlet weak var userSwitch: UISwitch!
    
    var defaults = UserDefaults.standard
    var facePoseResult = ""
    var conNode: Bool?
    var strNode: String? = "true"
    var cnnEmotion = "No Emotion Presented"
    
    //The sceneview that we are going to display.
//    private let sceneView = ARSCNView(frame: UIScreen.main.bounds)
    //The CoreML model we use for emotion classification.
    private let model = try! VNCoreMLModel(for: CNNEmotions().model)
    //The scene node containing the emotion text.
    private var textNode: SCNNode?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard ARWorldTrackingConfiguration.isSupported else { return }
        
       guard ARFaceTrackingConfiguration.isSupported else {
           fatalError("Face tracking not available on this on this device model!")
        view.addSubview(sceneView)
       }
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.session.run(ARFaceTrackingConfiguration(), options: [.resetTracking, .removeExistingAnchors])
//        userSwitch.isOn = false
        
        if let cond = defaults.string(forKey: "NodeConditional") { // Access UserDefault
                   strNode = cond
               }
               
        conNode = Bool(strNode ?? "true")
//        print(strNode!)
//        print(conNode!)
//        if conNode == true{
//            userSwitch.isOn = true
//        }
//        else{
//            userSwitch.isOn = false
//        }
        
    }

//    /// Creates a scene node containing yellow coloured text.
//    /// - Parameter faceGeometry: the geometry the node is using.
//    private func addTextNode(faceGeometry: ARSCNFaceGeometry) {
//        let text = SCNText(string: "", extrusionDepth: 1)
//        text.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIColor.systemYellow
//        text.materials = [material]
//
//        let textNode = SCNNode(geometry: faceGeometry)
//        textNode.position = SCNVector3(-0.1, 0.3, -0.5)
//        textNode.scale = SCNVector3(0.003, 0.003, 0.003)
//        textNode.geometry = text
//        self.textNode = textNode
//        sceneView.scene.rootNode.addChildNode(textNode)
//    }
    @IBAction func captureButtonPressed(_ sender: UIButton) {
//        print(cnnEmotion)
                
        self.defaults.set(cnnEmotion, forKey: "UserCNNEmotion") // Publish to UserDefaults
        self.defaults.set(facePoseResult, forKey: "UserBlendShapeEmotion")
        performSegue(withIdentifier: "goToData", sender: self)
        
//        self.dismiss(animated: true, completion: nil)
    }

//    @IBAction func scnRendererSwitch(_ sender: UISwitch) {
//        if scnRendererSwitch.on{
//            testBool = true
//            print(testBool)
//        }
//        else{
//            testBool = false
//            print(testBool)
//        }
//    }
    @objc(renderer:nodeForAnchor:) func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let device = sceneView.device else { return nil }
        let node = SCNNode(geometry: ARSCNFaceGeometry(device: device))
//        //Projects the white lines on the face.
        
        if conNode == true{
            node.geometry?.firstMaterial?.fillMode = .lines
        }
        else{
            node.geometry?.firstMaterial?.transparency = 0
        }
        
        
        
//
        return node
//        return nil
    }
//    @IBAction func switchStateChanged(_ sender: UISwitch) {
//        if userSwitch.isOn{
//
//            conNode = true
//            strNode = "true"
//            self.defaults.set(strNode, forKey: "NodeConditional")
//
//
//        }
//        else{
//
//            conNode = false
//            strNode = "false"
//            self.defaults.set(strNode, forKey: "NodeConditional")
//
//
//        }
//    }
    
    

//    @objc(renderer:didAddNode:forAnchor:) func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        guard let faceGeometry = node.geometry as? ARSCNFaceGeometry, textNode == nil else { return }
//        addTextNode(faceGeometry: faceGeometry)
//    }

    @objc(renderer:didUpdateNode:forAnchor:) func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let faceGeometry = node.geometry as? ARSCNFaceGeometry,
            let pixelBuffer = self.sceneView.session.currentFrame?.capturedImage
            else {
            return
        }
        
        //Updates the face geometry.
        faceGeometry.update(from: faceAnchor.geometry)
        facePoseAnalyzer(anchor: faceAnchor)
        
        DispatchQueue.main.async {
            self.userBlendShapeText.text = self.facePoseResult
        }
        //Creates Vision Image Request Handler using the current frame and performs an MLRequest.
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right, options: [:]).perform([VNCoreMLRequest(model: model) { [weak self] request, error in
                //Here we get the first result of the Classification Observation result.
            guard let firstResult = (request.results as? [VNClassificationObservation])?.first else { return }
            DispatchQueue.main.async { [self] in

                    //Check if the confidence is high enough - used an arbitrary value here - and update the text to display the resulted emotion.
                if firstResult.confidence > 0.40 {
//                        (self?.textNode?.geometry as? SCNText)?.string = firstResult.identifier
                        self?.userEmotionText.text = firstResult.identifier
                        
//                        Insert necessary change for text here. Delete SCNText after for a static implementation of emotion readout
                        self!.cnnEmotion = firstResult.identifier
//                        print(self!.emotion)
                    }
                }
            }])
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
        let mouthLeft = anchor.blendShapes[.mouthStretchLeft]
        let mouthRight = anchor.blendShapes[.mouthStretchRight]
        
        var newFacePoseResult = "Neutral"
    
        if ((jawOpen?.decimalValue ?? 0.0) + (innerUp?.decimalValue ?? 0.0) + (innerUp?.decimalValue ?? 0.0)) > 0.8 {
            newFacePoseResult = "Surprised"
        }
        
        if ((browLeft?.decimalValue ?? 0.0) + (browRight?.decimalValue ?? 0.0)) > 0.9 {
            newFacePoseResult = "Angry"
        }
        
        if ((frownLeft?.decimalValue ?? 0.0) + (frownRight?.decimalValue ?? 0.0)) > 0.9 {
            newFacePoseResult = "Sad"
        }
        
        if ((smileLeft?.decimalValue ?? 0.0) + (smileRight?.decimalValue ?? 0.0)) > 0.9 {
            newFacePoseResult = "Happy"
        }
        
        if ((mouthLeft?.decimalValue ?? 0.0) + (mouthRight?.decimalValue ?? 0.0)) > 0.9 {
            newFacePoseResult = "Disgust"
        }
        
//        if tongue?.decimalValue ?? 0.0 > 0.08 {
//            newFacePoseResult = "😛"
//        }
//
//        if cheekPuff?.decimalValue ?? 0.0 > 0.5 {
//            newFacePoseResult = "🤢"
//        }
//
//        if eyeBlinkLeft?.decimalValue ?? 0.0 > 0.5 {
//            newFacePoseResult = "😉"
//        }
        
        if self.facePoseResult != newFacePoseResult {
            self.facePoseResult = newFacePoseResult
        }
        
    }
    
    
}

