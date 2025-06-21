import UIKit
import CastarSDK

class ViewController: UIViewController {
    
    private var castarInstance: Castar?
    
    // UI Elements
    private let titleLabel = UILabel()
    private let statusLabel = UILabel()
    private let startButton = UIButton(type: .system)
    private let stopButton = UIButton(type: .system)
    private let clientIdLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initializeCastarSDK()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        
        // Title Label
        titleLabel.text = "My Time App"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Client ID Label
        clientIdLabel.text = "Client ID: cskKFkzBSlmLUF"
        clientIdLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        clientIdLabel.textColor = UIColor.secondaryLabel
        clientIdLabel.textAlignment = .center
        clientIdLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clientIdLabel)
        
        // Status Label
        statusLabel.text = "SDK Status: Initializing..."
        statusLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        statusLabel.textAlignment = .center
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
        
        // Start Button
        startButton.setTitle("Start SDK", for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        startButton.backgroundColor = UIColor.systemBlue
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = 12
        startButton.addTarget(self, action: #selector(startSDK), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        
        // Stop Button
        stopButton.setTitle("Stop SDK", for: .normal)
        stopButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        stopButton.backgroundColor = UIColor.systemRed
        stopButton.setTitleColor(.white, for: .normal)
        stopButton.layer.cornerRadius = 12
        stopButton.addTarget(self, action: #selector(stopSDK), for: .touchUpInside)
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stopButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Client ID Label
            clientIdLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            clientIdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            clientIdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Status Label
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Start Button
            startButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 40),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Stop Button
            stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 20),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.widthAnchor.constraint(equalToConstant: 200),
            stopButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func initializeCastarSDK() {
        // Set ClientId - Using the provided client ID
        let key = "cskKFkzBSlmLUF"
        
        // Create a Castar instance
        let result = Castar.createInstance(withDevKey: key)
        
        if let castarInstance = result {
            // The instance is created successfully
            self.castarInstance = castarInstance
            statusLabel.text = "SDK Status: Initialized Successfully"
            statusLabel.textColor = UIColor.systemGreen
            startButton.isEnabled = true
            print("CastarSDK initialized successfully")
        } else {
            // Handle errors
            statusLabel.text = "SDK Status: Initialization Failed"
            statusLabel.textColor = UIColor.systemRed
            print("Failed to initialize CastarSDK")
        }
    }
    
    @objc private func startSDK() {
        guard let castarInstance = castarInstance else {
            statusLabel.text = "SDK Status: Not Initialized"
            statusLabel.textColor = UIColor.systemRed
            return
        }
        
        // Start the SDK
        castarInstance.start()
        statusLabel.text = "SDK Status: Running"
        statusLabel.textColor = UIColor.systemGreen
        startButton.isEnabled = false
        startButton.alpha = 0.5
        stopButton.isEnabled = true
        stopButton.alpha = 1.0
        print("CastarSDK started successfully")
    }
    
    @objc private func stopSDK() {
        guard let castarInstance = castarInstance else {
            statusLabel.text = "SDK Status: Not Initialized"
            statusLabel.textColor = UIColor.systemRed
            return
        }
        
        // Stop the SDK
        castarInstance.stop()
        statusLabel.text = "SDK Status: Stopped"
        statusLabel.textColor = UIColor.systemOrange
        startButton.isEnabled = true
        startButton.alpha = 1.0
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
        print("CastarSDK stopped successfully")
    }
} 