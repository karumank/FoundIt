//
//  ContainerViewController.swift
//  FoundIt
//
//  Created by Krishna on 12/06/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

import UIKit

private var detailViewController: DetailViewController?

class ContainerViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    var menuItem: NSDictionary? {
        didSet {
            hideOrShowMenu(false, animated: true)
            if let detailViewController = detailViewController {
                detailViewController.menuItem = menuItem
            }
        }
    }
    var showingMenu = false

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ContainerViewController
    func hideOrShowMenu(show: Bool, animated: Bool) {
        showingMenu = show
        let menuOffset = CGRectGetWidth(menuContainerView.bounds)
        scrollView.setContentOffset(show ? CGPointZero : CGPoint(x: menuOffset, y: 0), animated: animated)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailViewSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            detailViewController = navigationController.topViewController as? DetailViewController
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        /*
         Fix for the UIScrollView paging-related issue mentioned here:
         http://stackoverflow.com/questions/4480512/uiscrollview-single-tap-scrolls-it-to-top
         */
        scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - CGRectGetWidth(scrollView.frame))
        
        let multiplier = 1.0 / CGRectGetWidth(menuContainerView.bounds)
        let offset = scrollView.contentOffset.x * multiplier
        let fraction = 1.0 - offset
        menuContainerView.layer.transform = transformForFraction(fraction)
        menuContainerView.alpha = fraction
        
        if let detailViewController = detailViewController {
            if let rotatingView = detailViewController.hamburgerView {
                rotatingView.rotate(fraction)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hideOrShowMenu(showingMenu, animated: false)
        
        menuContainerView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let menuOffset = CGRectGetWidth(menuContainerView.bounds)
        showingMenu = !CGPointEqualToPoint(CGPoint(x: menuOffset, y: 0), scrollView.contentOffset)
        print("didEndDecelerating showingMenu \(showingMenu)")
    }
    
    func transformForFraction(fraction:CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0 / 1000.0;
        let angle = Double(1.0 - fraction) * -M_PI_2
        let xOffset = CGRectGetWidth(menuContainerView.bounds) * 0.5
        let rotateTransform = CATransform3DRotate(identity, CGFloat(angle), 0.0, 1.0, 0.0)
        let translateTransform = CATransform3DMakeTranslation(xOffset, 0.0, 0.0)
        return CATransform3DConcat(rotateTransform, translateTransform)
    }
}
