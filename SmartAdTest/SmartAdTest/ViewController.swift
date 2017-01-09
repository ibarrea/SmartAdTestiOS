//
//  ViewController.swift
//  SmartAdTest
//
//  Created by Ignacio Barrea on 2/1/17.
//  Copyright © 2017 Ignacio Barrea. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, SASAdViewDelegate {

    
    let items: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"  ]
    
    // Instances of banners (marked as optional since it is created after the initialization of the controller)
    fileprivate var banner1: SASBannerView?
    fileprivate let defaultCellHeight: CGFloat = 50.0
    fileprivate var statusBarHidden = false
    fileprivate var stickyAdView: UIView?

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        createBanners()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    //Smart AD Methods
    
    deinit {
        // The banner is automatically released by ARC but the delegate and the modalParentViewController should be set to nil to prevent crashes during fast navigation in the application.
        // This can be made in the deinitializer which will be called automatically by ARC when the controller is released.
        removeBanner(banner1)

        
        NSLog("BannerInTableViewController has been deallocated");
    }
    
    func createBanners() {
        self.banner1 = createBanner(Constants.banner1InTableViewPageID())

    }
    func bannerFrameForView(_ view: UIView, height: CGFloat) -> CGRect {
        // Convenient method to reset the frame of a banner
        return CGRect(x: 0, y: 0, width: view.frame.width, height: height)
    }
    
    func createBanner(_ pageId: String) -> SASBannerView {
        // The instance of the banner is created with a default frame and an appropriate loader.
        let banner = SASBannerView(frame: bannerFrameForView(self.view, height: defaultCellHeight), loader: .activityIndicatorStyleWhite)
        
        // Setting the delegate.
        banner.delegate = self
        
        // Setting the modal parent view controller.
        banner.modalParentViewController = self
        
        // Loading the ad (using IDs from the Constants class).
        banner.loadFormatId(Constants.bannerFormatID(), pageId: pageId, master: true, target: nil)
        
        return banner
    }
    
    func removeBanner(_ banner: SASBannerView?) {
        if let banner = banner {
            banner.removeFromSuperview()
            banner.modalParentViewController = nil
            banner.delegate = nil
        }
    }
    
    
    // FIN Smart AD Methods

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isAdCell(indexPath) {
            createBanners()
            // Attach relevant banner to the container cell
            return SASAdViewContainerCell(for: banner1, in: tableView)

        }
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
    
    func isAdCell(_ indexPath: IndexPath) -> Bool {
        // In this sample, ad cells are in fixed positions
        return (indexPath as NSIndexPath).row == 5 || (indexPath as NSIndexPath).row == 19
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
    
    
    // MARK: - SASAdViewDelegate
    
    func refreshAdCell(_ adView: SASAdView?) {
        // Refresh the ad cell (or the whole table view if no ad cell is given in parameter)
//        if adView == banner1 {
//            tableView.reloadRows(at: [IndexPath(row: self.tableView, section: 0)], with: .automatic)
//        }else {
//        }
        
//        tableView.reloadData()

    }
    
    
    func adView(_ adView: SASAdView, didDownloadAd ad: SASAd) {
        NSLog("An ad object has been loaded")
        
        // Refresh the table view when an ad is loaded
        refreshAdCell(adView)
    }
    
    func adViewDidLoad(_ adView: SASAdView)  {
        NSLog("Banner has been loaded")
    }
    
    func adView(_ adView: SASAdView, didFailToLoadWithError error: Error) {
        NSLog("Banner has failed to load with error: \(error.localizedDescription)")
        
        // The cell is collapsed if the ad cannot be loaded
        removeBanner(adView as? SASBannerView)
        refreshAdCell(adView)
    }
    
    func adViewWillExpand(_ adView: SASAdView) {
        NSLog("Banner will expand")
        
        // When the ad is expanded, hide the status bar
        statusBarHidden = true;
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func adViewWillCloseExpand(_ adView: SASAdView) {
        NSLog("Banner will close expand")
        
        // When the ad will closed, the status bar should be restored
        statusBarHidden = false;
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func adView(_ adView: SASAdView, didSend videoEvent: SASVideoEvent) {
        // This delegate can be used to listen for events if the ad is a video (banner or interstitial).
        
        // For instance, you can use these events to check if the video has been played until the end
        // by listening to the event 'SASVideoEvent.Complete'
        if videoEvent == .complete {
            NSLog("The video has been played until the end")
        }
    }
    
    func adView(_ adView: SASAdView, withStickyView stickyView: UIView, didStick stuck: Bool, withFrame stickyFrame: CGRect) {
        // This delegate can be used to be notified when a video read banner did stick or unstick, in this implementation as the navigation bar appears / disappears during vertical swipe we need to animate the sticky view
        
        if stuck {
            // keep a reference to the view to animate it if necessary
            self.stickyAdView = stickyView
        } else {
            self.stickyAdView = nil
        }
    }
    

    


}

