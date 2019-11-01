//
//  KTRefresh.swift
//  SwiftDemo
//
//  Created by Mac on 2019/10/17.
//  Copyright © 2019 Ketil. All rights reserved.
//

import UIKit
import ESPullToRefresh

public typealias KTRefreshHandler = (() -> ())

extension UIScrollView {
    
    func headerRefresh(handle: @escaping KTRefreshHandler) {
        self.es.addPullToRefresh(handler: handle)
    }
    func footerRefresh(handle: @escaping KTRefreshHandler) {
        self.es.addInfiniteScrolling(handler: handle)
    }
    func headerStopRefresh() {
        self.es.stopPullToRefresh()
    }
    func footerStopRefresh() {
        self.es.stopLoadingMore()
    }
    func noticeNoMoreData () {
        self.es.noticeNoMoreData()
    }
    func resetNoMoreData() {
        self.es.resetNoMoreData()
    }
    func headerAutoRefresh() {
        self.es.autoPullToRefresh()
    }
    func removeRefreshHeader() {
        self.es.removeRefreshHeader()
    }
    func removeRefreshFooter() {
        self.es.removeRefreshFooter()
    }
}

