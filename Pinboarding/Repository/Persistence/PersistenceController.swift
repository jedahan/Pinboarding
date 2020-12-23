import Combine
import CoreData
import PinboardKit

struct PersistenceController {

    // MARK: - Properties

    let container: NSPersistentContainer

    // MARK: - Life cycle

    init(
        inMemory: Bool = false
    ) {
        self.container = NSPersistentContainer(
            name: "Pinboarding"
        )

        if inMemory {
            self.container.persistentStoreDescriptions.first?.url = URL(
                fileURLWithPath: "/dev/null"
            )
        }

        self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        self.container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError(
                    "Something bad happened: \(error), \(error.userInfo)"
                )
            }
        }
    }

    // MARK: - Public

    func appendNewPosts(
        _ posts: [PostResponse]
    ) {
        posts.forEach { postResponse in
            do {
                try Post.makePost(
                    from: postResponse,
                    in: container.viewContext
                )
            } catch {
                print("Something happened: \(error)")
            }
        }
    }
}
