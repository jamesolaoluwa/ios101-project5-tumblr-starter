//  ViewController.swift
//  ios101-project5-tumbler

import UIKit
import NukeExtensions

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Store fetched posts for the table view
    var posts: [Post] = []

    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Assign data source & delegate checks
        tableView.dataSource = self
        tableView.delegate = self

        // --- Add Refresh Control ---
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl

        // Fetch data initially
        fetchPosts()
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController viewDidAppear — tableView frame: \(tableView?.frame.debugDescription ?? "nil")")
    }

    @objc func handleRefresh(_ sender: UIRefreshControl) {
        fetchPosts()
    }

    func fetchPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/artdaily.tumblr.com/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.refreshControl?.endRefreshing()
                }
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.refreshControl?.endRefreshing()
                }
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.refreshControl?.endRefreshing()
                }
                return
            }

            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)

                DispatchQueue.main.async { [weak self] in

                    let posts = blog.response.posts

                    print("✅ We got \(posts.count) posts!")
                    for post in posts {
                        print("🍏 Summary: \(post.summary)")
                    }

                    // Save posts and reload table view
                    self?.posts = posts
                    self?.tableView.reloadData()
                    self?.tableView.refreshControl?.endRefreshing()
                }

            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.refreshControl?.endRefreshing()
                }
            }
        }
        session.resume()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView numberOfRowsInSection called; posts.count=\(posts.count)")
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView cellForRowAt called for row \(indexPath.row)")
        let post = posts[indexPath.row]

        // Dequeue our PostCell (registered in code or provided by storyboard)
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell

        // Use safe accessors that work whether the cell was created from storyboard or programmatically
        cell.summaryLabel?.text = post.summary
        cell.postImageView?.image = nil

        if let photo = post.photos.first, let imageView = cell.postImageView {
            let url = photo.originalSize.url
            // Use NukeExtensions helper to load image
            NukeExtensions.loadImage(with: url, into: imageView)
        }

        return cell
    }

    // MARK: - UITableViewDelegate
    // (Add delegate methods if you need custom behavior)
}
