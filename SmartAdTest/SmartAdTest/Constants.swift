//
//  Constants.swift
//  SmartAdTest
//
//  Created by Ignacio Barrea on 2/1/17.
//  Copyright © 2017 Ignacio Barrea. All rights reserved.
//

import Foundation
// IDs used by the Smart AdServer SDK to retrieve the ads.
class Constants {
    
    //TESTING
    
    class func siteID() -> Int { return 45220 }
    class func baseURL() -> String { return "http://mobile.smartadserver.com" }
    
    class func nativeAdFormatID() -> Int { return 15140 }
    class func bannerFormatID() -> Int { return 15140 }
    class func toasterFormatID() -> Int { return 15151 }
    class func interstitialFormatID() -> Int { return 12167 }
    
    class func bannerPageID() -> String { return "663262" }
    class func toasterPageID() -> String { return "663263" }
    class func interstitialPageID() -> String { return "663264" }
    class func interstitialDismissalAnimationPageID() -> String { return "663264" }
    class func prefetchInterstitialPageID() -> String { return "663804" }
    
    class func banner1InTableViewPageID() -> String { return "663529" }
    class func banner2InTableViewPageID() -> String { return "663531" }
    class func banner3InTableViewPageID() -> String { return "663530" }
    
    class func nativeAdIconInTableViewPageID() -> String { return "720265" }
    class func nativeAdCoverInTableViewPageID() -> String { return "717857" }
    class func nativeAdMediaInTableViewPageID() -> String { return "692588" }
    
    
    //REALES
    
//    class func siteID() -> Int { return 134577 }
//    class func baseURL() -> String { return "http://mobile.smartadserver.com" }
//    
//    class func bannerFormatID() -> Int { return 49655 }
//    class func interstitialFormatID() -> Int { return 12167 }
//    
//    class func bannerPageID() -> String { return "748531" }
//    class func interstitialPageID() -> String { return "663264" }
//    
//    class func banner1InTableViewPageID() -> String { return "748531" }
    
}
