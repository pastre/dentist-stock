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
    
    init(permissions: CameraPermission) {
        self.permissions = permissions
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
