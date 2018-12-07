// Qiita.swift
import Foundation

public struct Qiita {
    private(set) var keyword: String
    private let session: URLSession
    
    public init(keyword: String, session: URLSession = .shared) {
        self.keyword = keyword
        self.session = session
    }
    
    // keywordをもとに記事を検索する
    public func search(completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://qiita.com/api/v2/items?page=1&per_page=20&query=\(keyword)")!
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        session.dataTask(with: req) { (data, _, _) in
            if let data = data, let result = String(data: data, encoding: .utf8) {
                // 実際にはここでごにょごにょ整形する
                completion(result)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
