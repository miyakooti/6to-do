//
//  BannerSetUpper.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/05/02.
//

import Foundation
import GoogleMobileAds

class BannerSetUpper {
    static func setUpBanner(bannerView: GADBannerView, viewController: UIViewController) {
        // GADBannerViewのプロパティを設定
        bannerView.adUnitID = Constants.adUnitID
        bannerView.rootViewController = viewController
        // 広告読み込み
        bannerView.load(GADRequest())
    }
}
