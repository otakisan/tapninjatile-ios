//
//  GameMenuViewController.swift
//  TapNinjaTile
//
//  Created by takashi on 2016/04/30.
//  Copyright © 2016年 Takashi Ikeda. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GameMenuViewController: UIViewController {

    var isShowAd = false
    var interstitial : GADInterstitial?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loadAd()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.initAnalysisTracker("ゲームメニュー")
        
        self.showAd()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @objc private func reloadAd() {
        self.loadAd()
    }

    private func loadAd() {
        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-3119454746977531/6434970408")
        let gadRequest = GADRequest()
        self.interstitial?.loadRequest(gadRequest)
        self.interstitial?.delegate = self
    }
    
    private func showAd() {
        if self.isShowAd && self.interstitial!.isReady {
            self.interstitial?.presentFromRootViewController(self)
        }
    }
}

extension GameMenuViewController : GADInterstitialDelegate {
    func interstitialDidDismissScreen(ad: GADInterstitial!){
        self.loadAd()
    }
    
    func interstitialWillPresentScreen(ad: GADInterstitial!) {
        self.isShowAd = false
    }
    
    func interstitial(ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!){
        print(error)
        NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: #selector(GameMenuViewController.reloadAd), userInfo: nil, repeats: true)
    }
}
