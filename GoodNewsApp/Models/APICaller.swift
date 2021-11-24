import Foundation

//write your own key inside here for your API_KEY
let API_KEY = "d15a897dbe044c01ad86cc17c1f8cd05"

final public class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/everything?q=e&apiKey=\(API_KEY)")
        static let searchUrlString = "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=\(API_KEY)&q="
    }
    
    private init () {}
    
    func getTopStories(completionHandler: @escaping (Result<[Article], ErrorMessage>) -> Void){
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            if let error = error {
                completionHandler(.failure(.invalidData))
                print(error)
                return
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewsModel.self, from: data)
                    completionHandler(.success(result.articles))
                }
                catch {
                    completionHandler(.failure(.invalidData))
                }
            }
        }
        task.resume()
    }
    
    func search(with query: String, completionHandler: @escaping (Result<[Article], Error>) -> Void){
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let urlString = Constants.searchUrlString + query
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completionHandler(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewsModel.self, from: data)
                    completionHandler(.success(result.articles))
                }
                catch {
                    completionHandler(.failure(error))
                }
            }
        }
        task.resume()
    }
}


final public class APICaller2 {
    static let shared = APICaller2()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(API_KEY)")
    }
    
    private init () {}
    
    func getTopStories(completionHandler: @escaping (Result<[Article], Error>) -> Void){
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completionHandler(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewsModel.self, from: data)
                    completionHandler(.success(result.articles))
                }
                catch {
                    completionHandler(.failure(error))
                }
            }
        }
        task.resume()
    }
}

final public class APICaller3 {
    static let shared = APICaller3()
    
    struct Constants {
        
        //DONT FORGET TO CHANGE THE DATE TO 1 MONTH AGO
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/everything?q=a&apiKey=\(API_KEY)")
    }
    
    private init () {}
    
    func getTopStories(completionHandler: @escaping (Result<[Article], Error>) -> Void){
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completionHandler(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewsModel.self, from: data)
                    completionHandler(.success(result.articles))
                }
                catch {
                    completionHandler(.failure(error))
                }
            }
        }
        task.resume()
    }
}


final public class APICaller4 {
    static let shared = APICaller4()
    
    struct Constants {
        
        //DONT FORGET TO CHANGE THE DATE TO 1 MONTH AGO
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=uk&category=general&apiKey=\(API_KEY)")
    }
    
    private init () {}
    
    func getTopStories(completionHandler: @escaping (Result<[Article], Error>) -> Void){
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completionHandler(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewsModel.self, from: data)
                    completionHandler(.success(result.articles))
                }
                catch {
                    completionHandler(.failure(error))
                }
            }
        }
        task.resume()
    }
}

final public class APICaller5 {
    static let shared = APICaller5()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?q=b&country=us&apiKey=\(API_KEY)")
    }
    
    private init () {}
    
    func getTopStories(completionHandler: @escaping (Result<[Article], Error>) -> Void){
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completionHandler(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewsModel.self, from: data)
                    completionHandler(.success(result.articles))
                }
                catch {
                    completionHandler(.failure(error))
                }
            }
        }
        task.resume()
    }
}
