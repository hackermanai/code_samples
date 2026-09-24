/*
 * Koi Editor
 * JavaScript lexer and outline demo
 */

const APP_NAME = "Koi Editor";
const VERSION = '0.1.0';
const MAX_ITEMS = 1_000;
const ENABLE_LOGGING = true;

let activeUser = null;


// -----------------------------------------------------------------------------
// Functions
// -----------------------------------------------------------------------------

function greet(name) {
    return `Hello, ${name}! Welcome to ${APP_NAME}.`;
}

function calculateTotal(items, taxRate = 0.08) {
    let subtotal = 0;

    for (const item of items) {
        subtotal += item.price * item.quantity;
    }

    return subtotal * (1 + taxRate);
}

async function fetchUser(userId) {
    const response = await fetch(`/api/users/${userId}`);

    if (!response.ok) {
        throw new Error(`Request failed: ${response.status}`);
    }

    return await response.json();
}

function* generateIds(start = 1) {
    let id = start;

    while (true) {
        yield id++;
    }
}


// -----------------------------------------------------------------------------
// Classes
// -----------------------------------------------------------------------------

class User {
    constructor(name, email) {
        this.name = name;
        this.email = email;
        this.active = true;
    }

    get displayName() {
        return `${this.name} <${this.email}>`;
    }

    set enabled(value) {
        this.active = Boolean(value);
    }

    greet() {
        return greet(this.name);
    }

    async save() {
        const payload = {
            name: this.name,
            email: this.email,
            active: this.active,
        };

        return await saveUser(payload);
    }

    *permissions() {
        yield "read";

        if (this.active) {
            yield "write";
        }
    }
}

class Admin extends User {
    constructor(name, email, roles = []) {
        super(name, email);
        this.roles = roles;
    }

    hasRole(role) {
        return this.roles.includes(role);
    }
}


// -----------------------------------------------------------------------------
// Function expressions and arrows
// -----------------------------------------------------------------------------

const square = function (value) {
    return value * value;
};

const double = value => value * 2;

const add = (a, b) => {
    return a + b;
};

const delayedValue = async (value) => {
    await new Promise(resolve => setTimeout(resolve, 10));
    return value;
};


// -----------------------------------------------------------------------------
// Objects and collections
// -----------------------------------------------------------------------------

const settings = {
    theme: "dark",
    fontSize: 15,
    lineNumbers: true,

    format(value) {
        return String(value).trim();
    },

    nested: {
        enabled: true,
        limits: [10, 20, 30],
    },
};

const users = [
    new User("Alice", "alice@example.com"),
    new Admin("Bob", "bob@example.com", ["admin", "developer"]),
];

const userMap = new Map([
    ["alice", users[0]],
    ["bob", users[1]],
]);


// -----------------------------------------------------------------------------
// Strings, templates, regex
// -----------------------------------------------------------------------------

const singleQuoted = 'single quoted string';
const doubleQuoted = "double quoted string";
const escaped = "quote: \" backslash: \\ newline: \n";

const message = `
${APP_NAME} ${VERSION}

Current user: ${
    activeUser
        ? `${activeUser.name} (${activeUser.email})`
        : "none"
}
`;

const nestedTemplate = `Result: ${
    users.map(user => `${user.name}: ${user.active ? "on" : "off"}`).join(", ")
}`;

const emailPattern = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i;
const pathPattern = /\/api\/users\/(\d+)/g;


// -----------------------------------------------------------------------------
// Numbers and operators
// -----------------------------------------------------------------------------

const decimal = 123.456;
const hex = 0xFFAA11;
const binary = 0b101010;
const octal = 0o755;
const large = 1_000_000;
const bigint = 9_007_199_254_740_991n;

const result =
    (decimal + hex) * 2
    / 4
    % 3;


// -----------------------------------------------------------------------------
// Control flow
// -----------------------------------------------------------------------------

function describeUser(user) {
    if (!user) {
        return "No user";
    }

    if (user instanceof Admin) {
        return `Admin: ${user.name}`;
    }

    switch (user.active) {
        case true:
            return `Active: ${user.name}`;

        case false:
            return `Inactive: ${user.name}`;

        default:
            return "Unknown";
    }
}

function processUsers(users) {
    const output = [];

    for (const user of users) {
        try {
            if (!emailPattern.test(user.email)) {
                throw new Error(`Invalid email: ${user.email}`);
            }

            output.push({
                name: user.name,
                description: describeUser(user),
            });
        }
        catch (error) {
            console.error(error);
        }
        finally {
            console.log(`Processed ${user.name}`);
        }
    }

    return output;
}


// -----------------------------------------------------------------------------
// Nested declarations
// -----------------------------------------------------------------------------

function outer(value) {
    function inner(multiplier) {
        return value * multiplier;
    }

    if (value > 10) {
        function largeValue() {
            return inner(2);
        }

        return largeValue();
    }

    return inner(1);
}


// -----------------------------------------------------------------------------
// Async
// -----------------------------------------------------------------------------

async function saveUser(user) {
    const response = await fetch("/api/users", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(user),
    });

    return response.json();
}

async function main() {
    const ids = generateIds(100);

    console.log(ids.next().value);
    console.log(greet("Koi"));

    for (const user of users) {
        console.log(user.displayName);
    }

    const processed = processUsers(users);
    console.log(processed);

    const user = await fetchUser(42);
    activeUser = user;

    return user;
}

main().catch(error => {
    console.error("Fatal error:", error);
});

