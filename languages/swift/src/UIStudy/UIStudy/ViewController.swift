//
//  ViewController.swift
//  UIStudy
//
//  Created by Junho Han on 2017. 6. 4..
//  Copyright © 2017년 candide. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }
  @IBAction func onClickButton(_ sender: Any) {
    let sb = NSStoryboard(name: "Another", bundle: nil)
    let vc = sb.instantiateController(withIdentifier: "another")
    self.presentViewControllerAsSheet(vc as! AnotherViewController)
  }
}

