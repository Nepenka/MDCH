//
//  EmmiterLayerAnimator.swift
//  MDCH
//
//  Created by 123 on 10.02.24.
//

import UIKit
import SnapKit



class EmmiterLayerAnimator {
    private let bounds = UIScreen.main.bounds
    
    
    func addAnimationOnView(_ view: UIView) {
        setupEmmiterAnimations { [weak view] (emmiter) in
            view?.layer.addSublayer(emmiter)
        }
    }
    
    private func setupEmmiterAnimations(completion: @escaping (CAEmitterLayer) -> Void) {
        let emmiterLayer = CAEmitterLayer()
        let item = DispatchWorkItem {
            emmiterLayer.emitterPosition = CGPoint(x: self.bounds.width / 2, y: self.bounds.height + 40)
            emmiterLayer.emitterSize = CGSize(width: self.bounds.width + 50, height: 20)
            emmiterLayer.emitterShape = .line
            emmiterLayer.beginTime = CACurrentMediaTime()
            emmiterLayer.timeOffset = 5
            emmiterLayer.birthRate = 0.3
            
            
            let emoji = ["😍", "😎", "🏳️‍🌈", "👨‍❤️‍👨", "🤮", "🔞"]
            emmiterLayer.emitterCells = self.makeEmmiterCells(emoji: emoji)
        }
        
        item.notify(queue: DispatchQueue.main) {
            completion(emmiterLayer)
        }
        DispatchQueue.global(qos: .userInteractive).async(execute: item)
    }
    
    private func makeEmmiterCells(emoji: [String]) -> [CAEmitterCell] {
        var cells = [CAEmitterCell]()
        
        for index in 0..<emoji.count*3 {
            
            let cell = CAEmitterCell()
            let random = .pi / 180 * Float.random(in: -20...20)
            cell.contents = emoji[index % emoji.count].emojiToImage().rotate(radians: random)?.cgImage
            cell.scale = 0.4
            cell.scaleRange = 0.3
            cell.birthRate = Float.random(in: 0.2...0.6)
            cell.lifetime = 8.0
            cell.velocity = 0
            cell.yAcceleration = -bounds.height / 28
            cells.append(cell)
        }
        
        
        return cells
    }
}
