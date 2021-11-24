import UIKit

class NewsTableViewCell: UITableViewCell {
    
    
    static let identifier = "NewsTableViewCell"
    
    //creating UILabel elements for the cell
    private var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFill //keeps aspectratio and fills the image
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
//      imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subTitleLabel)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsImageView.frame = CGRect(x: 10,
                                     y: 15,
                                     width: contentView.frame.size.width-20,
                                     height: contentView.frame.size.height * 0.6)

        newsTitleLabel.frame = CGRect(x: 12,
                                      y: contentView.frame.size.height * 0.7 - 13,
                                      width: contentView.frame.size.width-20,
                                      height: contentView.frame.size.height * 0.30)
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subTitleLabel.text = nil
        newsImageView.image = nil 
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel) {
        newsTitleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
        
        //fetch image
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(cgImage: data as! CGImage)
        } else if let url = viewModel.imageUrl {
            URLSession.shared.dataTask(with: url) {  [weak self]data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                //viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
            
        }
    }
    
}
