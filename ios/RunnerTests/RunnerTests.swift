import Flutter
import UIKit
import XCTest

final class RunnerTests: XCTestCase {
    func test_givenUndeterminedCameraPermission_whenTapped_itShouldRequestAccess() {
        var requestCallCount = 0
        let permissions = CameraPermission.mock(
          currentState: .undetermined,
          request: { requestCallCount += 1 }()
        )
        let sut = BarcodeScannerView(
          permissions: permissions
        )
        sut.perform(Selector("onTap"))
        XCTAssertEqual(1, requestCallCount)
    }
    
    func test_givenGrantedCameraPermission_whenTapped_itShouldNotRequestAccess() {
        var requestCallCount = 0
        let permissions = CameraPermission.mock(
          currentState: .allowed,
          request: { requestCallCount += 1 }()
        )
        let sut = BarcodeScannerView(
          permissions: permissions
        )
        sut.perform(Selector("onTap"))
        XCTAssertEqual(0, requestCallCount)
    }
    
    func test_givenDeniedCameraPermission_whenTapped_itShouldRouteToSettings() {
        var openSettingsCallCount = 0
        let permissions = CameraPermission.mock(
          currentState: .denied,
          openSettings: { openSettingsCallCount += 1}
        )
        let sut = BarcodeScannerView(
          permissions: permissions
        )
        sut.perform(Selector("onTap"))
        XCTAssertEqual(1, openSettingsCallCount)
    }
    
    func test_givenAllowedCameraPermission_whenAppears_itShouldHideInstruction() {
        let sut = BarcodeScannerView(permissions: .mock(currentState: .allowed))
        guard let messageLabel = sut.subviews.compactMap { $0 as? UILabel }.first
        else { return XCTFail("View has no label to display instructions") }
        XCTAssertTrue(messageLabel.isHidden)
    }

    func test_givenDeniedCameraPermission_whenAppears_itShouldDisplayRouteToSettingsInstruction() {
        let sut = BarcodeScannerView(permissions: .mock(currentState: .denied))
        guard let messageLabel = sut.subviews.compactMap { $0 as? UILabel }.first
        else { return XCTFail("View has no label to display instructions") }
        XCTAssertFalse(messageLabel.isHidden)
        XCTAssertEqual("Dê acesso a camera para escanear códigos de barras", messageLabel.text)
    }
    
    func test_givenUndeterminedCameraPermission_whenAppears_itShouldDisplayTapToGiveAccessInstruction() {
        let sut = BarcodeScannerView(permissions: .mock(currentState: .undetermined))
        guard let messageLabel = sut.subviews.compactMap { $0 as? UILabel }.first
        else { return XCTFail("View has no label to display instructions") }
        XCTAssertFalse(messageLabel.isHidden)
        XCTAssertEqual("Dê acesso a camera para escanear códigos de barras", messageLabel.text)
    }
}

struct CameraPermission {
    enum State {
        case allowed, denied, undetermined
    }
    
    let currentState: () -> State
    let request: () -> Void
    let openSettings: () -> Void
}

extension CameraPermission {
    static func mock(
        currentState: @autoclosure @escaping () -> State = { .allowed }(),
        request: @autoclosure @escaping () -> Void = (),
        openSettings: @escaping () -> Void = { }
    ) -> CameraPermission {
        .init(
            currentState: currentState,
            request: request,
            openSettings: openSettings
        )
    }
}

final class BarcodeScannerView: UIView {
    private let permissions: CameraPermission
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dê acesso a camera para escanear códigos de barras"
        return label
    }()
    
    init(permissions: CameraPermission) {
        self.permissions = permissions
        super.init(frame: .zero)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(messageLabel)
        
        messageLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        renderPermissionInstruction()
    }
    
    private func renderPermissionInstruction() {
        let currentState = permissions.currentState()
        messageLabel.isHidden = currentState == .allowed
    }
    
    @objc
    private func onTap() {
        switch permissions.currentState() {
        case .allowed: 
            break
        case .denied: 
            permissions.openSettings()
        case .undetermined: 
            permissions.request()
        }
    }
}
