//
//  ViewController.swift
//  Poke3D
//
//  Created by Joseph Garcia on 14/06/24.
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
        
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration() // ARImageTracking because it's looking for an image in the real world
        
        
        //In the below code, it used an ARReferenceImage.referenceImages and found them on the assets folder in a group called "Pokemon Cards" as a String, in the main app bundle. The trackingImages is an optional because if the app doesn't find the folder, it might crash so we make the imageToTrack an if statement for safety and only use it if it finds the image folder.
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            
            configuration.detectionImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 3
            
            print("Images Successfully Added")
            
        }
        

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate

    func renderer(_ renderer: any SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
    
        let node = SCNNode()

        if let imageAnchor = anchor as? ARImageAnchor {
            

            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            
            //Now we use the firstMaterial and the diffuse so the color in white and the transparency
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            // Now we can create the planeNode with the geometry we just typed in let = plane
            let planeNode = SCNNode(geometry: plane)

            planeNode.eulerAngles.x = -.pi / 2
            
            //Then to the original node we add the childNode
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "eevee-card" {
                if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn") {
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        planeNode.addChildNode(pokeNode)
                    }
                }
            }
            
            if imageAnchor.referenceImage.name == "oddish-card" {
                if let pokeScene = SCNScene(named: "art.scnassets/oddish.scn") {
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        planeNode.addChildNode(pokeNode)
                        
                    }
                }
            }
            
            if imageAnchor.referenceImage.name == "roy" {
                if let pokeScene = SCNScene(named: "art.scnassets/roy.scn") {
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        planeNode.addChildNode(pokeNode)
                        
                    }
                }
            }
            
        }
        //We return the node "3D Object"
        return node
    }
}
                                   
