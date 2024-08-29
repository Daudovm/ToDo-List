//
//  circularView.swift
//  ToDo List
//
//  Created by Macbook pro on 31.07.2024.
//

import UIKit

class CircularView: UIView {

    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupLayers() {
        createTrackLayer()
        createProgressLayer()
    }
    
    private func createTrackLayer() {
        let circulePath = UIBezierPath(arcCenter: self.center, radius: frame.size.width / 2, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * .pi, clockwise: true)
        trackLayer.path = circulePath.cgPath
        trackLayer.strokeColor = UIColor(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1).cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 10
        trackLayer.lineCap = .round
        
        layer.addSublayer(trackLayer)
    }
    
    private func createProgressLayer() {
        let circulePath = UIBezierPath(arcCenter: center , radius: frame.size.width / 2, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)

        progressLayer.path = circulePath.cgPath
        progressLayer.strokeColor = UIColor(red: 0.1490196078, green: 0.7882352941, blue: 0.4196078431, alpha: 1).cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 10
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }
    
    func setProgress(to progress: CGFloat, widtAnimation: Bool, textCenter: String) {
        progressLayer.strokeEnd = 1
        if widtAnimation {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.toValue = progress
            animation.duration = 0.5
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            progressLayer.add(animation, forKey: "progressAnim")
        }else {
            progressLayer.strokeEnd = progress
        }
        
        textLabel.text = textCenter
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let frameX = frame.origin.x * -1
        let frameY = frame.origin.y * -1
        progressLayer.frame = CGRect(x: frameX, y: frameY, width: frame.size.width, height: frame.size.width)
        trackLayer.frame = CGRect(x: frameX, y: frameY, width: frame.size.width, height: frame.size.width)
        textLabel.frame = CGRect(x: 0 , y: 0, width: frame.size.width, height: frame.size.width)
        
        addSubview(textLabel)
        setupLayers()
    }
}
