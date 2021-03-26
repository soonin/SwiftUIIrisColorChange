//
//  ImageNode.swift
//  SwiftUIIrisColorChange
//
//  Created by Pooya on 2021-03-08.
//

import SceneKit

final class ImageNode : SCNNode {
    
    init(width: CGFloat, height: CGFloat , image: UIImage) {
        super.init()
        let plane = SCNPlane(width: width, height: height)
        plane.firstMaterial?.diffuse.contents = image
        plane.firstMaterial?.isDoubleSided = true
        geometry = plane
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented!")
    }
    
}

struct GlobalVar {
    static var irisnames = ["bicolor_iris.png","blueIRIS.png","grayIRIS.png","multiIRIS.png"]
    static var leftIriSName = "bicolor_iris.png"
    static var rightIriSName = "bicolor_iris.png"
}
