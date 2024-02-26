
import Foundation

struct NetworkManager {
    private let urlSession: URLSession
    private var urlComponents = URLComponents()
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(FetchError.invalidURL))
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(FetchError.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,(200...299).contains(response.statusCode) else {
                completion(.failure(FetchError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(FetchError.invalidData))
                return
            }
           
            completion(.success(data))
            
        }.resume()
    }
    
    mutating func modifyUrlComponent(path: String) -> URL? {
        urlComponents.scheme = "https"
        urlComponents.host = "www.kobis.or.kr"
        urlComponents.path = "/kobisopenapi/webservice/rest\(path)"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: "ab168a1eb56e21306b897acd3d4653ce")
        ]
        
        return urlComponents.url
    }
}

struct Decoder {
    func parse<T: Decodable>(data: Data, type: T.Type) throws -> T {
        return try JSONDecoder().decode(type, from: data)
    }
    
    func decodeDailyBoxOfficeList(_ data: Data) -> [DailyBoxOfficeInfo] {
        var movieList: [DailyBoxOfficeInfo] = []
        
        do {
            movieList = try Decoder().parse(data: data, type: BoxOfficeDataResponse.self).boxOfficeResult.dailyBoxOfficeList
        } catch {
            print(error.localizedDescription)
        }
        
        return movieList
    }
}



