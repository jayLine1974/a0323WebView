//
//  ViewController.swift
//  a0323WebView
//
//  Created by 林俊傑 on 2022/3/23.
//

import UIKit
import  WebKit

class ViewController: UIViewController,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler {
    
    let webView = WKWebView()
    @IBOutlet weak var edEdit: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebview()      // 設定 webView
        self.view.addSubview(webView)
        webviewConstraint() // 約束 webView
        loadWebview()       // 載入網頁
    }
    // MARK: 自訂成員函式
    // 設定 webView

    fileprivate func setupWebview() {
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        let webConfiguration = webView.configuration
        webConfiguration.userContentController.add(self, name: "AppFunc")

    }
    // 接受網頁傳回的資訊

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        edEdit.text = message.body as! String
    }
    // 約束 webView

    fileprivate func webviewConstraint() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        let ctLeft = NSLayoutConstraint(item: webView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 20)

        let ctRight = NSLayoutConstraint(item: webView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -20)

        let ctTop = NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 100)

        let ctBottom = NSLayoutConstraint(item: webView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -20)

        NSLayoutConstraint.activate([ctLeft,ctRight,ctTop,ctBottom])

    }

    // 載入網頁
    fileprivate func loadWebview() {
        //file:///Users/ljjmacbook/Desktop/html/index.htm
        webView.loadFileURL(URL(string: "file:///Users/ljjmacbook/Desktop/html/index.htm")!, allowingReadAccessTo: URL(string: "file:///Users/ljjmacbook/desktop/html")!)
    }
    
    @IBAction func btSendWebPageTextClick(_ sender: UIButton) {
        let strLabel = edEdit.text
    
                let strJS =
                "document.getElementById('MyLabel').innerText = '\(strLabel)'"
                webView.evaluateJavaScript(strJS)
    }
    
    @IBAction func btGetWebPageTextClick(_ sender: UIButton) {
        webView.evaluateJavaScript("GetSel()",
                    completionHandler: {
                    (result, err) in
            self.edEdit.text = result as! String
                })
    }
    
}

