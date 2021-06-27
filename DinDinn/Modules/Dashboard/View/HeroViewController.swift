//
//  HeroViewController.swift
//  DinDinn
//
//  Created by SanjayPathak on 24/06/21.
//

import UIKit

class HeroViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageView3WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView2WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView1WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView1WidthConstraint.constant = view.frame.size.width
        imageView2WidthConstraint.constant = view.frame.size.width
        imageView3WidthConstraint.constant = view.frame.size.width
        scrollView.delegate = self
    }

}

extension HeroViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(round(scrollView.contentOffset.x/view.frame.size.width))
        
    }
}
