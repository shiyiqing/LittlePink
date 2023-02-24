//
//  LPBaseNavigationController.swift
//  LittlePink
//
//  Created by Tingting Wu on 2023/2/13.
//  Copyright © 2023 wtt. All rights reserved.
//

import UIKit

class LPBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isNavigationBarHidden = true
    }


}
