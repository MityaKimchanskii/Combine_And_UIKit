//
//  ViewController.swift
//  Combine_And_UIKit
//
//  Created by Mitya Kim on 3/26/23.
//

import UIKit
import Combine

extension Notification.Name {
    static let newBlogPost = Notification.Name("newPost")
}

struct BlogPost {
    let title: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var blogTextField: UITextField!
    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var subscribedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        publishButton.addTarget(self, action: #selector(publishButtonTapped), for: .primaryActionTriggered)
        
        // Create a publisher
        let publisher = NotificationCenter.Publisher(center: .default, name: .newBlogPost, object: nil)
            .map { (notification) -> String? in // Combine with an operator
            return (notification.object as? BlogPost)?.title ?? ""
        }
        
        // Create a subscriber
        let subscriber = Subscribers.Assign(object: subscribedLabel, keyPath: \.text)
        publisher.subscribe(subscriber)
    }
    
    @objc func publishButtonTapped(_ sender: UIButton) {
        // Post the notification
        let title = blogTextField.text ?? "Coming soon"
        let blogPost = BlogPost(title: title)
        NotificationCenter.default.post(name: .newBlogPost, object: blogPost)
    }


}

