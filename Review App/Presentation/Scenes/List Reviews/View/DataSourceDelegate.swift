import Foundation

protocol DataSourceDelegate: AnyObject {
    func titleForHeaderInSections(_ section: Int) -> String?
}
