// demo.ts
// Koi Editor TypeScript lexer test.

interface User {
    id: number;
    name: string;
    email?: string;
}

type UserId = string | number;

enum Status {
    Idle,
    Loading,
    Ready,
    Error,
}

namespace Format {
    export function userName(user: User): string {
        return `${user.name} <${user.email ?? "unknown"}>`;
    }

    export function status(value: Status): string {
        return Status[value] ?? "Unknown";
    }
}

function sealed<T extends new (...args: any[]) => object>(target: T): T {
    Object.seal(target);
    Object.seal(target.prototype);
    return target;
}

@sealed
class UserStore {
    private users = new Map<UserId, User>();
    private status: Status = Status.Idle;

    constructor(private readonly endpoint: string) {}

    get currentStatus(): Status {
        return this.status;
    }

    add(user: User): void {
        this.users.set(user.id, user);
    }

    remove(id: UserId): boolean {
        return this.users.delete(id);
    }

    find(id: UserId): User | undefined {
        return this.users.get(id);
    }

    async load(): Promise<void> {
        this.status = Status.Loading;

        try {
            const response = await fetch(this.endpoint);

            if (!response.ok) {
                throw new Error(`Request failed: ${response.status}`);
            }

            const users = (await response.json()) as User[];

            for (const user of users) {
                this.add(user);
            }

            this.status = Status.Ready;
        }
        catch (error) {
            this.status = Status.Error;
            console.error("Failed to load users:", error);
        }
    }
}

function createUser(id: UserId, name: string, email?: string): User {
    return {
        id: Number(id),
        name,
        email,
    };
}

function printUsers(users: readonly User[]): void {
    for (const user of users) {
        console.log(Format.userName(user));
    }
}

async function main(): Promise<void> {
    const store = new UserStore("/api/users");

    store.add(createUser(1, "Alice", "alice@example.com"));
    store.add(createUser(2, "Bob"));

    await store.load();

    const alice = store.find(1);

    if (alice) {
        console.log(`Found ${alice.name}`);
    }

    const values = [1, 2, 3, 4, 5];

    const doubled = values
        .filter(value => value > 2)
        .map(value => value * 2);

    console.log("Values:", doubled);

    // Braces in comments should not affect folding:
    // { } {{{ }}}

    const text = `
        Template strings may contain braces.
        { this should not affect folding }
    `;

    console.log(text);
}

main().catch(error => {
    console.error(error);
});
