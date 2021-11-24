import UIKit
import NaturalLanguage
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table}()
    
    //filter can be 1 or 0
    var filter = 1
    private let searchVC = UISearchController(searchResultsController: nil)
    private var positiveArticles = [Article]()
    private var viewModels = [NewsTableViewCellViewModel]()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "✩Good News"
        fetchTopStories()
        createSearchBar()
        createToggleButton()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        //swiping down to get Only Good News
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for:.valueChanged)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        filter = 1
        viewModels.removeAll()
        fetchTopStories()
        refreshControl.endRefreshing()
        title = "✩Good News"

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.addSubview(refreshControl)
    }
    
    @objc private func backwardButtonTapped(){
        title = "All News"
        //filter = 0
        self.viewModels.removeAll()
        APICaller2.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                //FILTER GOOD NEWS
                self?.positiveArticles.removeAll()
                for article in articles {
                    self?.positiveArticles.append(article)
                                    
                }
                self?.reloadTableData()
            case.failure(let error):
                print(error)
            }
        }
    }
    
    private func createToggleButton(){
        let logoutBarButtonItem = UIBarButtonItem(title: "NO FILTER" ,style: .done, target: self, action: #selector(backwardButtonTapped))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
        
    }
    
    private func createSearchBar(){
        navigationItem.searchController  = searchVC
        searchVC.searchBar.delegate = self
        searchVC.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Give me a good topic", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
    }
    
    private func fetchTopStories() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                //FILTER GOOD NEWS
                self?.positiveArticles.removeAll()
                for article in articles {
                    let text = article.description
                    if self?.getSentimentFromBuildInAPI(text: text ?? "" ) == self?.filter{
                        self?.positiveArticles.append(article)
                        print(article.title)
                    }
                }
                self?.reloadTableData()
                dispatchGroup.leave()
            case.failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.enter()
        APICaller3.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                //FILTER GOOD NEWS
                self?.positiveArticles.removeAll()
                for article in articles {
                    let text = article.description
                    if self?.getSentimentFromBuildInAPI(text: text ?? "" ) == self?.filter{
                        self?.positiveArticles.append(article)
                        print(article.title)
                    }
                }
                self?.reloadTableData()
                dispatchGroup.leave()
            case.failure(let error):
                print(error)
            }
        }
        
        
        dispatchGroup.enter()
        APICaller4.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                //FILTER GOOD NEWS
                self?.positiveArticles.removeAll()
                for article in articles {
                    let text = article.description
                    if self?.getSentimentFromBuildInAPI(text: text ?? "" ) == self?.filter{
                        self?.positiveArticles.append(article)
                        print(article.title)
                    }
                }
                self?.reloadTableData()
                dispatchGroup.leave()
                //dispatchGroup.wait()
            case.failure(let error):
                print(error)
            }
        }

        dispatchGroup.enter()
        APICaller5.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                //FILTER GOOD NEWS
                self?.positiveArticles.removeAll()
                for article in articles {
                    let text = article.description
                    if self?.getSentimentFromBuildInAPI(text: text ?? "" ) == self?.filter{
                        self?.positiveArticles.append(article)
                        print(article.title)
                    }
                }
                self?.reloadTableData()
                dispatchGroup.leave()
            case.failure(let error):
                print(error)
            }
        }
    }
    
    
    
    func reloadTableData() {
        let toAddModels = (self.positiveArticles.compactMap(
            {NewsTableViewCellViewModel(
                title: $0.title,
                url: $0.url,
                subTitle: $0.description ?? "No Description",
                imageUrl: URL(string: $0.urlToImage ?? ""))}
        ))
        
        self.viewModels += toAddModels
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    
    func getSentimentFromBuildInAPI(text: String) -> Int {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text
        let (sentiment, _) = tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore)
        let sentimentScore = (sentiment?.rawValue as NSString?)?.doubleValue
        var finalScore = 0
        
        if let score = sentimentScore {
            if score < 0 {
                finalScore = 0 // Negative
            } else if score > 0 {
                finalScore = 1 // Positive
            }
            else {
                finalScore = -1 // Neutral
            }
        }
        return finalScore
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row > viewModels.count-1){
            return UITableViewCell()
        } else {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = viewModels[indexPath.row]
        guard let url = URL(string: article.url ?? "") else {
            return
        }
        let sf = SFSafariViewController(url: url)
        sf.dismissButtonStyle = .close
        present(sf, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filter = 1
        self.viewModels.removeAll()
        self.positiveArticles.removeAll()
        self.fetchTopStories()
        self.title = "✩Good News"
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        APICaller.shared.search(with: text) { [weak self] result in
            switch result {
            case .success(let articles):
                //FILTER GOOD NEWS
                //print(articles)
                self?.positiveArticles.removeAll()
                for article in articles {
                    let text = article.description
                    if self?.getSentimentFromBuildInAPI(text: text ?? "" ) == self?.filter{
                        self?.positiveArticles.append(article)
                    }
                }
                self?.viewModels.removeAll()
                self?.reloadTableData()
                DispatchQueue.main.async {
                    self?.searchVC.dismiss(animated: true, completion: nil)
                }
            case.failure(let error):
                print(error)
            }
        }
    }
}

