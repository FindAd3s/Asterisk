//
//  CNNViewController.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 7/15/22.
//

import UIKit
import ARKit

class CNNViewController: UIViewController, ARSCNViewDelegate{

    @IBOutlet weak var userEmotionText: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    
    var defaults = UserDefaults.standard
    var facePoseResult = ""
    
    
    var emotion = "No Emotion Presented"
    //The sceneview that we are going to display.
//    private let sceneView = ARSCNView(frame: UIScreen.main.bounds)
    //The CoreML model we use for emotion classification.
    private let model = try! VNCoreMLModel(for: CNNEmotions().model)
    //The scene node containing the emotion text.
    private var textNode: SCNNode?

    override func viewDidLoad() {
        super.viewDidLoad()
     
        guard ARFaceTrackingConfiguration.isSupported else {
            fatalError("Face tracking not available on this on this device model!")
        }
        
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
        node.geometry?.firstMaterial?.fillMode = .lines
        return node
    }

    @objc(renderer:didUpdateNode:forAnchor:) func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let faceGeometry = node.geometry as? ARSCNFaceGeometry,
            let pixelBuffer = self.sceneView.session.currentFrame?.capturedImage
            else {
            return
        }
        
        //Updates the face geometry.
        faceGeometry.update(from: faceAnchor.geometry)
//        facePoseAnalyzer(anchor: faceAnchor)
        
//        DispatchQueue.main.async {
//            self.userBlendShapeText.text = self.facePoseResult
//        }
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
                        self!.emotion = firstResult.identifier
//                        print(self!.emotion)
                    }
                }
            }])
    }
    @IBAction func captureButtonPressed(_ sender: UIButton) {
        print(emotion)
                
        self.defaults.set(emotion, forKey: "CNNUserEmotion") // Publish to UserDefaults
        
        performSegue(withIdentifier: "goToCnnData", sender: self)
    }
    
}

