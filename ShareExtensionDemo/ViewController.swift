//
//  ViewController.swift
//  ShareExtensionDemo
//
//  Created by Grace Han on 2/13/17.
//  Copyright © 2017 GraceHan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  let suiteName = "group.com.grace.ShareExtensionDemo"
  let color = "keyImageData"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.refreshImageSource()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func reloadImage(_ sender: Any) {
    self.refreshImageSource()
  }
  
  func refreshImageSource() {
    if let prefs = UserDefaults(suiteName: suiteName) {
      if let imageData = prefs.object(forKey: color) as? Data {
        DispatchQueue.main.async(execute: { () -> Void in
          self.imageView.image = UIImage(data: imageData)
        })
      }
    }
  }

}

