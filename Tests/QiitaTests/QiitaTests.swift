// QiitaTests.swift
import XCTest
import QiitaCore

final class QiitaTests: XCTestCase {
    func testSearch() throws {
        let session = URLSessionMock()
        let qiita = Qiita(keyword: "swift", session: session)
        
        qiita.search { _ in }

        XCTAssertEqual(session.url, "https://qiita.com/api/v2/items?page=1&per_page=20&query=swift")
    }

    static var allTests = [
        ("testSearch", testSearch),
    ]
}


final class URLSessionDataTaskMock: URLSessionDataTask {
    override func resume() {
        // Do nothing
    }
}

final class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var url: String = ""
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = request.url?.absoluteString ?? ""
        return URLSessionDataTaskMock()
    }
}
