//
//  anotherViewController.swift
//  UIStudy
//
//  Created by Junho Han on 2017. 6. 4..
//  Copyright © 2017년 candide. All rights reserved.
//

import Cocoa

class AnotherViewController: NSViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  override var representedObject: Any? {
    didSet {
      // Update the view, if already loaded.
    }
  }
  @IBAction func onClickClose(_ sender: Any) {
    self.view.window?.close()
  }
}

