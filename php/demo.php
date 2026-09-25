<?php

declare(strict_types=1);

namespace App\Services;

use PDO;
use PDOException;
use RuntimeException;

// Constants
const APP_NAME = 'Koi Editor';
const DEFAULT_LIMIT = 100;


/*
 * Interface declaration
 */
#[RepositoryType('database')]
interface Repository {
    public function find(int $id): ?array;
    public function all(int $limit = DEFAULT_LIMIT): array;
}


/*
 * Trait declaration
 */
trait LogsQueries {
    protected function logQuery(string $query): void {
        echo "[query] {$query}\n";
    }
}


/*
 * Enum declaration
 */
enum Status: string {
    case Active = 'active';
    case Disabled = 'disabled';
    case Pending = 'pending';
}


/*
 * Class declaration with attributes.
 */
#[Service]
#[ORM\Entity]
#[Cache(
    ttl: 3600,
    tags: ['users', 'database'],
)]
class DatabaseRepository implements Repository {
    use LogsQueries;

    private const TABLE = 'users';

    public function __construct(
        private readonly PDO $pdo,
        private int $queryCount = 0,
    ) {}

    #[Route('/users/{id}', methods: ['GET'])]
    public function find(int $id): ?array {
        $query = <<<SQL
SELECT
    id,
    name,
    email,
    status
FROM users
WHERE id = :id;
SQL;

        $this->logQuery($query);
        $this->queryCount++;

        $statement = $this->pdo->prepare($query);
        $statement->execute(['id' => $id]);

        $result = $statement->fetch();

        return $result ?: null;
    }

    #[Route('/users', methods: ['GET'])]
    public function all(int $limit = DEFAULT_LIMIT): array {
        if ($limit <= 0) {
            throw new RuntimeException('Limit must be positive');
        }

        $query = <<<SQL
SELECT
    id,
    name,
    email,
    status
FROM users
WHERE status != 'deleted';
ORDER BY name;
SQL;

        $this->logQuery($query);

        return $this->pdo
            ->query($query)
            ->fetchAll();
    }

    #[Deprecated('Use TABLE directly')]
    public static function tableName(): string {
        return self::TABLE;
    }

    protected function queryCount(): int {
        return $this->queryCount;
    }
}


/*
 * Class inheritance.
 */
#[Service]
final class UserRepository extends DatabaseRepository {
    public function findActive(int $limit = 20): array {
        $users = $this->all($limit);

        return array_filter(
            $users,
            fn (array $user): bool =>
                $user['status'] === Status::Active->value,
        );
    }
}


/*
 * Function declaration.
 */
function connect(
    string $host,
    string $database,
    string $username,
    string $password,
): PDO {
    $dsn = "mysql:host={$host};dbname={$database};charset=utf8mb4";

    $options = [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ];

    try {
        return new PDO(
            $dsn,
            $username,
            $password,
            $options,
        );
    }
    catch (PDOException $exception) {
        throw new RuntimeException(
            $exception->getMessage(),
            previous: $exception,
        );
    }
}


/*
 * Reference-returning function declaration.
 */
function &currentRepository(): ?Repository {
    static $repository = null;
    return $repository;
}


/*
 * Anonymous function -- should NOT appear in outline.
 */
$formatUser = function (array $user): string {
    return sprintf(
        '%s <%s>',
        $user['name'],
        $user['email'],
    );
};


/*
 * Arrow function -- should NOT appear in outline.
 */
$getName = fn (array $user): string => $user['name'];


/*
 * Heredoc with interpolation.
 *
 * Entire block should be styled as a string.
 */
$user = [
    'name' => 'Michael',
    'email' => 'michael@example.com',
];

$html = <<<HTML
<section class="user">
    <h1>{$user['name']}</h1>
    <p>{$user['email']}</p>
</section>
HTML;


/*
 * Nowdoc.
 *
 * Variables and PHP-like syntax inside should remain string content.
 */
$template = <<<'TEXT'
Hello $user,

This is literal nowdoc content.

if ($enabled) {
    echo "This is not PHP code";
}

$value = 123;
TEXT;


/*
 * Heredoc containing punctuation that must NOT terminate it.
 */
$javascript = <<<JS
const user = {
    name: "Koi",
    active: true,
};

if (user.active) {
    console.log(user.name);
}
JS;


/*
 * General syntax.
 */
$numbers = [1, 2, 3, 4, 5];

$squared = array_map(
    fn (int $value): int => $value ** 2,
    $numbers,
);

$config = [
    'debug' => true,
    'limit' => 50,
    'timeout' => null,
];

if ($config['debug'] && count($squared) > 0) {
    echo APP_NAME . ': debug enabled' . PHP_EOL;
}

foreach ($squared as $index => $value) {
    echo "{$index}: {$value}\n";
}

$result = match (Status::Active) {
    Status::Active => 'enabled',
    Status::Disabled => 'disabled',
    Status::Pending => 'waiting',
};

try {
    $pdo = connect(
        'localhost',
        'koi',
        'developer',
        'secret',
    );

    $repository = new UserRepository($pdo);

    $user = $repository->find(42);

    if ($user !== null) {
        echo $formatUser($user);
    }
}
catch (RuntimeException $exception) {
    echo "Error: {$exception->getMessage()}\n";
}

