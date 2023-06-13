import XCTest
@testable import EurosportKit

final class DateExtensionTests: XCTestCase {
        
    func testDateFormat_lessThanAMinuteAgo() {
        let lessThanAMinuteAgo = Date(timeIntervalSinceNow: -10)

        XCTAssertEqual(lessThanAMinuteAgo.formattedDateComparedToNow, "Now")
    }

    func testDateFormat_oneMinuteAgo() {
        let oneMinuteAgo = Date(timeIntervalSinceNow: -60)

        XCTAssertEqual(oneMinuteAgo.formattedDateComparedToNow, "1 min ago")
    }

    func testDateFormat_twentyFourMinuteAgo() {
        let twentyFourMinuteAgo = Date(timeIntervalSinceNow: -60 * 24)

        XCTAssertEqual(twentyFourMinuteAgo.formattedDateComparedToNow, "24 min ago")
    }

    func testDateFormat_oneHourAgo() {
        let oneHourAgo = Date(timeIntervalSinceNow: -60 * 60)

        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        
        XCTAssertEqual(oneHourAgo.formattedDateComparedToNow, timeFormatter.string(from: oneHourAgo))
    }

    func testDateFormat_yesterdayAgo() {
        let yesterdayAgo = Date(timeIntervalSinceNow: -60 * 60 * 28)

        XCTAssertEqual(yesterdayAgo.formattedDateComparedToNow, "Yesterday")
    }

    func testDateFormat_fiveDaysAgo() {
        let fiveDaysAgo = Date(timeIntervalSinceNow: -60 * 60 * 24 * 5)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        XCTAssertEqual(fiveDaysAgo.formattedDateComparedToNow, dateFormatter.string(from: fiveDaysAgo))
    }
}
