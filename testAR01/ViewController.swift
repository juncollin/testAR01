//
//  ViewController.swift
//  testAR01
//
//  Created by 有本淳吾 on 2018/06/19.
//  Copyright © 2018 有本淳吾. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        
//        // シェイプ
//        let textShape = SCNText(string: "つぶ", extrusionDepth: 1)
//        textShape.flatness = 0.0
//
//        // パーティクルシステム
//        let particle = SCNParticleSystem(named: "Rain.scnp", inDirectory: "")
//        particle?.emitterShape = textShape
//        let particleShapePosition = particle?.emitterShape?.boundingSphere.center
//
//        // ノードにパーティクルシステムをピボット変更後して紐付ける
//        let particleNode = SCNNode()
//        particleNode.pivot = SCNMatrix4MakeTranslation(particleShapePosition!.x, particleShapePosition!.y, 0)
//        particleNode.addParticleSystem(particle!)
//
//        particleNode.position = SCNVector3(0, 0, -30)
//
//        scene.rootNode.addChildNode(particleNode)
        
        let floor = SCNFloor()
        floor.firstMaterial?.diffuse.contents = UIColor.darkGray
        floor.reflectivity = 0.0
        
        let floorNode = SCNNode(geometry: floor)
        floorNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        scene.rootNode.addChildNode(floorNode)
        
        floorNode.position = SCNVector3(0, -1, 0)
        
        let emitter1 = SCNParticleSystem(named: "Rain.scnp", inDirectory: "")
        let emitter2 = SCNParticleSystem(named: "Splash.scnp", inDirectory: "")
        emitter2?.loops = false
        
        let plane = SCNPlane(width: 100, height: 100)
//        plane.widthSegmentCount = 4
//        plane.heightSegmentCount = 4
//        plane.cornerSegmentCount = 4
        plane.firstMaterial?.diffuse.contents = UIColor.black
        emitter1?.emitterShape = plane
        
//        let particleNode = SCNNode(geometry: plane)
        let particleNode = SCNNode()
        particleNode.rotation = SCNVector4(1, 0, 0, Double.pi / 2 * 3)
        particleNode.position = SCNVector3(0,30,-10)

        particleNode.addParticleSystem(emitter1!)
        
        emitter1?.colliderNodes = [floorNode]
        emitter1?.particleDiesOnCollision = true
        
        emitter1?.systemSpawnedOnCollision = emitter2
        
        scene.rootNode.addChildNode(particleNode)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
