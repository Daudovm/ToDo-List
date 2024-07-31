//
//  HalfSizePresentationController.swift
//  ToDo List
//
//  Created by Macbook pro on 31.07.2024.
//

import UIKit

class HalfSizePresentationController: UIPresentationController {

    override var frameOfPresentedViewInContainerView: CGRect {
       
        guard let containerView = containerView else { return .zero }
        return CGRect(
            x: 0,
            y: containerView.bounds.height / 8,
            width: containerView.bounds.width,
            height: containerView.bounds.height - containerView.bounds.height / 8)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        guard let presentedView = presentedView else { return }
        containerView.addSubview(presentedView)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedView?.removeFromSuperview()
    }
}
