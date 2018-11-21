//
//  CardsViewController.swift
//  tinder_demo
//
//  Created by Carlos on 11/21/18.
//  Copyright © 2018 Carlos. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    
    @IBOutlet weak var draggableImageView: UIImageView!
    
    var cardInitialCenter: CGPoint!
    var originalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardInitialCenter = draggableImageView.center
        // Do any additional setup after loading the view.
    }

    @IBAction func onTap(_ sender: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer)
    {
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began
        {
            originalCenter = draggableImageView.center
            
            if velocity.x > 0
            {
                draggableImageView.transform = CGAffineTransform(rotationAngle: CGFloat(45 * Double.pi / 180))
            }
            else if velocity.x < 0
            {
                draggableImageView.transform = CGAffineTransform(rotationAngle: CGFloat(-45 * Double.pi / 180))
            }
        }
        else if sender.state == .changed
        {
            if translation.x > 50
            {
                UIView.animate(withDuration: 0.4)
                {
                    self.draggableImageView.center.x = 250
                    self.cardInitialCenter.x = 550
                }
            }
            else if translation.x < 50
            {
                UIView.animate(withDuration: 0.4)
                {
                    self.draggableImageView.center.x = -250
                    self.cardInitialCenter.x = -550
                }
            }
            else
            {
                draggableImageView.center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y)            }
            }
        else if sender.state == .ended
        {
            draggableImageView.center = cardInitialCenter
            draggableImageView.transform = CGAffineTransform.identity
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "profileSegue"
        {
            let photoViewController = segue.destination as! ProfileViewController
            photoViewController.image = draggableImageView.image
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
