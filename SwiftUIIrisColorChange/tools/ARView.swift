//
//  ARView.swift
//  SwiftUIIrisColorChange
//
//  Created by Pooya on 2021-03-08.
//

import Foundation
import ARKit
import SwiftUI


// MARK: - ARViewIndicator
struct ARViewIndicator : UIViewControllerRepresentable {
    typealias UIViewControllerType = ARView
    
    func makeUIViewController(context : Context) -> ARView {
        return ARView()
    }
    
    func updateUIViewController(_ uiViewController: ARViewIndicator.UIViewControllerType, context: UIViewControllerRepresentableContext<ARViewIndicator>) {}
}


class ARView: UIViewController, ARSCNViewDelegate {
    
    // set renderer
    private let sceneView = ARSCNView(frame: .zero)
    
    // Declare eye nodes
    private var leftEyeNode : ImageNode?
    private var rightEyeNode : ImageNode?
    
    // Specify ARConfiguration
    private let faceTrackingConfiguration = ARFaceTrackingConfiguration()
    
    var arView: ARSCNView {
        return self.view as! ARSCNView
    }
    
    
    override func loadView() {
        self.view = ARSCNView(frame: .zero)
        view = sceneView
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
       arView.delegate = self
       arView.scene = SCNScene()


     guard ARFaceTrackingConfiguration.isSupported else { fatalError("A TrueDepth camera is required") }
     /// Set sceneView delegate
     sceneView.delegate = self

     /// If needed, we can set some debugOptions
    }

    
    // MARK: - Functions for standard AR view handling
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       let configuration = ARWorldTrackingConfiguration()
       arView.session.run(configuration)
       arView.delegate = self

     /// Run session
     sceneView.session.run(faceTrackingConfiguration)

    }
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       arView.session.pause()
     
     /// Pause session
     sceneView.session.pause()

    }
    // MARK: - ARSCNViewDelegate
    func sessionWasInterrupted(_ session: ARSession) {}
    
    func sessionInterruptionEnded(_ session: ARSession) {}
    func session(_ session: ARSession, didFailWithError error: Error)
    {}
    func session(_ session: ARSession, cameraDidChangeTrackingState
    camera: ARCamera) {}
     
     
     
     
    // MARK: - Render face
     

     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {

         // Note: - You must compile this project with an iPhone with TrueDepth camera as target device, otherwise it will mark that sceneView has no `device` member

         /// Validate anchor is an ARFaceAnchor instance
         guard anchor is ARFaceAnchor,
             let device = sceneView.device else { return nil }

         /// Create node with face geometry
         let faceGeometry = ARSCNFaceGeometry(device: device)
         let node = SCNNode(geometry: faceGeometry)

         node.geometry?.firstMaterial?.colorBufferWriteMask = []

         /// Create eye ImageNodes
        rightEyeNode = ImageNode(width: 0.015, height: 0.015, image: UIImage(imageLiteralResourceName: GlobalVar.rightIriSName))
        leftEyeNode = ImageNode(width: 0.015, height: 0.015, image: UIImage(imageLiteralResourceName: GlobalVar.leftIriSName))

         /// Change the origin of the eye nodes
         rightEyeNode?.pivot = SCNMatrix4MakeTranslation(0, 0, -0.01)
         leftEyeNode?.pivot = SCNMatrix4MakeTranslation(0, 0, -0.01)

         /// Add child nodes
         rightEyeNode.flatMap { node.addChildNode($0) }
         leftEyeNode.flatMap { node.addChildNode($0) }

         return node
     }

     func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
         /// Get face anchor as ARFaceAnchor
         guard let faceAnchor = anchor as? ARFaceAnchor,
             let faceGeometry = node.geometry as? ARSCNFaceGeometry else { return }

         /// Update the geometry displayed on screen to be now conformed by the anchor calculated
         faceGeometry.update(from: faceAnchor.geometry)

         /// Update node transforms
         leftEyeNode?.simdTransform = faceAnchor.leftEyeTransform
         rightEyeNode?.simdTransform = faceAnchor.rightEyeTransform
     }

    
}
