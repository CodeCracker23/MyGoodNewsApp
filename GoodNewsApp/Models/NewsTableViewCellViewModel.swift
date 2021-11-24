import Foundation

class NewsTableViewCellViewModel  {
    
    let title: String
    let subTitle: String
    let imageUrl: URL?
    let url: String?
    let imageData: Data? = nil
    
    init( title: String,
          url: String?,
          subTitle: String,
          imageUrl: URL?) {
        self.title = title
        self.url = url
        self.subTitle = subTitle
        self.imageUrl = imageUrl
    }
    
}
