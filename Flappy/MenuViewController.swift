//
//  MenuViewController.swift
//  Flappy
//
//  Created by liusy182 on 19/4/16.
//  Copyright © 2016 liusy182. All rights reserved.
//

import UIKit
import HTPressableButton
import Cartography

class MenuViewController: UIViewController {
    private var player: MusicPlayer?
    
    private let playButton = HTPressableButton(
        frame: CGRectMake(0, 0, 260, 50), buttonStyle: .Rect)
    
    private let gameCenterButton = HTPressableButton(
        frame: CGRectMake(0, 0, 260, 50), buttonStyle: .Rect)

    override func viewDidLoad() {
        super.viewDidLoad()
        player = try? MusicPlayer(filename: "Pamgaea", type: "mp3")
        player?.play()
        
        setup()
        layoutView()
        style()
        render()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: Setup
extension MenuViewController{
    func setup(){
        playButton.addTarget(
            self,
            action: #selector(MenuViewController.onPlayPressed(_:)),
            forControlEvents: .TouchUpInside)
        view.addSubview(playButton)
        
        gameCenterButton.addTarget(
            self,
            action: #selector(MenuViewController.onGameCenterPressed(_:)),
            forControlEvents: .TouchUpInside)
        view.addSubview(gameCenterButton)
    }
    
    func onPlayPressed(sender: UIButton) {
        let vc = GameViewController()
        vc.modalTransitionStyle = .CrossDissolve
        presentViewController(vc, animated: true, completion: nil)
    }
    
    func onGameCenterPressed(sender: UIButton) {
        print("onGameCenterPressed")
    }
}

// MARK: Layout
extension MenuViewController{
    func layoutView() {
        constrain(playButton) { view in
            view.bottom == view.superview!.centerY - 60
            view.centerX == view.superview!.centerX
            view.height == 80
            view.width == view.superview!.width - 40
        }
        constrain (gameCenterButton) { view in
            view.bottom == view.superview!.centerY + 60
            view.centerX == view.superview!.centerX
            view.height == 80
            view.width == view.superview!.width - 40
        }
    }
}

// MARK: Style
private extension MenuViewController{
    func style(){
        playButton.buttonColor = UIColor.ht_grapeFruitColor()
        playButton.shadowColor = UIColor.ht_grapeFruitDarkColor()
        gameCenterButton.buttonColor = UIColor.ht_aquaColor()
        gameCenterButton.shadowColor = UIColor.ht_aquaDarkColor()
    }
}

// MARK: Render
private extension MenuViewController{
    func render(){
        playButton.setTitle("Play", forState: .Normal)
        gameCenterButton.setTitle("Game Center", forState: .Normal)
    }
}
