//
//  LoadingView.swift
//  LCOnline
//
//  Created by Rushabh Shah on 29/04/19.
//  Copyright © 2019 Rushabh Shah. All rights reserved.
//

import UIKit

class LoadingView: NSObject {
    
    static let transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    static let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    
    static let activityIndicatorView: UIActivityIndicatorView = {
        let aiView = UIActivityIndicatorView()
        aiView.style = UIActivityIndicatorView.Style.large
        aiView.color = .white
        aiView.translatesAutoresizingMaskIntoConstraints = false
        return aiView
    }()
    
    
    class func showLoading() {
        if let window = UIApplication.shared.keyWindow {
            
            window.addSubview(transparentView)
            window.addConstraintsWithFormat("H:|[v0]|", views: transparentView)
            window.addConstraintsWithFormat("V:|[v0]|", views: transparentView)
            
            window.addSubview(containerView)
            window.addConstraints([
                NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: window, attribute: .centerY, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: window, attribute: .height, multiplier: 0.15, constant: 0),
                NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 1, constant: 0)])
            
            containerView.addSubview(activityIndicatorView)
            /*containerView.addConstraintsWithFormat("H:|[v0]|", views: activityIndicatorView)
             containerView.addConstraintsWithFormat("V:|[v0]|", views: activityIndicatorView)*/
            containerView.addConstraints([
                NSLayoutConstraint(item: activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: activityIndicatorView, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 0.8, constant: 0),
                NSLayoutConstraint(item: activityIndicatorView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 1, constant: 0)])
            activityIndicatorView.startAnimating()
        }
    }
    
    class func hideLoading() {
        //if let window = UIApplication.sharedApplication().keyWindow {
        transparentView.removeFromSuperview()
        containerView.removeFromSuperview()
        activityIndicatorView.stopAnimating()
        //}
    }
    
    
}
