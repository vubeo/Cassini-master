//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Trương Thắng on 4/8/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        splitViewController?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    private struct Storyboard {
        static let ShowImageSegue = "Show Image"
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowImageSegue {
            if let imageVC = segue.destination.contentViewController as? ImageViewController {
                if let imageName = (sender as? UIButton)?.currentTitle {
                    imageVC.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
                }
            }
        }
    }
    
    @IBAction func showImage(sender: UIButton) {
        if let imageVC = splitViewController?.viewControllers.last?.contentViewController as? ImageViewController {
            if let imageName = sender.currentTitle
            {
                imageVC.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
                imageVC.title = imageName
            }
        } else {
            performSegue(withIdentifier: Storyboard.ShowImageSegue, sender: sender)
        }
    }
    
}

// MARK: - contentViewController

extension UIViewController {
    var contentViewController: UIViewController {
        if let navContentVC = self as? UINavigationController {
            return navContentVC.visibleViewController!
        } else {
            return self
        }
    }
}

// MARK: - <#Mark#>

extension CassiniViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contentViewController == self {
            if let imageVC = secondaryViewController.contentViewController as? ImageViewController, imageVC.imageURL == nil {
                return true
            }
        }
        return false
    }

}

