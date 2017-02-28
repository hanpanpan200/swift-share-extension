//
//  ShareViewController.swift
//  Share
//
//  Created by Grace Han on 2/13/17.
//  Copyright © 2017 GraceHan. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {
    
    let suiteName = "group.com.grace.ShareExtensionDemo"
    let color = "keyImageData"
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        if let content = extensionContext!.inputItems[0] as? NSExtensionItem {
            let contentType = kUTTypeImage as String
            
            // Verify the provider is valid
            if let contents = content.attachments as? [NSItemProvider] {
                
                // look for images
                for attachment in contents {
                    if attachment.hasItemConformingToTypeIdentifier(contentType) {
                        attachment.loadItem(forTypeIdentifier: contentType, options: nil) { data, error in
                            
                            let url = data as! URL
                            self.copyImageToSharedDir(url: url)
                        }
                    }
                }
            }
        }
        
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
    func copyImageToSharedDir(url: URL) {
        let fileManager = FileManager.default
        let destPath = fileManager.containerURL(forSecurityApplicationGroupIdentifier: self.suiteName)
        let fullDestPath = NSURL(fileURLWithPath: (destPath?.path)!).appendingPathComponent("IMG_0003.JPG")
        
        if fileManager.fileExists(atPath: (fullDestPath?.path)!) == true {
            do {
                try fileManager.removeItem(at: fullDestPath!)
            }catch{
                print("\n")
                print(error)
            }
        }
        
        do{
            try fileManager.copyItem(atPath: url.path, toPath: (fullDestPath?.path)!)
        }catch{
            print("\n")
            print(error)
        }

    }
}
