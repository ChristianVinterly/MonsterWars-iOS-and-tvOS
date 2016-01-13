//
//  CustomButton.swift
//  MonsterWars
//
//  Created by Christian Lysne on 13/01/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit

class FocusButton: UIButton {
    
    override func canBecomeFocused() -> Bool {
        return true
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)

        if (context.nextFocusedView == self){
            
            coordinator.addCoordinatedAnimations({
                self.transform = CGAffineTransformScale(self.transform, 1.1, 1.1)
                
                },
                completion: nil
            )
        } else if(context.previouslyFocusedView == self) {
            
            coordinator.addCoordinatedAnimations({
                self.transform = CGAffineTransformIdentity
                },
                completion: nil
            )
        }
    }
}