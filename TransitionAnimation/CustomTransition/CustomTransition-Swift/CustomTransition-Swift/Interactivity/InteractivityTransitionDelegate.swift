//
//  InteractivityTransitionDelegate.swift
//  CustomTransition-Swift
//
//  Created by 张星宇 on 16/2/8.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class InteractivityTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    var gestureRecognizer: UIScreenEdgePanGestureRecognizer? = nil
    var targetEdge: UIRectEdge = UIRectEdge()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return InteractivityTransitionAnimator(targetEdge: targetEdge)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return InteractivityTransitionAnimator(targetEdge: targetEdge)
    }
    
    /// 前两个函数和淡入淡出demo中的实现一致
    /// 后两个函数用于实现交互式动画
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gestureRecognizer = self.gestureRecognizer {
            return TransitionInteractionController(gestureRecognizer: gestureRecognizer, edgeForDragging: targetEdge)
        }
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gestureRecognizer = self.gestureRecognizer {
            return TransitionInteractionController(gestureRecognizer: gestureRecognizer, edgeForDragging: targetEdge)
        }
        return nil
    }
}
