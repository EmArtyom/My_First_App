import UIKit
import SnapKit

struct Onboarding {
    let image: String
    let title: String
    let subtitle: String
    let description: String
}

class WelcomeViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - UI
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let pageControl = UIPageControl()
    
    //Массив для онбоардинга
    private let onboardingData: [Onboarding] = [
        Onboarding(
            image: "onboarding1",
            title: "Добро пожаловать",
            subtitle: "Начните свое путешествие",
            description: "Узнайте как использовать наше приложение."
        ),
        Onboarding(
            image: "onboarding2",
            title: "Удобство",
            subtitle: "Все под рукой",
            description: "Доступ к вашим данным и функциям приложения в любой момент."
        ),
        Onboarding(
            image: "onboarding3",
            title: "Безопасность",
            subtitle: "Ваши данные защищены",
            description: "Мы обеспечиваем высокий уровень безопасности для ваших данных."
        )
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupScrollView()
        setupStackView()
        setupPageControl()
        setupContent()
    }
}

// MARK: - Setup scrollView

extension WelcomeViewController {
    
    func setupScrollView() {
        //Позволяет UIScrollView автоматически перелистывать страницы при прокрутке.
        scrollView.isPagingEnabled = true
        
        // Позволяет скрывать индикаторы
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}

//MARK: - Setup stackView

extension WelcomeViewController {
    
    func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width).multipliedBy(CGFloat(onboardingData.count))
            make.height.equalTo(scrollView.snp.height)
            make.trailing.equalTo(scrollView)
            make.leading.equalTo(scrollView)
        }
    }
}

//MARK: - Setup pageControl

extension WelcomeViewController {
    func setupPageControl() {
        pageControl.numberOfPages = onboardingData.count
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true // исчезает если одна страница
        pageControl.currentPageIndicatorTintColor = .systemBlue // активные индикаторы
        pageControl.pageIndicatorTintColor = .lightGray // inactive indicators
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        pageControl.backgroundStyle = .prominent
        view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            pageControl.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        pageControl.setIndicatorImage(UIImage(systemName: "water.waves"), forPage: 0)
        pageControl.setIndicatorImage(UIImage(systemName: "sunset.circle.fill"), forPage: 1)
        pageControl.setIndicatorImage(UIImage(systemName: "mountain.2"), forPage: 2)
    }
}

//MARK: - Setup content

extension WelcomeViewController {
    func setupContent() {
        for i in 0..<onboardingData.count {
            let pageView = createOnboardingPage(index: i)
            stackView.addArrangedSubview(pageView)
        }
    }
}

//MARK: - Create onboarding page

extension WelcomeViewController {
    func createOnboardingPage(index: Int) -> UIView {
        let data = onboardingData[index]
        let pageView = UIView()
        
        //Создаем и настраиваем UIImageView
        let imageView = UIImageView()
        imageView.image = UIImage(named: data.image)
        imageView.contentMode = .scaleToFill
        pageView.addSubview(imageView)
        
        //Создаем и настраиваем titleLabel
        let titleLabel = UILabel()
        titleLabel.text = data.title
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        pageView.addSubview(titleLabel)
        
        //Создаем и настраиваем subtitleLabel
        let subtitleLabel = UILabel()
        subtitleLabel.text = data.subtitle
        subtitleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        pageView.addSubview(subtitleLabel)
        
        //Создаем и настраиваем descriptiontitleLabel
        let descriptionLabel = UILabel()
        descriptionLabel.text = data.description
        descriptionLabel.font = .systemFont(ofSize: 20, weight: .regular)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        pageView.addSubview(descriptionLabel)
        
        // Размещение
        imageView.frame = view.bounds
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 150),
            titleLabel.widthAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 1),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subtitleLabel.widthAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 1),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            descriptionLabel.widthAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 1)
        ])
        
        if index == onboardingData.count - 1 {
            let startButton = UIButton(type: .system)
            startButton.setTitle("Начать", for: .normal)
            startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            startButton.setTitleColor(.white, for: .normal)
            startButton.backgroundColor = .systemBlue
            startButton.layer.cornerRadius = 10
            startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
            //            startButton.layer.masksToBounds = true
            
            startButton.translatesAutoresizingMaskIntoConstraints = false
            pageView.addSubview(startButton)
            
            NSLayoutConstraint.activate([
                startButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
                startButton.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
                startButton.widthAnchor.constraint(equalToConstant: 150),
                startButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        
        return pageView
    }
}

//MARK: - Start button action

extension WelcomeViewController {
    // TODO: - Вход в основое приложение
    @objc func startButtonTapped() {
        let locationVC = HomeViewController()
        SwitchUIViewController.presentViewController(locationVC)
    }
}

// MARK: - PageControl tapp
extension WelcomeViewController {
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let xOffset = CGFloat(sender.currentPage) * scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
    
}

#Preview {
    WelcomeViewController()
}

